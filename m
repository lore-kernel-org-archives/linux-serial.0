From: "Albert Cervera Areny" <informatic@sedifa.com>
Subject: Connecting more than 4 serial ports
Date: Thu, 22 Jan 2004 19:05:01 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <32798.192.168.192.123.1074794701.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 199.Red-80-26-113.pooles.rima-tde.net ([80.26.113.199]:11138
	"HELO localhost") by vger.kernel.org with SMTP id S266281AbUAVSFF
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Jan 2004 13:05:05 -0500
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi, everyone!

	I'm envolved in a project in which we need to control about 9 peripherals
connected with the serial port. (Some of you helped us a lot with some of
them, big thanks!) Now we need to connect them all at the same time so
I've bought 4 cards with 2 serial ports each (the mother board includes
2).
	By now, we've been able to use ttyS0 to ttyS3 but now comes the problem :(

We're trying to use ttyS4 with one of the cards

00:0a.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550
UART) (rev 01) (prog-if 02 [16550])
        Subsystem: Timedia Technology Co Ltd: Unknown device 4037
        Flags: stepping, medium devsel, IRQ 17
        I/O ports at c800 [size=32]

00:0b.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550
UART) (rev 01) (prog-if 02 [16550])
        Subsystem: Timedia Technology Co Ltd: Unknown device 4037
        Flags: stepping, medium devsel, IRQ 18
        I/O ports at c400 [size=32]

The second one is the one used for port ttyS2 and ttyS3.

So we try the following:

# mknod -m 660 ttyS4 c 4, 68
# chown :dialout /dev/ttyS4
# setserial /dev/ttyS4 uart 16550A port 0xc800 irq 17 Baud_base 115200
skip_test ^Fourport

(I've also tried without the ^Fourport and skip_test)
Then I use kermit to connect to a modem but It doesn't work, opens the
line, but it returns no echo. (Of course, If I connect it to ttyS2 and
connect with kermit it works, and I've tried all of the serial connectors
just in case I was wrong with the card I thought I was using)
The kernel is stock 2.6.0 from debian and comes with IRQ SHARE and
MULTIPLE PORTS.

I'm I missing something in this process?

Thanks in advance!

