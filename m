From: Christopher <kirian100@yahoo.com>
Subject: Re: Regarding PATCH for ITE887x Serial
Date: Wed, 25 Feb 2009 12:25:27 +0200
Message-ID: <49A51C97.1040702@yahoo.com>
References: <499E6C09.4090108@yahoo.com> <499E6FC7.506@wincor-nixdorf.com> <499E77CE.4010008@yahoo.com> <499E81D3.4080107@wincor-nixdorf.com> <499E84AE.7050209@yahoo.com>   <499E86D2.1030507@wincor-nixdorf.com> <499F120A.8050902@yahoo.com> <49A507EF.8010502@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp106.prem.mail.ac4.yahoo.com ([76.13.13.45]:28073 "HELO
	smtp106.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753174AbZBYKZc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Feb 2009 05:25:32 -0500
In-Reply-To: <49A507EF.8010502@wincor-nixdorf.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Niels de Vos <niels.devos@wincor-nixdorf.com>
Cc: linux-serial@vger.kernel.org

Hi Niels,

I don't really know why but the output of dmesg only shows my oboard 
serial. I have looked all over the dmesg and i cannot find the device 
even at an unknown state
I have even checked dmesg log for the matter.

These are discovered for the onboard serial ports.
kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
kernel: 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
kernel: 00:0d: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

I will try and remove the card to read what it says exactly on the chip 
and update the email. Its definitely ITE but i will give u exactly what 
it says on chip.

Output for /proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f2-03f5 : floppy
03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : ACPI PM1a_EVT_BLK
    1004-1005 : ACPI PM1a_CNT_BLK
    1008-100b : ACPI PM_TMR
    1010-1015 : ACPI CPU throttle
    1028-102b : ACPI GPE0_BLK
    102c-102f : ACPI GPE1_BLK
1180-11bf : 0000:00:1f.0
  1180-11bf : motherboard
1800-180f : 0000:00:1f.1
  1800-1807 : ide0
  1808-180f : ide1
1810-181f : 0000:00:1f.3
  1810-181f : i801_smbus
1820-183f : 0000:00:1f.2
  1820-183f : uhci_hcd
1840-185f : 0000:00:1f.4
  1840-185f : uhci_hcd
2000-2fff : PCI Bus #02
  2000-20ff : 0000:02:0c.0
    2000-20ff : 8139too
  2400-243f : 0000:02:08.0
    2400-243f : e100
  2440-247f : 0000:02:0e.0
  2480-248f : 0000:02:0e.0
  2490-249f : 0000:02:0e.0
fe00-fe00 : motherboard


Thanks
Chris

Niels de Vos wrote:
> Hello Christopher,
>
> Christopher wrote:
>   
>> I have tried:
>>
>> Debian 5
>> Fedora Live CD 11
>> Ubuntu 8.10
>> CentOS 5.2 custom kernel from kernel.org with almost all modules enabled
>>     
>
> Great testing. The Fedora Live CD 11 contains a very recent kernel
> and should recognize all known (at least to me) ITE-chips.
>
>
>   
>> Nothing recognizes it. All output is same on lspci.
>>     
>
> Not only lspci is important, also the output of dmesg (grep for tty)
> and the file /proc/ioports.
>
>
>   
>> I have CCed linux-serial@vger.kernel.org as well with output of lspci -vv
>>
>> 02:0e.0 Serial controller: PLX Technology, Inc. Unknown device 9016 (rev
>> 01) (prog-if 02 [16550])
>>        Subsystem: Unknown device 544e:0008
>>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>        Interrupt: pin A routed to IRQ 169
>>        Region 0: I/O ports at 2440 [disabled] [size=64]
>>        Region 1: I/O ports at 2490 [disabled] [size=16]
>>        Region 2: I/O ports at 2480 [disabled] [size=16]
>>        Region 3: Memory at f2003000 (32-bit, non-prefetchable)
>> [disabled] [size=4K]
>>        Region 4: Memory at f2002000 (32-bit, non-prefetchable)
>> [disabled] [size=4K]
>>        Region 5: Memory at f2001000 (32-bit, non-prefetchable)
>> [disabled] [size=4K]
>>     
>
> Compared this to one of the ITE-chips here. I'm not convinced this is
> a chip by ITE. Can you tell me the exact type of it887x (x=...)?
>
>
>   
>> My main server runs Linux 2.6.18-92.1.22.el5 #1 SMP Tue Dec 16 12:03:43
>> EST 2008 i686 i686 i386 GNU/Linux (CentOS 5.2)
>>
>> I have attached the "drivers" they gave me for 2.6 kernel supposedly.
>> Although i believe its for the 2.4 as the readme that it has its for 2.4
>> kernel.
>>     
>
> This rough patch was available for kernel-2.4. As nobody But ITE could
> provide us (Wincor-Nixdorf) with drivers for kernel-2.6. I was assigned
> to implement the serial-part of the driver in 8250_pci.c.
>
> Hope that helps,
> Niels
>
>
>   
>> Thanks
>>
>> Regards,
>> Chris
>>
>> Niels de Vos wrote:
>>     
>>> Christopher wrote:
>>>  
>>>       
>>>> Im currently compiling my own kernel use guide from
>>>> http://howtoforge.com/kernel_compilation_centos
>>>>     
>>>>         
>>> Site is down atm... Don't refresh your browser ;)
>>>
>>>
>>>  
>>>       
>>>> Using the latest kernel from kernel.org and my current .config
>>>>
>>>> You believe this will have the drivers needed?
>>>>     
>>>>         
>>> Yes, that should work.
>>>
>>> Please send me a little update on you success (or not).
>>>
>>> Thanks,
>>> Niels
>>>
>>>
>>>  
>>>       
>>>> Thanks
>>>>
>>>> Chris
>>>>
>>>> Niels de Vos wrote:
>>>>    
>>>>         
>>>>> Christopher wrote:
>>>>>  
>>>>>      
>>>>>           
>>>>>> I have tried to install the kernel as you said:
>>>>>>
>>>>>> [root@Server ~]# rpm -ivh --nodeps
>>>>>> http://kojipkgs.fedoraproject.org/packages/kernel/2.6.29/0.137.rc5.git4.fc11/i586/kernel-2.6.29-0.137.rc5.git4.fc11.i586.rpm
>>>>>>
>>>>>>
>>>>>>
>>>>>> Retrieving
>>>>>> http://kojipkgs.fedoraproject.org/packages/kernel/2.6.29/0.137.rc5.git4.fc11/i586/kernel-2.6.29-0.137.rc5.git4.fc11.i586.rpm
>>>>>>
>>>>>>
>>>>>>
>>>>>> Preparing...               
>>>>>> ###########################################
>>>>>> [100%]
>>>>>>   1:kernel                 ###########################################
>>>>>> [100%]
>>>>>> WARNING: No module ehci-hcd found for kernel
>>>>>> 2.6.29-0.137.rc5.git4.fc11.i586, continuing anyway
>>>>>> WARNING: No module ohci-hcd found for kernel
>>>>>> 2.6.29-0.137.rc5.git4.fc11.i586, continuing anyway
>>>>>> WARNING: No module uhci-hcd found for kernel
>>>>>> 2.6.29-0.137.rc5.git4.fc11.i586, continuing anyway
>>>>>> WARNING: No module ata_piix found for kernel
>>>>>> 2.6.29-0.137.rc5.git4.fc11.i586, continuing anyway
>>>>>> Usage: new-kernel-pkg [-v] [--mkinitrd] [--rminitrd]
>>>>>>       [--initrdfile=<initrd-image>] [--depmod] [--rmmoddep]
>>>>>>       [--kernel-args=<args>] [--remove-args=<args>]
>>>>>>       [--banner=<banner>] [--multiboot=multiboot]
>>>>>>       [--mbargs=mbargs] [--make-default]
>>>>>>       <--install | --remove | --update> <kernel-version>
>>>>>>       (ex: new-kernel-pkg --mkinitrd --depmod --install 2.4.7-2)
>>>>>> error: %posttrans(kernel-2.6.29-0.137.rc5.git4.fc11.i586) scriptlet
>>>>>> failed, exit status 1
>>>>>> [root@Server ~]#
>>>>>>
>>>>>> It fails to install the kernel.
>>>>>>             
>>>>>>             
>>>>> Hmm, same here... Tried to create the initrd with mkinitrd but it won't
>>>>> detect my AHCI-drives... Unable to boot the system completely.
>>>>>
>>>>> You might be able to create a working initrd manually, after installing
>>>>> the kernel with 'rpm -ivh --nodeps --noscripts ...'. However, easiest
>>>>> would be to update the mkinitrd-package to the required version and
>>>>> install the kernel after that.
>>>>>
>>>>> Alternatively you might try an older version of the kernel 2.6.23+. Or
>>>>> download and try with a Fedora-10-Live CD/USB.
>>>>>
>>>>> Hope that helps,
>>>>> Niels
>>>>>
>>>>>
>>>>>  
>>>>>      
>>>>>           
>>>>>> Any ideas?
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Niels de Vos wrote:
>>>>>>           
>>>>>>             
>>>>>>> Hello Chris,
>>>>>>>
>>>>>>> Christopher wrote:
>>>>>>>  
>>>>>>>               
>>>>>>>               
>>>>>>>> I have bought off ebay the 8port Serial DB9 adapter with ITE8871
>>>>>>>> chipset
>>>>>>>> and my CentOS5.1 with Kernel 2.6.18-92.1.22.el5 does not seem to
>>>>>>>> recognize it.
>>>>>>>>                         
>>>>>>>>                 
>>>>>>> ITE887x hardware gets recognised with kernel 2.6.23 and newer.
>>>>>>> RHEL has
>>>>>>> not included a backport for this driver (so CentOS also didn't).
>>>>>>>
>>>>>>> I know some people use a Fedora kernel on CentOS. You can download
>>>>>>> the
>>>>>>> most recent version from here:
>>>>>>> <http://koji.fedoraproject.org/koji/packageinfo?packageID=8>
>>>>>>>
>>>>>>> I don't know if the RPM just installs like that (probably not).
>>>>>>> But for
>>>>>>> some testing it should be okay to install the RPM with
>>>>>>> 'rpm -ivh --nodeps kernel....rpm'.
>>>>>>>
>>>>>>> If the ports still don't work as expected, please re-post the
>>>>>>> output of
>>>>>>> 'lspci -vv' and the relevant parts from 'dmesg' to me with a CC to
>>>>>>> linux-serial@vger.kernel.org.
>>>>>>>
>>>>>>> Good luck :)
>>>>>>> Niels
>>>>>>>
>>>>>>>
>>>>>>>  
>>>>>>>               
>>>>>>>               
>>>>>>>> lspci -vv shows
>>>>>>>>
>>>>>>>> 02:0e.0 Serial controller: PLX Technology, Inc. Unknown device 9016
>>>>>>>> (rev
>>>>>>>> 01) (prog-if 02 [16550])
>>>>>>>>        Subsystem: Unknown device 544e:0008
>>>>>>>>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>>>>>>>> ParErr- Stepping- SERR+ FastB2B-
>>>>>>>>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>>>>>>>            
>>>>>>>>                 
>>>>>>>>> TAbort-
>>>>>>>>>               
>>>>>>>>>                   
>>>>>>>> <TAbort- <MAbort- >SERR- <PERR-
>>>>>>>>        Interrupt: pin A routed to IRQ 169
>>>>>>>>        Region 0: I/O ports at 2440 [disabled] [size=64]
>>>>>>>>        Region 1: I/O ports at 2490 [disabled] [size=16]
>>>>>>>>        Region 2: I/O ports at 2480 [disabled] [size=16]
>>>>>>>>        Region 3: Memory at f2003000 (32-bit, non-prefetchable)
>>>>>>>> [disabled] [size=4K]
>>>>>>>>        Region 4: Memory at f2002000 (32-bit, non-prefetchable)
>>>>>>>> [disabled] [size=4K]
>>>>>>>>        Region 5: Memory at f2001000 (32-bit, non-prefetchable)
>>>>>>>> [disabled] [size=4K]
>>>>>>>>
>>>>>>>>
>>>>>>>> I saw online in a post from KernelTrap you wrote at
>>>>>>>> http://kerneltrap.org/mailarchive/linux-kernel/2007/3/26/70429 that
>>>>>>>> you
>>>>>>>> created a patch for this.
>>>>>>>>
>>>>>>>> Since i have no idea from C language and how to load the driver can
>>>>>>>> you
>>>>>>>> please let me know what to do to properly load the driver?
>>>>>>>>
>>>>>>>> Thanks a lot for your time and assistance.
>>>>>>>>
>>>>>>>> Chris
>>>>>>>>                         
>>>>>>>>                 
>>>>>>>                   
>>>>>>>               
>>>>>         
>>>>>           
>>>   
>>>       
>
>
>   
