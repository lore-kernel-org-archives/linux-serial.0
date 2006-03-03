From: malk@sidehack.sat.gweep.net
Subject: Re: Possible bug in serial driver 8250/8250-fourport
Date: Fri, 3 Mar 2006 14:17:01 -0500 (EST)
Message-ID: <20060303191701.48315.qmail@sidehack.sat.gweep.net>
References: <200603031714.26023.haiku@bloodshed.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sidehack.sat.gweep.net ([204.145.148.154]:10744 "HELO
	sidehack.sat.gweep.net") by vger.kernel.org with SMTP
	id S1751499AbWCCTRC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Mar 2006 14:17:02 -0500
In-Reply-To: <200603031714.26023.haiku@bloodshed.net> from "Colin Laplace" at Mar 03, 2006 05:14:25 PM
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Colin Laplace <haiku@bloodshed.net>
Cc: linux-serial@vger.kernel.org

Did you try monitoring /proc/tty/driver/serial for the ports in question
(byte counts in and out, and any errors (framing, parity, etc)) are in
there, you can confirm your setserial settings there too, account for all
bytes in and out.

Also -- do you have software or hardware flow control going?
i.e. how are your tty's configured?  sounds like they should be a 
raw setup -- if canonical mode or otherwise are consuming characters
that should normally pass through to your equipment it may cause
problems.  I have no clue what protocol your music equipment speaks.

Might be worthwhile sending your code snippet that configures your ttys
and if hardware flow control is involved etc.

The serial and tty layer (I've found) have been very robust for a bunch
of multiport stuff I've been doing in the last 6 months (albeit a 2.4
kernel).  The tty stuff really has to work right as a lot of stuff
besides just serial ports are tty based (duh).

Good luck w/ your project.

> Hello,
> 
> I am writing to this list because i am now clueless on a problem i am having 
> with writing data on a serial port, and now the only thing i can think of is 
> a serial driver bug.
> The situation is the following :
> I have a NetMos Technology PCI 9845 Multi-I/O Controller (rev 01), which has 
> four ports. Each of its ports are connected as follow :
> - port 1 TX connected to a Midi Chipset DREAM SAM9708 port 1
>   port 1 RX connected to FATAR midi keyboard 
> - port 2 TX connected to a Midi Chipset DREAM SAM9708 port 2
> - port 3 connected to an external midi in/out (1)
> - port 4 connected to an external midi in/out (2)
> 
> This configuration has been tested on both kernel 2.6.10 with 8250 module, and 
> 2.6.15 with 8250-fourport module, the problem arises on both.
> Each of the serial ports are configured this way :
> setserial /dev/tts/$id uart 16550A port 0x$addr irq $irq
> ^fourport spd_cust divisor 8 low_latency
> 
> The problem is as follow :
> When playing MIDI data over port 1, sometimes the output just stops, the data 
> doesn't go anymore to the Dream 1 port. Then (and that's the strange part), 
> if we press a key of the FATAR keyboard (connected to the same serial port 
> but on RX), all the data that was not played comes out all of a sudden, and 
> the playback continues to be output normally. This problem does *NOT* happen 
> on any of the other serial ports, only on the one where TX is connected to 
> the dream 1 and RX to the FATAR midi keyboard.
> I have been trying with both snd-serialmidi alsa driver, as well with a 
> homemade user-land program which drives midi events to the serial port, and 
> the problems happens on both ways. Also, very important to note : NO error 
> messages are given by write() calls when the problem arises, nor do i get 
> kernel messages.
> 
> This situation happens very often. If you need any other information please 
> let me know. I would really appreciate any feedback you could have about this 
> matter.
> 
> Best regards,
> Colin Laplace
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

