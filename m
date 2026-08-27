Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FD42E435
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858378; cv=none; b=Gvgv8CbGW/mM5QkrVItUbdPWwhojhqPRsCSVAeMihtEPPYnbGDzgLW7PgQh766P5eF22p+qs7zmb7hOrafc51irj4L5wELSuJ8E0S4vMHbpbhtK0ADREweQmqbZVAipRhy+nWblhvFf8Q7W9l3TYJbcd7xVRgidJtDAykZCnmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858378; c=relaxed/simple;
	bh=c9fQatl/2XRGaujWafoUdIomEtQnIxPEUQgxfqDDs/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cr9jFl3bGoJYVCKxmNztK0uhYvBZPznFHc9OBY8YcBOlcGBjQ/rZbS7QBg7DHI0oAQH+xN2klxKxWThqOjAEmEmbGHC+DDv0JjD6PnQ6C1dmI2bcoV5WZKTeFTU3liWKZ6H3iTUE889k+G6WhRqwOdmwcHtLZZbCOSNH4/YH9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbrmH/v2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbrmH/v2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9251F000E9;
	Thu, 27 Aug 2026 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858377;
	bh=FbUbHWBBYteBn2Upp/DggaXHVt3wV9TEN11qhr4xzPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbrmH/v2/YBYrS2nmWvN1TsHSRpRhbz76qpwTIvv27J8E0c/cUHHMhcDiOroyHDaF
	 naU8FZIpPm7C3GHvLobTyEQaeKwJ3kn8Kz3W0/DkrD89jglLaYZYmZbfH+Uc9DrUST
	 I0dj8q7M6tdQSNiRx5slpr801kM2WuCrAxRnMpnvu8C4VocDaOiRbfW6pyBJ1/xUxP
	 33khQhp7VB3s4+EoZTn94fgTqTmJ9DyZcNtI+uDYC7UAMXLsDocVwPdUbNK6B1yTan
	 mNdSeY8ldmmEj7iQco9IOkOPi07IfikU2vr2FQ6iVAwA5X737OVL3ot7idz/ruqgwn
	 6VpG9Lcmapizw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 4/9]: Amend internal manipulation of glyph structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <apCGh2y_Ole8rAGT@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCGh2y_Ole8rAGT@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:19:36 +0000
Message-Id: <20260827191937.4B9251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Missing bounds check in `bit_cursor` allows an out-of-bounds r=
ead of kernel memory, leading to a severe information leak, exacerbated by =
the new `vc_char_mask`.
- [High] `vc_do_resize` corrupts `vc_video_erase_char` by overwriting the c=
orrect value from `update_attr(vc)` with a manually calculated, malformed v=
alue.
- [High] `fbcon_init` fails to initialize `vc_char_mask` and `vc_attr_shift=
_pos` when `init =3D=3D false`, truncating 512-character fonts to 256 chara=
cters during console driver binding.
- [High] The patch removed the left-shift of attributes for 512-character f=
onts in `build_attr()`, but failed to update `vc_invert_attr()` and `csi_RS=
B()`, which still expect the shifted format.
- [High] `vc_complement_mask` is incorrectly initialized for 512-character =
fonts due to out-of-order execution between `fbcon_init` and `visual_init`.
--

commit 2c79dd51730bb5b8d8d112b0649dbd28e356ba79
Author: Alan Mackenzie <acm@muc.de>

vt: 32b glyph: 4. Amend internal manipulation of glyph structure

This commit replaces hard-coded bitmask constants with new variables
in the vc_data structure to handle the extraction and insertion of bit
fields for 16-bit and 32-bit glyphs.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1051,19 +1036,37 @@ static void visual_init(struct vc_data *vc, int n=
um, bool init)
>  		con_free_unimap(vc);
>  	vc->uni_pagedict_loc =3D &vc->uni_pagedict;
>  	vc->uni_pagedict =3D NULL;
> -	vc->vc_hi_font_mask =3D 0;
> +	vc->vc_hi_font_mask =3D 0; /* Probably redundant, 2025-01-16. */
>  	vc->vc_complement_mask =3D 0;
>  	vc->vc_can_do_color =3D 0;
>  	vc->vc_cur_blink_ms =3D DEFAULT_CURSOR_BLINK_MS;
> +
>  	vc->vc_sw->con_init(vc, init);

[ ... ]

>  	if (!vc->vc_complement_mask)
> -		vc->vc_complement_mask =3D vc->vc_can_do_color ? 0x7700 : 0x0800;
> +		vc->vc_complement_mask =3D (vc->vc_can_do_color ? 0x77 : 0x08)
> +			<< vc->vc_attr_shift_pos;

[Severity: High]
Can this fail to correct a wrongly initialized complement mask?

visual_init() calls the console driver init (which reaches fbcon_init)
before vc_attr_shift_pos is fully initialized. fbcon_init() configures
vc_complement_mask falling back to a shift of 8.

When execution returns here, the zero-check skips execution because the
mask is already non-zero. For 512-character fonts, does this leave the
mask targeting bits 8-15 instead of 9-15, causing the mouse pointer to
corrupt the character glyph index?

[ ... ]

