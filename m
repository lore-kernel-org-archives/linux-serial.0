Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AB427F94
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504613; cv=none; b=OsPYgX9VzWyZjKgT6m4ab7vvBQU/VrUJNoGAeBfITqweN6QuK0P44ALPTtD6TyamUFOC/Z6ZevWPvMIiCQUrltvkJSERvva+oPe1FoNL9bwIiaViORzRYG/zSyTaJJTiHoZ52TEEmjeygKyKdBTNR09tqvr2HcUqiNkvfWjtF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504613; c=relaxed/simple;
	bh=XaWNFDdsQ4CZzpc/gX5PCDlHvYT1VShbXKhyCbat2/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L96TZn2A+DjRJYRNBBScaKmDlZD9vlPptDq63EUSQRRBoU4JlGT9ZxnZfyIkwADxOWhODG/JRNM3fhXsYPc+0y94WciASNsruGflVBs2ZYHV2kXyoaWVIr/vbWxFk0zcdUpxU+p6ujVIlmmZbpIKXQ5fnuKPSv8W5eFulAaGgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=HB84/xDB; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HB84/xDB"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 70EC424002A
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 15:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785504609;
	bh=5BhR3+0hmKhGZe6Gv78P1YqiUapc2hoDTOrznJ26wHo=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=HB84/xDB5Zq+tOKk5M+0YIJfEkDsL+C4AcmLS2EJWM9yQx1FN+yFefCFv+Om6sY6S
	 25a3rMMNPsvVdK1dXvXBVwymEBrtWeQQC/7wY7Fk7bGZ4PVGwyXBlx+J58Jl6Nyzy3
	 Sdlb9rn+bquyXzhAEYjkyj0GXALhuXsA/xdjmMG6aw262EK+tEDgywnWny1wM0LWvr
	 ikEHob5o1ijVaizSwccYio1T5/HLV8fHoRN3gqVo2meDleOJDXikaKIrhXAWSlW/I2
	 bkBMS2v6FdwKJ1X0hYiWgjo74aZ45hUDUmXFIPk3ORiImnzbtNnGB7rajxoWIrdBHs
	 h2N9uz6mut1Wg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hBRl42TxMz9rxK;
	Fri, 31 Jul 2026 15:30:08 +0200 (CEST)
Message-ID: <74334baf76168a49c839b2fb0478bd3bc191f572.camel@posteo.de>
Subject: Re: [PATCH 2/2] serdev: use tty_port_tty_get() in
 ttyport_write_buf() to prevent UAF
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Jiri Slaby
	 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, Joshua Rogers
	 <linux@joshua.hu>, stable <stable@kernel.org>
Date: Fri, 31 Jul 2026 13:30:09 +0000
In-Reply-To: <2026073144-sputter-gusto-c640@gregkh>
References: 
	<20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
	 <20260731-aisle-tty-serdev-v1-2-2401a3189327@linuxfoundation.org>
	 <11b34a60b7f66379e66f4cff779acdccd3fd0c8d.camel@posteo.de>
	 <2026073144-sputter-gusto-c640@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-+oaxTSrBQKxiYHEjqZQz"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-+oaxTSrBQKxiYHEjqZQz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-31 at 15:22 +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 31, 2026 at 01:00:30PM +0000, Markus Probst wrote:
