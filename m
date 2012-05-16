From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Wed, 16 May 2012 17:42:49 +0800
Message-ID: <4FB37699.7050004@freescale.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com> <20120426120043.GH17184@pengutronix.de> <4F9A3831.1020203@freescale.com> <4474267.dxHCC3PlP5@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:35839
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966479Ab2EPJi0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 May 2012 05:38:26 -0400
In-Reply-To: <4474267.dxHCC3PlP5@laptop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, r58066@freescale.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, alan@linux.intel.com

=E4=BA=8E 2012=E5=B9=B405=E6=9C=8816=E6=97=A5 17:37, Philippe R=C3=A9to=
rnaz =E5=86=99=E9=81=93:
> Does this mean that there is no hope for a working uart dma on imx31 =
?
yes.

only works in mx6q now.

BR
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
