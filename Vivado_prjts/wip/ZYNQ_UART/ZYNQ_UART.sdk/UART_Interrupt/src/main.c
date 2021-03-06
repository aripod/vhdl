#include <stdio.h>
#include "xparameters.h"
#include "xil_printf.h"
#include "xuartps.h"
#include "xscugic.h"

#define UART_DEVICE_ID		XPAR_XUARTPS_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define UART_INT_IRQ_ID		XPAR_XUARTPS_1_INTR

#define RECV_BUFFER_SIZE	50

XUartPs UartPs	;			/* Instance of the UART Device */
static XScuGic InterruptController;	/* Instance of the Interrupt Controller */

int UartIntrInit(XScuGic *IntcInstPtr, XUartPs *UartInstPtr, u16 DeviceId, u16 UartIntrId);
static int SetupInterruptSystem(XScuGic *IntcInstancePtr, XUartPs *UartInstancePtr, u16 UartIntrId);
void UARTHandler(void *CallBackRef, u32 Event, unsigned int EventData);

u8 end = 0, UART_newData=0;
volatile int TotalReceivedCount;
static u8 RecvBuffer[RECV_BUFFER_SIZE];	/* Buffer for Receiving Data */

int main(void)
{
	int Status;

	Status = UartIntrInit(&InterruptController, &UartPs, UART_DEVICE_ID, UART_INT_IRQ_ID);
	if (Status != XST_SUCCESS)
	{
		xil_printf("UART Interrupt Example Test Failed\r\n");
		return XST_FAILURE;
	}
	while(end==0)
	{
		if(UART_newData==1)
		{
			// Process the received data.
			xil_printf("Buffer: %s\n", RecvBuffer);
			UART_newData = 0;
		}
	}

	return 0;
}

int UartIntrInit(XScuGic *IntcInstPtr, XUartPs *UartInstPtr, u16 DeviceId, u16 UartIntrId)
{
	int Status;
	XUartPs_Config *Config;
	u32 IntrMask;

	/*
	 * Initialize the UART driver so that it's ready to use
	 * Look up the configuration in the config table, then initialize it.
	 */
	Config = XUartPs_LookupConfig(DeviceId);
	if (NULL == Config) {
		return XST_FAILURE;
	}

	Status = XUartPs_CfgInitialize(UartInstPtr, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Check hardware build */
	Status = XUartPs_SelfTest(UartInstPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the UART to the interrupt subsystem such that interrupts
	 * can occur. This function is application specific.
	 */
	Status = SetupInterruptSystem(IntcInstPtr, UartInstPtr, UartIntrId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Setup the handlers for the UART that will be called from the
	 * interrupt context when data has been sent and received, specify
	 * a pointer to the UART driver instance as the callback reference
	 * so the handlers are able to access the instance data
	 */
	XUartPs_SetHandler(UartInstPtr, (XUartPs_Handler)UARTHandler, UartInstPtr);

	/*
	 * Enable the interrupt of the UART so interrupts will occur, setup
	 * a local loopback so data that is sent will be received.
	 */
	IntrMask =
		XUARTPS_IXR_TOUT | XUARTPS_IXR_PARITY | XUARTPS_IXR_FRAMING |
		XUARTPS_IXR_OVER | XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_RXFULL |
		XUARTPS_IXR_RXOVR;

	XUartPs_SetInterruptMask(UartInstPtr, IntrMask);

	XUartPs_SetOperMode(UartInstPtr, XUARTPS_OPER_MODE_NORMAL);

	/*
	 * Set the receiver timeout. If it is not set, and the last few bytes
	 * of data do not trigger the over-water or full interrupt, the bytes
	 * will not be received. By default it is disabled.
	 *
	 * The setting of 8 will timeout after 8 x 4 = 32 character times.
	 * Increase the time out value if baud rate is high, decrease it if
	 * baud rate is low.
	 */
	XUartPs_SetRecvTimeout(UartInstPtr, 8);

	return XST_SUCCESS;
}

static int SetupInterruptSystem(XScuGic *IntcInstancePtr, XUartPs *UartInstancePtr, u16 UartIntrId)
{
	int Status;
	XScuGic_Config *IntcConfig; /* Config for interrupt controller */


	/* Initialize the interrupt controller driver */
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the interrupt controller interrupt handler to the
	 * hardware interrupt handling logic in the processor.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
				(Xil_ExceptionHandler) XScuGic_InterruptHandler,
				IntcInstancePtr);

	/*
	 * Connect a device driver handler that will be called when an
	 * interrupt for the device occurs, the device driver handler
	 * performs the specific interrupt processing for the device
	 */
	Status = XScuGic_Connect(IntcInstancePtr, UartIntrId,
				  (Xil_ExceptionHandler) XUartPs_InterruptHandler,
				  (void *) UartInstancePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Enable the interrupt for the device */
	XScuGic_Enable(IntcInstancePtr, UartIntrId);

	/* Enable interrupts */
		 Xil_ExceptionEnable();

	 return XST_SUCCESS;
}

void UARTHandler(void *CallBackRef, u32 Event, unsigned int EventData)
{
	XUartPs_Recv(&UartPs, RecvBuffer, RECV_BUFFER_SIZE);
	UART_newData = 1;
	/* All of the data has been received
	if (Event == XUARTPS_EVENT_RECV_DATA) {
		UART_newData = 1;
		TotalReceivedCount = EventData;
	}*/
}
