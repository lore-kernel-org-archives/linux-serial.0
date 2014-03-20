From: "Bollinger, Seth" <Seth.Bollinger@digi.com>
Subject: Re: Possible software flow problem in serial_core
Date: Thu, 20 Mar 2014 23:34:11 +0000
Message-ID: <CF50E0EB.6E95%seth.bollinger@digi.com>
References: <CF505B08.6E64%seth.bollinger@digi.com>
 <532B743F.2030705@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.8]:54429 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759365AbaCTXlF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Mar 2014 19:41:05 -0400
In-Reply-To: <532B743F.2030705@hurleysoftware.com>
Content-Language: en-US
Content-ID: <40F4F7B38E5B9E4FBEB8209D6928AC71@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>


>What hardware is this?

We=B9re using the Freescale mxs-auart driver (i.mx28).
=20
>A 16550 transmitter doesn't shut-off at uart->stop_tx(), so the remain=
ing
>data in the transmitter FIFO is still transmitted.

Ok, I just reviewed the 8250 driver and you=B9re correct, it appears th=
e
transmitter is only disabled on the 16C950.  I misread before (incorrec=
tly
saw 16C550)...

>Some hardware has (relatively) big FIFOs and allows the transmitter to=
 be
>shutoff, but these should unconditionally re-enable the transmitter
>without
>clearing the xmit fifo.

Do you have a driver that would be a good example of this?  From lookin=
g
at serial_core.c:uart_start(), is seems that start_tx() is only called =
if
the serial_core ring buffer is not empty.  If we don=B9t stop the
transmitter, we slew too many characters.

>Are you seeing lost data? Maybe it's because soft flow-control is to
>slow to shutoff the sender?

No dropped bytes, but we do see a few bytes trapped in the fifo because=
 we
received an XOFF.  When we receive the XON, start_tx() is never called
because the serial_core ring buffer is empty, and we have no more data =
to
transmit.  When we enable the transmitter manually, these bytes will po=
p
out.

Thanks for all of your help!

Seth

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
