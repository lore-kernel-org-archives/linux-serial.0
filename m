From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH V2] serial: imx: enable the clocks only when the uart
 is used
Date: Sat, 8 Jun 2013 14:22:39 +0800
Message-ID: <51B2CDAF.3050104@freescale.com>
References: <1370311173-15019-1-git-send-email-b32955@freescale.com> <20130608060116.GB20780@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:39336
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911Ab3FHGTi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Jun 2013 02:19:38 -0400
In-Reply-To: <20130608060116.GB20780@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

=E4=BA=8E 2013=E5=B9=B406=E6=9C=8808=E6=97=A5 14:01, Shawn Guo =E5=86=99=
=E9=81=93:
> Running linux-next 20130607, I just found that the serial console sto=
ps
> working due to this patch.  I think the clocks need to be enabled for
> console as well.
could you tell me the board?
i tested on imx6q-sabreauto boards, the console is ok.

thanks
Huang Shijie



--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
