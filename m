Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60561437846
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144900; cv=none; b=iCEiPkqczDDWDQ2vMk3IBF1vglnYEmtLi3JupNq5BSd8d1fdzqnKd1VJSka7NiCUHWqO72N7z9q9TYsU7QE6b4RC9bZrkEhgllu8dyutcn1UJ/i8WDJL2V+OCfivGRsFHWRU87Ps1l/yqkxnjJ4KyqFOzHe91yRZYafjRNX4x+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144900; c=relaxed/simple;
	bh=KpScrL0xcTegO2odziBOkrvVlKL9Zw4hFo/+0Kf9GdQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kHCk96+RpDj+QiOqTvGxdENLS3FgHsx8qEzuujet7ekcfGU6SCwauMeBrWhePbVd/JYdoR8YKWSo+UWxpDwBpn7uHb6LFoYutnJa1wwdjvUjAIkKVhMSSOwz5YzM2z7y7Ea3Ig75yxEeHIMECuylk0UOXTYxITvQsU15c4J+7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkZPPH7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkZPPH7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61591F000C6;
	Fri, 16 Oct 2026 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144899;
	bh=aRrGSSk2tdHNpBKV4Kow3gW4MdtmDviDsQOKTmDL4qI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jkZPPH7uDqRfk4MXSFPUJcFMmBZ8E66wvde+cHfKXwsHCXmTMchNP9gPlEy3W/gHe
	 eE6fYkBqoRAxlqcVMztvtFLO8nj+yKCE6TTxRdVNNnynAw8RVHB7lZ6CjKJm8ZNPgV
	 dcqrgLA+SF0tPUJOuJ3sDmz0eiDI7+jVKpmkv8jAozezMpuXEie4JIragpCWDkEsOp
	 nRanhddvbEwi+WYE35+KLM977ou0eJovB0njTZbdtpqvHFYaw+CbVbLTOjotWd9VLk
	 gb8tsM+Y5LvGbl3BXrPsETAdBAKloMdfC4KtxJ3u/teWoKbRa2IV6Egm1UuxSYnGhS
	 NnxGkOUsMVe/Q==
Message-ID: <sashiko-outbox-174115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] fbcon: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016093357.33294-4-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
 <20261016093357.33294-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:01:38 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] fbcon: missing mode restore on VT switch due to par->graphics desy=
nc
--

commit c18deeb283bd933a2a74f5f89b8adc5baff05746
Author: Thomas Zimmermann <tzimmermann@suse.de>

fbcon: Implement struct consw.con_unblank

Implement con_unblank from struct consw with the !blank branches from
fbcon_blank(). The new function is called fbcon_unblank(). Remove the
duplicated code from fbcon_blank().

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index caad4e06944ea..6b6f162c90dd3 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2293,32 +2293,53 @@ static bool fbcon_blank(struct vc_data *vc, enum =
vesa_blank_mode blank,
[ ... ]
> +static bool fbcon_unblank(struct vc_data *vc)
> +{
> +	struct fb_info *info =3D fbcon_info_from_console(vc->vc_num);
> +	struct fbcon_par *par =3D info->fbcon_par;
> +	bool mode_switch =3D par->graphics && vc->vc_mode =3D=3D KD_TEXT;

[Severity: High]
Can par->graphics become out of sync and prevent a required mode restore?

If vt_kdsetmode(KD_GRAPHICS) is called on a background console, it returns
early without calling do_blank_screen(), leaving par->graphics as false.

When switching to this VT, if the previous foreground VT was also in
KD_GRAPHICS mode, complete_change_console() in drivers/tty/vt/vt_ioctl.c sk=
ips
do_blank_screen() because old_vc_mode matches vc->vc_mode:

	if (old_vc_mode !=3D vc->vc_mode) {
		if (vc->vc_mode =3D=3D KD_TEXT)
			do_unblank_screen(1);
		else
			do_blank_screen(1);
	}

Because do_blank_screen() is skipped, par->graphics remains false for the n=
ew
framebuffer. When the application later exits and calls ioctl(KDSETMODE,
KD_TEXT), fbcon_unblank() is triggered.

Since par->graphics is false, mode_switch evaluates to false, skipping
fb_set_var() with FB_ACTIVATE_KD_TEXT. Without FB_ACTIVATE_KD_TEXT, DRM
helpers (like drm_fb_helper_set_par()) won't force a mode restore before the
DRM master drops its locks, which could leave the display frozen or corrupt=
ed.

> +
> +	if (mode_switch) {
> +		struct fb_var_screeninfo var =3D info->var;
> +
> +		var.activate =3D FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE | FB_ACTIVATE_KD_=
TEXT;
> +		fb_set_var(info, &var);
> +		par->graphics =3D false;
> +		par->var =3D info->var;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016093357.3329=
4-1-tzimmermann@suse.de?part=3D3
