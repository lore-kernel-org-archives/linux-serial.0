From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Possible software flow problem in serial_core
Date: Thu, 20 Mar 2014 19:05:35 -0400
Message-ID: <532B743F.2030705@hurleysoftware.com>
References: <CF505B08.6E64%seth.bollinger@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:53910 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759160AbaCTXFh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Mar 2014 19:05:37 -0400
In-Reply-To: <CF505B08.6E64%seth.bollinger@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Bollinger, Seth" <Seth.Bollinger@digi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>

[ +cc linux-serial ]

On 03/20/2014 09:44 AM, Bollinger, Seth wrote:
> Hello All,
>
> We=E2=80=99ve recently run into a possible problem with software flow=
 control
> handling in the serial_core layer.
>
> Here is the scenario:
>
> 1. Transmit from uart to remote device
> 2. Remote device sends us an XOFF
> 3. The tty layer receives the XOFF
> 4. stop_tty() - The uart transmitter is stopped (ops->stop_tx) just a=
s the
> serial_core ring is cleared (this could trap a few bytes in the fifo)=
=2E
> 5. Remote device sends us an XON
> 6. The tty layer receives the XON
> 7. start_tty() - However, the serial_core ring is empty, so the call =
to
> start the uart transmitter (uart_start:ops->start_tx) is skipped
>
> Any window, however small, could leave bytes stuck in the transmitter
> forever -- particularly if there will be no further transmission unti=
l
> receiving a response.
>
> I can't find any functionality in the drivers that accounts for this
> possibility.  Can you help me find how Linux serial drivers manage th=
is
> eventuality?
>
> Thanks,
>
> Seth

What hardware is this?

A 16550 transmitter doesn't shut-off at uart->stop_tx(), so the remaini=
ng
data in the transmitter FIFO is still transmitted.

Some hardware has (relatively) big FIFOs and allows the transmitter to =
be
shutoff, but these should unconditionally re-enable the transmitter wit=
hout
clearing the xmit fifo.

Are you seeing lost data? Maybe it's because soft flow-control is to
slow to shutoff the sender?

Regards,
Peter Hurley


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
