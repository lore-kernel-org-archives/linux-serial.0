From: "Neil Everton" <neil@gemini-it.com>
Subject: RE: Connecting more than 4 serial ports
Date: Thu, 22 Jan 2004 21:26:34 -0000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <S266440AbUAVV0g/20040122212636Z+35986@vger.kernel.org>
References: <32798.192.168.192.123.1074794701.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server15.donhost.co.uk ([81.21.65.151]:20499 "HELO
	server15.donhost.co.uk") by vger.kernel.org with SMTP
	id S266440AbUAVV0g (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Jan 2004 16:26:36 -0500
In-Reply-To: <32798.192.168.192.123.1074794701.squirrel@www.clientes.sedifa.com>
List-Id: linux-serial@vger.kernel.org
To: 'Albert Cervera Areny' <informatic@sedifa.com>, linux-serial@vger.kernel.org

Hi,
	Why not consider using a Cyclades card. I've got an order receipts
system which can handle up to 96 modems (although we've only ever used
maximum of 8 on a single PC).

	Not cheap, but certainly a good solution, you just access ttyC0,
ttyC1..... and they're pretty much standard on most Linux build stock
kernels.

Regards
Neil Everton


-----Original Message-----

Hi, everyone!

	I'm envolved in a project in which we need to control about 9
peripherals
connected with the serial port. (Some of you helped us a lot with some of
them, big thanks!) Now we need to connect them all at the same time so
I've bought 4 cards with 2 serial ports each (the mother board includes
2).
	By now, we've been able to use ttyS0 to ttyS3 but now comes the
problem :(

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

-
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


