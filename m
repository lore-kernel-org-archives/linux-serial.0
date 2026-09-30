Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A325218A8
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790942; cv=none; b=i5WikmHPbpuvX1bSG0q7OZPIQIOA36CrEyYkf6ykZSRRemCjRrR/c4EGMCVi77iZrRc05RvF0emdligmBfUcISCprkyP9JkVupbgw9zlaMy1VIZm6IWEMTNNcIC4XpMd3RItsM2+JtE56R7tdizXkmXlYB7YKr7qAGVehllnTGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790942; c=relaxed/simple;
	bh=AZSDroTFvfKnuaaxYGY2YeUQ1yf6PTxmndMCJO+EF1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJAanWWiq2utvu5j21xYVKnqQoIsBmNYE49la6RAIUlq7Gcon5YRtAstnH6TcPN+s+kww6go+/9TB5TEwcsdzCk/8wY4CgJmYVDQSmT8JrLcB7ZhUGEIZu3zsnNByEU/BqWXgfoaDNpqv05u538XMb7LjCMXQ19q9cpCV6RUXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=hR+xoNWS; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hR+xoNWS"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6627A240103
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 19:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790790496;
	bh=V3niE6WEv00dnTClKTgw/hzPOB84un8xX0M9WxcZnCk=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=hR+xoNWSjCS5Vn251zCGhdV2BQ85nkHrdvJXTeTz8XtcV+kmC0D0ipk8yqU/iV/WQ
	 KB1tH06P7sBMSoNUrhIIgcTNKl8iJPMJmVnnjg9WnpZyjg+pigNqFvYoYJ1kx9L30g
	 FEnjJ7ADDrVcm4LOdRUHOLopi0cYlWv4g3lcuJ9uSwZEVU2cYXgu7IqYGtlXplxvmF
	 Tlf0dmbsitoS6k4A6LgvDRW7t1yZryJI/pScklSb4g3i/IRxwr81ftEbm+hLlhqfHd
	 tuN3MKE3kkNJhMUB6ryGYyvoptFKocmt4Yn3CyD9IM27dIdzkWnJnCBrcQkQ2pGvf1
	 uVZBdVDVc6aag==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hw2Zl5X2Fz9rxB;
	Wed, 30 Sep 2026 19:48:15 +0200 (CEST)
Message-ID: <cc761b12f8ddc6c900713ef09b6368bd293aadaf.camel@posteo.de>
Subject: Re: [PATCH v3 2/4] tty: serdev: Export functions to pause
 receive_buf callback calls
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, gary@garyguo.net, linux-serial@vger.kernel.org
Date: Wed, 30 Sep 2026 17:48:16 +0000
In-Reply-To: <20260930174318.032AA1F00898@smtp.kernel.org>
References: 
	<20260930-rust_serdev_probe_refactor-v3-0-d1b6e77135e0@posteo.de>
	 <20260930-rust_serdev_probe_refactor-v3-2-d1b6e77135e0@posteo.de>
	 <20260930174318.032AA1F00898@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-7n5+9zA0RVLFoV4z/Btm"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-7n5+9zA0RVLFoV4z/Btm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-30 at 17:43 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] tty: serdev: AB-BA deadlock between ttyport_pause_rx() and ttypo=
rt_receive_buf()
> - [High] tty: serdev: Self-deadlock calling pause_rx or resume_rx from re=
ceive_buf
> - [High] tty: serdev: TOCTOU race leading to NULL pointer dereference in =
ttyport_close/pause/resume
> --
>=20
> commit f462dbe8ac06c8a92e0fb79ce15c1e6444a27110
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> tty: serdev: Export functions to pause receive_buf callback calls
>=20
> These functions will be used to simply the serdev rust abstraction. It
> also contributes to the fixing of 2 race conditions in the serdev rust
> abstraction.
>=20
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/s=
erdev-ttyport.c
> > index c11908f5e1ce3..2bed0e54202a8 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
>=20
> [ ... ]
>=20
> > @@ -35,6 +37,9 @@ static size_t ttyport_receive_buf(struct tty_port *po=
rt, const u8 *cp,
> >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> >  		return 0;
> > =20
> > +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
> > +		return 0;
> > +
> >  	ret =3D serdev_controller_receive_buf(ctrl, cp, count);
>=20
> [Severity: High]
> Can this cause a self-deadlock if the driver attempts to pause or resume
> reception during data reception?
>=20
> If the downstream driver's receive callback calls serdev_device_pause_rx(=
)
> or serdev_device_resume_rx(), they will attempt to acquire the non-recurs=
ive
> serport->lock which is already held by ttyport_receive_buf().
It was never intended to be called from inside receive_buf.

