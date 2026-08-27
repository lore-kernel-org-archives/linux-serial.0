Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D437187C
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858738; cv=none; b=TAl+55QbGIqbLFpcfzco4IQRxCa2ATRkqBDw65mLMfMxYSN8BOwr8A/oxOFaWDPWjEkhcukTHYrObIKuV2+JDDidGhRduaZqgrEEoCu/BlqLUzDPYkWJ0MxKzYKG80yM7NoujWdVsANQgo25guBoIs54d71CAErlWcscQsVJ3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858738; c=relaxed/simple;
	bh=TvrKz1rk+7jKOT6WuAT2myo7h6FHZgRAE7v4xa2lzfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H4icRwe2Zkf2yuXsclg1OA3qP+kTdLtzwsDwmnW4BdKoVcYLq7+L+ewHKIPMTIw59r8S+GOY0FtzJGn+n+3VUKfWkMyitShSNfRn+LgsOiWltIha74WvmQfMIVGrqLf4pTVSKwXD7mFl9htaKdaAhTgObZuVK6A9ZuquRnwGRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHEidlJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHEidlJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F041F00A3D;
	Thu, 27 Aug 2026 19:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858735;
	bh=96P4Mbkyy/eLAR/FrCa8rmmhc7B+YUCtHstLNUMLkUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHEidlJSJ39VstNzObVwD5Wl4UzkFTGaEmBp/hl84rnuIOH9wln2EGwosFzYQtvNk
	 aioJuCVeFt0d24LhOr7EmKmSso/QZO2sXWSV7iAHUfjGBKkxxXthFgFlweBx4MuNn2
	 jOK4w2b5Sl80G+qS9xEFF2QhRn5phcaSDutAQB+45sCzTutEA+a6lS1xPKzYTwvaCc
	 GvKlU9swpYlsNkvj+N2Y1OAWAeD0Sbem852mzEdkzMBpTsmklQaILmA0uLlBY1DuNJ
	 Qq69TY5CqZDJdKMXcGuj5pxEumUL+jFiT7/Ch2I7/xGn6u7ustBSWNpo9/8KqPvyTE
	 uFG14FY7XCtRA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 8/9]: vt: Enhancements to the VT ioctl interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <apCIXtwoPY_a3QOi@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCIXtwoPY_a3QOi@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:25:34 +0000
Message-Id: <20260827192535.33F041F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Downgrading user-sized allocations from kvmalloc-backed routines t=
o kmalloc_array breaks legitimate large requests and allows an unprivileged=
 user to exhaust memory or flood the kernel log.
- [High] Missing compat ioctl handlers for the newly introduced `PIO_UNIMAP=
21` and `GIO_UNIMAP21` commands breaks UAPI for 32-bit applications.
- [High] Uninitialized kernel stack memory leaked to userspace when CONFIG_=
CONSOLE_TRANSLATIONS is disabled.
- [Medium] Required buffer size is silently truncated in the legacy 16-bit =
GET ioctl if the dictionary exceeds 65535 entries.
- [Low] Incompatible pointer types passed to fallback dummy functions break=
 the build when CONFIG_CONSOLE_TRANSLATIONS is disabled.
--

commit 50062db5106d84e65d87483ac16b8d41dbdd6175
Author: Alan Mackenzie <acm@muc.de>

    vt: Enhancements to the VT ioctl interface
   =20
    Handle the current 16-bit P/GIO_UNIMAP ioctls by converting
    to/from 32-bit code-points/glyph numbers.  Add handling for new
    32-bit ioctls P/GIO_UNIMAP21.  Convert to and from __user in
    vt_ioctl.c rather than in vt.c or consolemap.c.

> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 28993a3d0acb6..05986430e1bb3 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c

[ ... ]

