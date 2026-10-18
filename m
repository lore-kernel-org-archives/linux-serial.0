Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369B49C4CE
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792332569; cv=none; b=GenXNQoui7bBF6f8+j8FZ88WSS4jbwEWHMHqXUZ029ZGxV6SbyTnavxQq3T5iuftGH9qH+Rr1QSMbcWMpNbyl6sMLAJ1cwRBugyUTX2mQi0eNpfazhK/6ORpRcnSg9VVlkeGsUaXezkozwo4Ku/yo4JeOftARL4hNvX0VBY80Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792332569; c=relaxed/simple;
	bh=hSnWYeleWa54OyhTRrzUPybA4KrPvUhnxGuntnR1Q5Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oYFy9PotllEsCR/8FIjJBdfwuBCz5US1abQvdFkB1xbFaJqw/uatmzuXTDBoyVDK/qjKl4VQICbePGte3Fy/Jefn/NkdaUGiaoBHjZcPFTGEbQJ0vTIPEY9aTWRjmZ72MU2qUdpiCQV4wLhX00I9csfGKF0IHTtywGiMwEJ6XT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKpZ6oyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKpZ6oyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9DC1F000C5;
	Sun, 18 Oct 2026 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792332568;
	bh=dSR7F6X9U0L5FWSlT+MeXUGjuEsuOxHRqP1SLFnyMOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TKpZ6oyQ11LM+9+P0wQoM9HoQ5C+HJ2qHuVTRe9RYVISxuwbImG4Ya0D/nWgMPVEp
	 FzAkU+kEuBa9rmGp0a6BC39b/4r+uMS2Vd3iFZerim1KjeyAC0oLlsWfI+InLQSGK8
	 cPQa7zIIU17ICJQ3hs9LmzLDOyTMcahfnbWHVIJhd0dHENg/HNYcYdufDXdOXbRY8N
	 AQRrEEC00BX9mycwike/xvVD9XvmwzBi+mKk45LC1f3J+ILm119lMyWWnz+H2Q6E84
	 Iq1yB6Fw5GAHcTZ0LnF0yoTORIeeHk4vFXbD0jnXlwKlahZ++joOGDbsP4lcNFH8ZL
	 1avAUBjD8nktg==
Message-ID: <sashiko-outbox-176185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] hvc: add an M3000 firmware console backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-11-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-11-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:09:27 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] hvc: hvc_m3000 fails to register console when CONFIG_VT_CONSOLE=
=3Dy
- [Low] tty: hvc_m3000: ineffective window size initialization in m3000_tty=
_init()
--

commit 7a0bedd3c2b41c2e4d2aba3f69c932366fc243a8
Author: Magnus Lindholm <linmag7@gmail.com>

hvc: add an M3000 firmware console backend

This commit adds an HVC console backend for the Fujitsu M3000 (IKKAKU
platform) using the Open Firmware pseudo-console via the SPARC p1275
interface. It registers hvc0 after validating the firmware model and console
endpoints, polling input with a timer while the TTY is open.

> diff --git a/drivers/tty/hvc/hvc_m3000.c b/drivers/tty/hvc/hvc_m3000.c
> new file mode 100644
> index 0000000000000..e2150d4793080
> --- /dev/null
> +++ b/drivers/tty/hvc/hvc_m3000.c
> @@ -0,0 +1,202 @@

[ ... ]

> +static int __init m3000_console_init(void)
> +{
> +	struct m3000_console *con =3D &m3000_consoles[0];
> +	phandle node;
> +	int ret;
> +
> +	if (tlb_type !=3D sparc64_vii)
> +		return -ENODEV;
> +	if (!m3000_property_matches(prom_finddevice("/"), "model", "IKKAKU"))
> +		return -ENODEV;
> +	con->stdin =3D prom_getint(prom_chosen_node, "stdin");
> +	if (!con->stdin || con->stdin =3D=3D -1 || !prom_stdout || prom_stdout =
=3D=3D -1)
> +		return -ENODEV;
> +	node =3D prom_inst2pkg(prom_stdout);
> +	if (!m3000_property_matches(node, "name", "pseudo-console"))
> +		return -ENODEV;
> +	node =3D prom_inst2pkg(con->stdin);
> +	if (!m3000_property_matches(node, "name", "pseudo-console"))
> +		return -ENODEV;
> +	ret =3D hvc_instantiate(0, 0, &m3000_ops);
> +	if (ret < 0)
> +		return ret;
> +	con->ready =3D true;
> +	return 0;
> +}
> +console_initcall(m3000_console_init);

