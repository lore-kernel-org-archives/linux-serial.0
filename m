Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA082F6187
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766320799; cv=none; b=C6eN226Gq2p4vRPBbLRhbUwf/xKYrkT36E93pYJxeSMCixlADE+zbo0CykZJnwMuFxsKxCVBNwZrIkRuI6QSt6srYPP2KYqALz3Vy4KI2vByi9ZMk9X6HCOUqr807x6QZM7fsITp1gDCPZOe8NO02X+9rrBn+wI7FYr7MNT2Pd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766320799; c=relaxed/simple;
	bh=/3/QZmfVIC5B4D6mXau0TYYV6FS3BKLsn19ubTNxiLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQ1MjmQGN5uMmRa3iRxsT92Ne9FWWgmAccMgktV9iJK0kfx9F4tdDWIKmmtba9JRfCOWeb6pDNGYBS4+/MS7lNA5X5MEVZubyoJdSnqKmp+fUKIPWs7c+XJr9MRGvdRCudYRl3duLtPcQvTOJRz0Gy6GNaLHfFgZ8g7gnxQsIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Ky1lios+; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Ky1lios+"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id DA38E240028
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 13:39:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766320795; bh=hPUX8qdghOF0Zyc6gHbLhr07GrCmJ3eFXT1WSz6FmyY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Ky1lios+fBwJY5newfSOVSnNhDgGZMzUGipPXyWd76iElzbozsWkwcKNmrDTfTeUS
	 U3aZ+A1C+3Uj45MuwZRbtrCzoju11HI+i/uWmAlmP1t+L1mhaZCCCc1g+eAa3ulEu7
	 1EAK02aNbYmvduWV4MV7qLo69RRBTr2VeYmEkUJGSE1s3mfd62ccTGMeGtqLiSVylw
	 HyTV27wZQq0uFmt6VU+ABN4lXJR5N6RrtYgC241re0z20AcGRacUQ6g4zZ+8dY4BH+
	 wgDJfVHcI1qL3gylkTZI79+uNeYHbln00WdvDvbLuaKkKcNzjcQfuGG7riGT2FY9ZX
	 8xcxEYX/vV1xQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dZ17Y4VNlz9rxF;
	Sun, 21 Dec 2025 13:39:53 +0100 (CET)
Message-ID: <d4b835e75db528274de38893644cdf7c61115627.camel@posteo.de>
Subject: Re: [PATCH RFC 3/4] samples: rust: add Rust serial device bus
 sample device driver
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
Date: Sun, 21 Dec 2025 12:39:54 +0000
In-Reply-To: <c65689bf-67fd-4f7e-a878-59675ad429c4@gmail.com>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
	 <20251220-rust_serdev-v1-3-e44645767621@posteo.de>
	 <c65689bf-67fd-4f7e-a878-59675ad429c4@gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-yAFJbOQoiwFi2gHleB90"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-yAFJbOQoiwFi2gHleB90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dirk,

