Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3142BC56
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858738; cv=none; b=FcjsO+PYd7PfLCwrewbS35wRAIwSKdrxqPXPFImdnCrwXdsTnlTtIOym1z/HG6fmtshNF740nr+/oK3spTJIMYd/OElFH4RoGirU0mFG/OC9ekX3cAq/xi3sYRkp8etBAlnx8MNrFvxnzf4Z58YiVnQl9RfrFMsUFdb7n0DOI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858738; c=relaxed/simple;
	bh=20HVZiKu5OHP1jg2+Nl/3Y1bIvyRy9QyBbNs7tIPhkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WCOFscxAgjc+ls+ubJHoXu3H/Nc/tb6gBSa4shUCgcjpyXmJ37a0F9aOkdvW8jlfH+qS+plXDzPUOH6nUat6UqBDr3hdHZ4Gz/9Kp6+0Ap5lmBYGOC3t7poFYGiMNfdJBezbtMrZGU5s+AvxvNbsf3WyMFo0jSb1RXpmiRRKqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caZiuM7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caZiuM7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AF81F00A3A;
	Thu, 27 Aug 2026 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858734;
	bh=liM7vgTjmUm5n6RpLjwlfmzvmxa80WHxUVHF/vR/7uY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=caZiuM7pf9eWWkd454RQyZemP2hlx+jL9JVKiCxL7+9kJxVM5vsErt55fCyVf/JHV
	 rat957dYlyX8+BmHOs1P7NNgUox7xr8HG71SZd+XghndcR+fl82D8q+np7sfCzzDkM
	 ETAatyhoUfQcRYQ8/c5GKLbPGVvFaVzHW6b3sjUgmEwMYMkjJnLfQFxEtDtzEPFpnz
	 oqTLM4i6hX1QIjbZCsrkyjyKq5LOXl48g4GOgGf89jvG2b50zpTBpKGVGAF0YObs7t
	 /hhWRgn3FA46E/jq7y2QR6WiAfzmLea8PqtQIyn3H18PKdsbAmcc4irjeqH8dR464i
	 bSB0gZLPcoMCQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 9/9]: vt: Misc changes, e.g. to #include directives
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <apCI6JhoH5D7ss34@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCI6JhoH5D7ss34@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:25:34 +0000
Message-Id: <20260827192534.73AF81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `con=
_font_get()` can lead to a kernel heap buffer overflow.
- [Critical] Pre-calculating the allocation size `c` based on the per-conso=
le `vc->vc_font.charcount` causes a heap buffer overflow in `vgacon_font_ge=
t()` due to a per-console versus global state mismatch.
--

commit 501185cf94f089f684db150e409e50e6d10bc832
Author: Alan Mackenzie <acm@muc.de>

vt: Misc changes, e.g. to #include directives

Rearrange some #include directives, add some clarifying comments, and some
code changes which didn't fit elsewhere.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index baf7c98429e9c..0c389a5643576 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
[ ... ]
> @@ -4967,14 +4968,16 @@ static int con_font_get(struct vc_data *vc, struc=
t console_font_op *op)
>  {
>  	struct console_font font;
>  	int c;
> -	unsigned int vpitch =3D op->op =3D=3D KD_FONT_OP_GET_TALL ? op->height =
: 32;
> +	unsigned int vpitch =3D
> +		op->op =3D=3D KD_FONT_OP_GET_TALL ? vc->vc_font.height : 32;
> =20
>  	if (vpitch > max_font_height)
>  		return -EINVAL;
> =20
>  	void *font_data __free(kvfree) =3D NULL;
> +	c =3D DIV_ROUND_UP(vc->vc_font.width, 8) * vpitch * vc->vc_font.charcou=
nt;
>  	if (op->data) {
> -		font.data =3D font_data =3D kvzalloc(max_font_size, GFP_KERNEL);
> +		font.data =3D font_data =3D kvzalloc(c, GFP_KERNEL);

[Severity: Critical]
Does this introduce a race condition regarding the allocation size?

Since the buffer size c is now calculated using vc->vc_font.width and
vc->vc_font.charcount before acquiring the console_lock, couldn't another
thread concurrently call con_font_set(), update the console font dimensions
to be larger, and cause the newly sized font data to be written into this
undersized heap allocation later when vc_sw->con_font_get() is called inside
the lock?

Additionally, can this cause an issue with the vgacon driver due to a misma=
tch
between per-console and global state?

The vgacon driver tracks whether a 512-character font is in use globally
via vga_512_chars. However, vc->vc_font.charcount is maintained per-console.

If a 512-character font is set on one terminal (setting vga_512_chars to
true), but con_font_get() is called on a different terminal that still
has a 256-character font, this calculation will size the allocation for 256
characters.

The vgacon_font_get() callback will then observe the global flag and
force a read of 512 characters, writing out of bounds into the smaller
buffer during vgacon_do_font_op().

>  		if (!font.data)
>  			return -ENOMEM;
>  	} else
> @@ -4991,8 +4994,6 @@ static int con_font_get(struct vc_data *vc, struct =
console_font_op *op)
>  			return ret;
>  	}
> =20
> -	c =3D DIV_ROUND_UP(font.width, 8) * vpitch * font.charcount;
> -
>  	if (op->data && font.charcount > op->charcount)
>  		return -ENOSPC;
>  	if (font.width > op->width || font.height > op->height)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D9
