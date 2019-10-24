# ESXINTPfix
This project can help in automatically fixing NTP configuration of ESXI hosts.

When dealing with large infrastructure where changes are too dynmic it is sometime hard to monitor all parameters are set as per the compliance.
NTP configuration for ESXI hosts is a key parameter which can affect few functionalities of the VM's.

Below is a sample Jenkins based project which triggeres powercli script, fix hosts NTP configuraion on a perticular VC.
