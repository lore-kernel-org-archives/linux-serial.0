From: =?ISO-8859-2?Q?Ond=F8ej_Pu=BEman?= <puzman@gmail.com>
Subject: Bug in 8250.c - uninitialized FIFOs
Date: Fri, 03 Dec 2010 18:56:16 +0100
Message-ID: <4CF92F40.5070004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gatekeeper.amit.cz ([188.95.124.146]:35588 "EHLO
	electra.amit.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753665Ab0LCSFM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Dec 2010 13:05:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by electra.amit.cz (Postfix) with ESMTP id 21049501A0
	for <linux-serial@vger.kernel.org>; Fri,  3 Dec 2010 18:56:16 +0100 (CET)
Received: from electra.amit.cz ([127.0.0.1])
	by localhost (imp.amit.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRdxilMOQM7K for <linux-serial@vger.kernel.org>;
	Fri,  3 Dec 2010 18:56:14 +0100 (CET)
Received: from [192.168.1.64] (puzman-o.praha.amit.cz [192.168.1.64])
	by electra.amit.cz (Postfix) with ESMTP id 0685E5019E
	for <linux-serial@vger.kernel.org>; Fri,  3 Dec 2010 18:56:14 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,
I have found a bug in 8250.c driver which causes that 16550A uart FIFOs 
are not turned on during initialization if they are manually configured 
by setserial. UART is then working only as plain 16450 without FIFOs. On 
systems with higher interrupt latency this causes buffer overruns and 
loss of received data when using higher communication speeds.

I'm working for a company which produces industrial computers. These 
devices typically contain high number (8 or more) of traditional 16550A 
uarts - we use TL16C554A chips, but that is not much relevant. UARTs are 
connected to the CPU by ISA bus (Celeron based devices) or LPC bus (Atom 
based devices).

In the Linux the UARTs are using standard 8250.c driver and are 
initialized using setserial command:
setserial /dev/ttyS4 uart 16550A port 0x3E0 irq 10 baud_base 115200

This executes the UART initialization through serial8250_startup() 
function. At the beginning of the function up->capabilities is 
initialized from uart_config:
 up->capabilities = uart_config[up->port.type].flags;
Please note that neither up->port.fifosize nor up->tx_loadsz is 
initialized here!!

Later in the same function serial8250_clear_fifos() is called and 
disables FIFOs. The above comment says that they will be reenabled in 
set_termios (they won't ...)

After serial8250_startup() the serial8250_set_termios() is called. In 
this function the following check fails because up->port.fifosize is 
zero because it is not initialized correctly.

        if (up->capabilities & UART_CAP_FIFO && up->port.fifosize > 1) {
                if (baud < 2400)
                        fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
                else
                        fcr = uart_config[up->port.type].fcr;
        }

fcr variable remains zero and in the end the FCR register is set to zero 
which results in disabled FIFOs even if the UART type is 16550A. This is 
also true for other types of UARTs with FIFOs.

If the UART is autoconfigured via 'setserial /dev/ttySx autoconfig' then 
port.fifosize and tx_loadsz are initialized correctly in the 
autoconfig() function and the UART is working correctly then.

I checked the source codes and I can say that this bug is present in 
2.6.x series of kernels for a couple of years. Namely I can confirm its 
presence in 2.6.16.57, 2.6.32.24 and 2.6.36.1 (tested all of them on our 
hardware).

I think it was not noticed before because not many people use manually 
configured non PNP UARTs on ISA/LPC bus these days. Also the data loss 
caused by buffer overruns occures only if  IRQ latency is higher then 
time needed to receive one character on given communication speed.
For example our hardware looses received characters only if the UARTs 
are connected throught LPC bus with SERIRQ (serial IRQ transport) and 
not if they are connected to ISA bus because LPC SERIRQ has higher 
interrupt latency then parallel ISA interupt lines.

Here is the patch to correct the bug created against 2.6.36.1:

diff -Naur a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c     2010-11-22 20:03:49.000000000 +0100
+++ b/drivers/serial/8250.c     2010-12-03 18:32:54.000000000 +0100
@@ -1952,6 +1952,8 @@
        unsigned char lsr, iir;
        int retval;

+       up->port.fifosize = uart_config[up->port.type].fifo_size;
+       up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
        up->capabilities = uart_config[up->port.type].flags;
        up->mcr = 0;


The patch should work on most 2.6.x kernels.
I hope that someone will be able to put that in the official kernel tree.
--
Ondrej Puzman
HW & SW developer

AMiT, spol. s.r.o.

