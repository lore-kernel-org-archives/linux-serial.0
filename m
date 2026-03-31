Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8B3090C2;
	Tue, 31 Mar 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969739; cv=none; b=cV/du9y+WsfOCGPFL9h3T1Y2DZNIgvxcqGJUEBXEJd0fcmtf+VVFWfmmAg523SqKcctdVvNn2/gbFmP8jcnLtUHY+ml9/PUm8Ef88VlSGeDeGQKm44keZQyVHglyjrzBkbafScFGVqV56xY/le8hFzXLc5ke1ZPLBt5G96qqMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969739; c=relaxed/simple;
	bh=DEwrpBDFtn6lpl96OLsXY6ZciqOYpOpLXcervYIiU9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfsUVNChci+4X/mC8juR9kcZCHnD17VtYfy7sDspA0q2ifeqSDWJUN0SiH3qDmwd9FNPp0Nb3Xd+nJKiqO3lWlQTeXYh5Miz5IAZF8AojxrfsY+LeoaoyEVm1x8+5kD2BIDOgpbg/2UfWK9cV3a8QqRJBzgnTj0YX5qUvJWnDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=EL0yiK8I; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="EL0yiK8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774969735; x=1775574535; i=deller@gmx.de;
	bh=bBl0y8eCS8L4ZwEL9vdGNXXjTgV9jczaPe7298QiqcQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EL0yiK8IcjPmX2L7TUAjQbmI8iZnTUauARBZDhlcsivz/12HS9PBOHVJ51eholIB
	 LZqxslCdzqhc6Zj/4fFfDHjezeF2TqAD1i1BxdhBFGSPQq0PsHIkTmfImXryZ/ky/
	 f+HQb2nEEV5fuZJcygrmZ+3kgIac/s/EEIEAJY15rhaM2YhmPMKVk0bpqVzz0xDGV
	 5/RY8clHmnO3bjMhID2QW+aG28quEUqFyij6nj9HV+PjTmSFRgFbflmiYDnO8xuIh
	 Vr2aW0aZ88ocaPIexMFlsPv8HdU8ySihuRo9rYmBl5Gbo4rnQIlkMIjFbaYHEvKvL
	 3umIQMMGJQ73LUx73A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1vaTt92DMW-00mkhR; Tue, 31
 Mar 2026 17:08:55 +0200
Message-ID: <7c963dce-7b39-4047-b0bb-548957852d65@gmx.de>
Date: Tue, 31 Mar 2026 17:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fbcon,fonts: Refactor framebuffer console rotation
To: Thomas Zimmermann <tzimmermann@suse.de>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, simona@ffwll.ch, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260327130431.59481-1-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260327130431.59481-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UqZMgjrr1WGbxL7bGesYE1GaUYCCYbM25mm83zGPM8mr14HPi1L
 hrE9u7KgD0SWlAusXbuSkWJAsQ4Xwdc0f9BJcAj0cXVTGm5iVMaXti4gHZ9q1DXolsEr3EX
 jV+7/8RI2GC5982cZraGO4H1jjXLjPS9JEelI8//rxs51nCCC+Z8g+ajIXJqPAgp+ysq3bm
 Hd3sjAkUfz6O20aWfnzow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zSR/+DiTiJs=;W/F7CCV4dwgqDChuSVpg/s7ltW2
 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
 UPijCQ82FFmxBeNR/NW9

Hi Thomas,

On 3/27/26 13:49, Thomas Zimmermann wrote:
> Refactor the framebuffer console rotation into individual components
> for glyphs, fonts and the overall fbcon state. Right now this is mixed
> up in fbcon_rotate.{c,h}. Also build cursor rotation on top of the new
> interfaces.
>=20
> Start with an OOB fix in patch 1. If buffer allocation fails, fbcon
> currently uses a too-small glyph buffer for output. Avoid that.
>=20
> Patches 2 to 4 make a number of small improvements to the font library
> and its callers.
>=20
> Patches 5 to 8 refactor the font rotation. Fbcon rotation rotates each
> individual glphy in a font buffer and uses the rotated buffer's glyphs
> for output. The result looks like the console buffer has been rotated
> as a whole. Split this into helpers that rotate individual glyphs and
> a helper that rotates the font buffer of these. Then reimplement fbcon
> rotation on top. Document the public font helpers.
>=20
> Patch 9 rebuilds cursor rotation on top of the new glyph helpers. The
> fbcon cursor is itself a glyph that has to be rotated in sync with the
> font.
>=20
> Patch 10 moves the state of fbcon rotation into a single place and makes
> is a build-time conditional.
>=20
> Tested with fbcon under bochs on Qemu.
>=20
> Built upon the fbcon changes at [1].
>=20
> [1] https://lore.kernel.org/linux-fbdev/20260309141723.137364-1-tzimmerm=
ann@suse.de/


Thanks a lot for this cleanup work!

I've applied this series to the fbdev git tree.

Helge

 =20
> Thomas Zimmermann (10):
>    fbcon: Avoid OOB font access if console rotation fails
>    vt: Implement helpers for struct vc_font in source file
>    lib/fonts: Provide helpers for calculating glyph pitch and size
>    lib/fonts: Clean up Makefile
>    lib/fonts: Implement glyph rotation
>    lib/fonts: Refactor glyph-pattern helpers
>    lib/fonts: Refactor glyph-rotation helpers
>    lib/fonts: Implement font rotation
>    fbcon: Fill cursor mask in helper function
>    fbcon: Put font-rotation state into separate struct
>=20
>   drivers/tty/vt/vt.c                     |  34 +++
>   drivers/video/fbdev/core/bitblit.c      |  35 +--
>   drivers/video/fbdev/core/fbcon.c        |  48 ++++-
>   drivers/video/fbdev/core/fbcon.h        |  14 +-
>   drivers/video/fbdev/core/fbcon_ccw.c    |  70 ++----
>   drivers/video/fbdev/core/fbcon_cw.c     |  70 ++----
>   drivers/video/fbdev/core/fbcon_rotate.c |  88 ++------
>   drivers/video/fbdev/core/fbcon_rotate.h |  71 ------
>   drivers/video/fbdev/core/fbcon_ud.c     |  67 ++----
>   include/linux/console_struct.h          |  30 +--
>   include/linux/font.h                    |  51 +++++
>   lib/fonts/Makefile                      |  36 ++--
>   lib/fonts/font_rotate.c                 | 275 ++++++++++++++++++++++++
>   lib/fonts/fonts.c                       |   2 +-
>   14 files changed, 525 insertions(+), 366 deletions(-)
>   create mode 100644 lib/fonts/font_rotate.c
>=20

