Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5A3B05B1
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175976; cv=none; b=XN/t0gNeS50GZVZPJnuVB6uDFuO0BfRBCELDtmSXf4Uvai15UAOzcbgR6I+yb8FInaD/ZnhoAGRfjTmOqXPtyGWh8auS48HFl7SI5Zs23QyoRUMDbtPooi6VtmnVyBY9FmE8kEehU02ZEa2w5LZz0s6AgeFbXnR+pch0yyrCDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175976; c=relaxed/simple;
	bh=W8mCp3SJrCu4CBEqSbc4yuvWfyqV1/A4EX/v4gQIyvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SyNF6EpwrlDNR/YCviJV+aDeX+h5KnujC486tTY/ZSdtRIHeaPeXRaXTxrAF9dUb6O0pq56Rg3j73TF3hj11ObiVWDIRiI1OPn7tt8bc5m7BJ7kYWOgLFTgLiwdK2jlKRdt7zm48WQ2aAoCjxkip4d9icGGs46/vtkQZZibVpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=dUhDHp1O; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="dUhDHp1O"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D6183240029
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 17:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790175969;
	bh=uEgYgG2jtpKqiEwQEWofsJ4lh37upe+OlrEoikITC34=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=dUhDHp1OUpnfUasNBkFTQn3Qy1oMMMERHkE3RzNc9KDn9ean8msh6xLpynV9oGOAp
	 b09yCVlnCBmOwaFbhThbOs+v5JnskGIneGE+ztRMDsSNovkKDIfQXyt+rqezbvv81Q
	 E/0HZ/orNvk33taziSVjvMyYtYX5vc8s7E/5b5qWz7oHr9g1PWfshGY5/krzz9BPUS
	 +CFRtuQxpawTPFuq0pXfRpR2hsxerydyZtnvaGZtY6ioq41T9lk50E2sgMEagyoqz6
	 G7qg3mDRMvxh/x7gjggiZq8Tgj+eIyjTuWiNGIHLb/Xqewg05xSr84ZD60swSwlIwS
	 QYuSC6cfaSo6A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hqgJs27jgz9rxD;
	Wed, 23 Sep 2026 17:06:05 +0200 (CEST)
Message-ID: <708eb7c004c0cce22d71bc8fbd68b44aa3b704a3.camel@posteo.de>
Subject: Re: [PATCH v2 1/3] tty: serdev: Export functions to pause
 receive_buf callback calls
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Eric Biggers	
 <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Lorenzo Stoakes	
 <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"	
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Jiri Slaby	
 <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev
Date: Wed, 23 Sep 2026 15:06:08 +0000
In-Reply-To: <DLMQUEKCSXRS.2OBTL1GV4FXVV@garyguo.net>
References: 
	<20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
	 <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>
	 <2026092356-chatting-dust-3de9@gregkh>
	 <2fcec4f3cd70a41e282505ff5c99b19e5809aead.camel@posteo.de>
	 <DLMQUEKCSXRS.2OBTL1GV4FXVV@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-qFTq82k4Jz8KYLv/i1pk"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-qFTq82k4Jz8KYLv/i1pk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-23 at 14:52 +0100, Gary Guo wrote:
> On Wed Sep 23, 2026 at 2:31 PM BST, Markus Probst wrote:
> > On Wed, 2026-09-23 at 12:35 +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Sep 20, 2026 at 02:29:58PM +0000, Markus Probst wrote:
> > > > These functions will be used to simply the serdev rust abstraction.=
 It
