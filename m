From: Alexandre Courbot <Alexandre.Courbot@lifl.fr>
Subject: Disabling the FIFO on the UART - Bug in 8250 mode?
Date: Mon, 14 Jun 2004 15:23:09 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <40CDA6BD.2020606@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:48576 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S262927AbUFNNZH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jun 2004 09:25:07 -0400
Received: from malonne.lifl.fr (malonne.lifl.fr [134.206.10.29])
          by reserv5.univ-lille1.fr (8.12.11/jtpda-5.3.1) with ESMTP id i5EDP0WQ028301
          for <linux-serial@vger.kernel.org>; Mon, 14 Jun 2004 15:25:00 +0200
Received: from lifl.fr (helios.lifl.fr [134.206.10.253])
          by malonne.lifl.fr  with ESMTP id i5EDP2V03226
          for <linux-serial@vger.kernel.org>; Mon, 14 Jun 2004 15:25:02 +0200 (MEST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello everybody,

I'm doing some serial-line programming on an embedded device which has a 
very limited UART, which doesn't feature a FIFO. For my tests I send 
bytes using "echo" or "cat" over the serial line for the device to 
receive. Since the processing of the received data can take some time, 
I've enable hardware flow control (RTS/CTS) which works fine - excepted 
that the PC naturally empty its 16 bytes FIFO before stopping sending 
bytes. Which means that when my device sets CTS to low, I'm losing all 
the bytes that the PC has in the FIFO.

This is a normal behavior and I can't do much about it, excepted 
disabling the FIFO on the PC. This is what I'd like to do, but 
unfortunately, as states the Linux Serial Howto:

"As of late 2000 there was no way the Linux user could set these [the 
FIFO buffers settings] directly (setserial can't do it)."

I've read somewhere else what seems to be a workaround to do it anyway:
(http://groups.google.nl/groups?q=stty+disable+fifo&hl=nl&lr=&ie=UTF-8&selm=Printing-HOWTO.1-24498.841892935%40cc.gatech.edu&rnum=8)

   7.2.  Older serial printers that drop characters

   Jon Luckey points out that some older serial printers with ten-cent
   serial interfaces and small buffers really mean stop when they say so
   with flow control.  He found that disabling the FIFO in his Linux
   box's 16550 serial port with setserial corrected the problem of
   dropped characters (you apparently just specify the uart type as an
   8250 to do this).

So I tried doing so (setserial /dev/ttyS0 uart 8250), and that's where 
the weird things start. My device then only receives one byte on 16 
(i.e. the latest to enter the FIFO when the serial interrupt is 
triggered!). It is clearly stated that a 8250 uart does not have any 
FIFO, so I'm starting to suspect a bug here. I've tested on two Linux 
x86 machines, runnning kernels 2.6.3 and 2.6.6, the behavior is the 
same. I've also tried with UARTs16550 and 16450.

I've also been able to quickly test on a Windows machine. There, I am 
able to set some advanced settings of the UART (including 
enabling/disabling the FIFO and tuning its size) and everything works as 
I'd like.

I really need the ability to disable the FIFO to death. Is there a good 
reason why it is not possible with Linux? Any workaround to disable it 
properly? Is the behavior in 8250 mode incorrect/buggy (the quotation 
seems to ?

Since I'm in bad need for this I'm ready to add support for it myself if 
necessary.

Any help/pointer would be greatly appreciated.
Thanks,
Alex.
-- 
Alexandre Courbot - PhD student
RD2P/LIFL
http://www.lifl.fr/~courbot
