Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39237EFEE
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120699; cv=none; b=dSO5GXtMLES9+u4PnGwpW8QTgGTpVqLY/bVioik5p49uhQfRUwVIiqTff4JEFE4OKBjVdqvo4OMPBVvM/q1aUSUj82vVHyy8RjprIuY5hSqzPTxo4ErtUZmgwwhDVq4VVjj/iGoRw3svqO9dvIRmzOma9RVDcqtxWuI0pQloyqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120699; c=relaxed/simple;
	bh=PNgbGL7sK2AqsrQNtjbqWCMuc1+q5XcMnhFl2brotrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MjsLCtfGyNsIypTT62pH1cwFZCTfDXdpR9hwa35/EN26BBXyxu5eSTcIjAteXErhkDY1d8KdiU1p92NMjkgjUbgJ+4IzuTv2pDe2iW5MOwZz/HPa6evg7a+jmx8QYUq8lkXctHbtCOQH7S7kwIQyww0EzqAPIL9w+t9qPreBSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcSGku/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcSGku/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BBC1F000FF;
	Fri, 11 Sep 2026 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120698;
	bh=baHUk9XK+QjBf5T9+7IHDmpb1au+ttmDjlX/GdARsEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IcSGku/3dyja91Cz6V+NYOceS9u4vBimSoViel33mRLdm6r37SZx+xL9lSVroB7cl
	 gnY6+TDi/LXN1H/3It4WCpbbHwygGPle4uFUM1ldFAo6Jl/5cm/Pj7lj0j4wiI1fpB
	 Mqx3A3a5eYWlSRYw/rKLxKxbsf66mMyerMIMur4zjtDSD5cLW3T15Ce3N4StM0Ktmq
	 5CqDHpM+o0MjOaOKdKANloqRPbREifI5v56MdbqVopGG4MUMIwQfi5L9ZtDfmBTaOs
	 oLMAsxk70EUqNHdVXhvuijUI2j6le7nAIEZNv3qeLs9xfGHhQLdoRlrtZ7pNYM4uQF
	 8sMjSnRN0kWIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] vgacon: Use vt_font_cursor_{start,end}()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260911094518.78093-4-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:58:16 +0000
Message-Id: <20260911095817.D3BBC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Cursor bounds are calculated using `vc_font.height` instead of `vc=
_cell_height`, breaking hardware cursors when the text cell height is overr=
idden.
--

commit 25f4b9b96dc26e69ace4c42e72c99970c3c5fcf1
Author: Thomas Zimmermann <tzimmermann@suse.de>

vgacon: Use vt_font_cursor_{start,end}()

This commit replaces vgacon's custom cursor size calculations with the shar=
ed
helpers vc_font_cursor_start() and vc_font_cursor_end(). It subtracts one
from the end value to account for VGA hardware expectations.

> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index 536e7fe4d1426..b16ddb1b09a70 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c

[ ... ]

> @@ -524,33 +525,8 @@ static void vgacon_cursor(struct vc_data *c, bool en=
able)
>  		return;
>  	}
> =20
> -	switch (CUR_SIZE(c->vc_cursor_type)) {

[ ... ]

> -	default:
> -		vgacon_set_cursor_size(1, c_height);
> -		break;
> -	}
> +	vgacon_set_cursor_size(vc_font_cursor_start(&c->vc_font, c_type),
> +			       vc_font_cursor_end(&c->vc_font, c_type) - 1);

[Severity: High]
Does this code break the hardware cursor when the character cell height is
dynamically overridden?

If a user space utility like SVGATextMode calls the VT_RESIZEX ioctl with a
smaller v_clin, c->vc_cell_height is updated while c->vc_font.height remains
unchanged.=20

By computing the cursor bounds using the static font height via the shared
helpers instead of the active character cell height, it seems the programmed
start scanline could exceed the maximum scanline of the character cell
(VGA_CRTC_MAX_SCAN).=20

Since the hardware scanline counter resets before reaching the programmed c=
ursor
start line, would this cause the hardware cursor to become completely invis=
ible?

>  }
> =20
>  static void vgacon_doresize(struct vc_data *c,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094518.7809=
3-1-tzimmermann@suse.de?part=3D3
