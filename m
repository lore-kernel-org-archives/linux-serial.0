Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC440EB99
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858080; cv=none; b=pAscpR6BCdlzVJ+BM9CUPd1cjPya7eRiqNUF2YnOdOzBHIYkmNoSjkLGDsS+79Lm8z4Kgm1SgnJZLDVHtAvMl5goLabQtQUVL8bHdSYNhOSEN9DBfjBQxIrdYNWtvd5ygeiFo8G4pcOSUzKb+46kewCDVga6Gubs2JtObq9zCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858080; c=relaxed/simple;
	bh=xF9dojHZp/fsr8wzh0Dp8DOqIAqYc/x1jlY8ZN8SWWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMurljPUXpveEH+Cb34O6Z8ZDaQl4QHV70u34YlHxLiKcy9TFEk1AcbzHwfAnZRvIvL6hsBykodFQJqzSLU4cYP9WE7ae/v71NmEALJ77mxuYNyRT/buNuefYv1x9YIUkJSxzGTgMIbm1BXellnz0LbRdRd3bGaezRMF+WeEdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/jB0R2v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/jB0R2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0341F000E9;
	Thu, 27 Aug 2026 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858079;
	bh=2JUzywhNaxq6ibgTry/TixZ6Tep+1QTVbqSk42ZWtfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E/jB0R2vdTqOkjsldH1EHtmV3hokXju5K9FNNKaVCituQXxMcXc4eJB3I0o7LHR3t
	 iFQshD2sqHzEkrCKaLcefeORMYnMM60s7xsbGOmWPvp/hWlCeZv9FGCVF3MI38+yUL
	 m1tVCr0sMTpjWw1JcxIy1wN7LODsIuHstxymEOH6MKUPxWDrCqHhjC0gSVQOYHPJTn
	 6RxuYJSi+WC0pf/CgNLADQvgKZ51rMDdzGMh/NFhpwH6x+4+Ke+XiEqG8gdEE1mu4X
	 5GAJroHZAoE8G9f0tJzUcBNOBZyV2eSxOq2g5XVvS92h5iOVVYePVqNfAhKM3aQ6AE
	 bIwe7SqI2taXA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 7/9]: vt: Handle up to 2^21 glyphs, rather than 256/512
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <apCH8Pt7qdDjUWuW@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCH8Pt7qdDjUWuW@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:14:38 +0000
Message-Id: <20260827191439.4A0341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The intended support for large 21-bit fonts is functionally broken=
, and allocations near the 4MB boundary trigger a kernel warning.
--

commit 0f8b2aafff067c8299c320bab75fcb965a117b84
Author: Alan Mackenzie <acm@muc.de>

vt: Handle up to 2^21 glyphs, rather than 256/512

This commit increases the maximum number of font glyphs supported by the
vt subsystem to 2^21 to supplement tests with full Unicode limits.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 9208970f731e0..baf7c98429e9c 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
[ ... ]
> @@ -5015,17 +5016,23 @@ static int con_font_set(struct vc_data *vc, const=
 struct console_font_op *op)
[ ... ]
>  	size =3D DIV_ROUND_UP(op->width, 8) * vpitch * op->charcount;
> +#ifndef CONFIG_FB_GLYPH_21BIT
>  	if (size > max_font_size)
>  		return -ENOSPC;
> -
> +#endif
>  	void *font_data __free(kfree) =3D font.data =3D memdup_user(op->data, s=
ize);

[Severity: High]
Will memdup_user() reliably handle the newly permitted size allocations?

Because memdup_user() relies on kmalloc(), it is bounded to allocations
up to 4MB (MAX_PAGE_ORDER). If a user requests a font with 2^21 glyphs, the
size could easily exceed this limit, causing the allocation to silently fail
with -ENOMEM.=20

Would it be better to use vmemdup_user() here to fully support the larger
21-bit limit?

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 576be479d9286..a610071c89f53 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -2525,10 +2531,18 @@ static int fbcon_set_font(struct vc_data *vc, con=
st struct console_font *font,
>  	int i, ret;
>  	font_data_t *new_data;
> =20
> -	/* Is there a reason why fbconsole couldn't handle any charcount >256?
> -	 * If not this check should be changed to charcount < 256 */
> +#ifdef CONFIG_FB_GLYPH_21BIT
> +	if (charcount < 256)
> +		return -EINVAL;

[Severity: High]
Does this relaxed limit expose a kernel warning crash vector in the page
allocator?

By allowing charcount to reach 2^21, font allocations can approach or exact=
ly
hit the 4MB limit. When font_data_import() is called later in this function
with these parameters, it does the following:

lib/fonts/fonts.c:font_data_import() {
    ...
    alloc_size =3D size + sizeof(*font_data);
    font_data =3D kmalloc(alloc_size, GFP_USER);
    ...
}

If a user with CAP_SYS_TTY_CONFIG configures a font where the requested size
is exactly 4MB (which passes the memdup_user() check in con_font_set()), the
addition of sizeof(*font_data) will push the alloc_size slightly over 4MB.=
=20

Since this kmalloc() lacks the __GFP_NOWARN flag and requires an order 11
allocation, it will trigger a WARN_ON_ONCE in the page allocator. This could
crash systems configured with panic_on_warn.

> +#else
> +	/* There is no longer any reason why fbconsole can't handle
> +	 * any charcount >256, when CONFIG_FB_GLYPH_21BIT is #defined.
> +	 * Hence this check has been changed to charcount < 256
> +	 * above.
> +	 */
>  	if (charcount !=3D 256 && charcount !=3D 512)
>  		return -EINVAL;
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D7
