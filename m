Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7564718FD
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146381; cv=none; b=Fu0g1k4U5Goy+RSgFOBHTgeCLuWyk9ljP88LpELslXvzgh/VxH6r7EBfwOH3jIR6Dz40Pcfiyi0g1F3lowp63UyC5LG2ejIRn40MTV74wmzwpNJfNcesg/gS+Wrt0GWEkMkzDq9D/YUuhk/QaAwojYIjTHUrwjKYahxgXE/vyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146381; c=relaxed/simple;
	bh=ANE3eqKGt/aCEqE+dmE88RrL+2P3hh2CJlvIj0HWhmE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=e0JpAQdLsqKFCVm1Zhy0WThfd8h5pcr3LyjsHoCLM/FBhqOGXJMYBUAodvgd2/H4PZkyVuFBtt1QO8lYlLh26OChJyfSYEMAlMMM5AcUMDbc37AgR0PUIovSffQGip6ffACPaSJuJDYGUQhNWNUkT+TroIh2aWIYeQiBDvPqYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/owTgg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/owTgg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523881F000C5;
	Fri, 16 Oct 2026 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146377;
	bh=YCtmJOcLI9NBVa/MU4O4425Tk2YsWx72QmxW6vEBUWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/owTgg9NDrQ7MIOBwsvPxFsODsKVxv+hou7kr08vsewh0AQzbBXY8BFCKgQl8y7g
	 j8S9mjluh4n9NlDQ1vdwFwqwu7vGCyok/q1c8A84horndH3MKV5Yt/gX+BkRIPbDXN
	 XmZTulton3W3sCZHFqRA7abYIy6GL05CP+0JcvVw4XmQV1AMH2AuIoptV331jbao/R
	 qHD9r2y0svhkLJXm70cVBDlmnm48qw0sInrmrNqfUA8AGQASzsIlrpuIOeyEQ+5bDf
	 dsB188FW4X0gPfU8JLiaIceCbqlkokP1Y0P19paGGLBY8wqsMFklzEuMz7S72GBUsj
	 Rp/F8/njMNaBA==
Message-ID: <sashiko-outbox-174167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] vgacon: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016093357.33294-7-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
 <20261016093357.33294-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:26:16 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] console: IRQ state leak in vgacon_unblank() during panic
- [Medium] vgacon: failure to blank screen during graphics mode switch
--

commit 1fe83e2b75ae124b5285efec89c3a22f914e107d
Author: Thomas Zimmermann <tzimmermann@suse.de>

vgacon: Implement struct consw.con_unblank

This commit implements the con_unblank callback from struct consw by
extracting the VESA_NO_BLANKING logic from vgacon_blank() into a new
function named vgacon_unblank(). It also updates how the global
vga_is_gfx mode tracking is handled during console transitions.

> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index 37bd18730fe0d..761c8da10449b 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -800,39 +800,47 @@ static void vga_pal_blank(struct vgastate *state)
>  static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
>  			 bool mode_switch)
>  {
> +	if (mode_switch)
> +		vga_is_gfx =3D true;

[Severity: Medium]
Does setting vga_is_gfx to true before calling vgacon_set_origin() prevent
the screen from blanking correctly?

If mode_switch is true, vga_is_gfx is set to true immediately. Later in this
same path under VESA_NO_BLANKING, vgacon_set_origin() is called:

static bool vgacon_set_origin(struct vc_data *c)
{
	if (vga_is_gfx ||	/* We don't play origin tricks in graphic modes */
	    (console_blanked && !vga_palette_blanked))	/* Nor we write to blanked =
screens */
		return false;
        ...
}

Because vga_is_gfx is already set to true, vgacon_set_origin() will
short-circuit and return false without reprogramming the hardware mem_top.
Will this result in a visible flash of uncleared text before the graphics
driver takes over?

> +
>  	switch (blank) {

[ ... ]

> +static bool vgacon_unblank(struct vc_data *c)
> +{
> +	bool mode_switch =3D vga_is_gfx && c->vc_mode =3D=3D KD_TEXT;
> +
> +	if (mode_switch)
> +		vga_is_gfx =3D false;
> +
> +	if (vga_vesa_blanked) {
> +		vga_vesa_unblank(&vgastate);

[Severity: High]
Can this call safely execute in a panic context where interrupts must
remain disabled?

When panic() executes, it explicitly disables local interrupts via
local_irq_disable() before calling console_unblank().

The console unblanking subsystem will invoke this new .con_unblank callback,
which calls vga_vesa_unblank(). However, vga_vesa_unblank() uses
raw_spin_unlock_irq():

static void vga_vesa_unblank(struct vgastate *state)
{
	/* restore original values of VGA controller registers */
	raw_spin_lock_irq(&vga_lock);
        ...
	raw_spin_unlock_irq(&vga_lock);
}

This unconditionally re-enables hardware interrupts, which destroys the safe
context set up by panic(). If a hardware interrupt fires during the remaind=
er
of the panic sequence, could it lead to secondary oopses or deadlocks that
hide the panic logs from the user?

Should the vga_lock acquisition use irqsave/irqrestore variants instead
to preserve the caller's IRQ state?

> +		vga_vesa_blanked =3D VESA_NO_BLANKING;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016093357.3329=
4-1-tzimmermann@suse.de?part=3D6
