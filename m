Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E164388390
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120547; cv=none; b=jMQOZu3jtO6JlVZy4ZF56MSHxh6juS0mORJH3J5AdE66/pXOIw7Uzmoc75jdmqpWLezdiaPNmyFgQl9PZh/quhX/mgCpLjvkdZPGBeftuClKzgKUEvihTp855ooYzuJWs8tNwa1hEOWSqxLHfYzbMfk7bRtMmalMfNxaloZhacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120547; c=relaxed/simple;
	bh=2aUrlP6o1mg08o/X/oz8ekxh5x/b9WNV98suOvVetNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nlSDebTliFWH53Q/wWM8Dan1kNsKKwR/Bz3nFScRh16u27EGqaff4aDBG6IxDCAj+BEwxECO+HKNFz+hZEasGju3kImmYDZVTPspGkKU/i/TpukhZsLtV4DVDU5Dri+gKmYb6pwBeeyn23p8uHaqDHPRpd6QOlVCyvGiKJlWdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXR9Nxet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXR9Nxet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B3F1F00893;
	Fri, 11 Sep 2026 09:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120545;
	bh=WJykm7fkN6noDXw4FUIEEZu6P2sasK12frKVHjX4ink=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXR9Nxetxu+dcuOlIQt/6hNCuidypSSvf3eRWGvgFh5ymh2MLy4anxbzuROM4VxSR
	 kIzkMbyJSGh99xIBMKbcLkDC7x1q2wAV4sZ9+XwYxB2ulmQETFn2rj0tRpJrokMRb0
	 PpR1B6Cunk/0Leoy2f5zdVx3006aDoWN24crXEP5K+N7Tn1NJmNqUrtOWH++qv29LC
	 /XIBSSBj4BUxQcNhIR5cU9QWn7ktB0SUUL2Qn6vkHz25jkrJF3DDp8JuugPMPHSBo/
	 iHDfIyRhOwpc5FoJiw0yuk+Ta8YdrZbIoAAIIfoGfiy03GvgMqwnRtQH9Z5i3wqiDd
	 Ht6ij+GxakBHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] vt: Add cursor-size helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260911094518.78093-2-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:55:45 +0000
Message-Id: <20260911095545.B6B3F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unprotected concurrent access to the `cur_default` module parame=
ter creates a TOCTOU race that can lead to an infinite loop.
- [Low] The kerneldoc comments inaccurately describe the fallback behavior =
for unknown cursor types.
--

commit 79b9bf7bbf256d349ee59d8fded428600a818ace
Author: Thomas Zimmermann <tzimmermann@suse.de>

vt: Add cursor-size helpers
   =20
Cursors in the VT subsystem are blocks within a character cell that are
filled with the foreground color. The new helpers vc_font_cursor_start()
and vc_font_cursor_end() return the scanlines in which the cursor block
starts rsp. ends. This is compatible with VGA hardware

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8f467b22b799e..87c4bc2ef4950 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -264,6 +264,96 @@ unsigned int vc_font_size(const struct vc_font *font)
>  }
>  EXPORT_SYMBOL_GPL(vc_font_size);
> =20
> +static unsigned int vc_cursor_start(unsigned int height, unsigned int cu=
rsor_size)
> +{
> +retry:
> +	switch (cursor_size) {
[ ... ]
> +	default:
> +		pr_warn_once("Unknown cursor %u\n", cursor_size);
> +		if (cursor_size !=3D CUR_SIZE(cur_default))
> +			cursor_size =3D CUR_SIZE(cur_default);
> +		else
> +			cursor_size =3D CUR_UNDERLINE;
> +		goto retry;
> +	}
> +}

[Severity: Medium]
Is there a risk of an infinite loop here due to a data race on cur_default?

Since cur_default is a module parameter that can be modified concurrently,
reading it twice without READ_ONCE() inside vc_cursor_start() allows the
compiler to emit multiple memory reads.

If a concurrent thread modifies the parameter between unknown cursor sizes
(for example, switching between 7 and 8) while this function executes,
could this Time-Of-Check to Time-Of-Use race continuously trigger the goto
retry and cause a soft lockup?

> +/**
> + * vc_font_cursor_start - Calculates the cursor's first scanline within =
a glyph
> + * @font: The VC font
> + * @cursor_type: The type of cursor pattern
> + *
> + * The parameter @font is an initialized font. The argument in @cursor_t=
ype
> + * is one of the CUR_ constants, as stored in struct @vc_data.vc_cursor_=
type. For
> + * unknown values, the helper draws an underline dash.

[Severity: Low]
Does this kerneldoc accurately describe the fallback behavior?

The documentation for vc_font_cursor_start() promises an unconditional
fallback to an underline dash for unknown values, but the actual code
implementation first falls back to cur_default.

Should the documentation be updated to clarify that it first tries to use
cur_default before falling back to an underline dash?

> + *
> + * Returns:
> + * The index of the cursor's first scanline within the glyph
> + */
> +unsigned int vc_font_cursor_start(const struct vc_font *font, unsigned i=
nt cursor_type)
> +{
[ ... ]
> +static unsigned int vc_cursor_end(unsigned int height, unsigned int curs=
or_size)
> +{
> +retry:
> +	switch (cursor_size) {
[ ... ]
> +	default:
> +		pr_warn_once("Unknown cursor %u\n", cursor_size);
> +		if (cursor_size !=3D CUR_SIZE(cur_default))
> +			cursor_size =3D CUR_SIZE(cur_default);
> +		else
> +			cursor_size =3D CUR_UNDERLINE;
> +		goto retry;
> +	}
> +}

[Severity: Medium]
Can this identical fallback logic also result in a soft lockup?

Just like in vc_cursor_start(), the unprotected concurrent access to
cur_default in vc_cursor_end() could potentially trap a thread in an
infinite goto retry loop if the module parameter is modified at the exact
right time.

> +/**
> + * vc_font_cursor_end - Calculates the first scanline after the cursor w=
ithin a glyph
> + * @font: The VC font
> + * @cursor_type: The type of cursor pattern
> + *
> + * The parameter @font is an initialized font. The argument in @cursor_t=
ype
> + * is one of the CUR_ constants, as stored in struct @vc_data.vc_cursor_=
type. For
> + * unknown values, the helper draws an underline dash.

[Severity: Low]
Is this comment also missing the cur_default fallback behavior?

Similar to vc_font_cursor_start(), the comment for vc_font_cursor_end()
states it draws an underline dash for unknown values, but the code first
relies on cur_default.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094518.7809=
3-1-tzimmermann@suse.de?part=3D1
