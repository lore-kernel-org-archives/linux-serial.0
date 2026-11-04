Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759596;
	b=Mi5vpGtRwm2XUGCH7kuqWh75wbrP+9GLfWLnzFGF6hy9esCcCDbq0X0oDoaBKy3rquPb
	 I+gL0oihrZG33cO3RG47m6/PspHQwsoKNs+0BcPXvngBoVsGoL2mLTtJEur4aqHk0rllv
	 C2HaWiYw+UG9eSLcxXGh0yUngSX9PYDp4eHHgDM6b+ZY+xuCKx5m94hpfr7SsHxCLd9qf
	 0gH3Iavil73rDJZN5x6Zi7QAywzcKJHDew1BiqzqKKaBSTZ34ySbt+zXSncUjHynwj8Zw
	 niQpEPQoFl90Bwuh3MnfCfieDZOltXVfX0Mgf6iHrjBDs4ojwjM+O7TXE1PK0qm7Z9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759596;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JDDxIUrF8tb8pEdwRthMxrGgkj9rOEQ/nGn0twGKudY=;
	b=1GqTd3PET9+aBw4hRFPowqNnwkpkgLC4ldiXUXPnekpz+IDzC8UgniPi877D9kID9MEC
	 wY64w/aV2cu0HvnZLLQhVz63Tr83uhWPisGo2Ef/ax7Z6xJHnPSIFGoxIHFAQrAZlMohe
	 aIAnzfb2iQzuiZCgMepQmPxkD2swBK9nDnsEDyAe8MZJrEjCzWwFeFz5IatpMWRyPhK1I
	 8zs3cS005eYnCYHgp7uIP3DgJ5HyOWK2cL+EY5wBRRN78JliEN8n7csbvR6dJXXfcEt1w
	 wdVeUhXDfez1uwaULP940771Qah4WlOMQ7IG8V6Cv0rPVbWD60ERee2mneMiAdm/4Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbSTM+qV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A48606A32E
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbSTM+qV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21A31F000C1;
	Wed,  4 Nov 2026 02:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759595;
	bh=JDDxIUrF8tb8pEdwRthMxrGgkj9rOEQ/nGn0twGKudY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbSTM+qV/osARaBA20iC1Scr99ZC5qdF3zssU1vTtDhpi+HkDN9tG6nAGtJM6j7Ip
	 PQzTalt0wVkGa2EX5JnmrSqfXF0RT2dZRqKVj+0BDI/kVLWpNVcVMT3BOphPiTYsUI
	 35Hj12ijfRnDFIcDcgVM+QBMGSZQtGB8Fe1LX95FEwqs8jMpEkW97zplMVacX4Qat5
	 NkEpUYxdG1/sNEZDJkZ644WO1Lpff1cvGRJMstLPIF/55ejtC67JE7j4U7vdeQoNnu
	 yQK0oeKA7RWfZiM91Lba/jqbT+FtF2PnS7kEwu/pdWCrY1f1or/tZWFjciJzBS8S2K
	 7x2Mhg4LpaQeQ==
Message-ID: <sashiko-outbox-196498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: n_gsm: release the control channel if device
 registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261104021509.1468558-1-vulab@iscas.ac.cn>
References: <20261104021509.1468558-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:33:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: n_gsm: NULL deref and DLCI 0 leak in gsm_activate_mux() on re=
-activation
- [High] tty: n_gsm: race between dlci_put() in gsm_activate_mux() and gsm_=
queue()
- [High] tty: n_gsm: concurrent gsm_activate_mux() clears active gsm->dlci[=
0] to NULL
--

commit 75222737c883df9342677bd8689ca9cd6f7dffbf
Author: Wentao Liang <vulab@iscas.ac.cn>

tty: n_gsm: release the control channel if device registration fails

This commit releases the control channel DLCI 0 via dlci_put() if
gsm_register_devices() fails in gsm_activate_mux().

> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index e55779ff0af2b..8ef2c711b2aa0 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3195,8 +3195,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
>  		gsm->receive =3D gsm1_receive;
> =20
>  	ret =3D gsm_register_devices(gsm_tty_driver, gsm->num);
> -	if (ret)
> +	if (ret) {
> +		dlci_put(dlci);
>  		return ret;
> +	}

[Severity: High]
Can this cause a NULL pointer dereference in gsmtty_cleanup() and leak the
previous gsm->dlci[0] when re-activating a mux after DLCI 0 closes?

When an active mux has open virtual TTYs (where gsmtty_install() took a
reference via dlci_get(gsm->dlci[0])) and control channel DLCI 0 closes via
an incoming DISC or DM frame, CMD_CLD, T1 retry exhaustion, or keep-alive
timeout, gsm_dlci_close() marks the mux dead without unregistering the tty
devices or releasing gsm->dlci[0]:

drivers/tty/n_gsm.c:gsm_dlci_close() {
	if (dlci->addr !=3D 0) {
		tty_port_tty_hangup(&dlci->port, false);
		...
	} else {
		timer_delete(&dlci->gsm->ka_timer);
		dlci->gsm->dead =3D true;
	}
}