> @@ -484,10 +484,155 @@ static int vt_k_ioctl(struct tty_struct *tty, unsi=
gned int cmd,
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_FB_GLYPH_21BIT
> +static int vt__user_unipair_8_to_21(unsigned int ct,
> +				    struct unipair __user *entries,
> +				    struct unipair21 **tmp21_entries)
> +{
> +	struct unipair *tmp_entries;
> +	int i, ret =3D 0;
> +
> +	tmp_entries =3D kmalloc_array(ct, sizeof(struct unipair), GFP_KERNEL);
> +	if (!tmp_entries)
> +		return -ENOMEM;
> +	if (copy_from_user(tmp_entries, entries, ct * sizeof(struct unipair))) {
> +		ret =3D -EFAULT;
> +		goto free_tmp;
> +	}
> +	*tmp21_entries =3D kmalloc_array(ct, sizeof(struct unipair21), GFP_KERN=
EL);

[Severity: High]
Could these unbounded allocations fail or cause page allocator warnings? A =
full
legacy map (65535 entries) requires an order-7 allocation for `tmp21_entrie=
s`
(524KB), which might spuriously fail without a vmalloc fallback. Additional=
ly,
does this allow an unprivileged user to exhaust memory or flood the kernel =
log
by providing large `ct` values without `__GFP_NOWARN`?

> +	if (!*tmp21_entries) {
> +		ret =3D -ENOMEM;
> +		goto free_tmp;
> +	}

[ ... ]

> +static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *use=
r_ud,
> +		bool perm, struct vc_data *vc)
> +{
> +	struct unimapdesc tmp;
> +	struct unipair21 *tmp21_entries =3D NULL;
> +	int ret =3D 0, ret1 =3D 0;
> +	unsigned int ct;
> +
> +	if (copy_from_user(&tmp, user_ud, sizeof(tmp)))
> +		return -EFAULT;
> +	switch (cmd) {

[ ... ]

> +	case GIO_UNIMAP:
> +		if (!perm && fg_console !=3D vc->vc_num)
> +			return -EPERM;
> +		tmp21_entries =3D kmalloc_array(tmp.entry_ct,
> +					      sizeof(struct unipair21),
> +					      GFP_KERNEL);
> +		if (!tmp21_entries)
> +			return -ENOMEM;
> +		ret =3D con_get_unimap(vc, tmp.entry_ct, &ct, tmp21_entries);
> +		if (ret)
> +			goto free_tmp21;
> +		ret =3D vt_unipair_21_to__user_8(ct, tmp21_entries, tmp.entries);
> +free_tmp21:	ret1 =3D put_user(ct, &user_ud->entry_ct);

[Severity: High]
If CONFIG_CONSOLE_TRANSLATIONS is disabled, the dummy `con_get_unimap` inli=
ne
returns `-EINVAL` without initializing `ct`. Does this result in uninitiali=
zed
kernel stack memory leaking to userspace when `ct` is copied by `put_user()`
on the error path?

[Severity: Medium]
Also, could this silently truncate the required buffer size if the dictiona=
ry
exceeds 65535 entries? The 32-bit accurate size `ct` is written to a 16-bit
`user_ud->entry_ct`, causing legacy applications reading the map via GIO_UN=
IMAP
to receive an incorrect, truncated size and fail to allocate a sufficient b=
uffer.

> +		kfree(tmp21_entries);
> +		return ret ? ret : ret1;
> +	}
> +	return 0;
> +}
> +
> +static inline int do_unimap_ioctl21(int cmd, struct unimapdesc21 __user =
*user_ud,
> +		bool perm, struct vc_data *vc)
> +{
> +	struct unimapdesc21 tmp;
> +	struct unipair21 *k_entries;
> +	int ret =3D 0, ret1 =3D 0;
> +
> +	if (copy_from_user(&tmp, user_ud, sizeof(tmp)))
> +		return -EFAULT;
> +	switch (cmd) {
> +	case PIO_UNIMAP21:
> +		if (!perm)
> +			return -EPERM;
> +		k_entries =3D kmalloc_array(tmp.entry_ct,
> +					  sizeof(struct unipair21),
> +					  GFP_KERNEL);

[Severity: High]
Does this allow unbounded allocations similar to `vt__user_unipair_8_to_21(=
)`?
Passing an unbounded user-provided size `tmp.entry_ct` to `kmalloc_array`
without `__GFP_NOWARN` could allow an unprivileged user to trigger page
allocator warnings and exhaust memory. Furthermore, `con_set_unimap()`
propagates this count to `dict->count`, leading to additional unbounded
`kmalloc` allocations in `set_inverse_transl()`.

[ ... ]

> @@ -1026,16 +1203,20 @@ compat_kdfontop_ioctl(struct compat_console_font_=
op __user *fontop,
>  }
> =20
>  struct compat_unimapdesc {
> -	unsigned short entry_ct;
> +	u16 entry_ct;
>  	compat_caddr_t entries;
>  };
> =20
> +#ifdef CONFIG_FB_GLYPH_21BIT
>  static inline int
>  compat_unimap_ioctl(unsigned int cmd, struct compat_unimapdesc __user *u=
ser_ud,
>  			 int perm, struct vc_data *vc)
>  {

[Severity: High]
Are we missing compat ioctl handlers for `PIO_UNIMAP21` and `GIO_UNIMAP21`?
`struct unimapdesc21` contains a pointer, so its layout differs between 32-=
bit
and 64-bit architectures (8 bytes vs 16 bytes). Without explicit handling in
`vt_compat_ioctl()`, 32-bit processes on 64-bit kernels will fail to invoke
these new ioctls and receive -ENOIOCTLCMD or -ENOTTY.

[ ... ]

> diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
> index e017588979194..af99aeefe177f 100644
> --- a/include/linux/vt_kern.h
> +++ b/include/linux/vt_kern.h
> @@ -96,13 +96,13 @@ static inline int con_clear_unimap(struct vc_data *vc)
>  	return 0;
>  }
>  static inline
> -int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user =
*list)
> +int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair *list)

[Severity: Low]
Will this break the build when CONFIG_CONSOLE_TRANSLATIONS is disabled?
The fallback dummy function for `con_set_unimap` expects a `struct unipair =
*`,
but the callers in `vt_ioctl.c` under `CONFIG_FB_GLYPH_21BIT` (like
`do_unimap_ioctl21`) pass `struct unipair21 *`, which violates strict type
checking.

>  {
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D8
