Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2E36CDF8
	for <linux-serial@vger.kernel.org>; Fri,  6 Mar 2026 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828092; cv=none; b=cCfXVgCiA6tv9ZrCzk3ip3MP+7Ri9zN10FkY9ssMzrrHuDuSSx9wBektIXFcXkztvzojTutHIeEsD53Yn6Jtg1MSp1guowbVoRlsd6JEXbEp6tq5CBBsWxLjyMIZOcfJOtRyiJoW1N6JL2IT5QERhwhXRh6FtN7Sj/qsGJ+vMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828092; c=relaxed/simple;
	bh=k6mKC+XBaSUQQ7rGXKVuP80dOmUOJUKDWxFRjBI7aio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RvVe5HJnyqymMXJ3QnfafU8171/EcDVVqsl/umdL9g07yCvvxAesGkmWWmxaUnnT5lh/LtCA8sULw3V5UMrEiSO21MdD4d9WINa4HgyLYvYJGsSmLhgw+MwICaaMMABFKZuN4a+OXryh3gSvvfksDB5fCS3avzYenfER45BBI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Dfx63eBY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Dfx63eBY"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C5136240101
	for <linux-serial@vger.kernel.org>; Fri,  6 Mar 2026 21:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1772828087; bh=lHq/GDpYQJsqvr0Wo/pN4wfYJnQQpU3mHGi4u+WMRm4=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Dfx63eBYelLh0263Mf5stw/sZFs5aMQxlJzOb/H6gku8VMor5NLtstFdYSJs5ovDz
	 uXBwtYJDD1+MVdFUIR3XAcJcXm6aSBh7HzdtIryGDW1mvQ1SRR+lSOSeKAfKW2epR+
	 EoI2vlRbZ7GxlWaHsDxolwiRQa2YC1N5ev7QCABp19PhHe2L814hy0Fbe+Sj1Ma0KC
	 4L6BeWTojVadzW3Ri7JfVhdO9EURpZRJ6fOfvmTT+6OW5qo1N1P1nABhQN6DvUe9FL
	 vg3n6vpXHIYCgWbylyA4B7JK59qeLRFTK8JhehU7M3GPqgECZ02zXtF0J2HIrI+XOM
	 VSjTmbgcI4TFg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fSHgl34wKz9rxG;
	Fri,  6 Mar 2026 21:14:43 +0100 (CET)
Message-ID: <11da7a1b29146ede059cf6ce6a383c6bdd930f44.camel@posteo.de>
Subject: Re: [PATCH v2 2/4] serdev: add private data to serdev_device
From: Markus Probst <markus.probst@posteo.de>
To: Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,  Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Kari
 Argillander	 <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng
 <boqun@kernel.org>, David Airlie <airlied@gmail.com>,  Simona Vetter
 <simona@ffwll.ch>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Date: Fri, 06 Mar 2026 20:14:46 +0000
In-Reply-To: <934ca1e6-dfee-411e-890a-083dcfc9f6b1@infradead.org>
References: <20260306-rust_serdev-v2-0-e9b23b42b255@posteo.de>
	 <20260306-rust_serdev-v2-2-e9b23b42b255@posteo.de>
	 <934ca1e6-dfee-411e-890a-083dcfc9f6b1@infradead.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-aBym8UsBbPNnHXvAhiGC"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-aBym8UsBbPNnHXvAhiGC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-03-06 at 11:49 -0800, Randy Dunlap wrote:
> Hi--
>=20
> On 3/6/26 11:35 AM, Markus Probst wrote:
> > Add private data to `struct serdev_device`, as it is required by the
> > rust abstraction added in the following commit
> > (rust: add basic serial device bus abstractions).
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  include/linux/serdev.h | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> > index 5654c58eb73c..b591af23faf0 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -33,12 +33,13 @@ struct serdev_device_ops {
> > =20
> >  /**
> >   * struct serdev_device - Basic representation of an serdev device
> > - * @dev:	Driver model representation of the device.
> > - * @nr:		Device number on serdev bus.
> > - * @ctrl:	serdev controller managing this device.
> > - * @ops:	Device operations.
> > - * @write_comp	Completion used by serdev_device_write() internally
> > - * @write_lock	Lock to serialize access when writing data
> > + * @dev:	 Driver model representation of the device.
> > + * @nr:		 Device number on serdev bus.
> > + * @ctrl:	 serdev controller managing this device.
> > + * @ops:	 Device operations.
> > + * @write_comp	 Completion used by serdev_device_write() internally
> > + * @write_lock	 Lock to serialize access when writing data
> > + * @private_data Private data for the device driver.
> >   */
>=20
> I don't quite get why each changed line has an extra tab added to it. ?
So all the fields have the same indentation.
Otherwise the description of private_data, because of its length, would
be 1 character more to the right.

> Also, struct member names in kernel-doc should with a colon  (':'), e.g.,
>=20
>  * @private_data: Private data for the device driver.
>=20
> Please correct that and the 2 lines above it also.
> And maybe test it to check for warnings.
I can do that.

>=20
> >  struct serdev_device {
> >  	struct device dev;
> > @@ -47,6 +48,7 @@ struct serdev_device {
> >  	const struct serdev_device_ops *ops;
> >  	struct completion write_comp;
> >  	struct mutex write_lock;
> > +	void *private_data;
> >  };
> > =20
> >  static inline struct serdev_device *to_serdev_device(struct device *d)
> >=20
>=20
> thanks.

Thanks
- Markus Probst


--=-aBym8UsBbPNnHXvAhiGC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmmrNa8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSq1YP/28JYsd8iwZ3XvLX0auV
ABTuvvfUP5s/CN951XT/JYNqTA1xt0IZpF28MTOJiqFbu1ZkiX0UzXT1IXnkmXpb
fB6R9ALauEj3gbbudo3IiY4iS+N0XGNHYtMa8nrSGx8Y/GQ/PcYeAL5PpxG0ISgA
/pDFjAUGYHb/8bhKuGoX+JJnUVmgYjraurLS0Z6SReaZ13qEll4u/8E35CfpIao8
pgjRahC7ZdoxiW4xSjtZgw47aPi8E6PnQ00cz5UTHe15Qh5R415wH8vC1kqH+nyr
eaE4GDHNWHLO4p8QEp589G6b/HTBMMV+83jYaxHJLpMJ1ZMnIPC1lLL0SjaMCUsp
zZMwsezKMIMHv8Hukn/iqErIlFA2g/aBq+R0/3r2JJwl/cB6sA9aJSwamPmebiPl
Xk/aKvMQUKE4QxRAYTVRQv131SlT8U88TQsawem/F2NPnBTCmS0thujfymuFkeyT
D8046dh+7krCDD+mYyq3LJR0i+r/pz9HVjPcGMLMiGDlzfB7zssSMPSlQUND5nqc
LlmYSeuM5exH7fuZLE5farIDElQV2Uvq8Cu5sB0tGND8lfzaTesG7TFgROb+zdIB
9ALdpzXbeFlkl4fOHjcHc+flVKf1toZ0aX/hUQtFi53fp3mxlXUjvHv25TRtd1xq
5hcI/dH5n+E2PLW4G/2tw/Aq
=k64Y
-----END PGP SIGNATURE-----

--=-aBym8UsBbPNnHXvAhiGC--
