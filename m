Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECE486BB5
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586591; cv=none; b=COuqidk5AdFEEZQ0HEFD1I/j2GbIR7cjDruBmo/lphQY01+l0rtG1aJSsMM8Ul/e3kcDMfzxNv9N80srBejIneWGh9r6u+C+QLxVV6Ev8N4jeD9or7UoPjYHsAR9tNR+aP7PxmDYJkOCvx752xWYgd9OQOn1i1pRwAWZuI+IkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586591; c=relaxed/simple;
	bh=ZJ9dqj/cop97sdmkxZarzEqk9hPcdirKjW8gMlUi0CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lLYwjlqA7VSVzNThnBPAB1n+EQFhlCiSbGoI6OiOpwZ1jboUAX66QmgEYzFftxlUro/QFIizsLasdchszAQKd9G8ox6hIpP+1IX16KmfcG8H9k1lqVAkjvtVPYc/jF/9xLbJLsM2ToOOwzZkjg/EIU6mKNN1sSlu2KPUeaGAgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=At/kN12f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="At/kN12f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BC31F000FF;
	Mon, 28 Sep 2026 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790586589;
	bh=wi2jzKuyPggljN5tonSl1aWZJ9v0xu31EY4+l5BAXxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=At/kN12fRrhOoM3zlwZmebmqx4IOJ4oR8Sfy8pNsbabLgzvnuVBbIuix/8/YagVrb
	 7xEPf32vLrL+kLDPhSKCtVT2ZoxX1Sjk+Qt/By/SquyFF432Ctu8rCAOurdYhENS5G
	 d5xoxB5IYVnv80mcbhh+70E+7Elm4qMMyMCv91HIXRfX4jR15eYeNTAADH7YW53lXz
	 4DOhHQYXAJwFUU+GQeMq+02g2S3CL6SjaDYk3iDRX31KQajgYJfqG8MkcLqw+rIKjD
	 JsVvQ8a10FPR/Ne/H6xUVB5gStRxfe0WIRgwa3oyZmEpvmCgU0ypja4fHcOEnsIEHk
	 plZw8kZ/eFMUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] vgacon: Use vt_cursor_{start,end}()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260928085724.41660-4-tzimmermann@suse.de>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:09:49 +0000
Message-Id: <20260928090949.A7BC31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vgacon: CUR_DEF bypasses pre-VGA hardware cursor hiding workarou=
nd
--

commit d1a44aa19f5cbfffe54990d3cf6f73ab9b42b5ed
Author: Thomas Zimmermann <tzimmermann@suse.de>

vgacon: Use vt_cursor_{start,end}()
   =20
Replace vgacon's custom cursor metrics with the shared helpers
vc_cursor_start() and vc_font_cursor_end(). Note that the _end()
function returns the index of the scanline below the cursor, while
VGA hardware expects the cursor's final scanline. Hence vgacon
subtracts 1 from the end value.
   =20
The cursor shapes remain mostly unchanged, except that non-underline
cursors now also use the glyph's top-most and bottom-most scanline.
This follows the style used by fbcon.
   =20
v2:
- restore use of vc_cell_height (Sashiko)
   =20
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>

> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index 536e7fe4d1426..b1408bb5e2656 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
[ ... ]
> @@ -513,10 +514,11 @@ static void vgacon_cursor(struct vc_data *c, bool e=
nable)
>  	vgacon_restore_screen(c);
> =20
>  	c_height =3D c->vc_cell_height;
> +	c_size =3D CUR_SIZE(c->vc_cursor_type);
> =20
>  	write_vga(14, (c->vc_pos - vga_vram_base) / 2);
> =20
> -	if (!enable) {
> +	if (!enable || c_size =3D=3D CUR_NONE) {

[Severity: Medium]
Does this check fail to intercept CUR_DEF if the default cursor is
configured as CUR_NONE?

If cur_default is set to CUR_NONE and an unprivileged user triggers a cursor
reset (\e[?0c), c_size will equal CUR_DEF. Since CUR_DEF does not equal
CUR_NONE, this bypasses the hardware-specific hide sequence below.

>  	        if (vga_video_type >=3D VIDEO_TYPE_VGAC)
>  			vgacon_set_cursor_size(31, 30);
>  		else
> @@ -524,33 +526,8 @@ static void vgacon_cursor(struct vc_data *c, bool en=
able)
>  		return;
>  	}
> =20
[ ... ]
> -	default:
> -		vgacon_set_cursor_size(1, c_height);
> -		break;
> -	}
> +	vgacon_set_cursor_size(vc_cursor_start(c_height, c_size),
> +			       vc_cursor_end(c_height, c_size) - 1);

[Severity: Medium]
If c_size is CUR_DEF and the default cursor is CUR_NONE, could this
cause cursor wrapping on EGA/MDA hardware?

When vc_cursor_start() and vc_cursor_end() resolve the CUR_DEF to CUR_NONE
internally, they both return c_height. This results in
vgacon_set_cursor_size() being called with start =3D c_height and
end =3D c_height - 1.

Pre-VGA hardware (EGA/MDA/CGA 6845 CRTCs) do not support start > end for
hiding cursors, which leads to a massive wrapping block cursor instead of
hiding it.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928085724.4166=
0-1-tzimmermann@suse.de?part=3D3
