From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad
 name
Date: Mon, 8 Jul 2013 16:54:36 +0800
Message-ID: <51DA7E4C.4050507@freescale.com>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com> <1373004752-21302-5-git-send-email-b32955@freescale.com> <20130706050803.GC30164@S2101-09.ap.freescale.net> <20953.22066.706534.773272@ipc1.ka-ro> <20130708075004.GR24642@n2100.arm.linux
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:28843 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719Ab3GHIup convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Jul 2013 04:50:45 -0400
In-Reply-To: <20130708075004.GR24642@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>, Shawn Guo <shawn.guo@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8808=E6=97=A5 15:50, Russell King - ARM=
 Linux =E5=86=99=E9=81=93:
> On Sun, Jul 07, 2013 at 01:51:14PM +0200, Lothar Wa=C3=9Fmann wrote:
>> Hi,
>>
>> Shawn Guo writes:
>>> On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
>>>> There is something wrong with the RTS/CTS pads:
>>>>    The RTS pad is assigned with the CTS's value;
>>>>    while the CTS pad is assigned with the RTS's value.
>>>>
>>> So basically, you are saying that select_input should be set up for=
 CTS
>>> rather than RTS.  It seems that the people who generated the macro =
got
>>> the wrong input from developer.
>>>
>> programming 'select_input' only makes sense for inputs, not outputs.
>> Since CTS is an output signal, select_input only makes sense for the
>> RTS function of the pads.
> Note: If you are a DTE, then RTS is an output, CTS is an input.  If y=
ou
> are a DCE, then RTS is an input and CTS is an output (normally on a
> standard UART, you just swap the wiring for RTS and CTS but really th=
at's
> all that is going on.)  So swapping them in software should be accept=
able
> too, provided you're not having to disable any auto flow control faci=
lities.
>
thanks for explanation.


Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
