From: Colin Laplace <haiku@bloodshed.net>
Subject: Possible bug in serial driver 8250/8250-fourport
Date: Fri, 3 Mar 2006 17:14:25 +0100
Message-ID: <200603031714.26023.haiku@bloodshed.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ip-218.36.113.64.sbbsnet.net ([64.113.36.218]:16398 "EHLO
	john.anime.com.ar") by vger.kernel.org with ESMTP id S932101AbWCCQPQ
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Mar 2006 11:15:16 -0500
Received: from [192.168.2.5] (133.Red-88-7-215.staticIP.rima-tde.net [88.7.215.133])
	by cobalt-eth1.anime.com.ar (8.10.2/8.10.2) with ESMTP id k23G6BE25622
	for <linux-serial@vger.kernel.org>; Fri, 3 Mar 2006 11:06:12 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I am writing to this list because i am now clueless on a problem i am having 
with writing data on a serial port, and now the only thing i can think of is 
a serial driver bug.
The situation is the following :
I have a NetMos Technology PCI 9845 Multi-I/O Controller (rev 01), which has 
four ports. Each of its ports are connected as follow :
- port 1 TX connected to a Midi Chipset DREAM SAM9708 port 1
  port 1 RX connected to FATAR midi keyboard 
- port 2 TX connected to a Midi Chipset DREAM SAM9708 port 2
- port 3 connected to an external midi in/out (1)
- port 4 connected to an external midi in/out (2)

This configuration has been tested on both kernel 2.6.10 with 8250 module, and 
2.6.15 with 8250-fourport module, the problem arises on both.
Each of the serial ports are configured this way :
setserial /dev/tts/$id uart 16550A port 0x$addr irq $irq
^fourport spd_cust divisor 8 low_latency

The problem is as follow :
When playing MIDI data over port 1, sometimes the output just stops, the data 
doesn't go anymore to the Dream 1 port. Then (and that's the strange part), 
if we press a key of the FATAR keyboard (connected to the same serial port 
but on RX), all the data that was not played comes out all of a sudden, and 
the playback continues to be output normally. This problem does *NOT* happen 
on any of the other serial ports, only on the one where TX is connected to 
the dream 1 and RX to the FATAR midi keyboard.
I have been trying with both snd-serialmidi alsa driver, as well with a 
homemade user-land program which drives midi events to the serial port, and 
the problems happens on both ways. Also, very important to note : NO error 
messages are given by write() calls when the problem arises, nor do i get 
kernel messages.

This situation happens very often. If you need any other information please 
let me know. I would really appreciate any feedback you could have about this 
matter.

Best regards,
Colin Laplace
