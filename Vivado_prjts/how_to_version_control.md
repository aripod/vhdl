# Workflow for *Version Control* in **Vivado Projects**

The followng steps are based on Vivado and git. The chosen structure for the directories within the repository is the following:
- **Repository_name**
    - *ip_repo*: Folder where al the custom repositories created should be *completely* copied.
    - *src*: Folder where the script for the design and the sources from **sdk** are copied.
         - *bd*: Exported hardware from Vivado.
         - *hdl*: Any hdl file that is included in the project.
         - *sdk_src*: File sources from SDK.
    - *build.tcl*: Script created in Vivado.

The design flow is the following:
1. Create an *empty repository*.
2. Open Vivado, create a new project *in the directory of the repository created in step 1* and follow the regular design flow.
3. Generate a build script for a Vivado project:
    1. File -> Write Project Tcl...
    2. Save it in *Repository_name*.
    3. Name it **build.tcl**.
3. Generate the block design script in Vivado.
    1. File -> Export -> Export hardware...
    2. Save it in *Repository_name/src/bd**.
    3. Name it **design_1.tcl***.
4. Modify the build script
    1. Replace the corresponding lines so they look like this:
        ```
        # Set the reference directory to where the script is
        set origin_dir [file dirname [info script]]
        
        # Create project
        create_project myproject $origin_dir/myproject
        ```
    2. At the end of the script, add the following lines
        ````
        # Create block design
         source $origin_dir/src/bd/design_1.tcl
        
         # Generate the wrapper
         set design_name [get_bd_designs]
         make_wrapper -files [get_files $design_name.bd] -top -import
         
         regenerate_bd_layout
        ````
5. Copy the files created and edited in SKD (under the src folder) to Repository_name/src/sdk_src.
6. Commit the following files and/or folders:
    1. build.tcl
    2. src/bd/desing_1.tcl
    3. Any files added to src/hdl
    4. Any files added to src/sdk_src
    5. ip_repo if any custom ip was created.

To build the Vivado project with the *cloned* repository:
1. Clone the repository.
2. Open Vivado.
3. Go to *Windows -> Tcl Console*
4. In the Tcl Console, navigate to the directory where the repository has been cloned.
5. Run `source build.tcl`
6. In case there have been SKD files included, the files Repository_name/src/sdk_src have to be imported.

All these steps are based from [this article](http://www.fpgadeveloper.com/2014/08/version-control-for-vivado-projects.html). Minor changes have been made.
