From: Ulrich Hertlein <u.hertlein@sandbox.in-berlin.de>
Subject: UART not generating MSR-change (or any) interrupt
Date: Mon, 24 Jun 2002 21:37:12 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200206242137.12029.u.hertlein@sandbox.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from k0009394 (pD9E6A141.dip0.t-ipconnect.de [217.230.161.65])
	by hirsch.in-berlin.de (8.12.1/8.12.1/Debian -2) with ESMTP id g5OJwNpp031771
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2002 21:58:23 +0200
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,

this is my first post to this mailing list so please excuse any breach of 
protocol or such.

I'm currently developing an Input Device (Joystick) module for a R/C 
transmitter (such as used to model aircraft) interface. This little piece of 
hardware connects to a serial port and changes the RI line according to a 
pulse-width modulation pattern. The pulses vary in length from about 0.3 ms 
to around 1.7 ms. In order to minimize system load I want to implement an 
interrupt handler to handle changes of the modem-status register.

The module code currently sets up the input device stuff and initializes the 
UART of the requested port. For I/O base and IRQ 'setserial' reports the 
expected standard values (COM1=0x3f8,IRQ=4 COM2=0x2f8,IRQ=3 ...) and I'm 
using those to setup the UART ('setserial' reports a 16550A) and do a 
'request_irq'. The UART setup follows 'serial.c' pretty closely, except for 
not setting a baud rate. The module inserts and initializes fine and I can 
see a new joystick device using a small SDL test program.

But the interrupt handler never is called, even if I tell the UART to generate 
other interrupts as well, such as UART_IER_MSI | UART_IER_RLSI | 
UART_IER_RDI. '/proc/stat' also shows no interrupts being generated on 
IRQ=3,COM2.

A small test program using user-land 'ioctl' to either poll the MSR or wait 
for changes using 'TIOCMIWAIT' also show no activity on the RI line. But I 
know it's there since another user-land program that polls the MSR using 
'inb' show the expected wave pattern.

Does anyone have an idea what is going on? Tell me if you need additional 
information about anything. I'm running linux-2.4.19 on a Soyo K7V Dragon+ 
board with 1.2 GHz AMD Duron CPU.

Thanks in advance,
-Ulrich

-- 
Ulrich Hertlein ... u.hertlein <at> sandbox <dot> in-berlin <dot> de
               "Writing software is more fun than working."

