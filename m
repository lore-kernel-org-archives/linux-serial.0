Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593440D582
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111070; cv=none; b=Yjs+GfhT9/RwDm72Lzvxo9IPiAhjWJi31LoGd61M0Go0DPl0NAKTCEggYSHdrTkqgaKeilPemrx6znn+F2ypFYKMLtTXtHe3kqttg3f2YB+Nvg5Vaeya+xpfnMEb3qx5/JOdamGXgD5TA9HHIBfoG+FfvrGbRmQDJfyli4enRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111070; c=relaxed/simple;
	bh=w88DJSnFRPg8ppLE3fu1CFccbkOlyzOi5gXGeTyZpaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OMUKi59sP/NzTNv1Rrf9VWGtbfJuKzlT+6hZO4hYwU0jCYJ9RRZK/1zM5eKB5U40QTZ6KunhHaWwAWpTqpA+fcYhoLzSNHIvSU2BOe8VIq9YhOg9TZstGJo3H5pKT2eWDQI6PwxG5rkAqPUPUywZ5QxHCaIGOWxiwnLjh+A/ims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSgsAvn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSgsAvn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1924A1F000FF;
	Fri, 11 Sep 2026 07:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789111065;
	bh=AKNYghHfjws+zi+FmWx3Kvn/3uNFOrpg1HmuNm2ASZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSgsAvn5qo51Gjk/rQawJjtfwK0tNmn2MFUM5A6wSZT6buQ/tN3NiSDYi+omIY3vq
	 DU6ni3RNgMTUY0UoJagBvJ0SWmhl4h80hFujlLvEjxtpAPkDLPc39Bf1T1U6CFe7LK
	 LuqoCjKm0qTpaAAtrM1jFux49JCAjjWm4sIx4EPzK0GO3imY+z8XYcUwuBbuflxp3p
	 gPEodkSzTK4YqVB81WszTxcyflFTKKew+lQBfiT4ZNTD5NWmGrEKJtzES1wktAqHDK
	 AD4Ro9BosuKVQsyvzr/rghZqzXHiGcAcj+4hkoWU7gk7+6iyE967IIoUOGieTOk7bz
	 WkgStMjHIk7yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: n_gsm: keep DLCI 0 object across mux restarts
Reply-To: sashiko-reviews@lists.linux.dev
To: henrymei <ljp1205831794@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260911065826.3515170-1-henrymei@tencent.com>
References: <20260911065826.3515170-1-henrymei@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:17:44 +0000
Message-Id: <20260911071745.1924A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] A Use-After-Free vulnerability in gsm_activate_mux() due to a =
Time-of-Check to Time-of-Use (TOCTOU) race with virtual TTY destruction whe=
n accessing gsm->dlci[0] locklessly.
- [High] Reference leak of DLCI 0 in gsm_activate_mux() under multiple cond=
itions, such as when the base reference was never initially dropped or on e=
arly error paths.

Pre-existing issues:
- [Critical] gsm_cleanup_mux() unconditionally drops references on data DLC=
Is (dlci[1] to dlci[63]) without clearing their pointers, leading to a doub=
le-drop and Use-After-Free across multiple mux restarts.
--

commit d9235f406403e25f640b7a316cd1963f9911d61e
Author: Aohan Mei <henrymei@tencent.com>

    tty: n_gsm: keep DLCI 0 object across mux restarts
   =20
    gsmtty_install() takes a reference on the object occupying the
    gsm->dlci[0] slot, and gsmtty_cleanup() drops a reference on whatever
    object occupies the slot at cleanup time. The two are expected to
    balance on the same object, but gsm_activate_mux() breaks that: on a
    mux restart (GSMIOC_SETCONF with a need_restart change) it
    unconditionally allocates a fresh DLCI 0 into the slot, orphaning the
    old object which still has install-time references outstanding.

> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c13e050de83b1..2ca7e18addc52 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c

[Severity: Critical]
This is a pre-existing issue, but does gsm_cleanup_mux() contain a double-d=
rop
regression?

Looking at drivers/tty/n_gsm.c, gsm_cleanup_mux() iterates over all dlci
objects and unconditionally drops their references:

drivers/tty/n_gsm.c:gsm_cleanup_mux() {
	...
	for (i =3D NUM_DLCI - 1; i >=3D 0; i--)
		if (gsm->dlci[i])
			gsm_dlci_release(gsm->dlci[i]);
	...
}

If a virtual tty is open, its refcount drops by 1 but it is not freed, and
gsm->dlci[i] is not cleared. If a user simply reconfigures the mux twice,
calling GSMIOC_SETCONF a second time, gsm_cleanup_mux() is called again and
drops the reference a second time.

Could this cause the refcount to hit 0 and free the dlci, despite the user
still holding the tty file descriptor? Subsequent operations on the open tty
would then trigger a use-after-free.

> @@ -3186,7 +3186,29 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
>  	struct gsm_dlci *dlci;
>  	int ret;
> =20
> -	dlci =3D gsm_dlci_alloc(gsm, 0);
> +	dlci =3D gsm->dlci[0];
> +	if (dlci) {

[Severity: Critical]
Does this un-synchronized access to gsm->dlci[0] introduce a time-of-check =
to
time-of-use (TOCTOU) race?

If gsm_activate_mux() is called via GSMIOC_SETCONF without holding gsm->mut=
ex,
and a virtual tty is concurrently closed, gsmtty_cleanup() drops the
outstanding reference on dlci 0 via dlci_put(gsm->dlci[0]).

If that concurrent dlci_put() drops the reference to 0, the dlci object is
freed. Could gsm_activate_mux() then access the freed memory via dlci_get()
below?

> +		/*
> +		 * gsmtty_install() takes a reference on the object that
> +		 * occupies the dlci[0] slot and gsmtty_cleanup() drops a
> +		 * reference on the object occupying the slot at cleanup
> +		 * time. Replacing the object here while such references
> +		 * are still outstanding makes the cleanup reference drop
> +		 * on the wrong (new) object, freeing it prematurely, and
> +		 * leaks the old one. Keep the still-referenced object in
> +		 * the slot and re-take the base reference that
> +		 * gsm_cleanup_mux() dropped so the install and cleanup
> +		 * references always balance on the same object.
> +		 */
> +		dlci_get(dlci);

[Severity: High]
Can unconditionally acquiring a duplicate base reference here lead to a
resource leak?

If the mux is closed via a modem command (CMD_CLD), gsm->dead is set to true
without calling gsm_cleanup_mux(). A subsequent GSMIOC_SETCONF with identic=
al
parameters skips gsm_cleanup_mux() but calls gsm_activate_mux().

In this scenario, the initial base reference was never dropped, and this
dlci_get() takes a duplicate reference.

Additionally, what happens if gsm_register_devices() fails shortly after th=
is?

drivers/tty/n_gsm.c:gsm_activate_mux() {
	...
	ret =3D gsm_register_devices(gsm_tty_driver, gsm->num);
	if (ret)
		return ret;
	...
}

The early error path returns without dropping the reference acquired here,
which seems to permanently leak the newly acquired reference.

> +		dlci->dead =3D false;
> +		dlci->adaption =3D gsm->adaption;
> +		dlci->mtu =3D gsm->mtu;
> +		dlci->ftype =3D gsm->ftype;
> +		dlci->k =3D gsm->k;
> +	} else {
> +		dlci =3D gsm_dlci_alloc(gsm, 0);
> +	}
>  	if (dlci =3D=3D NULL)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911065826.3515=
170-1-henrymei@tencent.com?part=3D1
