From: Noam Camus <noamc@ezchip.com>
Subject: UART IRQ over SMP
Date: Mon, 4 Mar 2013 11:18:53 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC40F680F@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1255
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:30793 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab3CDJS6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 04:18:58 -0500
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hello=20

I got my UART IRQ line hardwired to CPU0.=20
However CPU1 (due to scheduler balancing I presume) is used for calling=
 the request_irq() from 8250.c.
By doing that the "chip" irq_enable() is unmasking UART IRQ line of CPU=
1 and not CPU0.
Now I do not get UART interrupts since they are masked at CPU0.

I tried to unmask CPU0 UART IRQ line by default at early boot.
Once I do that I get some spurious interrupt that handle_level_irq() le=
aves masked.
It is because I did not register any action yet with the request_irq().

Is there known way for dealing with such scenario?

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Noam Camus
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
