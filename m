From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
Date: Wed, 3 Jul 2013 10:15:36 +0800
Message-ID: <51D38948.4040606@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com> <1372746628-20092-4-git-send-email-b32955@freescale.com> <20130702095645.GD31358@e106331-lin.cambridge.arm.com> <51D2AEC1.6030004@freescale.com> <20130702111118.GE31358@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:14494
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767Ab3GCCLx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 22:11:53 -0400
In-Reply-To: <20130702111118.GE31358@e106331-lin.cambridge.arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8802=E6=97=A5 19:11, Mark Rutland =E5=86=
=99=E9=81=93:
> compatible string ("fsl,imx21-uart") that should not break newer
> kernels if they choose to use the more-specific compatible string.
>
ok.

I will add back the the "fsl,imx21-uart".

thanks for the review.

Huang Shijie


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
