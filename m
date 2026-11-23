Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451528;
	b=JkVGn+/S71L5ylz3iQeKCCIVuvFTu6DiiQrE6NT/E0mnciu2Tce+yEH0ZL5EdX1ZQy+E
	 TG+RBmYrzQNek6z4hNzFR4DG0bSrDti4GVvEl4qi4tR/64B60P5dP3/YFEBJaFxu+pU/D
	 3EUpHbRqMyoReoxraV8mwq20L3WPNdjDUq2pU3A1Os4JuSMzy28tXpIXNMy/0pI768EsO
	 1x40ewJh9GuSb1ZAUwDFNeAPA9QPpnAY4FCbHVWm8wRoAjDecvhVu2YHGyWG+rgy+vrc/
	 /q8pW7LhrjIBtgxCIUjGJV9GzYbMOx36TZ5J4OtjdtFPQ7lxESYAgUaESakFD5c6IYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451528;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=TPc+B6SyiPOBoemXEdWJN89RW2VpN/zQ9IhgpAww9QM=;
	b=nfSy+rcm96TtnCdVdMH0UHtitMsynohsAmKcZ+Ps149kGH0Yt/IAIP5vurDi3L2NjfDS
	 hEvv01ya45bzuX/YoQvbfFgg+JGtyrMoft0RqKW3jDKko/k1oN0GyWpRaQgK3GeS10pAO
	 gOXgRDQqIHBtDJkElyul02jYF9S94mijVjOnbyJeXD6N6WeddxvHCtg2Je25ZvXpNn2tD
	 rZAUF78uFOqj2wmuc2m7nR6KqEmo22qxtmd+Ahe3Xqm5KDZr/tV99eZCWIXYtJKQOlY6H
	 XJhhE1YPF2e7GsnYPux6jj6/eHHAj73rLEsIt4+UB/suKo2+0IeQNKWMYUSHfeDkxtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=LaN4gwyK;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144B606A32D
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 16:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9144B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=LaN4gwyK
DKIM2-Signature:  i=1; m=1; t=1795451525;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:Sdk+6Ldf8Cn45xJu3DhW0Swy9ewy
   SAk6PftxfNy8jLbH1fAmiZv4Uv7Fvd7vOpY2tnR7vQKDXmUsSYxsoLtNfAJzHtkWylhJLmsB9Zy
   svMt1VjvbWCxcWZGPUNxouh48fYeAmJKeTxZDI13cjDQBDyYanMDquChfpix74Q08EEnKzpHIV6
   5j5OjjUB7arLJvgTcT5+Dvhe2uJzc8uyzhOVCXNxUThbm3FO1RZSA7uiYxH0ix9POQ2Pg6F7mHe
   NhlfX828pkMvnvlmVCILKEFW61DAtUTfSCUvcouDtlz6Wfe60Oj+ThUGhS1plpYavgm6fHRI+ii
   d2xi5TkgaNYaWw==;
Message-Instance:  m=1;
 h=sha256:
   SPp04/p4gOLsE1/3LE/i5C9hn0vJcyJbT1dMMBhdwPs=:
   SPWlB7LsG9so2TpI6Yd53bJAPV2lgdw+5yNAh8VYKyA=,
  sha512:
   e/zFelSKOFKLj4Zikxk5syinPUcGLzmAm/xhnZmrZ06toFht8ZKJ6ZwQKny4GqUsNaBHkSOLoLrJl+PVKuDHZw==:
   c0rxsq5IG4Dp44vIwJW9b/03vjRkMq2e8afz1WLSec658FQ/JkZKHf5UQ5Q0Fvm5c2lssOP9NbfEiZpqlqoepg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795451482; x=1796056282; i=deller@gmx.de;
	bh=TPc+B6SyiPOBoemXEdWJN89RW2VpN/zQ9IhgpAww9QM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LaN4gwyKTXN8ZarIqitV7yMncDVkExKzr1ntO3aNHkQTKb/f7/KoQygv3m63et8q
	 8qfcu+49AFyPKB1EYBng1e4n7CEDFOYhbxTHxclCDrpmBnb4HG/mjezRvJBkkNx4G
	 LlcQq/Ovn7WErPjQKP91461GU37dib/Fz8c1jKORzh9zx+aa9C+ofWtMkoOy5oHUp
	 FPZNmsGyjWE4As5uLxduatQgBEG42pGtGi2NagyBb+5vrb0j0Cp+CHnx01h+xEwVL
	 ORA1O3qggK8KUidDmWnDAhq83t8KFBaA4ju1VvXpc1oXXb0+UsQdwJFb99EhBIYpW
	 /OSr889E4g3gD0beLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1yQXc52UEB-00u5bn; Mon, 23
 Nov 2026 17:31:22 +0100
