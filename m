From: Christian Gagneraud <cgagneraud@techworks.ie>
Subject: setserial and ioremap
Date: Wed, 07 Oct 2009 18:51:24 +0100
Message-ID: <4ACCD51C.3020604@techworks.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 133.155.reserved.hosting365.ie ([82.195.155.133]:41781 "EHLO
	mail.techworks.ie" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZJGSQi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Oct 2009 14:16:38 -0400
Received: from archeopterix.techworks.local (unknown [86.43.120.173])
	by mail.techworks.ie (Postfix) with ESMTP id AE845BC0C
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2009 18:49:16 +0100 (IST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm using an ARM platform that has a PC104 bus.
The vendor of the board provide a 2.6.21 kernel, and in it there's a 
plethora of small kernel module to support each single expansion board 
having a 16550 chip for each single supported platform (because the 
PC104 bus is not always at the same address).
These modules are very smal, they only fill up a uart_port struct and 
call serial8250_register_port().
The small detail is that they set the iotype to UPIO_MEM, set the 
mapbase to the right physical address and set UPF_IOREMAP in the flags.

Instead of using these kernel modules, I would like to use setserial. 
but it doesn't support both UPIO_MEM and UPF_IOREMAP.
I've easily added the UPIO_MEM iotype to setserial but got unlucky 
with UPF_IOREMAP. Even if I set UPF_IOREMAP in the flags, the kernel 
refuse to ioremap the base address (I tried both with mapbase and 
membase).
I've spotted the code in 8250.c, and it should do the ioremap if the 
flags contains UPF_IOREMAP. But I have the feeling that this flag is 
cleared or ignored when coming from userspace.

I've noticed that in the machine initialisation code the PC104 IO 
space is not ioremap'ed, could it be the source of the problem?
I remembered having seen a global ioremap of the PC104 on another 
PC104 ARM board, but i wonder it that's the right strategy.

if the PC104 IO space was ioremap'ed by defatult, then i could use 
UPIO_PORT with an unmodified setserial.

Any thought about this?

Regards,
Chris
