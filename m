From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
Date: Tue, 2 Jul 2013 18:43:13 +0800
Message-ID: <51D2AEC1.6030004@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com> <1372746628-20092-4-git-send-email-b32955@freescale.com> <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:57129 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916Ab3GBKjg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 06:39:36 -0400
In-Reply-To: <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8802=E6=97=A5 17:56, Mark Rutland =E5=86=
=99=E9=81=93:
> On Tue, Jul 02, 2013 at 07:30:26AM +0100, Huang Shijie wrote:
>> >  The imx6 uart can supports the DMA, imx uart driver has added a n=
ew
>> >  compatible property for the imx6 uart.
>> > =20
>> >  In order to enable the DMA for some uart port in imx6, we rename =
the
>> >  uart's compatible property to "fsl,imx6-uart".
> Doesn't this change break using these dts with an older kernel? You
is it reasonable to use a new dts with an old kernel?


> remove the "fsl,imx21-uart" string older kernels understand.
>
> Given you already had "fsl,imx6q-uart" and "fsl,imx6sl-uart" strings,
> would it not have made more sense to just add these to the driver?
I think it's not a good idea.

Shawn, what's your opinion about this?

thanks
Huang Shijie


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
