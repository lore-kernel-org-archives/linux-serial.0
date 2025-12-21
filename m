Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F542F6187
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766320875; cv=none; b=P6Ex9xX/bKZk/A3eAuaX9I+L+bCaLXl/MpGov+wq+GzGFriSA03oNj3qSALgIrFOPojRviUauOJnZwKgwOcz7bbURAKv/N8uKwfn8NTw9OFnltWQADqPvrNVr5SJm3+ZDslJC5z3Uo6V75AoE8OLpTMm1BfJLfiDsCPE7qAcIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766320875; c=relaxed/simple;
	bh=cZytxEdW4XTEOQ291sMH3JQMnG5LZFVodCXhGukLfyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dola6qmXvQ0QDAOkIYxTxFbFfZGJgmE/cpzpEReQqW+VGI9mNO9BZzQhvnQPig3XlkBiRGVfn21SQPJlhNWJzZ4FbERhziChca44ogBTSpCY9u8eLz/ELs8ov7n4NyaZAYSSM29MSH2yctS5n3nlHGoRspvUKZAu4KvPzV7sLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=jFMq9lbX; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="jFMq9lbX"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 36D3E240101
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 13:41:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766320871; bh=ZRgiQM1NQkguPep0kX6Mk/2+ATcGhBqLmzP1kGUPBcU=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=jFMq9lbXEWoqi1aoAYgeHkJvLbcAS7Iv2305SHDrbBj3LyBs2ImL1BV9poDMxnjTx
	 iJi7S8HLxjo648NVBYyTFDyubv+NHX1gCFVu2O0z9nvVkdl8Esrf81+yPnA1Kygizj
	 Xd0U7m3y8Tt1XQQU4FDJCeiqyqep+nulRjBWmXCy/L3795np3XRc53xmLwhngx82+u
	 ltsSP3dGmRXbdiuz+FCnd7M+qfwbaF3E+9aGTQU246BqV8ZXpwV43HzwqAYORf1g6X
	 hLur8QL1kTKKV/cC0I1ylO5VdEyEXJRBYJ43kR9DCzGFr1SvhkxlG5v2BPt6ToiZKu
	 zfPEYUMnqiMzg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dZ1915D8jz9rwn;
	Sun, 21 Dec 2025 13:41:09 +0100 (CET)
Message-ID: <2f42525e678925a803ea4acaeb1e704953e44681.camel@posteo.de>
Subject: Re: [PATCH RFC 2/4] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Dirk Behme <dirk.behme@gmail.com>, Rob Herring <robh@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Kari Argillander	
 <kari.argillander@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Date: Sun, 21 Dec 2025 12:41:10 +0000
In-Reply-To: <4c26408c-b8ce-42a6-b0df-47053fd81eda@gmail.com>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
	 <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
	 <4c26408c-b8ce-42a6-b0df-47053fd81eda@gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-/XVG65cPYd9G6NsyoQIJ"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-/XVG65cPYd9G6NsyoQIJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dirk,

