From: Nils Carlson <nils.carlson@ericsson.com>
Subject: 16550 IIR LSR out-of-sync in handle_port
Date: Mon, 3 Jan 2011 11:39:44 +0100
Message-ID: <4D21A770.3080309@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailgw10.se.ericsson.net ([193.180.251.61]:46913 "EHLO
	mailgw10.se.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1ACKjq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jan 2011 05:39:46 -0500
Received: from [130.100.96.59] (seasc0608.dyn.rnd.as.sw.ericsson.se
 [130.100.96.59])	by linux.du.uab.ericsson.se (8.14.4/8.14.4) with ESMTP id
 p03Adisk020537	for <linux-serial@vger.kernel.org>; Mon, 3 Jan 2011 11:39:44
 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm having an intermittent problem with my 16550 which is integrated in 
a W83627DHG-P SuperIO chipset on a stable 2.6.32 kernel (though things 
haven't changed much in 8250.c)

The sequence of events is as follows:
1. I get an interrupt for ttyS1 and IIR=0xc2 is read. This indicates 
that the Transmitter Holding Register (THR) is empty and the handle_port 
function is entered.
2. The LSR is read as LSR=0x00, indicating that the THR is non-empty. At 
this point we don't call the transmit_chars function as this is decided 
by the LSR reading.
3. After this I only hear from the serial port once, and then it goes 
completely quiet; no more interrutps. This single interrupt has a 
IIR=0xc1, so nothing interesting.

Checking the LSR later it is set to LSR=0x60 indicating that now the THR 
is empty.

After this my serial port is permanently out of the game as no more 
interrupts are generated.

Looking through the W83627DHG-P SuperIO chipset datasheet the only thing 
I can come up with is that this is some sort of bug where the LSR is not 
set concurrently with the IIR and I'm having terribly bad luck as the 
LSR doesn't agree with the IIR. The other possibility is that something 
is in fact writing to the serial port, though as I'm printk'ing from 
each serial_in and serial_out I'm quite sure this isn't the case.

I see some solutions, but I don't think they're very pretty. One is to 
stop and restart the tx interrupt each  time we call start_tx, this 
should guarantee fresh interrupts.

Another solution would be to actually ignore the LSR in the interrupt 
routine and just decode the IIR. This seems to be what the datasheet 
intended. I'm guessing there are reasons not to do things this way, but 
it does sort of make sense.

All help and feedback much appreciated.

Nils Carlson
