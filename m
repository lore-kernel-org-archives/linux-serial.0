From: "Salomon, Frank" <frank.salomon@wincor-nixdorf.com>
Subject: Re: Serial port read working but not write.
Date: Fri, 23 Jul 2004 14:12:49 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <410100C1.5030404@wincor-nixdorf.com>
References: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com> <4100DAA3.7060205@wincor-nixdorf.com>
   <20040723100226.GU18676@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from muxi.wincor-nixdorf.com ([217.115.67.71]:53137 "HELO
	mail.wincor-nixdorf.com") by vger.kernel.org with SMTP
	id S263806AbUGWM1n (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2004 08:27:43 -0400
Received: from label.wincor-nixdorf.com (label.wincor-nixdorf.com [172.18.160.24])
	by zipp.wincor-nixdorf.com (8.12.8/8.12.8) with ESMTP id i6NCRgAw023805
	for <linux-serial@vger.kernel.org>; Fri, 23 Jul 2004 14:27:42 +0200
In-Reply-To: <20040723100226.GU18676@lug-owl.de>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org



Jan-Benedict Glaw wrote:
> On Fri, 2004-07-23 11:30:11 +0200, Salomon, Frank <frank.salomon@wincor-nixdorf.com>
> wrote in message <4100DAA3.7060205@wincor-nixdorf.com>:
> 
>>Hi,
>>the problem is you need a procedure which find out what the problem is.
>>Hardware check:
>>Your hole hardware you can divided in:
>>- PC - com port
>>- cable
>>- external Hardware
>>
>>Check the com-port:
>>create a cable bridge between pin 2 and 3 of you port.
>>run # dd bs=1 count=1 if=/dev/ttySx | hexdump
>>on an other vt run # cat /dev/inittab > /dev/ttySx
>>
>>If you don't see any output on the vt, which is running "dd bs=1 count=1 
>>if=/dev/ttySx | hexdump", your com port is not working correct.
> 
> 
> This doesn't need to work, depending on handshake settings. Also, (at
> least in theory), you can have different sending and receiving speeds...
> 
> 
>>Next you can connect your cable to the PC and pug the bridge to the
>>end of the cable and perform the same test.
> 
> 
> ...which also depends on tty settings.
> 
> man stty
> 
> MfG, JBG
> 
Hi,
it there any linux OS on which that test does not work after reboot ?

Mit freundlichen Gruessen,
Best regards,
Frank