> > On Fri, 2026-07-31 at 10:06 +0200, Greg Kroah-Hartman wrote:
> > > From: Joshua Rogers <linux@joshua.hu>
> > >=20
> > > ttyport_write_buf() snapshots serport->tty as a raw pointer without
> > > taking a reference, while ttyport_close() can concurrently release th=
e
> > > tty via tty_release_struct(), leading to a use-after-free. Use
> > > tty_port_tty_get() to obtain a reference-counted tty pointer, matchin=
g
> > > the pattern already used by ttyport_write_wakeup().
> > >=20
> > > Assisted-by: AISLE:Snapshot
> > > Cc: stable <stable@kernel.org>
> > > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev=
/serdev-ttyport.c
> > > index 48ce5b3f8308..4d37c8130dd7 100644
> > > --- a/drivers/tty/serdev/serdev-ttyport.c
> > > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > > @@ -85,13 +85,21 @@ static const struct tty_port_client_operations cl=
ient_ops =3D {
> > >  static ssize_t ttyport_write_buf(struct serdev_controller *ctrl, con=
st u8 *data, size_t len)
> > >  {
> > >  	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > > -	struct tty_struct *tty =3D serport->tty;
> > > +	struct tty_struct *tty;
> > > +	ssize_t ret;
> > > =20
> > >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> > >  		return 0;
> > > =20
> > > +	tty =3D tty_port_tty_get(serport->port);
> > > +	if (!tty)
> > > +		return 0;
> > > +
> > >  	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> > > -	return tty->ops->write(serport->tty, data, len);
> > > +	ret =3D tty->ops->write(tty, data, len);
> > > +	tty_kref_put(tty);
> > > +
> > > +	return ret;
> > >  }
> > > =20
> > >  static void ttyport_write_flush(struct serdev_controller *ctrl)
> >=20
> > It should be the responsibility of the driver to ensure
> > `serdev_device_close` and `serdev_device_write_buf` are not called
> > concurrently.
> >=20
> > This also applies to
> > - serdev_device_set_baudrate
>=20
> Doesn't touch a tty structure, so why is the same reference count logic
> needed here?
It calls `ttyport_set_baudrate`.

>=20
> > - serdev_device_set_flow_control
It calls `ttyport_set_flow_control`.
>=20
> Same here.
>=20
> > - serdev_device_wait_until_sent
>=20
> Or here?
It calls `ttyport_wait_until_sent`.

See `struct serdev_controller_ops ctrl_ops` in `serdev-ttyport.c`.

All of those mentioned above call into tty_ functions. Obviously the
tty_struct pointer needs to be valid for those calls, which is only the
case if the device is open.

Thanks
- Markus Probst

>=20
> > and more, which currently iirc even introduce a null pointer
> > dereference if called with the serdev device closed.
> >=20
> > I don't see why `serdev_device_write_buf` needs special protection
> > here, which the other functions don't need for some reason.
>=20
> It's the access to the tty pointer that I think the issue is, right?
>=20
> > As with the previous patch, this still makes sense for hardening.
> > With scope_guard being used,
> >=20
> > Reviewed-by: Markus Probst <markus.probst@posteo.de>
>=20
> Great, thanks, I'll send out a v2 next week with that change made, as
> I've done it locally and will wait a bit.
>=20
> thanks,
>=20
> greg k-h

--=-+oaxTSrBQKxiYHEjqZQz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpso18bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSrQUP/1Q6GABcF0LuIQmqnCKx
uz961k7HQn6OPhQHvg7lgvw913NoqazwXpd9ipUcLB1Y9xYOBgCKhoEL3/rQXBi7
viMHwRMTvquKGYV2jrkTqZ0XkbM+8YBuRYwUq7HTrT9DnBvgxclSIHcXGldBrmkV
19VJAI117F0Qb4jAXZtvR+vCmggVxrOaIGcIlY/Kgfx1aSBx9N4Da07+R3SdAc5x
6rfX3p7jKvFzI03xPEqmsz/mIf0Xsga5NdvJH1dpxfZ2bBbMrBgrjcOJYJxLhjJy
obXqxDG7rCu7HaHp492sckkz9uXExQGRpFIoPJcoc56F5HQd1EUT+w6LFo1O6kZD
w/GiRidw9Rn5Zw70v4QMac5+V7pC1t0kqBw/eeiulK1zbUcPq44l9HHVofPSyLEU
ivvVRCbFPAMAIjmoqjwCd0ZbwOHTnVMBoccWDPgTCuepdlk4sW7cmeKkEUnSrfiR
jih98IlCdUWj0ZxtltDuSwsBC2S+lVqSah646y1ZFTMGEoMy3gHIcOfLQ+DAaDBC
kprCTpLC8f9YdMI343sfquQtFMreH/D6lf/XFHg4NcinoHIASZoQ6D2TPdQUWlbv
cjmpmVo14YLtPaR9a3qrPjfozSQnjsMe1uTZnmt2YODBFtqSH9oyeFjo/GhowcH/
+Q0T07yw7XqcARrmMM6IU5Sw
=r5dn
-----END PGP SIGNATURE-----

--=-+oaxTSrBQKxiYHEjqZQz--
