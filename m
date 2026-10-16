Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFC3E3C53
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147128; cv=none; b=XLHoTZsNPa1dlL71GUjhPf1u/F3PbFOOGch10Ai5msdMvJaCwUbBCo3xDgzfZN/ehpkhzvu/bew8SybwD3cxw7Og/ZN129YzHtpx39SjRrKXfE11Ph5y6ZWeoEOuQeSz31KvJoSGMsxM49QlQ9KTgAUqKPl9vaJY4nEN/MOEkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147128; c=relaxed/simple;
	bh=9x+4ahKO2AdxIZdBXD+EPtDzyenemxDjSYX3Ql5GmBo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l+MOfsAOEPjw/NDfbrSNxRykWFppCBgxaVznRWcXx+iTybJhk2BuVxpIzFZ0mLBUPltTIWbwCD9+aM4UuJgep7ZprX7vzfRRcqKBrE9vegG4RELxFuRQ7Ki4Dvydpk0xrEji50rob2Fh6I0V8vj8OXBCdC0aXu/pzXrP3GDwQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXrEmEPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXrEmEPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D3B1F000C4;
	Fri, 16 Oct 2026 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792147119;
	bh=6HTC1wurps4knuvJB8DU+xyNAd0SGBH7rRvKogJaZRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXrEmEPucWTc/KqMUIoomD1VPrpioCG8ytmx1T91352KXVZYnYikeWOCV9uqs51TO
	 7vubAVeaPz8b9bFAB6fdwc3BICNgaiO2Och2QBT4WibkpdYA3+o/emHa3uSWVl7lU8
	 CFLjVNhwGAfqnzfE05/p4eOp+qGscnKRwAzgQzb0ekJLTRqhEyw4t6sSIi6Qvfvqa7
	 nVnlic04JX3SAavagH1Z1G4c+Ha76x7hdHf0LRcVcNR5wtOCdzM+MAN60m9mifnWwJ
	 OteFLvyLL7wopBaC/Mrm8j/L/6Gd65/jgahJYX0B+Da8Eff8EoMfzraMZD4kigq8gu
	 fyXZe8ikCxkrg==
Message-ID: <sashiko-outbox-174187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] vt: Remove old-style con_blank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016093357.33294-8-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
 <20261016093357.33294-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:38:39 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] vt: loss of text mode on unblanking if VT was blanked prior to KD_=
GRAPHICS
- [Medium] vt: display corruption due to premature vga_is_gfx assignment
--

commit 397a971ae2e535d87f46ac40e90cdd6df9d84c84
Author: Thomas Zimmermann <tzimmermann@suse.de>
Subject: vt: Remove old-style con_blank

This commit removes the mode_switch parameter from con_blank and con_unblank
callbacks. Consoles are now updated to detect mode switches internally from
the console state and vc_mode.

> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4674,10 +4674,7 @@ void do_blank_screen(int entering_gfx)
>  	if (console_blanked) {
>  		if (blank_state =3D=3D blank_vesa_wait) {
>  			blank_state =3D blank_off;
> -			if (vc->vc_sw->con_unblank)
> -				vc->vc_sw->con_blank(vc, vesa_blank_mode, 0);
> -			else
> -				vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
> +			vc->vc_sw->con_blank(vc, vesa_blank_mode);
>  		}
>  		return;
>  	}

[Severity: High]
If the console is already blanked and not in the vesa_wait state,
do_blank_screen() returns early and skips the con_blank callback entirely.

Because this patch removes the leaving_gfx parameter from the unblank
callback, fbcon_unblank() must now deduce the mode switch internally by
checking if par->graphics is true.

Since par->graphics is only set to true inside fbcon_blank(), skipping
fbcon_blank() leaves it as false:

do_blank_screen()
    if (console_blanked) {
        return; /* fbcon_blank is skipped, par->graphics remains false */
    }

When fbcon_unblank() is later called to switch back to KD_TEXT:

fbcon_unblank()
    bool mode_switch =3D par->graphics && vc->vc_mode =3D=3D KD_TEXT;
    if (mode_switch) {
        /* restore text mode */
    }

Does this cause the hardware text mode restoration to be bypassed when
mode_switch evaluates to false, leaving the VT frozen?

> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -797,15 +797,16 @@ static void vga_pal_blank(struct vgastate *state)
>  	}
>  }
> =20
> -static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
> -			 bool mode_switch)
> +static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank)
>  {
> +	bool mode_switch =3D !vga_is_gfx && c->vc_mode =3D=3D KD_GRAPHICS;
> +
> +	if (mode_switch)
> +		vga_is_gfx =3D true;
> +

[Severity: Medium]
Does setting vga_is_gfx =3D true here cause vgacon_set_origin() to abort
early?

vgacon_set_origin() is called later in this function during normal blanking:

vgacon_blank()
    if (mode_switch)
        vga_is_gfx =3D true;

    switch (blank) {
    case VESA_NO_BLANKING:
        vgacon_set_origin(c);

However, vgacon_set_origin() includes an early return if vga_is_gfx is true:

vgacon_set_origin()
    if (vga_is_gfx || ... )
        return;

If vgacon_set_origin() is skipped, the hardware CRTC offset won't be
reset to vga_vram_base. Even though scr_memsetw() clears the memory
at vga_vram_base, will the unreset CRTC offset cause the display hardware
to continue showing old memory, resulting in display corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016093357.3329=
4-1-tzimmermann@suse.de?part=3D7