> > > > also contributes to the fixing of 2 race conditions in the serdev r=
ust
> > > > abstraction.
> > > >=20
> > > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > > ---
> > > >  drivers/tty/serdev/core.c           | 50 +++++++++++++++++++++++++=
+++++++++++-
> > > >  drivers/tty/serdev/serdev-ttyport.c | 38 +++++++++++++++++++++++++=
+++
> > > >  include/linux/serdev.h              |  6 +++++
> > > >  3 files changed, 93 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serd=
ev/serdev-ttyport.c
> > > > index bab1b143b8a6..e8aa89e733bd 100644
> > > > --- a/drivers/tty/serdev/serdev-ttyport.c
> > > > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > > > @@ -7,8 +7,10 @@
> > > >  #include <linux/tty.h>
> > > >  #include <linux/tty_driver.h>
> > > >  #include <linux/poll.h>
> > > > +#include "../tty.h"
> > > > =20
> > > >  #define SERPORT_ACTIVE		1
> > > > +#define SERPORT_PAUSE_RX	2
> > > > =20
> > > >  struct serport {
> > > >  	struct tty_port *port;
> > > > @@ -32,6 +34,14 @@ static size_t ttyport_receive_buf(struct tty_por=
t *port, const u8 *cp,
> > > >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> > > >  		return 0;
> > > > =20
> > > > +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
> > > > +		return 0;
> > > > +
> > > > +	/*
> > > > +	 * Ensure writes by the driver are visible before allowing traffi=
c to resume.
> > > > +	 */
> > > > +	smp_mb__after_atomic();
> > >=20
> > > This scares me.  Why not use a real lock?=C2=A0
> > >=20
> > I can use locks to make it less "fragile". But I don't I think I need
> > them.
> >=20
> > > WHat's the issue here, you
> > > need this to be "flushed" before this call:
> > >=20
> > > > +
> > > >  	ret =3D serdev_controller_receive_buf(ctrl, cp, count);
> > >=20
> > > here?
> > >=20
> > > And you just tested a bit, you didn't set a bit, so what are you tryi=
ng
> > > to ensure is written exactly?
> > This should be an acquire load operation (paired with the release store
> > operation in `ttyport_resume_rx`).
>=20
> Then you should use `test_bit_acquire`.
Ok. For some reason there is no equivalent `set_bit_release`.

>=20
> However, this isn't sufficient because there's no synchronization between=
 this
> bit test with the bit set inside pause_rx.
Will be replaced with a mutex in the next revision.

Thanks
- Markus Probst

>=20
> Best,
> Gary

--=-qFTq82k4Jz8KYLv/i1pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqz6twbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSOk0QALLiTzfWtOf81gvgqjYo
mhW2jo2bqdGVcOHTrqDJY4ms9BRnQmAzJyMamlKEEks3mG6I0QtCAv41lntVXHeW
jvcOXO54yyQWxVwS+J+M+y8z//MLdvO7mb5v91vYBEY1jnMwl60PHnuKUuVTLms7
qN+zvihG68OVGFVTInb3CPN4N93cgZkM2gNl+2r/NJxci1tYJN/DgosHvFD2n2UA
X1ZkfXBMYxiOClRI5V0M36HL3LNM1tNa7Z32Mvl1D4ym09eUoLhPOT+EPONi65cm
WqBwSFQrWwCffcIzetd68CG6G6C9aPjbXValmd3kUAbsxWFdahghADq35wNb1kNE
Ga7tcuqL6lpoT46U0wTkDtp8iBk76AjoMK3RtO8SxFxdnstvCVnk8XuqL77QR6tT
Fd0lMktEYiCm/prxsbwC9jQqRZNEWMTPKGYr21rU2mClvElu4pRceWwzuxsm8D/i
G7T6runz97OxPDxhdjqGdXLtl8yMF6ds8S7/yxx9DqbtzLp+IhZye+HPsstIECWj
Xf+ElC8wyTVoCHosvVx6uw1TAKj/mxnq/A2adTvxHYEEiHGOEcMxMENmqZOaKk0G
Q1U4Ec9RqiAP9Kri1LPxf0pPmiB7rFHtcpfsd79f4KbLI2Owu/bvxqJ7pEQLLAPo
dFPE9V81NqqyfF4mWkx7RIC0
=m2Wa
-----END PGP SIGNATURE-----

--=-qFTq82k4Jz8KYLv/i1pk--
