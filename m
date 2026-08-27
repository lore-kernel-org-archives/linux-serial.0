Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD13431E76
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857979; cv=none; b=BYjLlgoGDLjU+/N603oPSZKGxjH8F5Zyd/VJGVg3uIN/jbiEfkV2UCDRQXCDyY23pVrGxvVQ0v1vBhCPHhQkHH1Gh6iJjtuGMP1h1QiWefT0VXbqAix4M/xy9dF2N7CaKmQ/bdWFEyj8r4X71uV2xFFbWpz27pnZftXnaxt+gPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857979; c=relaxed/simple;
	bh=UMiQ6H0crQ6QlfgYbkqDfbG+2kNs5ob1b4gkM54mkHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O8R28NNohRD9EXyRuuOAN1Ucls8ocTEsqV/3v3B9PQMGg23s7FFcJ2t+K5iUqnPhDmbL3NKUP2jUi9+L+xxfjTGX9h3XKu1JrD/2qnDHYYFpi++bcIIfY7zkAKib9sFXzRCCgjjcAhzjzovmtkAEhLvBVdsNrucFF7uHcTJGa44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYlQ6J1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYlQ6J1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0A51F000E9;
	Thu, 27 Aug 2026 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857977;
	bh=n/prNACSm7ZD+vf9e96Ht6fX4eX3xVkiLOEXo1W+KBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYlQ6J1j0JuUZur+PsSqfbunc9x4lITrP7q3r/JSauPA8IfMm3Eswn55v2lEF4frI
	 tPYIvbvgIFBnExt1xkfYIs/GGtWPbpjzUQWTG6QRxMjoi2YGE21Bvz7CrLbX5L/cHt
	 lE/IJ7jMBEChlxxr3/jceWvdBH1kL8yqoCFXDCXGozXk0g8k81PmutWnUphKnpTvUI
	 WK0GndRElaHtb2FFxwvTFlUDO3cduB46IvOQ/TbZhfh7ihr3UcpNBcshogO1fV2lWc
	 pKHza8rYqd1y4kA84X6vk2H6Q9aHFMLfN8ZtPAHqTJgqc9qcZSq5Qn/49aFwZiueS6
	 8HFZ+M0iWQR9w==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 5/9]: vt: Amend three Kconfig files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <apCG-zHyuMVYHJ6j@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCG-zHyuMVYHJ6j@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:12:57 +0000
Message-Id: <20260827191257.AE0A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Enabling CONFIG_FB_GLYPH_21BIT changes GLYPH_SZ to 4 globally, bre=
aking hardware console drivers (like vgacon) and rotated fbcon drivers that=
 still hardcode 16-bit screen buffer accesses.
- [Medium] FB_GLYPH_21BIT is a generic VT/fbdev feature but is inappropriat=
ely placed in the DRM clients menu, unnecessarily restricting its use.
--

commit 7b9fb605add2fa8c6f62e8ba79cee762cbcbd24c
Author: Alan Mackenzie <acm@muc.de>

vt: Amend three Kconfig files

Until it becomes clear how to integrate CONFIG_A11Y_BRAILLE_CONSOLE and
CONFIG_SPEAKUP, they will remain disabled when CONFIG_FB_GLYPH_21BIT is
#defined.

[ ... ]

> diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kc=
onfig
> index 6096c623d9d5b..0ce8c1506eaad 100644
> --- a/drivers/gpu/drm/clients/Kconfig
> +++ b/drivers/gpu/drm/clients/Kconfig
> @@ -42,6 +42,15 @@ config DRM_FBDEV_EMULATION
> =20
>  	  If in doubt, say "Y".
> =20
> +config FB_GLYPH_21BIT
> +	bool "Enable 21-bit glyphs in the frame buffer device"
> +	depends on (DRM_FBDEV_EMULATION =3D y)

[Severity: Medium]
Could placing this generic VT/fbdev feature in the DRM clients menu
inappropriately restrict its use?

Native framebuffer drivers (e.g., vesafb, efifb, simplefb) might be prevent=
ed
from utilizing 21-bit glyph support, as this strictly requires
DRM_FBDEV_EMULATION. The feature modifies the generic Virtual Terminal and
fbcon subsystems, which are independent of DRM.

[Severity: High]
Can enabling CONFIG_FB_GLYPH_21BIT corrupt the screen buffer for hardware
console drivers and rotated fbcon drivers?

When this is enabled, GLYPH_SZ becomes 4 globally and VT uses 32-bit screen
buffer entries. However, the consw interface still passes pointers typed as
const unsigned short *, and some drivers still hardcode 16-bit accesses.

For example, rotated fbcon implementations iterate the buffer using scr_rea=
dw()
which advances the u16 pointer by 2 bytes instead of 4, reading half-charac=
ters:

drivers/video/fbdev/core/fbcon_cw.c:cw_putcs_aligned() {
    ...
    src =3D par->rotated.buf + (scr_readw(s++) & charmask) * cellsize;
    ...
}

Similarly, vgacon maps physical VGA VRAM assuming exactly 16 bits per chara=
cter,
meaning 32-bit writes from scr_writeg in vt.c will overwrite adjacent cells
in hardware memory:

drivers/video/console/vgacon.c:vgacon_invert_region() {
    ...
    u16 a =3D scr_readw(p);
    ...
    scr_writew(a, p++);
    ...
}

> +	help
> +	  This option enables 21-bit glyphs in the fbdev framebuffer,
> +	  surmounting the traditional restriction to 256/512 glyphs dating back
> +	  to the VGA hardware of the 1980s and 1990s.  To use this effectively
> +	  you will need a suitable font and possibly a suitable keyboard layout.
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D5
