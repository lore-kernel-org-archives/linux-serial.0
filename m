Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC6393DD1
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327161; cv=none; b=V2ObWp2frcfqSOfK23KI4kdxJAA052awR2/TmZhZM/Qnc2LyyZzRzXwu/ehammONkgeFvp13ut7Wdh7nMMlMYJMJgbXKy8DUkKLmhWovW5tueLetGLL+DLffGMFfEKOvaqWw+cQ88Us8dGOpiSfdltVir/ocnJA/BNLvC1zjOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327161; c=relaxed/simple;
	bh=Cfw4uKfZ1797XDgc0D7Fxce9A9laeVTSyQ6b2lWsMH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dymj0ia7L/xlwheZP1Qv6PPusUYiFTqXGNLgwrUoQB/oQrOflWq6Y21tls2AmvUESm6ZT5E1GZyjRzj0xZEWkkgrMhv7kvpnaUSYHSQgRbFjrVd5XN0IdPymXRHjOCITT0wWOzudLF5GYUs9v3A4+fxtvHium0D2glhqIt2UNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=FhsGPg7D; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="FhsGPg7D"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 290D524002D
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 18:59:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1768327157; bh=6vZxPMAQX2zREFV4XyGG49AeoEkQVkAgqwbtgEA4yyc=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:OpenPGP:From;
	b=FhsGPg7D/h+88IKeN1y17SRJMUgDORmP/cXbnk+ydgDy9PD25azPtEqroWFT8RZL0
	 iaABdyvuYvKqJxaLlSTsf80r5thSCjmYKboZiKoDlOjw3iHvI2tPzUbo6FmVm4NFuf
	 kOY6TfvOZC3at0w3ir5VBEL4NTV3npfX10rIDfgv7u1GctATVjl1+/bHxbBr1Qm4mq
	 neiV+vMwr+8XMkhrfSc0dJz7qjYrt6XIr9c4hVKx0ILM98i6bimttPfa0lFoTOdJ73
	 LUgPqmpp7k629mNM4hqIK7NSef1FSbBF9DgzomPDC/zFC85SZpTJzRvmlul8Hm1Tbl
	 Vk3T8ORzXNKzA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4drH7Q4rWnz9rxQ;
	Tue, 13 Jan 2026 18:59:14 +0100 (CET)
Message-ID: <dcab1e61e451aeba27575c8245aef687caf94b23.camel@posteo.de>
Subject: Re: [PATCH RFC 2/4] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Kari Argillander <kari.argillander@gmail.com>, Rob Herring
 <robh@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri
 Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Date: Tue, 13 Jan 2026 17:59:16 +0000
In-Reply-To: <DFNN75KWL8B9.1YHK1ZRV43W7O@kernel.org>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
	 <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
	 <CAC=eVgSmD+bYh48gZteAaqwSHvcHes3CFmbUUBu=6UQ6fKCUJg@mail.gmail.com>
	 <76491897ad6e0ff2749935c39702b93adc9951d6.camel@posteo.de>
	 <DFNN75KWL8B9.1YHK1ZRV43W7O@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

