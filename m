Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A635DA76
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501793; cv=none; b=r8GpQWAur4JLilDBGN97QcLTcoYIX8LdcgjSQg+PGlHf16NOIYlyNlJMwzmQPnQ4SuIODKSWmrNhkfkXfeHG/Bmtsq5YN9RjrnMZ+I81ah4Im8SCnbGHoJoh2wi0NjlBPe7l8CMUu4kAqo8wxULmOZuI7iqiFoERKBaacaonlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501793; c=relaxed/simple;
	bh=kXjDFxvvU5agCXLhU7opxug8WhT9bJs2AMFw8OxVX/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5SXf5/5lnNS0zWit62gez9Rwwt6oif/PjK0o6oUa6gRKLtekt5O204ojuTzSZ89nP8Jo1e2+we+SMYumNvPxc4fhsO4JYCdDWQfETLSKOqrzMwmNseZpNm5PDIUX+rMqGYt3IXH+ufkkL1Ut0qusuDdmKu8degRMXKAIXZpy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=bdsaQ53h; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="bdsaQ53h"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D881F240101
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 14:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785501787;
	bh=jradFcftWYvOnDFfoP3/zr550UfgORNMS1jtQxVyzl0=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=bdsaQ53hrIvJcqN3yCv/4ww0j2I+KHXViwlWMFCEwlI9cwPRX2AUbTuCQMXBwFd4f
	 IXaN1lWugqPElhif72ODU1/1yb4kIJ9VcuSFcdQ12lOYRcZ8BirjwAnG/uY+j6kwZq
	 0UEDSyP5sKjw++Cu9hzseknIpfmrmkYXZZWqXDat7KgwBRU3HPsn98D5/J+JPSCrht
	 7YZGmhYEler1FKA/stIIqV1m/6w4Dhd5nuXs32wtOZe6mx26DisnoDHI07TLLQtRk3
	 Jb4EcvIN29kzKO86LU0Nksk0vfHgLmM40O2m6FgzfdUA7dgVneBfRbMBqEod+DqYWK
	 J3TQqpxEucvqQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hBQhn6Dkdz9rxL;
	Fri, 31 Jul 2026 14:43:05 +0200 (CEST)
Message-ID: <e78199c0d917f28cce30997317a9b45f7b8a57eb.camel@posteo.de>
Subject: Re: [PATCH 1/2] serdev: fix race between tty-port unregister and
 in-flight callbacks
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Jiri Slaby
	 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, Joshua Rogers
	 <linux@joshua.hu>, stable <stable@kernel.org>
Date: Fri, 31 Jul 2026 12:43:06 +0000
In-Reply-To: <2026073118-handwash-vitality-5f3f@gregkh>
References: 
	<20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
	 <20260731-aisle-tty-serdev-v1-1-2401a3189327@linuxfoundation.org>
	 <edd75d5a4362e5c8e7b691f65768d1fedc30309a.camel@posteo.de>
	 <2026073118-handwash-vitality-5f3f@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-mx5cNm777Bf9oKHRXlOr"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-mx5cNm777Bf9oKHRXlOr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-31 at 14:01 +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 31, 2026 at 11:30:53AM +0000, Markus Probst wrote:
