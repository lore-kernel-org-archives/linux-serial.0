From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2] serial: imx: enable the clocks only when the uart is
 used
Date: Sat, 8 Jun 2013 14:23:08 +0800
Message-ID: <20130608062307.GB22416@S2101-09.ap.freescale.net>
References: <1370311173-15019-1-git-send-email-b32955@freescale.com>
 <20130608060116.GB20780@S2101-09.ap.freescale.net>
 <51B2CDAF.3050104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:53037
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876Ab3FHGXI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Jun 2013 02:23:08 -0400
Content-Disposition: inline
In-Reply-To: <51B2CDAF.3050104@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Sat, Jun 08, 2013 at 02:22:39PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2013=E5=B9=B406=E6=9C=8808=E6=97=A5 14:01, Shawn Guo =E5=86=
=99=E9=81=93:
> >Running linux-next 20130607, I just found that the serial console st=
ops
> >working due to this patch.  I think the clocks need to be enabled fo=
r
> >console as well.
> could you tell me the board?
> i tested on imx6q-sabreauto boards, the console is ok.

imx6q-sabresd

Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
