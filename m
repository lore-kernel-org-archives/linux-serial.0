From: Ross Boylan <RossBoylan@stanfordalumni.org>
Subject: Re: Serial port shuts down APC UPS
Date: Fri, 24 Jan 2003 14:38:10 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030124223810.GB1459@wheat.boylan.org>
References: <11E89240C407D311958800A0C9ACF7D1A33D5E@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33D5E@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: Ed Vance <EdV@macrolink.com>
Cc: 'Ross Boylan' <RossBoylan@stanfordalumni.org>, linux-serial@vger.kernel.org

I haven't digested the whole message, but I do have some relevant
info.
On Fri, Jan 24, 2003 at 10:16:50AM -0800, Ed Vance wrote:
> 
> Hi Ross,
> 
> First off, let the serial driver find your ports. Don't use setserial on a
> PCI based system to tell the driver where the ports are. If the automatic
> scan does not find a motherboard resident legacy serial port, then that port
> is likely disabled in the BIOS. As you suspect, the "LSR safety check
> engaged" message means that there is no UART at the specified address. (LSR
> reads as all ones.)
> 
> To find out which ports have been detected, run "dmesg | more". After an
> incomprehensible page or two, you should find the serial driver's
> initialization messages, something like the following:
> 
> 	Serial driver version 5.05c (2001-07-08) with SHARE_IRQ 
> 	SERIAL_PCI ISAPNP enabled
> 	ttyS00 at 0x03f8 (irq = 4) is a 16550A
> 	ttyS01 at 0x02f8 (irq = 3) is a 16550A 
> 
> If there are additional serial port cards in the system, they will follow
> starting at ttyS04. BTW, ignore the silly leading zero in the tty names. 

The odd thing is that the settings show in dmesg and setserial are
consistent for ttyS1, which is having problems, but not for some of
the others, which work.

dmesg:

Jan 24 06:32:49 wheat kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jan 24 06:32:49 wheat kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jan 24 06:32:49 wheat kernel: ttyS02 at 0x03e8 (irq = 4) is a 16550A
Jan 24 06:32:49 wheat kernel: ttyS01 at port 0x02f8 (irq = 3) is a 16550A

Is there any significance to the fact the report is not in numerical
port order?

setserial:
/dev/ttyS0 uart 16550A port 0x03f8 irq 4 baud_base 115200 spd_normal skip_test
/dev/ttyS1 uart 16550A port 0x02f8 irq 3 baud_base 115200 spd_normal skip_test
/dev/ttyS2 uart 16550A port 0x03e8 irq 5 baud_base 115200 spd_normal skip_test

ttyS2 differs (used by internal modem).

Are you saying I should remove setserial from my system?  disable it
from running on startup?

> 
> All serial ports that the driver detected will be displayed here. It does
> not matter if a serial cable is attached or not. If your legacy port of
> interest does not appear in this list, then something else is wrong -
> probably broken hardware or disabled in the BIOS.
> 
> Test the port of interest by attaching it to an async terminal or terminal
> emulator that you know works and either echo characters to the port or use
> cat to display received characters. Verify that you have communication in
> both directions. Note that the port will default to 9600 baud. 

Do you mean attach a physical device to it?  I don't have one.  Or
just hook up to it with software?

> 
> Typically, the application program that opens the port is responsible for
> setting the baud rate and other port configurables that it will use. see man
> termios. 

So perhaps the apcupsd I have would set the port correctly, except
that the prior problem (LSR safety check engaged) is interefering.
This would be a happy outcome.


> 
> APC has a couple of flavors of interfaces. I don't know about the BackUPS
> 650 in particular. Since APC told you that the baud rate matters, I assume
> that it is not the signal level controlled interface found on the early
> models. That one required a different cable for Un*x and Windoze because of
> big differences in the monitoring software. (The Win cable has active
> components potted into it.) I thought the data byte oriented interface was
> only on the SmartUPS series. Hmmm ...

Well, they did tell me I needed different cables for Unix and Windows,
and they did say the UPS was being disable by a voltage on one of the
pins on the COM port.

> 
> Did APC give you a monitoring program to run? My last experience was with a
They have one on their site; I am using another that Debian packaged;
and their are several others.  The unit is quite stupid though, and
doesn't have much to say.

It does, they say, send info along the serial cable in bits (I think
this is what you mean by a "data signal", while the "disable" going
from the computer to the UPS is apparently a raw voltage).  I don't
know if anything other than "on battery" ever gets sent.

