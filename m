Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886F282F1B
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858298; cv=none; b=t9A9/MOQ/rILwHXgcMorWKSnkOasU8bRfD9O2ybLrVArL9yJggV4bcxv8jczHhwNBRA79xDEAl45JMTKjHnSx+koBeow/DA0rLfmTgmGUcwh1z31Vj60yXQqUh8Dy7vaHC+I0T0j1wCGmP0hOyPZp1P8avuLFQ1QmWDG95fxHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858298; c=relaxed/simple;
	bh=lbKK/hQk6euSTkUyxHMLSyR6pytsvIEZ9kgQ/o80I04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NnUNYwH7/b99MmTD/bCBn1q9x6NR9LSiS2lfmkBOVFrcxWhkSzkLl6NOG6sQLn1ehK05Mi2Lq6dQFE3O2hnB7kEkRx+yPH+wQeN0rQScfWmLklJg1Y865pAqcGQbglVkKQpVbca6yZbxRiFZXrZxEl231H7l6DkgZHTM0XJGcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8HjhhyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8HjhhyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8459F1F000E9;
	Thu, 27 Aug 2026 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858296;
	bh=3Y1YUit7K8xGsTJUj1MmOh4MveLqUcZEpDVGhRZ4fos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m8HjhhyI2eqdInsDlOj66+qB2N6USPqTElK64/oOrBorkz0KtlAVYWFW5MUvZKVoS
	 FeWm6oWTgbkKHSM/KKRXn4QwJyME6etNZg+evSSsrMLc63bmPZKjOQGwo0faV/H53r
	 iB3mn9HF6hhF8VPHjyJGTzJu3H7EcaLqxp1Lm5yOnN7RcQTwwEPoAAR2N44EtwaLWx
	 97JaBycWjL4+7uAQw/tyj/h7r+0PdkTmvJVg2qAWJyNvA2Y+MuDepr2Kiss25An9Un
	 5OgQIgg0JOHnkFkx4gPFeiG2LIhEva5BNC3oQqaomouX07EeY/dgSBc2ukpqPDpYKU
	 xzMMOfHTglmjw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 3/9]: Replace scr_readw/writew by scr_readg/writeg, etc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <apCGKUotSUZLvngV@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCGKUotSUZLvngV@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:18:16 +0000
Message-Id: <20260827191816.8459F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The loop evaluating screen blankness in fbcon_prepare_logo increme=
nts the pointer incorrectly, leading to overlapping/unaligned 32-bit glyph =
reads and an out-of-bounds read.
- [High] Incorrect pointer arithmetic in fbcon_switch when scrolling the lo=
go leads to severe screen buffer corruption in 32-bit glyph mode.
--

commit 161dfd956a8c1063b40c6d0ff761c9b6540eff43
Author: Alan Mackenzie <acm@muc.de>

Replace scr_readw/writew by scr_readg/writeg, etc

This patch updates vt and fbcon drivers to handle 32-bit glyphs by
replacing 16-bit specific scr_readw/writew with scr_readg/writeg,
adjusting pointers and attributes accordingly.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c

[ ... ]

> @@ -663,8 +663,8 @@ static void fbcon_prepare_logo(struct vc_data *vc, st=
ruct fb_info *info,
>  	q =3D (unsigned short *) (vc->vc_origin +
>  				vc->vc_size_row * rows);
>  	step =3D logo_lines * cols;
> -	for (r =3D q - logo_lines * cols; r < q; r++)
> -		if (scr_readw(r) !=3D vc->vc_video_erase_char)
> +	for (r =3D q - logo_lines * cols * GLYPH_HW; r < q; r++)
> +		if (scr_readg(r) !=3D vc->vc_video_erase_char)

[Severity: High]
Could this loop read out of bounds when evaluating screen blankness?
The pointer r is of type unsigned short *, so r++ advances it by 2 bytes.
However, scr_readg() reads 4 bytes, resulting in overlapping reads. On the
final iteration (when r equals q - 1), it appears scr_readg() would read 2
bytes past the end of the screen buffer allocation. Should this increment by
GLYPH_HW instead?

>  			break;
>  	if (r !=3D q && new_rows >=3D rows + logo_lines) {
>  		save =3D kmalloc(array3_size(logo_lines, new_cols, GLYPH_SZ),

[ ... ]

> @@ -2161,8 +2165,23 @@ static bool fbcon_switch(struct vc_data *vc)
>  		struct vc_data *conp2 =3D vc_cons[logo_shown].d;
> =20
>  		if (conp2->vc_top =3D=3D logo_lines
> -		    && conp2->vc_bottom =3D=3D conp2->vc_rows)
> +		    && conp2->vc_bottom =3D=3D conp2->vc_rows) {
> +			/* Scroll the bottom part of the screen up to fill the
> +			 * logo lines.
> +			 */
> +			i =3D conp2->vc_bottom - conp2->vc_top;
> +			d =3D (unsigned short *)conp2->vc_origin;
> +			s =3D (unsigned short *)(conp2->vc_origin +
> +					       logo_lines * conp2->vc_size_row);
> +			while (i--) {
> +				scr_memcpyw(d, s, conp2->vc_size_row);
> +				d +=3D conp2->vc_cols;
> +				s +=3D conp2->vc_cols;

[Severity: High]
Does this pointer arithmetic corrupt the console screen buffer for 32-bit
glyphs? The pointers d and s are unsigned short *, so advancing them by
vc_cols moves them forward by vc_cols * 2 bytes. Since conp2->vc_size_row
is vc_cols * 4 bytes for 32-bit glyphs, this seems to advance the pointers
by exactly half a row.

Because of this, the next loop iteration would overwrite the middle of the
previously copied row. Furthermore, the subsequent scr_memset_worl() would
start clearing from the wrong offset. Should these pointers be advanced by
conp2->vc_cols * GLYPH_HW?

> +			}
> +			scr_memset_worl(d, conp2->vc_video_erase_char,
> +				    conp2->vc_size_row * logo_lines);
>  			conp2->vc_top =3D 0;
> +		}
>  		logo_shown =3D FBCON_LOGO_CANSHOW;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D3
