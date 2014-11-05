From: Greg KH <greg@kroah.com>
Subject: Re: Fwd: Fwd: Re: pl2303 linux driver does not work
Date: Tue, 4 Nov 2014 20:29:55 -0800
Message-ID: <20141105042955.GA10613@kroah.com>
References: <5459A26A.2080204@grapecity.mn>
 <5459A354.2000006@grapecity.mn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47281 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751421AbaKEEbH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2014 23:31:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6F6BB2072A
	for <linux-serial@vger.kernel.org>; Tue,  4 Nov 2014 23:31:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <5459A354.2000006@grapecity.mn>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Batdelger.O" <david.batdelger@grapecity.mn>
Cc: linux-serial@vger.kernel.org

On Wed, Nov 05, 2014 at 12:11:00PM +0800, Batdelger.O wrote:
> 
> Thank you for your quick response.
> It's  just simple python code. I'm not sure if flow control is correct. I
> also used gtkterm and tried by every option.  I'm new at usbserial devices.
> How to know how should it be?
> 
>    import time
>    import serial
>    import sys
> 
>    ser = serial.Serial(
>         port='/dev/ttyUSB0',
>         baudrate=4800,
>         parity=serial.PARITY_ODD,
>         stopbits=serial.STOPBITS_ONE,
>         bytesize=serial.EIGHTBITS,
>         # timeout=0

That's a slow baud rate, do you mean that slow?

>    )
> 
>    # RTS 0 DTR 1. not sure it's correct one. I tried by reverse.
>    ser.setRTS(False)
>    ser.setDTR(True)

Does your device support hardware flow control?


> 
> 
>    print ser.isOpen()
> 
>    ON="\x1B\x5D"
>    ser.write(ON)
>    ser.flushOutput()
>    print "after write"
>    # read = ser.read()
>    # sys.stdout.write("RECEIVED:" + read + "\n")
>    ser.close()

Try using minicom to see if you can properly connect to your device
first, before trying to write your own code from "scratch", to determine
that the device works.

greg k-h