> BackUPS 600, which had the signal level interface and I had to write a
> program to monitor it. There are no data signals on the signal level
> interface so baud rate does not matter. Using a "gray cable" purchased from
> APC, we found the modem status signals were used as follows:
> 
> 	DCD ON  -  AC power has failed.
> 	DCD OFF -  AC power is normal/restored.
> 	CTS ON  -  Low Battery signal - less than a tiny bit of charge.
> 	CTS OFF -  Battery has at least a tiny bit of charge.
> 
> Do you have the pin-out signal descriptions for the connector on the
> UPS? 

No, though I suppose APC might share it.  As I understand it, the
issue is not only what the pinouts from the UPS are, but what comes
out at the other end of the cable.  APC seems to have different cables
that do different things.

There is some fairly rich information with the apcupsd.  I'll include
it here in the hopes it means more to you or someone else than it does
to me!  My cable is a 940-0020C from APC.  Unencouragingly, this is
not among the listed cable types for apcupsd (though it does have
940-0020B and simple).

-------------README.BackUPS-----------------------

The RTS serial port signal is used to shut down the UPS. The UPS will
shut down only if it operates from its battery. The manual says that
the shutdown signal must be high for at least 0.5s. But few milliseconds
is enough, at least for my APC Back-UPS 600.

Using RTS to shut down the UPS can be dangerous, because the RTS goes
high when the serial device is opened. The backupsd program then turns
RTS off, but it is on (high) for a moment. This kills the power when
backupsd is first started and there is a power failure at this time.
This can happen for example when the UPS is shut down, unattended,
and the power comes back for a while.

Either start backupsd before mounting any filesystems for read-write,
or (better) use TX (pin 3) instead of RTS (pin 7) to shut down the
UPS (pin numbers are for 9-pin plug). Use ioctl(fd, TCSBRKP, 10);
to make TX high for one second, for example. Using TX should be safe.
Maybe I will post the diffs if time permits...

------------- README.cables (parts) -----------------------

You may use this cable with both the Back-UPS and Smart-UPS from APC.
YES, I did state the above line, but you must set in the CONFIG file

Both cables for the Back-UPS from APC only have been tested and are
in use on three different Linux-Boxes.

   Cable for a smarter Back-UPS from APC only.
 
   Computer Side   |  Description of Cable           |  UPS Side
   DB9f  |  DB25f  |                                 |    DB9m
    4    |   20    |  DTR (5vcc)             *below  |    n/c
    8    |    5    |  CTS (low-batt)         *below  |     5
    2    |    3    |  RxD (other line-fail)  *below  |     3
    5    |    7    |  Ground (Signal)                |     4
    1    |    8    |  CD (line-fail from ups)        |     2
    7    |    4    |  RTS (shutdown ups)             |     1
   n/c   |    1    |  Frame/Case Gnd (optional)      |     9

*BELOW*

List if componets one needs to make this CABLE:

1) One (1) male DB9 connector.
2) One (1) female DB25 or DB9 connector.
   solder type not crimp DB connectors with standard hoods.
3) two (2) 4.7K ohm 1/4 watt %5 resistors.
4) one (1) foot of 3/32" (inch).
5) shrink wrap/boot.
6) rosin core solder.
7) three (3) to five (5) feet of 22AWG multi-stranded five (5) conductor cable.


First solder both of the resistors into pin# (4) DB9 or (20) DB25 the DTR.
This will be used as the Vcc pull-up voltage for testing the outputs on
you "BackUPS by APC" !!!! ONLY !!!!, all others at your own RISK!!!!!!

Next bend each of the resistors so that one connects to (8) DB9 or (5) DB25
the CTS (aka battery low signal) and the other to (2) DB9 or (3) DB25 the
RxD (aka another line fail signal).  This line is not currently used, but
it will be in the near future.

   Note: 8/5 is also wire to pin# 5 on the UPS side of the cable.
   Note: 2/3 is also wire to pin# 3 on the UPS side of the cable.

   note: we use the DTR as our +5 volts power for the circuit.

The rest of the wire connections are listed above.

I use this cable and daemon on my server that controls an APC BackUPS-600VA
that has one Cisco 1005 ISDN/Enet router, one 24-port HP-Enet Hub, and one
server (AMD-5x86-P75) w/o monitor.  Enjoy the power security of UPS control.

-------------apcupsd.txt (part) -----------------
BackUPS and NetUPS Simple Signals:

	LINEFAIL : OnlineStatus
	BATTSTAT : BatteryStatus
----------------------------------------

>We
> could infer level or data oriented interface from the signal names. If it is
> the data oriented interface, I don't know the protocol. You would have to
> have a monitoring application program from APC. If you have such a program,
> then it should configure the serial port all by itself. 
> 
> Hope that was more clarifying than confusing.
> 
> Cheers,
> Ed
> 
> Ed Vance              edv (at) macrolink (dot) com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