> > On Fri, 2026-07-31 at 10:06 +0200, Greg Kroah-Hartman wrote:
> > > From: Joshua Rogers <linux@joshua.hu>
> > >=20
> > > serdev_tty_port_unregister() clears port->client_data and frees the
> > > controller without synchronizing with in-flight flip buffer work.
> > > This can cause NULL pointer dereferences or use-after-free if
> > > ttyport_receive_buf() or ttyport_write_wakeup() runs concurrently.
> > >=20
> > > Add cancel_work_sync() to drain pending buffer work before clearing
> > > state, and add NULL checks for client_data in both callbacks as
> > > secondary hardening.
> > >=20
> > > Assisted-by: AISLE:Snapshot
> > > Cc: stable <stable@kernel.org>
> > > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/tty/serdev/serdev-ttyport.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev=
/serdev-ttyport.c
> > > index bab1b143b8a6..48ce5b3f8308 100644
> > > --- a/drivers/tty/serdev/serdev-ttyport.c
> > > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > > @@ -26,9 +26,14 @@ static size_t ttyport_receive_buf(struct tty_port =
*port, const u8 *cp,
> > >  				  const u8 *fp, size_t count)
> > >  {
> > >  	struct serdev_controller *ctrl =3D port->client_data;
> > > -	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > > +	struct serport *serport;
> > >  	size_t ret;
> > > =20
> > > +	if (!ctrl)
> > > +		return 0;
> > > +
> > > +	serport =3D serdev_controller_get_drvdata(ctrl);
> > > +
> > >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> > >  		return 0;
> > > =20
> > > @@ -46,9 +51,14 @@ static size_t ttyport_receive_buf(struct tty_port =
*port, const u8 *cp,
> > >  static void ttyport_write_wakeup(struct tty_port *port)
> > >  {
> > >  	struct serdev_controller *ctrl =3D port->client_data;
> > > -	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > > +	struct serport *serport;
> > >  	struct tty_struct *tty;
> > > =20
> > > +	if (!ctrl)
> > > +		return;
> > > +
> > > +	serport =3D serdev_controller_get_drvdata(ctrl);
> > > +
> > >  	tty =3D tty_port_tty_get(port);
> > >  	if (!tty)
> > >  		return;
> > > @@ -312,6 +322,7 @@ int serdev_tty_port_unregister(struct tty_port *p=
ort)
> > >  		return -ENODEV;
> > > =20
> > >  	serdev_controller_remove(ctrl);
> > > +	cancel_work_sync(&port->buf.work);
> > >  	port->client_data =3D NULL;
> > >  	port->client_ops =3D &tty_port_default_client_ops;
> > >  	serdev_controller_put(ctrl);
> >=20
> > So why exactly does tty keep calling `receive_buf` and `write_wakeup`
> > with the tty port closed?
> >=20
> > After `serdev_controller_remove` is called, the tty port should already
> > be closed by the drivers.
>=20
> Are you sure?  remove can be called by a device removal, while close
> might be coming from a different code path (like it is in userspace.)
>=20
> If this is impossible, as close will ALWAYS happen before remove, then
> it's not an issue, but that is probably not the case, right?

The driver *should* always close the serdev device on remove if
previously opened. Thus the existence of `devm_serdev_device_open`.

The serdev subsystem itself does not guarantee that it has been called.

I just took a look at every driver using `serdev_device_open` (non
devm), and every one seems to call `serdev_device_close` on remove.

Assuming `cancel_work_sync(&port->buf.work);` is used correctly here,
we could still take the patch for hardening.

Thanks
- Markus Probst

>=20
> thanks,
>=20
> greg k-h

--=-mx5cNm777Bf9oKHRXlOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpsmEobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSPnoP/0cy0RT9oHV7SXZFZtha
c1nq/y1RcBgmcbNulJ06C2nBg7uT21PzKOzFuhXEMQg8JeLen0LVNhTjad8+Ma5h
pMRVZLf48NqikqnbsMqhtM0b8SSFGsVtUL8HVvaDepyxP4r0FpGkggtm2aGts6ON
fqkAAiV1xKMcbjNNS9x1MfVNMvqgfI47Fau4yyVKu8nT3BQaaCSYPwaNbTUOVIkY
A8hU1E8VExVfkl/GiqXsbeF9HCwcE3twg3ZEBm+7P9398cGq3DuX5RYRrZK+PNl2
1RNarJRoK1Hkuz411gL492QHkqw97eLMj9qBWdQRt2xWUgRV7AM4YUUQ47otxc+0
3XZ5c+THK7saEzc5rhQ5Etss3YUnz4+xWmXlf2Yku7XJGujThfqct2hEl7mUQMtD
EfTmTTdpB3FsLrruxpTkAiq2hXLH0c9x5tzKM92g9/G+uR1udxVys6RU8QqCsAGo
vxiXCFZwVRMChEYOb/WXWVOKv1/bnbE2rN0U8AirT2nxvf5UCEqyUpVI46AGs/dR
GAot9jtfxX3tF1wM7E/lgAqBi54bv+Wrzy1ontwo0KHHQcgKo8H94scxE/8YFCxZ
ICX4u65gjDLehjTNk0eGQ8GhcO/R7sachZvg7UJTsKTw8xk16t1vuMwSJ9rjKDx1
ZquopxFs8kIG+bfzZsY1YNnA
=88FJ
-----END PGP SIGNATURE-----

--=-mx5cNm777Bf9oKHRXlOr--