On Sun, 2025-12-21 at 10:11 +0100, Dirk Behme wrote:
> Hi Markus,
>=20
> On 20.12.25 19:44, Markus Probst wrote:
> > Add a sample Rust serial device bus device driver illustrating the usag=
e
> > of the platform bus abstractions.
> >=20
> > This drivers probes through either a match of device / driver name or a
> > match within the OF ID table.
> > ---
> >  samples/rust/Kconfig               |  10 +++
> >  samples/rust/Makefile              |   1 +
> >  samples/rust/rust_driver_serdev.rs | 175 +++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 186 insertions(+)
> ...
> > diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_dri=
ver_serdev.rs
> > new file mode 100644
> > index 000000000000..f23b38a26c32
> > --- /dev/null
> > +++ b/samples/rust/rust_driver_serdev.rs
> > @@ -0,0 +1,175 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Rust Serial device bus device driver sample.
> > +
> > +use kernel::{
> > +    acpi,
> > +    device::{
> > +        self,
> > +        property::{
> > +            FwNodeReferenceArgs,
> > +            NArgs, //
> > +        },
> > +        Bound,
> > +        Core, //
> > +    },
> > +    of,
> > +    prelude::*,
> > +    serdev,
> > +    str::CString,
> > +    sync::aref::ARef, //
> > +};
> > +
> > +struct SampleDriver {
> > +    sdev: ARef<serdev::Device>,
> > +}
> > +
> > +struct Info(u32);
> > +
> > +kernel::of_device_table!(
> > +    OF_TABLE,
> > +    MODULE_OF_TABLE,
> > +    <SampleDriver as serdev::Driver>::IdInfo,
> > +    [(of::DeviceId::new(c"test,rust_driver_serdev"), Info(42))]
>=20
> I stopped reading here regarding the new "rust_driver_serdev" but
> re-reading Rob's
>=20
> https://lore.kernel.org/rust-for-linux/20241022234712.GB1848992-robh@kern=
el.org/
>=20
> adding "test,<whatever>" should be fine as-is without any documenation.
>=20
> > +);
> > +
> > +kernel::acpi_device_table!(
> > +    ACPI_TABLE,
> > +    MODULE_ACPI_TABLE,
> > +    <SampleDriver as serdev::Driver>::IdInfo,
> > +    [(acpi::DeviceId::new(c"LNUXBEEF"), Info(0))]
> > +);
> > +
> > +#[vtable]
> > +impl serdev::Driver for SampleDriver {
> > +    type IdInfo =3D Info;
> > +    type InitialData =3D ();
> > +    type LateProbeData =3D ();
> > +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&OF_=
TABLE);
> > +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Some(=
&ACPI_TABLE);
> > +
> > +    fn probe(sdev: &serdev::Device, info: Option<&Self::IdInfo>) -> im=
pl PinInit<Self, Error> {
> > +        let dev =3D sdev.as_ref();
> > +
> > +        dev_dbg!(dev, "Probe Rust Serial device bus device driver samp=
le.\n");
> > +
> > +        if let Some(info) =3D info {
> > +            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
> > +        }
>=20
> Last time I had a look to the log output from rust_driver_platform.rs
> (where this is copied from?) I was slightly confused to see the
> "Probed with ..." in the log but not the "Probe Rust ...". Well, I
> hadn't DEBUG enabled. So I wonder if the combination of `dev_dbg!()`
> and `dev_info!()` this way should be improved? At least in
> rust_driver_platform.rs because we could drop that here completely? I
> mean in rust_driver_platform.rs it makes sense to demonstrate how
> `info` is supposed to work. But do we need that here?
>=20
>=20
> > +        if dev.fwnode().is_some_and(|node| node.is_of_node()) {
> > +            Self::properties_parse(dev)?;
> > +        }
>=20
>=20
> This is a left over from copy & paste? I mean having all this
> `properties_parse()` below and calling it here does not make any sense
> here? And should be dropped completely?
It was meant to show, that this is the function in which fwnode
properties should be parsed. As I did indeed base the sample on the
platform driver sample, I left it as-is. I will minimize it down to 1
property without an extra function, given that the platform driver
sample already shows how to use properties.
>=20
>=20
> > +
> > +        Ok(Self { sdev: sdev.into() })
> > +    }
> > +
> > +    fn configure(
> > +        sdev: &serdev::Device<Core>,
> > +        _this: Pin<&Self>,
> > +        _id_info: Option<&Self::IdInfo>,
> > +    ) -> Result {
> > +        dev_dbg!(
> > +            sdev.as_ref(),
> > +            "Configure Rust Serial device bus device driver sample.\n"
> > +        );
> > +
> > +        sdev.set_baudrate(115200);
> > +        sdev.set_flow_control(false);
> > +        sdev.set_parity(serdev::Parity::None)?;
> > +        Ok(())
> > +    }
> > +
> > +    fn late_probe(
> > +        sdev: &serdev::Device<Bound>,
> > +        _this: Pin<&Self>,
> > +        _initial_data: Self::InitialData,
> > +    ) -> impl PinInit<Self::LateProbeData, Error> {
> > +        dev_dbg!(
> > +            sdev.as_ref(),
> > +            "Late Probe Rust Serial device bus device driver sample.\n=
"
> > +        );
> > +        Ok(())
> > +    }
> > +
> > +    fn receive(
> > +        sdev: &serdev::Device<Bound>,
> > +        _this: Pin<&Self>,
> > +        _late_probe_this: Pin<&Self::LateProbeData>,
> > +        data: &[u8],
> > +    ) -> usize {
> > +        let _ =3D sdev.write_all(data, serdev::Timeout::MaxScheduleTim=
eout);
>=20
>=20
> Is it intended to have a function with the name `receive()`calling
> `write()`?
This sample driver echos any data it receives back to the serial
device.

It shows how to receive data from the serial device and how to send
data to the serial device.

It depends on the driver, if it is necessary to call write inside
receive. The serial device may want a reply or ack from the driver
after it sent a message.

>=20
> > +        data.len()
> > +    }
> > +}
> > +
> > +impl SampleDriver {
> > +    fn properties_parse(dev: &device::Device) -> Result {
>=20
>=20
> As mentioned above I think this is a left over from copy & paste and
> should be dropped?
>=20
> Cheers,
>=20
> Dirk

Thanks
- Markus Probst

--=-yAFJbOQoiwFi2gHleB90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmlH6o4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSQVsP/inhFaJjRSBAcsKhmyFE
6jk3bbGEXxMjOACH5PtsMNFvjaGDZyaA/r/9IJyhaRA1AyqFu2ef+SK4DGmxy+Wo
99SRABayVPVVS76IPkndWTOuBoVwh7uBAABrfSVteUuGUNCnu8p1AnmE7IaiHM6v
O2E9zn0d2oaVbf5mFx+StaWKFKoauMNXGtioEni/rFdo74rGDb10an2fIl+WW8LW
EzbwcUgRQ/C2E7p50SYFNQuDCtPumnBUmTdZWQmKVCXniJrJyFrOl3X8JoM5i/HZ
obkAmDlAL3XwEead2uxm7NCtAV/klRVhWxXBXaIJpBHGeg2VkGFMzGl/we8qtmuK
CYMICi8h29q/tTA3njRwylxIBstudT33p2NqeYgDIzPjoQJSii2Lw7nwe4NEBE7G
tmL12/MP1kAH5pePRuCUrsxazIiasQoEuOFtFhWE6qCKy/P3peT6JWLAaA2Fhe0Y
95DCpSf55pae7AWGUCWG6UiEPOtG53/Bn1jKTlHqvwIHHnMhz9qf9CJtoM8ctLzG
Ppnno0a0ObUX/+CuQ78jcK+rrkLEPPfaUhE7nsxH8VRIVU8kP9hOPnf0lQoAzX5m
VGjFRLhiF/m64X7rK2ZYEFHL7zjVSEyASU3FTLJSEwbY3pJKRoGrj1Tnd77ZvG4f
0LkuriLVKRUZOQ0syuTpNuoW
=JOzO
-----END PGP SIGNATURE-----

--=-yAFJbOQoiwFi2gHleB90--