If userspace then calls GSMIOC_SETCONF with unchanged parameters (so
need_close and need_restart are 0 in gsm_config()) or GSMIOC_SETCONF_EXT
without GSM_FL_RESTART (so need_restart is false in gsm_config_ext()),
gsm_cleanup_mux() is skipped and gsm_activate_mux() is called because
gsm->dead is true:

drivers/tty/n_gsm.c:gsm_config_ext() {
	if (need_restart)
		gsm_cleanup_mux(gsm, true);
	...
	if (gsm->dead) {
		int ret =3D gsm_activate_mux(gsm);
		...
	}
}

In gsm_activate_mux(), gsm_dlci_alloc(gsm, 0) unconditionally overwrites
gsm->dlci[0] with a new struct gsm_dlci (leaking the old gsm->dlci[0] along
with its tty_port and kfifo), and gsm_register_devices() then fails with
-EEXIST because gsm->has_devices is still true and the minor devices are
still registered.

Calling dlci_put(dlci) on that error path invokes gsm_dlci_free(), which
sets dlci->gsm->dlci[0] =3D NULL while the existing virtual TTYs remain ope=
n:

drivers/tty/n_gsm.c:gsm_dlci_free() {
	timer_shutdown_sync(&dlci->t1);
	dlci->gsm->dlci[dlci->addr] =3D NULL;
	kfifo_free(&dlci->fifo);
	...
	kfree(dlci);
}

When one of those open virtual TTYs is subsequently closed, gsmtty_cleanup()
dereferences gsm->dlci[0] while it is NULL:

drivers/tty/n_gsm.c:gsmtty_cleanup() {
	dlci_put(dlci);
	dlci_put(gsm->dlci[0]);
	mux_put(gsm);
}

[Severity: High]
What prevents a use-after-free in gsm_queue() if data arrives on the
underlying serial TTY while gsm_register_devices() is running and then fail=
s?

In gsmld_open(), gsm->receive is initialized when the line discipline is
attached, and gsm_activate_mux() also sets gsm->receive before calling
gsm_register_devices(). Meanwhile, gsm_dlci_alloc(gsm, 0) publishes the new
channel to gsm->dlci[0] before returning:

drivers/tty/n_gsm.c:gsm_dlci_alloc() {
	...
	gsm->dlci[addr] =3D dlci;
	return dlci;
}

While gsm_register_devices() is running, incoming bytes on the underlying
TTY invoke gsmld_receive_buf() -> gsm->receive() -> gsm_queue() on another
CPU without any lock serializing against gsm_activate_mux() and without
checking gsm->dead:

drivers/tty/n_gsm.c:gsm_queue() {
	...
	dlci =3D gsm->dlci[address];
	...
}

If gsm_register_devices() fails, dlci_put(dlci) -> gsm_dlci_free() clears
gsm->dlci[0] =3D NULL and frees dlci via kfree(dlci) while gsm_queue() may =
be
concurrently dereferencing dlci (for example in gsm_dlci_open(),
gsm_dlci_close(), or gsm_dlci_command()). In addition, if an incoming SABM
frame opened DLCI 0 during that window, gsm_dlci_open() may have armed
gsm->ka_timer and scheduled gsm->tx_work, which gsm_dlci_free() does not
cancel, and any subsequent control frame reaching gsm_control_reply() will
dereference gsm->dlci[0] after it has been set to NULL.

[Severity: High]
Could two concurrent GSMIOC_SETCONF or GSMIOC_SETCONF_EXT ioctls race in
gsm_activate_mux() and leave an active mux with gsm->dlci[0] set to NULL?

Neither gsmld_ioctl() nor gsm_config() / gsm_config_ext() holds gsm->mutex
when checking gsm->dead and calling gsm_activate_mux():

drivers/tty/n_gsm.c:gsm_config() {
	...
	if (gsm->dead) {
		int ret =3D gsm_activate_mux(gsm);
		if (ret)
			return ret;
		if (gsm->initiator)
			gsm_dlci_begin_open(gsm->dlci[0]);
	}
	return 0;
}

If two threads concurrently issue GSMIOC_SETCONF or GSMIOC_SETCONF_EXT on a
dead mux:

Thread 1 enters gsm_activate_mux(), allocates dlci1 (setting
gsm->dlci[0] =3D dlci1), and sleeps inside gsm_register_devices().

Thread 2 still sees gsm->dead =3D=3D true, enters gsm_activate_mux(), alloc=
ates
dlci2 (overwriting gsm->dlci[0] =3D dlci2 and leaking dlci1), and calls
gsm_register_devices(), which fails with -EEXIST because Thread 1 already
registered the minor numbers for gsm->num.

Thread 2 then calls dlci_put(dlci2) -> gsm_dlci_free(), which sets
gsm->dlci[0] =3D NULL, while Thread 1 finishes gsm_register_devices() and s=
ets
gsm->has_devices =3D true and gsm->dead =3D false. When a virtual TTY is la=
ter
opened on the active mux, gsmtty_install() calls dlci_get(gsm->dlci[0]) with
gsm->dlci[0] =3D=3D NULL:

drivers/tty/n_gsm.c:gsmtty_install() {
	...
	dlci_get(dlci);
	dlci_get(gsm->dlci[0]);
	mux_get(gsm);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021509.1468=
558-1-vulab@iscas.ac.cn?part=3D1