> @@ -1185,12 +1188,31 @@ static int vc_do_resize(struct tty_struct *tty, s=
truct vc_data *vc,
>  	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
>  	unsigned short *oldscreen, *newscreen;
>  	u32 **new_uniscr =3D NULL;
> -
> +	unsigned int new_vc_char_mask =3D vc->vc_char_mask;
> +	unsigned int new_vc_attr_mask =3D vc->vc_attr_mask;
> +	unsigned int new_vc_attr_shift_pos =3D vc->vc_attr_shift_pos;
> +	unsigned int new_vc_video_erase_char =3D vc->vc_video_erase_char;
>  	WARN_CONSOLE_UNLOCKED();
> =20
>  	if (cols > VC_MAXCOL || lines > VC_MAXROW)
>  		return -EINVAL;
> =20
> +#ifndef CONFIG_FB_GLYPH_21BIT
> +	if (vc->vc_hi_font_mask =3D=3D 0x100) {
> +		new_vc_char_mask =3D 0x1ff;
> +		new_vc_attr_mask =3D 0xfe00;
> +		new_vc_attr_shift_pos =3D 9;
> +	} else {
> +		new_vc_char_mask =3D 0xff;
> +		new_vc_attr_mask =3D 0xff00;
> +		new_vc_attr_shift_pos =3D 8;
> +	}
> +#endif
> +	new_vc_video_erase_char =3D
> +		(vc->vc_video_erase_char & vc->vc_char_mask) |
> +		((vc->vc_video_erase_char >> vc->vc_attr_shift_pos) <<
> +		 new_vc_attr_shift_pos);

[Severity: High]
Could this recalculation corrupt the erase character during a resize?

When fbcon_set_disp() triggers a resize, this section recalculates
new_vc_video_erase_char by shifting the old value, dropping bits.
Later in vc_do_resize(), the correctly rebuilt erase character
from update_attr() is explicitly overwritten with this malformed
new_vc_video_erase_char.

Will this cause severe background color corruption following a display
mode or font change?

[ ... ]

> @@ -2141,8 +2163,10 @@ static void csi_RSB(struct vc_data *vc)
>  		break;
>  	case CSI_RSB_MAKE_CUR_COLOR_DEFAULT:
>  		vc->vc_def_color =3D vc->vc_attr;
> +#ifndef CONFIG_FB_GLYPH_21BIT
>  		if (vc->vc_hi_font_mask =3D=3D 0x100)
>  			vc->vc_def_color >>=3D 1;
> +#endif
>  		default_attr(vc);
>  		update_attr(vc);
>  		break;

[Severity: High]
Does this code still need to shift the default color?

The patch removes the left-shift of attributes for 512-character fonts
in build_attr(). Since vc_attr is now in an unshifted format, shifting
it right here halves the color value on a color reset instead of undoing
the shift.

[ ... ]

> @@ -3049,10 +3075,12 @@ static inline unsigned char vc_invert_attr(const =
struct vc_data *vc)
>  	if (!vc->vc_can_do_color)
>  		return vc->vc_attr ^ 0x08;
> =20
> +#ifndef CONFIG_FB_GLYPH_21BIT
>  	if (vc->vc_hi_font_mask =3D=3D 0x100)
>  		return   (vc->vc_attr & 0x11) |
>  			((vc->vc_attr & 0xe0) >> 4) |
>  			((vc->vc_attr & 0x0e) << 4);
> +#endif

[Severity: High]
Are these bitwise operations still valid for the new attribute layout?

The legacy logic in vc_invert_attr() applies bitwise transformations
(0x11, 0xe0, 0x0e) meant for attributes shifted left by 1. Applying
these to the new unshifted layout scrambles the foreground and
background colors when the selection or cursor is inverted.

> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/cor=
e/bitblit.c
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -260,7 +260,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_=
info *info, bool enable,
>  {
>  	struct fb_cursor cursor;
>  	struct fbcon_par *par =3D info->fbcon_par;
> -	unsigned short charmask =3D vc->vc_hi_font_mask ? 0x1ff : 0xff;
> +	unsigned int charmask =3D vc->vc_char_mask;
>  	int w =3D DIV_ROUND_UP(vc->vc_font.width, 8), c;
>  	int y =3D real_y(par->p, vc->state.y);
>  	int attribute, use_sw =3D vc->vc_cursor_type & CUR_SW;

[Severity: Critical]
Does this sequence allow an out-of-bounds read of kernel memory?

The function extracts the character index from the screen buffer without
validating it against vc_font.charcount. Under CONFIG_FB_GLYPH_21BIT,
vc_char_mask expands to 0x1fffff, removing the implicit bitmask limit.

When calculating the pointer later in bit_cursor():

src =3D vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));

Could a user with write access to /dev/vcsaN write crafted 32-bit
values to the screen buffer to leak sensitive memory to the display?

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1156,14 +1156,8 @@ static void fbcon_init(struct vc_data *vc, bool in=
it)
>  	}
> =20
>  	vc->vc_can_do_color =3D (fb_get_color_depth(&info->var, &info->fix)!=3D=
1);
> -	vc->vc_complement_mask =3D vc->vc_can_do_color ? 0x7700 : 0x0800;
> -	if (vc->vc_font.charcount =3D=3D 256) {
> -		vc->vc_hi_font_mask =3D 0;
> -	} else {
> -		vc->vc_hi_font_mask =3D 0x100;
> -		if (vc->vc_can_do_color)
> -			vc->vc_complement_mask <<=3D 1;
> -	}
> +	vc->vc_complement_mask =3D (vc->vc_can_do_color ? 0x77 : 0x08) <<
> +		(vc->vc_attr_shift_pos ? vc->vc_attr_shift_pos : 8);

[Severity: High]
Will this skip initializing vc_char_mask when init =3D=3D false?

When switching console drivers, visual_init() clears vc_hi_font_mask
and calls fbcon_init() with init =3D=3D false. Because the initialization of
the font mask was removed here, vc_do_resize() forcefully applies a
256-character mask (0xff).

Does this truncate valid 512-character fonts during driver binding,
rendering the upper 256 characters unreachable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D4
