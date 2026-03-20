Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100D3D16F0
	for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026812; cv=none; b=caWddh8fN3ONdVXwM4gzOQ7Y3T92r5edK2J9Qnr6vlANz+ddBDNZ0bIhNK8p/3nG5YgdqQTi77pZroqqOZhaxUk13vXtj+UggeEjt8XHHJZFNFIuePNLWrhMf6WbzczsjEGdkjoaxLOIGFR4mf2ZbOzt8CKrTlmxuLe3n/DLuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026812; c=relaxed/simple;
	bh=PAW+I/VkOcKB0Plto+s+x0QmEbI3yQtc3t6/t5GTNNE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PB4HFgQLulvJHyNFj7RbxYdVKi/gaHX9J5Ptn93tDfxmqEYu21nGjEDDRdLLChlw0AdoonBPD6ejvtaxi1j/wqnKYFKv4ts9DRwtUsGWoWMLbV0GUdSjNeOgKIPTnmpvX4vSHc+x/C69FOkpmJfgfUgtPn8ZUqZ52IUHcKwAblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=oQWUp9by; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="oQWUp9by"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1306F240103
	for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 18:13:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1774026809; bh=SCKt0XH7B1B8aIgxXx4Wexd8qNNlHqBjbw6IpXzlzpE=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=oQWUp9bydByMccnbBuFMAFHN9mJ4CGGgXbsLrV6s1cFmZBWDCSw1+XqTVPUXt6XtZ
	 p00/s6EFsvcstgDT55L3tYP+3KLj3WrTiGGctpAFbl1YykOmhSB2957HMjobpPhNuB
	 lAWKu0kbWCgZz90S8qCRyRv3UrsreJPGFZiO4O/eLWxrx+ckVyMBUqbn1bWPGuJ24J
	 ndaI7qiC8KatNS+ZA6dkBYclpmYk2HnasSxhG7W12tLaJyPHnW4q9W/BwpLG+82h7G
	 y5ut6FCQFF+GE5iexhkk+HyM5WQzzp+fy35P+TMKjslHIZA763x8t4yL47CceIF8FQ
	 lKcWb4XFBt9gQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fcq052Jy4z9rxF;
	Fri, 20 Mar 2026 18:13:25 +0100 (CET)
Message-ID: <4f4c09d683023df9daef89ca634b17b5c16625f7.camel@posteo.de>
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Kari Argillander	
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Date: Fri, 20 Mar 2026 17:13:28 +0000
In-Reply-To: <2026032048-curtly-refold-e4df@gregkh>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
	 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
	 <2026031402-absence-graph-af5d@gregkh>
	 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
	 <2026031422-shaded-matchbook-5078@gregkh>
	 <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
	 <2026031447-margarita-untamed-e976@gregkh>
	 <9e07a53053d1dd75a4ebe94aaa06e2279ef3701d.camel@posteo.de>
	 <2026032048-curtly-refold-e4df@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-8uD0GBqw6AAVRTJIz0DF"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-8uD0GBqw6AAVRTJIz0DF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-03-20 at 17:59 +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 20, 2026 at 04:53:09PM +0000, Markus Probst wrote:
> > On Sat, 2026-03-14 at 14:31 +0100, Greg Kroah-Hartman wrote:
> > > On Sat, Mar 14, 2026 at 12:08:09PM +0000, Markus Probst wrote:
> > > > On Sat, 2026-03-14 at 12:52 +0100, Greg Kroah-Hartman wrote:
> > > > > On Sat, Mar 14, 2026 at 11:42:02AM +0000, Markus Probst wrote:
> > > > > > On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
> > > > > > > On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote=
:
> > > > > > > > Add rust private data to `struct serdev_device`, as it is r=
equired by the
> > > > > > > > rust abstraction added in the following commit
> > > > > > > > (rust: add basic serial device bus abstractions).
> > > > > > >=20
> > > > > > > why is rust "special" here?  What's wrong with the existing p=
rivate
> > > > > > > pointer in this structure?  Why must we add another one?
> > > > > > Because in rust, the device drvdata will be set after probe has=
 run. In
> > > > > > serdev, once the device has been opened, it can receive data. I=
t must
> > > > > > be opened either inside probe or before probe, because it can o=
nly be
> > > > > > configured (baudrate, flow control etc.) and data written to af=
ter it
> > > > > > has been opened. Because it can receive data before drvdata has=
 been
