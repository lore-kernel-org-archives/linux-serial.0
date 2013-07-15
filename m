From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/3] serial: mxs: remove the unused macro
Date: Mon, 15 Jul 2013 16:30:27 +0800
Message-ID: <51E3B323.1070606@freescale.com>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com> <20130715082044.GL12139@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:55457
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754463Ab3GOI0X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Jul 2013 04:26:23 -0400
In-Reply-To: <20130715082044.GL12139@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8815=E6=97=A5 16:20, Uwe Kleine-K=C3=B6=
nig =E5=86=99=E9=81=93:
> You're suggesting that MXS_AUART_DMA_CONFIG was set here unconditiona=
lly
> before and so the check in the hunk above is not necessary anymore.
yes, that's what i want to say.
> (<pedantic>So your "not used any more" is technically wrong.</pedanti=
c>)
ok, I will change this comment.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
