From: "Jean-Pierre Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: RS485 implementation questions (primarly in atmel_serial.c)
Date: Wed, 30 Jan 2013 15:35:29 +0100
Message-ID: <000401cdfef7$0d4a9020$27dfb060$@acksys.fr>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out06.msg.oleane.net ([62.161.7.4]:58359 "EHLO
	smtp-out06.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab3A3Vf7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2013 16:35:59 -0500
Received: from smtp26.msg.oleane.net (smtp26.mail.priv [172.17.20.148])
	by smtp-out06.msg.oleane.net with ESMTP id r0UEuJGT029542
	for <linux-serial@vger.kernel.org>; Wed, 30 Jan 2013 15:56:19 +0100
In-Reply-To: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
Content-Language: fr
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Guido Classen' <clagix@gmail.com>, linux-serial@vger.kernel.org

Hi all,
At Guido's request here are my thoughts:

> Units this parameters are given. The crisv10.c driver gets the
> delay_before_send in milliseconds and atmel_serial
> delay_rts_after_send in bit-times (means depending on baud rate).

RTS delays should be given in ms not in bit-times since they are not related
to bit rate but to amplifiers and peer software response times.

> But in the atmel_serial.c driver rthe Transmit Timeguard function of
> the AT91 USART is used to implement this.  The purpose of the Transmit
> Timeguard function is to throttle transmission in case the receiving
> device is able to receive/process incoming characters at line
> speed. This means the USART will insert a gap between EACH transmitted
> byte and not only the last of a frame.  Atmel surely had its reasons
> to implement such a function, but luckily nowadays such devices are

Sounds to me like a "quick and dirty" implementation of the RTS toggling, to
avoid the burden of setting timers etc. The interbyte gap is not needed.

> An other point I don't understand is why ATMEL_US_TXEMPTY interrupt is
> used when in RS485 mode insted of the normal ATMEL_US_TXRDY or
> ATEM_US_ENDTX interrupts. In the RS485 mode the AT91 USART will
> connect the RTS pin to the internal TXEMPTY signal to drive the RTS
> until the last bit is shifted out. But this should not have any affect
> on ow the drive will pump out the bytes to the USART's transmit hold
> register?

Well, you need to ascertain that the previous frame is all out AND the RTS
has dropped before sending a new frame. Else the receiver might think it is
the same long frame.
Using TXEMPTY interrupt avoids setting an extra timer.
However in the real life you are half-duplex and never send two frames in a
row without waiting for an answer.
Other than that I agree with your remark.

> rare.  But this function is not especially related to RS485. It is
> also applicable in RS232 mode.  So in my view it is not the

True, it applies to some half-duplex RS232 radio modems too AFAIK.

French regards,
Jean-Pierre Tosoni

