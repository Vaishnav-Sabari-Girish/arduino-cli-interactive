# Chapter 4  (How to use `aci` Part 3)

By the end of this chapter , you will be able to add 3rd party cores to the `aci` tools. 
These 3rd party cores are required to be able to use boards like ESP32 and ESP8266. 

To do this , we have to first create the config file. 
To create the config file , type the following in the terminal 

```bash
arduino-cli config init 
```

This will create the `config.yaml` file at `/home/<username>/.arduino15/arduino-cli.yaml`. 

The previous step is optional. Because the script itself will create it for you. 
Just incase it doesn't , you have to create the .yaml file using the command given above. 

To do the above , type `aci` in the terminal , navigate to **Edit Configurations** option and choose your
preferred editor. 

Then copy and paste the following links for : 

1. ESP8266

`http://arduino.esp8266.com/stable/package_esp8266com_index.json`

2. ESP32 

`https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json`

Then exit the editor. 

Then in the terminal type :

```bash
arduino-cli core update-index
arduino-cli core install esp32:esp32 (esp8266:esp8266 for ESP8266)
arduino-cli board install 

#To list all boards 
arduino-cli board listall
```

![New Core](images/recordings/new_core.gif)
