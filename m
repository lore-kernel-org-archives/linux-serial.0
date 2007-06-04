From: kees <kees@schoen.mine.nu>
Subject: Re: serial port cannot be read in linux
Date: Mon, 04 Jun 2007 08:46:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706040845390.23789@schoen3.schoen.mine.nu>
References: <730b6c6b0706021439w41923cddvbf9fe953255190c0@mail.gmail.com>
 <730b6c6b0706021440y7bb07837l104f1afbc25ee4fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from psmtp08.wxs.nl ([195.121.247.22]:57352 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbXFDGqR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jun 2007 02:46:17 -0400
Received: from schoen3.schoen.mine.nu
 (ip5457f49a.direct-adsl.nl [84.87.244.154])
 by psmtp08.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14
 2006)) with ESMTP id <0JJ300GH9MT3CS@psmtp08.wxs.nl> for
 linux-serial@vger.kernel.org; Mon, 04 Jun 2007 08:46:15 +0200 (MEST)
In-reply-to: <730b6c6b0706021440y7bb07837l104f1afbc25ee4fa@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hello Bello <domician@gmail.com>
Cc: linux-serial@vger.kernel.org

Hi,

What does stty -a </dev/ttyS0 return to you?

regards

Kees


On Sat, 2 Jun 2007, Hello Bello wrote:

> Hello,
>
> I am trying to use a serial port in linux. My architecture is:
> -compaq evo n600c
> -debian GNU Linux 3.1
> -vanilla kernel: Linux furge 2.6.21 #2 SMP Sat Jun 2 21:25:42 CEST
> 2007 i686 GNU/Linux
>
> This is my dmesg output:
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
> 00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>
> I am trying to test the serial port by jumpering the receive and
> transmit pins of the serial port.
>
> Using this hardware, windows XP serial port tester program echos back
> the characters written to the port, so the hardware is ok.
>
> However, in Linux, the port stays dumb. I can write to it, but there
> is nothing to be read from it.
> e.g.
> cat /dev/ttyS0 > /tmp/serial.txt &; echo "a" > /dev/ttyS0; cat 
> /tmp/serial.txt
> or
> cp /dev/ttyS0 /dev/tty1; echo "a" > /dev/ttyS0
>
> I have read through the "Cannot write but not read" topic in this
> mailing list, but without any success.
> Also I have tried several serial port testing programs, all in vain.
> Kernel recompilations made no luck.
>
>
> I would really appreciate your help,
> Thanks,
> Gabor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
