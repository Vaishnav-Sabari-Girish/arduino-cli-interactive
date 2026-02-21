# Chapter 3 (How to use `aci` Part - 2)

By the end of this chapter , you will be able to 

1. [Compile Code for a specific board](#compile-code)
2. [Upload Code to the board](#upload-code)
3. [Install Libraries](#install-libraries)
<br><br>
## Compile Code

To compile the code in the Sketch you created [previously](./chapter_2.md#edit-a-sketch) , we open the
and make sure that `aci` is running and you must have [Selected the Board](./chapter_2.md#select-a-board) , 
[Created a new Sketch](./chapter_2.md#create-a-new-sketch) and [Edited the Code](./chapter_2.md#edit-a-sketch). 

We then use the Arrow keys to naviigate to the **Compile Code** Option and press **Enter**. 

Since you have already selected the board , it will compile the code for that specific board. 

In the following example we will compile the code for an Arduino Nano. 

![compile code gif](images/recordings/compile_code.gif)

<br><br>

## Upload Code

To upload the code , you need to first [Compile the code](#compile-code) and then back in the homepage , 
navigate to the **Upload Code** option and press **Enter**

Once you are inside the **Upload Code** , you will be asked to choose the Serial Port your board
is connected to. 

In Linux/macOS , the Serial port will show up as `/dev/ttyUSB0` and for windows , it will show up as
`COM7` or any other number other than 7. 

After selecting the Serial Port , you will then be asked to choose between OLD and NEW Bootloaders. 
OLD Bootloaders as usually only for Arduino Nanos , so make sure you do not mess up that one. 
Choose between OLD and NEW Bootloaders and the the code will be uploaded. 

In the below recordings , one will be for Arduino Nano (Old Bootloader) and one for the WeMOS D1 R1
(New Bootloader). 

### Old Bootloader.

![Old Bootloader](images/recordings/upload_code_old.gif)

### New Bootloader

![New Bootloader](images/recordings/upload_code_new.gif)

<br><br>

## Install Libraries

To install libraries , there is no need to Select a board or Create a New Sketch. 

Open a new terminal and type `aci`. 
The Navigate to the **Install Libraries** option using the Arrow Keys and click **Enter**

Now an input dialog box will appear prompting for the name of the library. 
Enter the name of the library and press **Enter**

When do you do , there will be a list of libraries that have the name you entered. 
Select the one you want to install and click **Enter**

Let us install the **DHT11** Library by **Dhrubha Saha**. 

To check if the library has been installed , type `arduino-cli lib list` and check the table
for the library you just installed. If it is present then the library has been installed successfully. 

![Lib Install](images/recordings/lib_install.gif)

You have successuflly , compiled and uploaded a sketch and also installed a library. 
