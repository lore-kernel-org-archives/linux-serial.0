From: Romano Giannetti <romanol@upco.es>
Subject: New "clone" two-serial card do not work in 2.6.8
Date: Fri, 6 May 2005 10:45:30 +0200
Message-ID: <20050506084530.GA21789@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.upco.es ([130.206.70.227]:19367 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261181AbVEFIph (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 May 2005 04:45:37 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Hi,

I have a two-ports serial card that claims to be a "Cyber 8000 plus". I
tried to make it works in 2.6.8 without success. The kernel is a 2.6.8 and
the distro Mandrake, so that I have devfs on. 

On lspci -vv the card answer with this two entries: 

01:07.0 Serial controller: Oxford Semiconductor Ltd EXSYS EX-41092 Dual 16950 Serial adapter (prog-if 06 [16950])
        Subsystem: AFAVLAB Technology Inc: Unknown device 2130
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at dec0 [size=32]
        Region 1: Memory at feadc000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at dee0 [size=32]
        Region 3: Memory at feadd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:07.1 Bridge: Oxford Semiconductor Ltd: Unknown device 9510
        Subsystem: AFAVLAB Technology Inc: Unknown device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at df00 [size=32]
        Region 1: Memory at feade000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at df20 [size=32]
        Region 3: Memory at feadf000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


I tried to do 

# setserial /dev/ttyS2 port 0xdec0 UART 16550A irq 16  && echo 1 > /dev/ttyS2 
                
After a bit I have: 

irq 16: nobody cared!
 [<c0107bfe>] dump_stack+0x1e/0x20
 [<c01090ab>] __report_bad_irq+0x2b/0x90
 [<c01091c0>] note_interrupt+0x90/0xb0
 [<c0109430>] do_IRQ+0xe0/0x100
 [<c010778c>] common_interrupt+0x18/0x20
 [<c01050ed>] cpu_idle+0x2d/0x40
 [<c036c824>] start_kernel+0x184/0x1c0
 [<c010019f>] 0xc010019f
handlers:
[<f8a4aff0>] (usb_hcd_irq+0x0/0x70 [usbcore])
[<f8a4aff0>] (usb_hcd_irq+0x0/0x70 [usbcore])
Disabling IRQ #16

My .config | grep -i serial: 

CONFIG_PARPORT_SERIAL=m
# Old Serial dongle support
CONFIG_MOUSE_SERIAL=m
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ESPSERIAL=m
# Serial drivers
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_WACOM_ACPI=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_MULTIPORT=y
CONFIG_SERIAL_8250_RSA=y
# Non-8250 serial port support
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SND_SERIAL_U16550=m
# USB Serial Converter support
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_G_SERIAL=m
CONFIG_LIRC_SERIAL=m
# CONFIG_LIRC_SERIAL_ANIMAX is not set
CONFIG_LIRC_SERIAL_IRDEO=y
# CONFIG_LIRC_SERIAL_IRDEO_REMOTE is not set
CONFIG_LIRC_SERIAL_TRANSMITTER=y
CONFIG_LIRC_SERIAL_SOFTCARRIER=y
# CONFIG_LIRC_SERIAL_IGOR is not set
CONFIG_LIRC_SERIAL_COM1=y
# CONFIG_LIRC_SERIAL_COM2 is not set
# CONFIG_LIRC_SERIAL_COM3 is not set
# CONFIG_LIRC_SERIAL_COM4 is not set
# CONFIG_LIRC_SERIAL_OTHER is not set
CONFIG_LIRC_PORT_SERIAL=0x3f8
CONFIG_LIRC_IRQ_SERIAL=0x4

Any hints? Thank you very much, 
    
           Romano


        
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
