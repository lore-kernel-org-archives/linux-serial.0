From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts
 is enabled
Date: Tue, 16 Jul 2013 16:11:19 +0800
Message-ID: <51E50027.4020701@freescale.com>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com> <1373857736-30108-2-git-send-email-b32955@freescale.com> <20130715082716.GM12139@pengutronix.de> <51E3B5B5.1030706@freescale.com> <20130715090755.GN12139@pengutronix.de> <51E3D499.3060902@freescale.com> <20130716073305.GP12139@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:54015
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860Ab3GPIHN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Jul 2013 04:07:13 -0400
In-Reply-To: <20130716073305.GP12139@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8816=E6=97=A5 15:33, Uwe Kleine-K=C3=B6=
nig =E5=86=99=E9=81=93:
>> This patch depends on the first patch. :)
> But it's not a hard dependency.
>
do you mean i should merge the patch 1 and patch 2 into a single patch?

>>> Something like:
>>>
>>> 	serial: mxs-auart: DMA unreliable without RTS/CTS
>>>
>>> 	According to [add some document name here] DMA doesn't work
>>> 	reliable without hardware handshaking. So make DMA dependant on
>>>  =20
>> Please see the spec about the RTSEN and RTS.
> Right, it's not hard for me. Other might not have the manual handy, s=
o
> a comment telling:
>
>> RTSEN enable the flow control by the hardware;
>> RTS enable the flow control by the software.
> would be nice.
i think we need another patch to add this comment.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
