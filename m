From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] cris: lower the printk level in cris serial driver
Date: Thu, 1 Sep 2011 09:09:30 +0100
Message-ID: <20110901090930.064c2775@lxorguk.ukuu.org.uk>
References: <1314857640-6623-1-git-send-email-xiyou.wangcong@gmail.com>
	<CAMuHMdWSm2bQQpdM1OM=6+17CeNikn9RYm_BpFmEV7jD4sAPig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34502 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756018Ab1IAIKk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Sep 2011 04:10:40 -0400
In-Reply-To: <CAMuHMdWSm2bQQpdM1OM=6+17CeNikn9RYm_BpFmEV7jD4sAPig@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Alan Cox <alan@linux.intel.com>, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (info->recv_cnt + recvl > 65536) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_CRIT
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "%s: Too much pending incoming serial data! Dropping %u bytes.\=
n", __func__, recvl);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=20
> I think dropped data warrants KERN_WARN.

If you have an overflow you want to push the relevant tty flag into the
queue. I'm not sure a printk is that useful - end users of embedded
devices (or even PC desktops) won't see it anyway and if you have seria=
l
console it can actually make things worse

Plus of course it's not rate limited here so its a log wiping vector ..=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