> > > > > > set yet, we need to ensure it waits on data receival for the pr=
obe to
> > > > > > be finished. Otherwise this would be a null pointer dereference=
. To do
> > > > > > this, we need to store a `Completion` for it to wait and a `boo=
l` in
> > > > > > case the probe exits with an error. We cannot store this data i=
n the
> > > > > > device drvdata, because this is where the drivers drvdata goes.=
 We also
> > > > > > cannot create a wrapper of the drivers drvdata, because
> > > > > > `Device::drvdata::<T>()` would always fail in that case. That i=
s why we
> > > > > > need a "rust_private_data" for this abstraction to store the
> > > > > > `Completion` and `bool`.
> > > > >=20
> > > > > So why is this any different from any other bus type?  I don't se=
e the
> > > > > "uniqueness" here that has not required this to happen for PCI or=
 USB or
> > > > > anything else.
> > > > >=20
> > > > > What am I missing?
> > > > In Short:
> > > > In serdev, we have to handle incoming device data (serdev calls on =
a
> > > > function pointer we provide in advance), even in the case that the
> > > > driver hasn't completed probe yet.
> > >=20
> > > But how is that any different from a USB or PCI driver doing the same
> > > thing?  Why is serdev so unique here?=C2=A0
> > >=20
> > In PCI or USB we don't need to provide function pointers for callbacks
> > in advance, which will be can be called any time (even while probe).
>=20
> All class drivers are like this, once you register with them, the
> function pointers you provide can be called before your probe call ends.
> So this isn't unique as far as I can tell.
>=20
> > > What specific serdev function
> > > causes this
> > >=20
> > drivers/tty/serdev/serdev-ttyport.c basically only wraps the serdev
> > calls to tty calls. This isn't directly caused by a serdev function,
> > but by the tty part.
> >=20
> > > why isn't it an issue with the C api?
> > >=20
> > In C you can set the drvdata inside the probe and even with it not
> > being fully initialized.
> >=20
> > With Rust the drvdata is only available after the probe.
> > But there is the posibility of serdev calling the provided callback
> > inside probe.
>=20
> Other classes have this same issue, so why isn't this a problem for HID
> and input and the like?
This is unique for a bus device.

A class device has its own Data (e. g. PwmOps), i. e. it will only be
registered after this Data has been initialized by the driver.

The receive_buf callback on the serdev device on the other hand must
happen on the drvdata, as there is no place to store its own Data.

The drvdata is only available at the end of the probe in Rust.

Thanks
- Markus Probst

>=20
> thanks,
>=20
> greg k-h

--=-8uD0GBqw6AAVRTJIz0DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmm9gDEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSIlkQALXlZoWwzPjZMy95xhqU
7I6KvPLFlLzYRlxIIThOXDGEIOZ95ce7T96q9ZhBhpA3scxteCuxy8+EsBqveKSQ
pcxhjMa0iKR4FYwMjDHmCQ8mRfZL3qJ2am1tHKOAVxl8ZiZk1s7yu4Wkhtz69pbG
n4dT4atBfUGvIuoJAVSyw6h5qydyrL1B6MViYFoFj0GoyGqzCI1dQ+Qg/zMONgvu
VHLP18oAF/BVjkK9RBp/WYVzh8gZv6/GkTPHN3O5NeFzzyf8d2uee4SjlFUXDros
8qM2nVWxI8IabGJ3nyi4wqb6PVzBQBuDV0jK1bbQBEj++7ktlirR9hjL69W0GCmY
OQBRWKrc73waYJ+s6FA8Ihuva8Jx25s7tfzvJno/2k7bcqZU90QNFleaN5L3MXmU
8GrJ60Y7OPh3gG4aYHHbm6qhUFOJCXojQmxNz7kzIq2EqZf8VpLMdaEMCgsjaJaZ
RYxgvTlgI0r5RxSlhuDMF/xrkiUup13b4JMbNRw4UCuDQbIWThuU5FXZq55A3AI4
j4thJY/XwRz9Z1fyfu+mlh22mVuBVe1S0NlOFKxDyE5Y4TE3virmvkRoN9meRQi/
cg2a7FRptqWcl2fuds3hqgAXNattBqV33B1+X+TcXHusT8udSvkjKwtM0bbYQJOq
to1ro//wgixTwjmnTMunazcl
=cBMA
-----END PGP SIGNATURE-----

--=-8uD0GBqw6AAVRTJIz0DF--
