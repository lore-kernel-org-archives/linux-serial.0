From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/5] serial: imx: distinguish the imx6 uart from the others
Date: Wed, 3 Jul 2013 10:17:44 +0800
Message-ID: <51D389C8.1030101@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com> <1372746628-20092-2-git-send-email-b32955@freescale.com> <20130703015243.GD9145@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:41044
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752606Ab3GCCOX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 22:14:23 -0400
In-Reply-To: <20130703015243.GD9145@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8803=E6=97=A5 09:52, Shawn Guo =E5=86=99=
=E9=81=93:
> Would it be better to use (!is_imx1_uart(sport)) here?  Thus when the=
re
a good idea.

i will fix it in next version.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