>=20
> [ ... ]
>=20
> > @@ -177,6 +182,32 @@ static bool ttyport_close(struct serdev_controller=
 *ctrl)
> >  	return true;
> >  }
> > =20
> > +static void ttyport_pause_rx(struct serdev_controller *ctrl)
> > +{
> > +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > +	struct tty_struct *tty =3D serport->tty;
>=20
> [Severity: High]
> Is it possible for this unprotected read of serport->tty to introduce a T=
OCTOU
> race leading to a NULL pointer dereference?
>=20
> If ttyport_pause_rx() races with ttyport_open(), the local tty pointer co=
uld
> be captured as NULL before acquiring the lock. After acquiring the lock, =
the
> code might observe SERPORT_ACTIVE as true (set by the concurrent open) an=
d
> proceed to dereference the stale, NULL tty pointer.
>=20
> (Note: ttyport_close() also appears to have this pre-existing issue).
True.

>=20
> > +
> > +	guard(mutex)(&serport->lock);
> > +
> > +	set_bit(SERPORT_PAUSE_RX, &serport->flags);
> > +
> > +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> > +		tty_buffer_flush_work(tty->port);
>=20
> [Severity: High]
> Could this tty_buffer_flush_work() cause an AB-BA deadlock with
> ttyport_receive_buf()?
>=20
> ttyport_pause_rx() acquires serport->lock and then calls
> tty_buffer_flush_work(), which blocks waiting for the currently executing=
 work
> to finish. If the current work is flush_to_ldisc(), it calls
> ttyport_receive_buf(), which attempts to acquire serport->lock, resulting=
 in
> a deadlock.
Already mentioned in a comment (true).

>=20
> > +}
> > +
> > +static void ttyport_resume_rx(struct serdev_controller *ctrl)
> > +{
> > +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > +	struct tty_struct *tty =3D serport->tty;
>=20
> [Severity: High]
> Can this also cause a NULL pointer dereference if it races with ttyport_o=
pen()
> and captures a NULL tty pointer before acquiring the lock?
True.

>=20
> > +
> > +	guard(mutex)(&serport->lock);
> > +
> > +	clear_bit(SERPORT_PAUSE_RX, &serport->flags);
> > +
> > +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> > +		tty_buffer_restart_work(tty->port);
> > +}
> > +

--=-7n5+9zA0RVLFoV4z/Btm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmq9S18bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSNC8QALTj72bR7OkQO3NisogX
gbBLeMfi5NO6Wioz0V0SUh26/Wk2mZqwOaJ8Lt5aX1L7xvufGvvn/vAvu/nKHiUG
gEKjZldJ2jV5AvDW4p/XMWlV7dHStNtbZd2Ym4C+xzLFjyFzRWkF+iCPR/JI70A2
eFuiSv0n0MxtTHQ/BktB5g6HEK2GNKAnuSzrkmax+Hsr6w18dzWWWA2hYMSMuRCv
wD7Rx17xX8h1jvDfyttfkC461LC1F8lLSfU+KMbVrJhgtZDyvhyC67Vtyk8YeaAW
awwoy1g8c5o0glN5dqu3GNdyQKnNa62MTD+4mghfveH+WCF1/m/s/v7LHfUjCyQt
F01BKWwZv/FR9m0JZNoqNMZF7fsx4TvP+ELy8DQ7swB8PvyRVBjLEkL0CoxIdXGx
m/bpipHlvxTHjp86+R32Lg59IkPa3JobYJ9elxe6dhBtFLMW2Mhjoss81II12jNV
tQIP2tTWfbAwWrJ1IV6znAJobO+sqerRGxBfq3sa5oE85+muISXed4S7Rpd3+E0B
H8HUMbT7BS1XhuXLem7RCHqV9OKkrgwZsZosss4KSKfku8bN5pVc1TVg6bvhfzh8
ji7knjuAWJ/E/m1VEpJSQ8Z40gPo18OSElRynV6JCvU/EBiYnJGq7P7apN0sFftz
XIO7CXemASSGKxXPkWWlExa5
=ULo7
-----END PGP SIGNATURE-----

--=-7n5+9zA0RVLFoV4z/Btm--