On Tue, 2026-01-13 at 18:37 +0100, Danilo Krummrich wrote:
> On Tue Jan 13, 2026 at 5:15 PM CET, Markus Probst wrote:
> > > > +impl<T: Driver + 'static> Adapter<T> {
> > > > +    const OPS: &'static bindings::serdev_device_ops =3D &bindings:=
:serdev_device_ops {
> > > > +        receive_buf: if T::HAS_RECEIVE {
> > > > +            Some(Self::receive_buf_callback)
> > > > +        } else {
> > > > +            None
> > > > +        },
> > > > +        write_wakeup: if T::HAS_WRITE_WAKEUP {
> > > > +            Some(Self::write_wakeup_callback)
> > > > +        } else {
> > > > +            Some(bindings::serdev_device_write_wakeup)
> > > > +        },
> > > > +    };
> > > > +    const INITIAL_OPS: &'static bindings::serdev_device_ops =3D &b=
indings::serdev_device_ops {
> > > > +        receive_buf: Some(Self::initial_receive_buf_callback),
> > > > +        write_wakeup: if T::HAS_WRITE_WAKEUP_INITIAL {
> > > > +            Some(Self::initial_write_wakeup_callback)
> > > > +        } else {
> > > > +            Some(bindings::serdev_device_write_wakeup)
> > > > +        },
> > > > +    };
> > > > +    const NO_OPS: &'static bindings::serdev_device_ops =3D &bindin=
gs::serdev_device_ops {
> > > > +        receive_buf: None,
> > > > +        write_wakeup: Some(bindings::serdev_device_write_wakeup),
> > > > +    };
> > > > +
> > > > +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_devic=
e) -> kernel::ffi::c_int {
> > > > +        // SAFETY: The serial device bus only ever calls the probe=
 callback with a valid pointer to
> > > > +        // a `struct serdev_device`.
> > > > +        //
> > > > +        // INVARIANT: `sdev` is valid for the duration of `probe_c=
allback()`.
> > > > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInt=
ernal>>() };
> > > > +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_re=
f());
> > > > +
> > > > +        from_result(|| {
> > > > +            let data =3D try_pin_init!(Drvdata {
> > > > +                driver <- T::probe(sdev, info),
> > > > +                initial_data: Some(Default::default()).into(),
> > > > +                late_probe_data: None.into(),
> > > > +            });
> > > > +
> > > > +            sdev.as_ref().set_drvdata(data)?;
>=20
> This does not work, a driver can obtain its device private data with
> Device::<Bound>::drvdata() [1].
>=20
> For this the driver must assert the correct type, but since you use a pri=
vate
> type instead of the type given by the driver, i.e. T, Device::<Bound>::dr=
vdata()
> will always fail for the driver.
>=20
> [1] https://rust.docs.kernel.org/kernel/device/struct.Device.html#method.=
drvdata
I need to fix that.

>=20
> > > > +
> > > > +            // SAFETY: We just set drvdata to `Drvdata<T>`.
> > > > +            let data =3D unsafe { sdev.as_ref().drvdata_borrow::<D=
rvdata<T>>() };
> > > > +
> > > > +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid=
 pointer to `serdev_device`.
> > > > +            unsafe { bindings::serdev_device_set_client_ops(sdev.a=
s_raw(), Self::INITIAL_OPS) };
> > > > +
> > > > +            // SAFETY: The serial device bus only ever calls the p=
robe callback with a valid pointer
> > > > +            // to a `struct serdev_device`.
> > > > +            to_result(unsafe {
> > > > +                bindings::devm_serdev_device_open(sdev.as_ref().as=
_raw(), sdev.as_raw())
> > > > +            })?;
>=20
> I don't think it is a good idea to hardcode this into the probe() callbac=
k and
> split it up in multiple stages, we can always solve things like ordering =
with
> new types, type states and guards.
>=20
> > > > +
> > > > +            // SAFETY: `&data.driver` is guaranteed to be pinned.
> > > > +            T::configure(sdev, unsafe { Pin::new_unchecked(&data.d=
river) }, info)?;
> > > > +
> > > > +            if !T::HAS_RECEIVE_INITIAL {
> > > > +                // SAFETY:
> > > > +                // - It is guaranteed that we have exclusive acces=
s to `data.initial_data` and
> > > > +                //   `data.late_probe_data`.
>=20
> How is it ensured that this does not run concurrently with
> initial_receive_buf_callback(), etc.?
```
if !T::HAS_RECEIVE_INITIAL {
    return 0;
}
```
at the beginning of the function does.

>=20
> > > > +                // - We just initialized `data.initial_data` with =
Some.
> > > > +                unsafe { Self::do_late_probe(sdev, data)? };
> > > > +            }
>=20
> It is a bit unclear to me what you try to achieve here.
>=20
> Do you want to synchronize an initial data transfer? Then something along=
 the
> lines of what Kari proposes seems reasonable.
>=20
> Or is the intention that this will run entirely async? But then distinct
> initialization stages as they appear above won't work.
Async.
The driver gets probed.
late_probe will be called, after all the necessary data for the
initialization is there.

Can you explain what doesn't work? The code has been tested with a
prototype driver before submission.

Kari his approach is synchronize inside the probe function, until all
the necessary data is there.
Which one do you think should be used for the abstraction?

>=20
> > > > +
> > > > +            Ok(0)
> > > > +        })
> > > > +    }
> > > > +
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// The caller must guarantee, that we have exclusive access t=
o `data.initial_data` and
> > > > +    /// `data.late_probe_data`. `data.initial_data` must be Some.
> > > > +    /// (i. e. `late_probe` has not been called yet).
> > > > +    unsafe fn do_late_probe(sdev: &Device<device::CoreInternal>, d=
ata: Pin<&Drvdata<T>>) -> Result {
> > > > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> > > > +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driv=
er) };
> > > > +
> > > > +        // SAFETY: The function contract guarantees that we have e=
xclusive access to
> > > > +        // `data.initial_data`.
> > > > +        let initial_data =3D unsafe { &mut *data.initial_data.get(=
) };
> > > > +
> > > > +        // SAFETY: The function contract guarantees that we have e=
xclusive access to
> > > > +        // `data.late_probe_data`.
> > > > +        let late_probe_data =3D unsafe { &mut *data.late_probe_dat=
a.get() };
> > > > +
> > > > +        *late_probe_data =3D Some(KBox::pin_init(
> > > > +            T::late_probe(
> > > > +                sdev,
> > > > +                data_driver,
> > > > +                // SAFETY: The function contract guarantees that `=
data.initial_data` is Some.
> > > > +                unsafe { initial_data.take().unwrap_unchecked() },
> > > > +            ),
> > > > +            GFP_KERNEL,
> > > > +        )?);
> > > > +        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid poi=
nter to `serdev_device`.
> > > > +        unsafe { bindings::serdev_device_set_client_ops(sdev.as_ra=
w(), Self::OPS) };
> > > > +        Ok(())
> > > > +    }
>=20
> <snip>
>=20
> > > > +    extern "C" fn initial_receive_buf_callback(
> > > > +        sdev: *mut bindings::serdev_device,
> > > > +        buf: *const u8,
> > > > +        length: usize,
> > > > +    ) -> usize {
> > > > +        if !T::HAS_RECEIVE_INITIAL {
> > > > +            return 0;
> > > > +        }
> > > > +
> > > > +        // SAFETY: The serial device bus only ever calls the recei=
ve buf callback with a valid
> > > > +        // pointer to a `struct serdev_device`.
> > > > +        //
> > > > +        // INVARIANT: `sdev` is valid for the duration of `receive=
_buf_callback()`.
> > > > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInt=
ernal>>() };
> > > > +
> > > > +        // SAFETY: `buf` is guaranteed to be non-null and has the =
size of `length`.
> > > > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, leng=
th) };
> > > > +
> > > > +        // SAFETY: `initial_receive_buf_callback` is only ever cal=
led after a successful call to
> > > > +        // `probe_callback`, hence it's guaranteed that `Device::s=
et_drvdata()` has been called
> > > > +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> > > > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvda=
ta<T>>() };
> > > > +
> > > > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> > > > +        let driver_data =3D unsafe { Pin::new_unchecked(&data.driv=
er) };
> > > > +
> > > > +        // SAFETY:
> > > > +        // - `data.initial_data` is always Some until `InitialRece=
iveResult::Ready` is
> > > > +        //   returned below.
> > > > +        // - It is guaranteed that we have exclusive access to `da=
ta.initial_data`.
> > > > +        let initial_data =3D unsafe { (*data.initial_data.get()).a=
s_mut().unwrap_unchecked() };
> > > > +
> > > > +        match T::receive_initial(sdev, driver_data, initial_data, =
buf) {
> > > > +            Ok(InitialReceiveResult::Pending(size)) =3D> size,
> > > > +            Ok(InitialReceiveResult::Ready(size)) =3D> {
> > > > +                // SAFETY:
> > > > +                // - It is guaranteed that we have exclusive acces=
s to `data.initial_data` and
> > > > +                //   `data.late_probe_data`.
> > > > +                // - We just initialized `data.initial_data` with =
Some.
> > > > +                if let Err(err) =3D unsafe { Self::do_late_probe(s=
dev, data) } {
>=20
> We are calling late_probe() again from initial_receive_buf_callback()? Wh=
y?
It only gets called once.
This is gated behind "if T::HAS_RECEIVE_INITIAL". And in probe its
gated behind "if T::HAS_RECEIVE_INITIAL".

If "receive_initial" does not get implemented by the driver, late probe
will be run immediately after the regular probe.

>=20
> > > > +                    dev_err!(sdev.as_ref(), "Unable to late probe =
device: {err:?}\n");
> > > > +                    // SAFETY: `sdev.as_raw()` is guaranteed to be=
 a valid pointer to
> > > > +                    // `serdev_device`.
> > > > +                    unsafe { bindings::serdev_device_set_client_op=
s(sdev.as_raw(), Self::NO_OPS) };
> > > > +                    return length;
> > > > +                }
> > > > +                size
> > > > +            }
> > > > +            Err(err) =3D> {
> > > > +                dev_err!(
> > > > +                    sdev.as_ref(),
> > > > +                    "Unable to receive initial data for probe: {er=
r:?}.\n"
> > > > +                );
> > > > +                // SAFETY: `sdev.as_raw()` is guaranteed to be a v=
alid pointer to `serdev_device`.
> > > > +                unsafe { bindings::serdev_device_set_client_ops(sd=
ev.as_raw(), Self::NO_OPS) };
> > > > +                length
> > > > +            }
> > > > +        }
> > > > +    }
>=20
> <snip>
>=20
> > There currently is only one serial device bus driver in the kernel,
> > which needs initial data:
> > drivers/bluetooth/hci_uart.h
> > drivers/bluetooth/hci_ldisc.c
> > drivers/bluetooth/hci_serdev.c
> >=20
> > This driver retrieves this initial data after probe (not in the probe)
> > and then initializes it with a workqueue. Given it is part of the
> > kernel, I assume this is the intended behaviour.
>=20
> In this case I assume the driver has a lock protected buffer in its priva=
te
> data? Which would be entirely different than what you implement above, no=
?
