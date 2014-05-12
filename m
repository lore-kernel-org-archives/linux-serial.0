From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
Date: Mon, 12 May 2014 11:40:37 +0800
Message-ID: <537042B5.2040600@freescale.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-by2on0056.outbound.protection.outlook.com ([207.46.100.56]:30186
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751425AbaELDiV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 May 2014 23:38:21 -0400
In-Reply-To: <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dean_jenkins@mentor.com
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, dirk.behme@de.bosch.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com

=E4=BA=8E 2014=E5=B9=B405=E6=9C=8809=E6=97=A5 23:19, dean_jenkins@mento=
r.com =E5=86=99=E9=81=93:
> Use imx_start_tx() just to enable the TX interrupt. It's the job of t=
he
> TX interrupt ISR to fill the transmit buffer, then. If the transmit b=
uffer
> is empty, the TX interrupt should be executed as soon as the start_tx=
()
> enables the interrupt, so there is no reason for the extra
> imx_transmit_buffer() call, here. Remove it.
I don't know why this patch needed?
What problem this patch fix or improve?

thanks
Huang Shijie
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