[Severity: Medium]
When booting with CONFIG_VT_CONSOLE=3Dy (which is enabled in sparc64_defcon=
fig)
and without an explicit console=3Dhvc0 command-line parameter, will hvc0 fa=
il
to register as the kernel console here?

During console_init(), con_init() in drivers/tty/vt/vt.c runs before the hvc
console initcalls because vt/ precedes hvc/ in drivers/tty/Makefile. With no
preferred console selected yet, register_console(&vt_console_driver) enables
tty0 (backed by dummy_con) via try_enable_default_console() and unregisters
prom_early_console.

Next, hvc_console_init() in drivers/tty/hvc/hvc_console.c runs (linked befo=
re
hvc_m3000.o in drivers/tty/hvc/Makefile) and calls
register_console(&hvc_console). In kernel/printk/printk.c:register_console(=
):

	if (preferred_console < 0) {
		if (hlist_empty(&console_list) || !console_first()->device ||
		    console_first()->flags & CON_BOOT) {
			try_enable_default_console(newcon);
		}
	}

Because console_first() is now vt_console_driver (which has a non-NULL
.device and does not have CON_BOOT set), try_enable_default_console() is
skipped and hvc_console.index remains -1.

When m3000_console_init() then runs and calls
hvc_instantiate(0, 0, &m3000_ops) -> hvc_check_console(0):

	if (index =3D=3D hvc_console.index)
		register_console(&hvc_console);

Because hvc_console.index is -1 rather than 0, and add_preferred_console()
was never called, register_console(&hvc_console) is not invoked, leaving the
system without kernel console output after prom_early_console is unregister=
ed.

Should m3000_console_init() call add_preferred_console("hvc", 0, NULL) befo=
re
hvc_instantiate() (or before hvc_console_init() runs) when Open Firmware's
stdout/stdin are verified to be pseudo-console?

> +
> +static int __init m3000_tty_init(void)
> +{
> +	struct m3000_console *con =3D &m3000_consoles[0];
> +	struct hvc_struct *hp;
> +
> +	if (!con->ready)
> +		return -ENODEV;
> +	timer_setup(&con->poll_timer, m3000_poll_tick, 0);
> +	hp =3D hvc_alloc(0, 0, &m3000_ops, sizeof(con->buffer));
> +	if (IS_ERR(hp))
> +		return PTR_ERR(hp);
> +	hp->ws.ws_row =3D 24;
> +	hp->ws.ws_col =3D 80;
> +	return 0;
> +}
> +device_initcall(m3000_tty_init);

[Severity: Low]
Does setting hp->ws.ws_row and hp->ws.ws_col directly in m3000_tty_init()
actually propagate the 80x24 window size to the TTY when /dev/hvc0 is opene=
d?

In drivers/tty/hvc/hvc_console.c, neither hvc_install() nor hvc_open() reads
hp->ws. The only consumer of hp->ws is the workqueue callback
hvc_set_winsz():

	tty =3D tty_port_tty_get(&hp->port);
	if (!tty)
		return;

	spin_lock_irqsave(&hp->lock, hvc_flags);
	ws =3D hp->ws;
	spin_unlock_irqrestore(&hp->lock, hvc_flags);

	tty_do_resize(tty, &ws);

hvc_set_winsz() only runs when hp->tty_resize is scheduled via hvc_resize()
or __hvc_resize(), and requires a tty_struct to already be attached to
hp->port (which happens in hvc_open() via tty_port_tty_set() right before
hp->ops->notifier_add is called).

Should this use hvc_resize(hp, ws) inside m3000_open() instead so that
hvc_set_winsz() is scheduled once the TTY is attached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D10
