From: Greg KH <greg@kroah.com>
Subject: Re: Fwd: Fwd: Re: pl2303 linux driver does not work
Date: Wed, 5 Nov 2014 19:36:20 -0800
Message-ID: <20141106033620.GA16661@kroah.com>
References: <5459A26A.2080204@grapecity.mn>
 <5459A354.2000006@grapecity.mn>
 <20141105042955.GA10613@kroah.com>
 <545ADCD8.3020702@grapecity.mn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51320 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbaKFDgW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 22:36:22 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9786720B55
	for <linux-serial@vger.kernel.org>; Wed,  5 Nov 2014 22:36:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <545ADCD8.3020702@grapecity.mn>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Batdelger.O" <david.batdelger@grapecity.mn>
Cc: linux-serial@vger.kernel.org

On Thu, Nov 06, 2014 at 10:28:40AM +0800, Batdelger.O wrote:
> 
> >On Wed, Nov 05, 2014 at 12:11:00PM +0800, Batdelger.O wrote:
> >>Thank you for your quick response.
> >>It's  just simple python code. I'm not sure if flow control is correct. I
> >>also used gtkterm and tried by every option.  I'm new at usbserial devices.
> >>How to know how should it be?
> >>
> >>    import time
> >>    import serial
> >>    import sys
> >>
> >>    ser = serial.Serial(
> >>         port='/dev/ttyUSB0',
> >>         baudrate=4800,
> >>         parity=serial.PARITY_ODD,
> >>         stopbits=serial.STOPBITS_ONE,
> >>         bytesize=serial.EIGHTBITS,
> >>         # timeout=0
> >That's a slow baud rate, do you mean that slow?
>     Actually, baud rate is 9600. 4800 was one of my attempts.
> >>    )
> >>
> >>    # RTS 0 DTR 1. not sure it's correct one. I tried by reverse.
> >>    ser.setRTS(False)
> >>    ser.setDTR(True)
> >Does your device support hardware flow control?
> I think so. The Features section of device doc contains line: "Automatic hardware flow control with CTS/RTS
>". But I'm not sure. How to know exactly it does?.

You usually need to set this up on the device itself.  The manual for
the device should say how to do this.

> >>
> >>    print ser.isOpen()
> >>
> >>    ON="\x1B\x5D"
> >>    ser.write(ON)
> >>    ser.flushOutput()
> >>    print "after write"
> >>    # read = ser.read()
> >>    # sys.stdout.write("RECEIVED:" + read + "\n")
> >>    ser.close()
> >Try using minicom to see if you can properly connect to your device
> >first, before trying to write your own code from "scratch", to determine
> >that the device works.
>     Device is working fine on windows 7. My simple python scripts is working
> fine without setting any options except port name (on win7).

Again, please try running minicom on Linux which sets up the line
settings in a "known manner" before blaming the kernel driver :)

thanks,

greg k-h
