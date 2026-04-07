Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086303C9EC7;
	Tue,  7 Apr 2026 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576935; cv=none; b=sA6rZ5xjVFN9G6s93gShCMOubZqX7EmE5yby0oC2m94NEyCvw2R2bqRIFGOyABzAgb3zXuDPnqTUNHwp5ja2Fr1714siejbEwEy9XHc7yxyBXQb7m/AbKP+v1q2dySxTsgswaO89QFde1mkbcizSYJqyhkz5ze+X9tFsbNK6GLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576935; c=relaxed/simple;
	bh=heg3x7ElmNFxYQmFamb4P+BKHDJ3kk1a9rd0TsZypU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYd9n3JLAWaoSAXMnngiy1B0vHDIzksGlGZOnITdya/YkWknGFEaSpmvStKzwXFs5xtbIJKZMaJBgnL9jqdVOpjXB4j4Lrq+xuqY0iunF5GI75kYoP1KwFKrZy6LlMFygM6JpAWwdzGdTmtlrCfuRSPZVG6uXSBxFdNmhTEPx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=DDbrEtsV; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="DDbrEtsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775576919; x=1776181719; i=deller@gmx.de;
	bh=YeHk8Sf1tT6rtXzZmZSm3aKs3z2Y9LseDt8hcdNh+R4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DDbrEtsVcgXLd90vIII+C7ZGTGZbPuD5zrZilT+xCUa8838XXmhGUbBO1aMvvNKA
	 Mb6km5a50rXGMTzBA7uSeIuKJkAYl+LIRdlBeNuHnuhtL8Ua93onf69wH0rkxmtke
	 zSkyzBK1oQnKI+fWHh7cQa88BrZM6t4fTAv5JTh0xzce2m4H4N9Cx6DJ6dLYcsld6
	 +kX8XK9twYYR2s59Zn5/PIAioSiiZo/tw7HlQskLtKzb2JI6j5iqbVrJZLa6FPh/1
	 eQUcLKOHbicxIqDd54ij+YYt4nGn5JCu++naL5PFWOFzog9v/r7ktwA4wbia+VTSJ
	 vMguzIng0ptP4d7kig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1vtiFH0WWC-00JjsP; Tue, 07
 Apr 2026 17:48:39 +0200
Message-ID: <5c8816fd-563f-4b79-84b7-57bf79a6d639@gmx.de>
Date: Tue, 7 Apr 2026 17:48:38 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] lib/fonts: Implement glyph rotation
To: Thomas Zimmermann <tzimmermann@suse.de>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, geert@linux-m68k.org, simona@ffwll.ch, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260407092555.58816-1-tzimmermann@suse.de>
 <20260407092555.58816-6-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260407092555.58816-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EDcpDQYUXzoMASknHU+8JhPXWZKJhNbLUEeBvAC0TNlvQGPjGos
 4BERoXStp2m3iHy1skayIgNUj4q/TqwlKPYWIfRI34PhpUVKxEwsmx9Kr/wU9olBKp0+7Ef
 +bc5Q1YF9C0unfxZDBrmDBIuVEopREPtCL94Uih+WJCNnd5oLrAKZ8OQqD8YCCRB5Rs0kDN
 c+EQkNAJYHW4o4C4wXvsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kz+tOXAPoi0=;1i7TD5dZgbwIYkBRTdW+5nfHh6/
 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
 cUFW2bLV+mzqFfeqfqimdk95bNjYZO4ng==

Hi Thomas,

On 4/7/26 11:23, Thomas Zimmermann wrote:
> Move the glyph rotation helpers from fbcon to the font library. Wrap the=
m
> behind clean interfaces. Also clear the output memory to zero. Previousl=
y,
> the implementation relied on the caller to do that.
>=20
> Go through the fbcon code and callers of the glyph-rotation helpers. In
> addition to the font rotation, there's also the cursor code, which uses
> the rotation helpers.
>=20
> The font-rotation relied on a single memset to zero for the whole font.
> This is now multiple memsets on each glyph. This will be sorted out when
> the font library also implements font rotation.
>=20
> Building glyph rotation in the font library still depends on
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy. If we get more users of the cod=
e,
> we can still add a dedicated Kconfig symbol to the font library.
>=20
> No changes have been made to the actual implementation of the rotate_*()
> and pattern_*() functions. These will be refactored as separate changes.
>=20
> v2:
> - fix typos
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/core/fbcon_ccw.c    |   4 +-
>   drivers/video/fbdev/core/fbcon_cw.c     |   4 +-
>   drivers/video/fbdev/core/fbcon_rotate.c |  12 +-
>   drivers/video/fbdev/core/fbcon_rotate.h |  71 -----------
>   include/linux/font.h                    |   8 ++
>   lib/fonts/Makefile                      |   1 +
>   lib/fonts/font_rotate.c                 | 150 ++++++++++++++++++++++++

Patch is Ok.
But since you move/add the file lib/fonts/font_rotate.c,
it should be reflected in MAINTAINERS file.
Do you mind sending a follow-up patch which adds /lib/fonts/* to the
FRAMEBUFFER LAYER and FRAMEBUFFER CORE entries in the MAINTAINERS file?

Other than that, I've now added this series to the fbdev git tree.

Thanks!
Helge
