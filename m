From: "Salomon, Frank" <frank.salomon@wincor-nixdorf.com>
Subject: Re: Serial port read working but not write.
Date: Fri, 23 Jul 2004 11:30:11 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <4100DAA3.7060205@wincor-nixdorf.com>
References: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mixi.wincor-nixdorf.com ([217.115.67.70]:58291 "HELO
	mail.wincor-nixdorf.com") by vger.kernel.org with SMTP
	id S267455AbUGWJpE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2004 05:45:04 -0400
Received: from label.wincor-nixdorf.com (label.wincor-nixdorf.com [172.18.160.24])
	by zipp.wincor-nixdorf.com (8.12.8/8.12.8) with ESMTP id i6N9j3Aw019344
	for <linux-serial@vger.kernel.org>; Fri, 23 Jul 2004 11:45:03 +0200
In-Reply-To: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,
the problem is you need a procedure which find out what the problem is.
Hardware check:
Your hole hardware you can divided in:
- PC - com port
- cable
- external Hardware

Check the com-port:
create a cable bridge between pin 2 and 3 of you port.
run # dd bs=1 count=1 if=/dev/ttySx | hexdump
on an other vt run # cat /dev/inittab > /dev/ttySx

If you don't see any output on the vt, which is running "dd bs=1 count=1 
if=/dev/ttySx | hexdump", your com port is not working correct.

Next you can connect your cable to the PC and pug the bridge to the
end of the cable and perform the same test.

Best Regards, Frank


suresh shenoy wrote:
> Hi all,
> 
>    I am currently using redhat linux 9.0. I am working
> with a hardware which senses some data and sends back
> to the PC through serial port. It also can move a dc
> motor using the same hardware. I am using POSIX serial
> port programming for talking with the board. After
> some struggles i was able to read the data from the
> hardware device. But my current problem is that it is
> not moving the motor when i send a command to the
> hardware. Does anyone know the solution to this
> problem. Please let me know if any piece of code or
> any more information is required that i can furnish.
> 
> Thanks & Regards,
> Suresh M Shenoy.
> 
> ________________________________________________________________________
> Yahoo! India Careers: Over 65,000 jobs online
> Go to: http://yahoo.naukri.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
