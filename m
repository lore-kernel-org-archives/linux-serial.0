Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1237A845
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858529; cv=none; b=Z1i70Thug8mkVcOFVq1nv6BTsTKn56oOmJRKmHYg3rC2YPyAZ7m2fCbPI3+lTQ04wRhlICtz0Wd0pJ8EJQlbb4OnFbKceVsp17MkIYev2ulvpNicSMpfoZUSLfte/58cUT0A5o4yHP2zEU6nXNARmP6HmHz2CMLeBLPFvrJOAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858529; c=relaxed/simple;
	bh=h+83XdcuooVwjNdLvbYjlH4N1PtVW5FVwTZpTSjydu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AUgqyaf+gt6voPxTtt1OCxiP8jSrQLOBAsgym0YtKPfNnYT77oN37jVsrB1YYz5XsdPfb8qfKxJTVAvSKbmqXEyDocunsnor2olPMsqIJI75bAWb4FlqNkiahmzNT/P2uL1Pamg6s2gd+37faO0GMl+sAPJTLdNe7dfkgGu0nUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMAgCkVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMAgCkVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1746E1F000E9;
	Thu, 27 Aug 2026 19:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858528;
	bh=OYHS1NO2GgjbDIZlUFLc3vRrFCtzRKpicpFqTlXsr3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMAgCkVxCKSy5Kfx3X+7A8lyJ6dkWR643cyQfeNzDfgrGKMEGJQBYe/901YBVKPwO
	 U2doNbOqkH8Ij/MfxRFkiDtPDM91ujoyxovTgWO8VOpz6pzXxWdab14wz4ZS7Sh/Gl
	 gXFd/nyVYxnD457LEFN5ZlnUoFyhEfr0rHrMyKv678HRsWf0EwX+BYiSLD4O87KK66
	 JcbV0bFDtCAp+DtjTvpfcmvUUG/UpwNtR0HVoCQNxpxXDZVHojAwgUglkjkYiiN4ky
	 v5dyaRYtwEcWeMf+0Xu1UikRjVv9G7m9A3ZRIkxGx63ZtN/HqpZhafDrpudtg03tno
	 FzbRrnauA2YhA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 6/9]: vt: Use u32 and typedef u1632 to handle whole
 glyphs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <apCHgPpGWGfVz2cI@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCHgPpGWGfVz2cI@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:22:07 +0000
Message-Id: <20260827192208.1746E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Using a raw 32-bit pointer dereference for VGA I/O memory caus=
es hardware faults on strict architectures and overflows 16-bit hardware vi=
deo RAM.
- [High] Casting a 32-bit stack variable's address to a 16-bit pointer in `=
con_putc` leads to blank or NUL characters on all big-endian architectures =
when 21-bit glyphs are disabled.
- [High] Pointer arithmetic in `fbcon_switch` implicitly assumes 16-bit gly=
phs, causing buffer misalignment and screen corruption when 32-bit glyphs a=
re enabled.
- [Medium] Fallback console translation macros were not updated for the new=
 `u1632` types, resulting in data truncation and build warnings.
--

commit 6fc77218ba179478ec0c7c9f101ceadca53ba76a
Author: Alan Mackenzie <acm@muc.de>

vt: Use u32 and typedef u1632 to handle whole glyphs

vt: 32b glyph: 6. Use u32 and typedef u1632 to handle whole glyphs

The glyph size u1632 is an either 32- or 16-bit unsigned word
depending on whether or not CONFIG_FB_GLYPH_21BIT is #defined.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8c7cbc47836fd..9208970f731e0 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
[ ... ]
> @@ -322,12 +322,12 @@ static inline u16 *screenpos(const struct vc_data *=
vc, unsigned int offset,
>  	return (u16 *)(origin + offset);
>  }
> =20
> -static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigne=
d int x)
> +static void con_putc(struct vc_data *vc, u32 ca, unsigned int y, unsigne=
d int x)
>  {
>  	if (vc->vc_sw->con_putc)
>  		vc->vc_sw->con_putc(vc, ca, y, x);
>  	else
> -		vc->vc_sw->con_putcs(vc, &ca, 1, y, x);
> +		vc->vc_sw->con_putcs(vc, (u16 *)&ca, 1, y, x);

[Severity: High]
Does casting this 32-bit local variable address to a 16-bit pointer expose
the endian-dependent memory layout to the backend driver?

On big-endian architectures where 21-bit glyphs are disabled, this cast
points to the most-significant 16 bits of the 32-bit variable (which are
zero). This leads to the backend reading 0x0000 and rendering a NUL charact=
er
instead of the true glyph.

[ ... ]
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 3e7cba53bdfc2..576be479d9286 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -2166,6 +2166,7 @@ static bool fbcon_switch(struct vc_data *vc)
>  	struct fbcon_par *par;
>  	struct fbcon_display *p =3D &fb_display[vc->vc_num];
>  	struct fb_var_screeninfo var;
> +	unsigned short *d, *s;
>  	int i, ret, prev_console;
> =20
>  	info =3D fbcon_info_from_console(vc->vc_num);

[Severity: High]
Does the pointer arithmetic in fbcon_switch implicitly assume 16-bit glyphs?

When a logo is displayed and the console is switched, the row pointers are
advanced using vc_cols:

			while (i--) {
				scr_memcpyw(d, s, conp2->vc_size_row);
				d +=3D conp2->vc_cols;
				s +=3D conp2->vc_cols;
			}

When CONFIG_FB_GLYPH_21BIT is enabled, vc_size_row is vc_cols * 4 bytes.
However, d and s are unsigned short *, so adding vc_cols only advances the
pointer by vc_cols * 2 bytes. Can this cause subsequent rows to overwrite
the second half of the previous row?

[ ... ]
> diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
> index 539d488fdc03f..5e50b4d4bd0b3 100644
> --- a/include/linux/consolemap.h
> +++ b/include/linux/consolemap.h
[ ... ]
> @@ -32,7 +42,7 @@ unsigned int ucs_get_width(uint32_t cp);
>  u32 ucs_recompose(u32 base, u32 mark);
>  u32 ucs_get_fallback(u32 cp);
>  #else
> -static inline u16 inverse_translate(const struct vc_data *conp, u16 glyp=
h,
> +static inline u1632 inverse_translate(const struct vc_data *conp, u16 gl=
yph,
>  		bool use_unicode)
>  {
>  	return glyph;

[Severity: Medium]
Were the fallback console translation macros missed when updating to the new
u1632 types?

The fallback for inverse_translate still accepts a u16 glyph, truncating any
32-bit glyph passed into it.

Additionally, the set_translate fallback below this (not shown in the diff)
still returns unsigned short *, which causes a type mismatch when assigned =
to
vc->vc_translate (which is now a u1632 *).

[ ... ]

Additionally, I have a question regarding the scr_writeg macro defined in
include/linux/vt_buffer.h, which is heavily used by these console updates:

include/linux/vt_buffer.h:
#define scr_writeg(val, addr) \
        (*((u32 *)(addr)) =3D (val))

[Severity: Critical]
Does using a raw 32-bit pointer dereference for VGA I/O memory cause hardwa=
re
faults on strict architectures (e.g., Alpha, MIPS)?

This bypasses architectural I/O accessors like writel/writew, which are
required for accessing MMIO space on these architectures. Furthermore, can
this overflow 16-bit hardware video RAM, since VGA VRAM requires exactly
16-bit accesses per character cell?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D6
