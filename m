From: "Hello Bello" <domician@gmail.com>
Subject: Re: serial port cannot be read in linux
Date: Sat, 2 Jun 2007 23:40:49 +0200
Message-ID: <730b6c6b0706021440y7bb07837l104f1afbc25ee4fa@mail.gmail.com>
References: <730b6c6b0706021439w41923cddvbf9fe953255190c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:64136 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724AbXFBVku (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 2 Jun 2007 17:40:50 -0400
Received: by ug-out-1314.google.com with SMTP id j3so466134ugf
        for <linux-serial@vger.kernel.org>; Sat, 02 Jun 2007 14:40:49 -0700 (PDT)
In-Reply-To: <730b6c6b0706021439w41923cddvbf9fe953255190c0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I am trying to use a serial port in linux. My architecture is:
-compaq evo n600c
-debian GNU Linux 3.1
-vanilla kernel: Linux furge 2.6.21 #2 SMP Sat Jun 2 21:25:42 CEST
2007 i686 GNU/Linux

This is my dmesg output:
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

I am trying to test the serial port by jumpering the receive and
transmit pins of the serial port.

Using this hardware, windows XP serial port tester program echos back
the characters written to the port, so the hardware is ok.

However, in Linux, the port stays dumb. I can write to it, but there
is nothing to be read from it.
e.g.
cat /dev/ttyS0 > /tmp/serial.txt &; echo "a" > /dev/ttyS0; cat /tmp/serial.txt
or
cp /dev/ttyS0 /dev/tty1; echo "a" > /dev/ttyS0

I have read through the "Cannot write but not read" topic in this
mailing list, but without any success.
Also I have tried several serial port testing programs, all in vain.
Kernel recompilations made no luck.


I would really appreciate your help,
Thanks,
Gabor
