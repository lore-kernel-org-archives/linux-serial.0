From: "Batdelger.O" <david.batdelger@grapecity.mn>
Subject: Fwd: Fwd: Re: pl2303 linux driver does not work
Date: Wed, 05 Nov 2014 12:11:00 +0800
Message-ID: <5459A354.2000006@grapecity.mn>
References: <5459A26A.2080204@grapecity.mn>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cp.mobinet.mn ([202.131.224.55]:56498 "EHLO cp.mobinet.mn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbaKEELC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2014 23:11:02 -0500
Received: from [202.131.242.154] (port=54550 helo=[192.168.71.31])
	by cp.mobinet.mn with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <david.batdelger@grapecity.mn>)
	id 1Xlrvu-0004nW-91
	for linux-serial@vger.kernel.org; Wed, 05 Nov 2014 12:10:58 +0800
In-Reply-To: <5459A26A.2080204@grapecity.mn>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Thank you for your quick response.
It's  just simple python code. I'm not sure if flow control is correct. 
I also used gtkterm and tried by every option.  I'm new at usbserial 
devices. How to know how should it be?

    import time
    import serial
    import sys

    ser = serial.Serial(
         port='/dev/ttyUSB0',
         baudrate=4800,
         parity=serial.PARITY_ODD,
         stopbits=serial.STOPBITS_ONE,
         bytesize=serial.EIGHTBITS,
         # timeout=0
    )

    # RTS 0 DTR 1. not sure it's correct one. I tried by reverse.
    ser.setRTS(False)
    ser.setDTR(True)


    print ser.isOpen()

    ON="\x1B\x5D"
    ser.write(ON)
    ser.flushOutput()
    print "after write"
    # read = ser.read()
    # sys.stdout.write("RECEIVED:" + read + "\n")
    ser.close()


-- 
Best regards,
Batdelger.O R&D engineer
Grapecity Mongolia LLC


On 2014.11.05 10:25, Greg KH wrote:
> On Wed, Nov 05, 2014 at 09:37:59AM +0800, Batdelger.O wrote:
>> Hello
>> Hope you guys are doing great.
>> I've got problem with pl2303 Linux driver. In a nutshell, my mission is to
>> control magnetic card reader/writer with PL-2303 XA / HXA chip from the
>> Linux. I'm using Ubuntu 14.04(kernel version: 3.13.0-39-generic). Everything
>> is going fine. Giving no errors. Writing data via usb-serial seems to work.
>> But the device is not receiving data. If that issue familiar with you,
>> please give me advice.
> How exactly are you "writing data"?  And have you set up flow control
> properly?
>
> thanks,
>
> greg k-h
>

-- 
Best regards,
Batdelger.O R&D engineer
Grapecity Mongolia LLC