Message-ID: <2b118db7-cdaf-49f5-b870-24415b66f3d9@gmx.de>
Date: Mon, 23 Nov 2026 17:31:18 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vt: Skip hardware scrolling while blanked and fix VESA
 blanking
To: Yu Peng <pengyu@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Nicolas Pitre
 <nico@fluxnic.net>, Ronan Pigott <ronan@rjp.ie>,
 linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261123101151.414436-1-pengyu@kylinos.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261123101151.414436-1-pengyu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pzPGSeJEveDk/2ua9ChTzwWs6PDLkGcDAW96ABiMsNj1XQG1Hzz
 GDShfEBU912v9y27f3yqmvPa4csGu9JRolvhkEmqDBK9Bet/+2qYq7659vnDXMLEbGCeix3
 sC6GB86RWMEC/yVmBruQCMaGwZ7M6gpocP0oxJYBBUFodDwEkCr1JezS23LQGFotd0WMKQS
 XC863dhoH2vemN1YT+aJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4XKPBVO23Vc=;oYq1oCpk2gjaY+rj+D6q2VrQS0z
 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

Hello Yu,

On 11/23/26 11:11, Yu Peng wrote:
> When vgacon is blanked without palette blanking (!vga_palette_blanked),
> vgacon_set_origin() rejects VRAM so vc->vc_origin points to the heap
> buffer vc->vc_screenbuf. Calling hardware scroll callbacks while blanked
> then treats vc->vc_screenbuf as VRAM and causes out-of-bounds accesses.
>=20
> Use con_should_update() to skip hardware scrolling and scrollback while
> blanked, allowing con_scroll() to fall back to software scrolling.

The patch looks ok, but can you please split it up into two patches and re=
send?
The part below (vgacon_blank) is independend of the scrolling part.

Thanks!
Helge

> In vgacon_blank(), return !vga_palette_blanked for VESA blanking so
> direct VESA blanking switches vc->vc_origin to vc->vc_screenbuf
> immediately instead of losing output on unblank.

 =20
> Assisted-by: LLM
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
>   drivers/tty/vt/vt.c            | 7 ++++---
>   drivers/video/console/vgacon.c | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 6a6eb8b2a6dec..39be682645097 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -726,8 +726,8 @@ static void con_scroll(struct vc_data *vc, unsigned =
int top,
>   		return;
>  =20
>   	vc_uniscr_scroll(vc, top, bottom, dir, nr);
> -	if (con_is_visible(vc) &&
> -			vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
> +	if (con_should_update(vc) &&
> +	    vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
>   		return;
>  =20
>   	src =3D clear =3D (u16 *)(vc->vc_origin + vc->vc_size_row * top);
> @@ -3488,7 +3488,8 @@ static void console_callback(struct work_struct *i=
gnored)
>   	if (scrollback_delta) {
>   		struct vc_data *vc =3D vc_cons[fg_console].d;
>   		clear_selection();
> -		if (vc->vc_mode =3D=3D KD_TEXT && vc->vc_sw->con_scrolldelta)
> +		if (con_should_update(vc) && vc->vc_mode =3D=3D KD_TEXT &&
> +		    vc->vc_sw->con_scrolldelta)
>   			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);
>   		scrollback_delta =3D 0;
>   	}
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgac=
on.c
> index 09f7c376b4689..3a706c1f1cb28 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -796,7 +796,7 @@ static bool vgacon_blank(struct vc_data *c, enum ves=
a_blank_mode blank,
>   			vga_vesa_blank(&vgastate, blank);
>   			vga_vesa_blanked =3D blank;
>   		}
> -		return false;
> +		return !vga_palette_blanked;
>   	}
>   }
>  =20

