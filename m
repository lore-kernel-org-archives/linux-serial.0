From: Ed Vance <EdV@macrolink.com>
Subject: RE: Serial port shuts down APC UPS
Date: Fri, 24 Jan 2003 10:16:50 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33D5E@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Ross Boylan' <RossBoylan@stanfordalumni.org>
Cc: linux-serial@vger.kernel.org

On Thu, Jan 23, 2003 at 5:39 PM, Ross Boylan wrote:
> 
> When I connect my APC BackUPS 650 to ttyS1 the unit turns off when
> Linux starts up.  APC tells me (after several days) that a different
> cable is necessary for Unixy systems than for windows.  Apparently
> some voltage on the serial port gets transmitted back to the unit,
> which interprets it as a shut down signal.  (That is, I continue to
> get power, but if the wall power fails the battery won't kick in).
> 
> Since the hardware works under Windows, I assume there is a software
> solution, and I would like to find it.
> 
> APC further says the port should be at 2400 baud, with Flow set to
> XON/XOFF (which might also be known as no FIFO).  I find baud control
> but no flow control in setserial, and at any rate my understanding is
> that it doesn't reprogram the physical device.
> 
> serial.c appears to set FIFO on, so that's probably part of the
> problem.  Is it safe to turn it off, or would that require
> rearchitecting things?  (Also, I don't know how to turn it off).
> 
> As a final complication, I get "LSR safety check engaged" on ttyS1
> when I start, even if the cable is disconnected.  My suspicion is that
> this indicates I have the wrong IO range or IRQ in setserial.
> 
> I've built my kernel from source (2.4.19 under Debian), so it would be
> relatively easy for me to modify serial.c (for example)--if I knew
> what to do!
> 
> Gigabyte GI-7IXE4 motherboard, using the AMD 751/756 chipset.  Athlon
> processor.  I've looked around for the ports in /proc/isapnp and
> lspci, but haven't found anything.  A mouse is on the other port, and
> I have an internal modem using another port.  Also using USB scanner.
> There are quite a lot of peripherals; interrupts are in short supply.
> 
> In case you can't tell, I'm no hardware expert.  I'd appreciate any
> help.  What do I need to do to get the serial port to work with my
> UPS?
> 

Hi Ross,

First off, let the serial driver find your ports. Don't use setserial on a
PCI based system to tell the driver where the ports are. If the automatic
scan does not find a motherboard resident legacy serial port, then that port
is likely disabled in the BIOS. As you suspect, the "LSR safety check
engaged" message means that there is no UART at the specified address. (LSR
reads as all ones.)

To find out which ports have been detected, run "dmesg | more". After an
incomprehensible page or two, you should find the serial driver's
initialization messages, something like the following:

	Serial driver version 5.05c (2001-07-08) with SHARE_IRQ 
	SERIAL_PCI ISAPNP enabled
	ttyS00 at 0x03f8 (irq = 4) is a 16550A
	ttyS01 at 0x02f8 (irq = 3) is a 16550A 

If there are additional serial port cards in the system, they will follow
starting at ttyS04. BTW, ignore the silly leading zero in the tty names. 

All serial ports that the driver detected will be displayed here. It does
not matter if a serial cable is attached or not. If your legacy port of
interest does not appear in this list, then something else is wrong -
probably broken hardware or disabled in the BIOS.

Test the port of interest by attaching it to an async terminal or terminal
emulator that you know works and either echo characters to the port or use
cat to display received characters. Verify that you have communication in
both directions. Note that the port will default to 9600 baud. 

Typically, the application program that opens the port is responsible for
setting the baud rate and other port configurables that it will use. see man
termios. 

APC has a couple of flavors of interfaces. I don't know about the BackUPS
650 in particular. Since APC told you that the baud rate matters, I assume
that it is not the signal level controlled interface found on the early
models. That one required a different cable for Un*x and Windoze because of
big differences in the monitoring software. (The Win cable has active
components potted into it.) I thought the data byte oriented interface was
only on the SmartUPS series. Hmmm ...

Did APC give you a monitoring program to run? My last experience was with a
BackUPS 600, which had the signal level interface and I had to write a
program to monitor it. There are no data signals on the signal level
interface so baud rate does not matter. Using a "gray cable" purchased from
APC, we found the modem status signals were used as follows:

	DCD ON  -  AC power has failed.
	DCD OFF -  AC power is normal/restored.
	CTS ON  -  Low Battery signal - less than a tiny bit of charge.
	CTS OFF -  Battery has at least a tiny bit of charge.

Do you have the pin-out signal descriptions for the connector on the UPS? We
could infer level or data oriented interface from the signal names. If it is
the data oriented interface, I don't know the protocol. You would have to
have a monitoring application program from APC. If you have such a program,
then it should configure the serial port all by itself. 

Hope that was more clarifying than confusing.

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