On Sun, 2025-12-21 at 10:19 +0100, Dirk Behme wrote:
> Hi Markus,
>=20
> On 20.12.25 19:44, Markus Probst wrote:
> > Implement the basic serial device bus abstractions required to write a
> > serial device bus device driver with or without the need for initial de=
vice
> > data. This includes the following data structures:
> >=20
> > The `serdev::Driver` trait represents the interface to the driver.
> >=20
> > The `serdev::Device` abstraction represents a `struct serdev_device`.
> >=20
> > In order to provide the Serdev specific parts to a generic
> > `driver::Registration` the `driver::RegistrationOps` trait is
> > implemented by `serdev::Adapter`.
> >=20
> > Co-developed-by: Kari Argillander <kari.argillander@gmail.com>
> > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/helpers/helpers.c          |   1 +
> >  rust/helpers/serdev.c           |  22 ++
> >  rust/kernel/lib.rs              |   2 +
> >  rust/kernel/serdev.rs           | 815 ++++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 841 insertions(+)
> >=20
> ...
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > new file mode 100644
> > index 000000000000..0f5ef325a054
> > --- /dev/null
> > +++ b/rust/kernel/serdev.rs
> ....
> > +    /// Write data to the serial device until the controller has accep=
ted all the data or has
> > +    /// been interrupted by a timeout or signal.
> > +    ///
> > +    /// Note that any accepted data has only been buffered by the cont=
roller. Use
> > +    /// [ Device::wait_until_sent`] to make sure the controller write =
buffer has actually been
> > +    /// emptied.
> > +    ///
> > +    /// Returns the number of bytes written (less than data if interru=
pted).
>=20
> Should it be "less than data.len"? Instead of just "data"? Same in the
> comment for `write()`below.
Yes.
>=20
>=20
> > +    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::E=
RESTARTSYS`] if interrupted
> > +    /// before any bytes were written.
> > +    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<u=
size> {
> > +        // SAFETY:
> > +        // - `self.as_raw()` is guaranteed to be a pointer to a valid =
`serdev_device`.
> > +        // - `data.as_ptr()` is guaranteed to be a valid array pointer=
 with the size of
> > +        //   `data.len()`.
> > +        let ret =3D unsafe {
> > +            bindings::serdev_device_write(
> > +                self.as_raw(),
> > +                data.as_ptr(),
> > +                data.len(),
> > +                timeout.into_jiffies(),
> > +            )
> > +        };
> > +        if ret < 0 {
> > +            // CAST: negative return values are guaranteed to be betwe=
en `-MAX_ERRNO` and `-1`,
> > +            // which always fit into a `i32`.
> > +            Err(Error::from_errno(ret as i32))
> > +        } else {
> > +            Ok(ret.unsigned_abs())
> > +        }
> > +    }
> > +
> > +    /// Write data to the serial device.
> > +    ///
> > +    /// If you want to write until the controller has accepted all the=
 data, use
> > +    /// [`Device::write_all`].
> > +    ///
> > +    /// Note that any accepted data has only been buffered by the cont=
roller. Use
> > +    /// [ Device::wait_until_sent`] to make sure the controller write =
buffer has actually been
> > +    /// emptied.
> > +    ///
> > +    /// Returns the number of bytes written (less than data if interru=
pted).
> > +    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::E=
RESTARTSYS`] if interrupted
> > +    /// before any bytes were written.
> > +    pub fn write(&self, data: &[u8]) -> Result<u32> {
> > +        // SAFETY:
> > +        // - `self.as_raw()` is guaranteed to be a pointer to a valid =
`serdev_device`.
> > +        // - `data.as_ptr()` is guaranteed to be a valid array pointer=
 with the size of
> > +        //   `data.len()`.
> > +        let ret =3D
> > +            unsafe { bindings::serdev_device_write_buf(self.as_raw(), =
data.as_ptr(), data.len()) };
> > +        if ret < 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(ret.unsigned_abs())
> > +        }
> > +    }
>=20
> Best regards
>=20
> Dirk

Thanks
- Markus Probst

--=-/XVG65cPYd9G6NsyoQIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmlH6uUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSKzwP/jRVFU10i5GjfwhXNi7L
mNYrRiM1KRkacuJrAc4MknRGzn3C0KmgLTKMLvA2+P4Uei41Mo68buR1fuuFG98c
9O42GBuOgcj/OJ2AWqynp83pIy2Dbt4GCnmgTOxKQe2r4mNgyPM2trWdc1Y0EJqJ
aKy4jq+ZoX89RYN3gmbc13uvme6cBxkm7igHrPCE1kTDAqr+h4FcvWP+Z5aHGo2A
ialZJqEyh+Xwzoun7YjuTiGwUfbfXCvB5n0VyO5iIswY2oDgOBemI89ZrfLQcf3V
h3SMtZdzrzQ6C2pTDWwLmve/++HkqFgBqeek4RGEUgm6Dni27v1oWMsXyWvqOB2y
qQVZKltS13OPmOunTCBuHgCSEfYBWRUGuZVhYDWOUNWOELaZLGFrrhpfZ1IJZOtv
HSn+yHyqUzrSnptNE8aDG/lAy6ZBsWvr2LGtGdJIPl3QfidkOQ4CH8E56p3ykrfR
G5pUwV6lTXtAj6RheQP62FgeZwwMn0T35yGa1GSGqpKeRYTvK44nDF1dCUSaYjHl
MwY1meFU8NkZBXe5CA6azbqk9UIX30kl+8LKZSeMRWLKSm9dzu+wlNayeZdvl/hn
7P2xSWkIT4yylvgq0v6G+l/yptafxcLoSdt1Lmge5tXuYbeLntYlK9BCibkp+W/X
04yfGlkxSinXCKfHrzNnzOxE
=93Qy
-----END PGP SIGNATURE-----

--=-/XVG65cPYd9G6NsyoQIJ--
