From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] cris: lower the printk level in cris serial driver
Date: Thu, 1 Sep 2011 08:35:51 +0200
Message-ID: <CAMuHMdWSm2bQQpdM1OM=6+17CeNikn9RYm_BpFmEV7jD4sAPig@mail.gmail.com>
References: <1314857640-6623-1-git-send-email-xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40952 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab1IAGfw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Sep 2011 02:35:52 -0400
In-Reply-To: <1314857640-6623-1-git-send-email-xiyou.wangcong@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Alan Cox <alan@linux.intel.com>, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org

On Thu, Sep 1, 2011 at 08:14, WANG Cong <xiyou.wangcong@gmail.com> wrot=
e:
> KERN_CRIT is too high, replace those KERN_CRIT with KERN_ERR or KERN_=
INFO.
>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
>
> ---
> diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv1=
0.c
> index 225123b..77ba4ed 100644
> --- a/drivers/tty/serial/crisv10.c
> +++ b/drivers/tty/serial/crisv10.c
> @@ -1788,7 +1788,7 @@ static unsigned int handle_descr_data(struct e1=
00_serial *info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct etrax_recv_buffer *buffer =3D phys_=
to_virt(descr->buf) - sizeof *buffer;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (info->recv_cnt + recvl > 65536) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_CRIT
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "%s: Too much pending incoming serial data! Dropping %u bytes.\=
n", __func__, recvl);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

I think dropped data warrants KERN_WARN.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
