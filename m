Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB507350D50;
	Tue, 13 Jan 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325857; cv=none; b=WZpif51p6v01b/OC8nJToltlDGIEdwo83vaKyKC07Nv5CLSbEscjrgCkMEFrslmC+2AeJmAyC4mKUDzBL/TEC42VX4Hnr3g1nVOJfSdGHK1Pv5gHrwg2dWtfEews3LKPmdcq+zVDCMjXqcZiLlQMiCQ2yiYIEI9uGAw+Hi5CcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325857; c=relaxed/simple;
	bh=Cp5crIbuQcHzWEEHYt1WMAFWV19fM6Vf342B6RTHqnM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=s3gPMBAzjcYezP43MdfZW+sE5KdcfeJbh61p2QbD4cFveXVqm0GaLwn5Y67WQfm3bYFBEVPd2HckKoSQPTlnH6jDMLgldp7tZ47t8bTYKcM9MS3v6LiBfkPT5eGU0D5eVDSdb/5gsrphJBzhVd7YupGgZ3t6LabKiYRU8DmSAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7rVHWXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7rVHWXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BDAC19423;
	Tue, 13 Jan 2026 17:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768325856;
	bh=Cp5crIbuQcHzWEEHYt1WMAFWV19fM6Vf342B6RTHqnM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=V7rVHWXpzsa38/v9AYza6SwdtmtTlzPKvz/Ib35WG5BLDw/JVTbOF2aA1VOvLgWa3
	 uJAUepyNvcqEKhsWLc7RHSOkI/QbiDHh00YGhGBMrS+2gEO31yRVtdjaCF4aU68W52
	 YsmLmHz7AXv7kduKRSUvRWEtUYyu0NNHzjaMN5lbfNXj6Wz7vDtpe7H/BdhVfFRgBZ
	 vVSVOlsXbQc3i3+W0AzVFEbFVgo5e2IKQNPtZibuGFxIzibCpu4mT/OJ1h2Z0jPoDR
	 0UH5xVckITC+5MAjxHfdB6kDb6vgV0zEmmyjtWvAC3tZ1BWGZNxDolyJWdYhP4sWTd
	 GyqpdPzq4+cFA==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 18:37:31 +0100
Message-Id: <DFNN75KWL8B9.1YHK1ZRV43W7O@kernel.org>
Subject: Re: [PATCH RFC 2/4] rust: add basic serial device bus abstractions
Cc: "Kari Argillander" <kari.argillander@gmail.com>, "Rob Herring"
 <robh@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
 <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
 <CAC=eVgSmD+bYh48gZteAaqwSHvcHes3CFmbUUBu=6UQ6fKCUJg@mail.gmail.com>
 <76491897ad6e0ff2749935c39702b93adc9951d6.camel@posteo.de>
In-Reply-To: <76491897ad6e0ff2749935c39702b93adc9951d6.camel@posteo.de>

On Tue Jan 13, 2026 at 5:15 PM CET, Markus Probst wrote:
>> > +impl<T: Driver + 'static> Adapter<T> {
>> > +    const OPS: &'static bindings::serdev_device_ops =3D &bindings::se=
rdev_device_ops {
>> > +        receive_buf: if T::HAS_RECEIVE {
>> > +            Some(Self::receive_buf_callback)
>> > +        } else {
>> > +            None
>> > +        },
>> > +        write_wakeup: if T::HAS_WRITE_WAKEUP {
>> > +            Some(Self::write_wakeup_callback)
>> > +        } else {
>> > +            Some(bindings::serdev_device_write_wakeup)
>> > +        },
>> > +    };
>> > +    const INITIAL_OPS: &'static bindings::serdev_device_ops =3D &bind=
ings::serdev_device_ops {
>> > +        receive_buf: Some(Self::initial_receive_buf_callback),
>> > +        write_wakeup: if T::HAS_WRITE_WAKEUP_INITIAL {
>> > +            Some(Self::initial_write_wakeup_callback)
>> > +        } else {
>> > +            Some(bindings::serdev_device_write_wakeup)
>> > +        },
>> > +    };
>> > +    const NO_OPS: &'static bindings::serdev_device_ops =3D &bindings:=
:serdev_device_ops {
>> > +        receive_buf: None,
>> > +        write_wakeup: Some(bindings::serdev_device_write_wakeup),
>> > +    };
>> > +
>> > +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) =
-> kernel::ffi::c_int {
>> > +        // SAFETY: The serial device bus only ever calls the probe ca=
llback with a valid pointer to
>> > +        // a `struct serdev_device`.
>> > +        //
>> > +        // INVARIANT: `sdev` is valid for the duration of `probe_call=
back()`.
>> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreIntern=
al>>() };
>> > +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_ref()=
);
>> > +
>> > +        from_result(|| {
>> > +            let data =3D try_pin_init!(Drvdata {
>> > +                driver <- T::probe(sdev, info),
>> > +                initial_data: Some(Default::default()).into(),
>> > +                late_probe_data: None.into(),
>> > +            });
>> > +
>> > +            sdev.as_ref().set_drvdata(data)?;

This does not work, a driver can obtain its device private data with
Device::<Bound>::drvdata() [1].

For this the driver must assert the correct type, but since you use a priva=
te
type instead of the type given by the driver, i.e. T, Device::<Bound>::drvd=
ata()
will always fail for the driver.

[1] https://rust.docs.kernel.org/kernel/device/struct.Device.html#method.dr=
vdata

>> > +
>> > +            // SAFETY: We just set drvdata to `Drvdata<T>`.
>> > +            let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvd=
ata<T>>() };
>> > +
>> > +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid po=
inter to `serdev_device`.
>> > +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_r=
aw(), Self::INITIAL_OPS) };
>> > +
>> > +            // SAFETY: The serial device bus only ever calls the prob=
e callback with a valid pointer
>> > +            // to a `struct serdev_device`.
>> > +            to_result(unsafe {
>> > +                bindings::devm_serdev_device_open(sdev.as_ref().as_ra=
w(), sdev.as_raw())
>> > +            })?;

I don't think it is a good idea to hardcode this into the probe() callback =
and
split it up in multiple stages, we can always solve things like ordering wi=
th
new types, type states and guards.

>> > +
>> > +            // SAFETY: `&data.driver` is guaranteed to be pinned.
>> > +            T::configure(sdev, unsafe { Pin::new_unchecked(&data.driv=
er) }, info)?;
>> > +
>> > +            if !T::HAS_RECEIVE_INITIAL {
>> > +                // SAFETY:
>> > +                // - It is guaranteed that we have exclusive access t=
o `data.initial_data` and
>> > +                //   `data.late_probe_data`.

How is it ensured that this does not run concurrently with
initial_receive_buf_callback(), etc.?

>> > +                // - We just initialized `data.initial_data` with Som=
e.
>> > +                unsafe { Self::do_late_probe(sdev, data)? };
>> > +            }

It is a bit unclear to me what you try to achieve here.

Do you want to synchronize an initial data transfer? Then something along t=
he
lines of what Kari proposes seems reasonable.

Or is the intention that this will run entirely async? But then distinct
initialization stages as they appear above won't work.

>> > +
>> > +            Ok(0)
>> > +        })
>> > +    }
>> > +
>> > +    /// # Safety
>> > +    ///
>> > +    /// The caller must guarantee, that we have exclusive access to `=
data.initial_data` and
>> > +    /// `data.late_probe_data`. `data.initial_data` must be Some.
>> > +    /// (i. e. `late_probe` has not been called yet).
>> > +    unsafe fn do_late_probe(sdev: &Device<device::CoreInternal>, data=
: Pin<&Drvdata<T>>) -> Result {
>> > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
>> > +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver)=
 };
>> > +
>> > +        // SAFETY: The function contract guarantees that we have excl=
usive access to
>> > +        // `data.initial_data`.
>> > +        let initial_data =3D unsafe { &mut *data.initial_data.get() }=
;
>> > +
>> > +        // SAFETY: The function contract guarantees that we have excl=
usive access to
>> > +        // `data.late_probe_data`.
>> > +        let late_probe_data =3D unsafe { &mut *data.late_probe_data.g=
et() };
>> > +
>> > +        *late_probe_data =3D Some(KBox::pin_init(
>> > +            T::late_probe(
>> > +                sdev,
>> > +                data_driver,
>> > +                // SAFETY: The function contract guarantees that `dat=
a.initial_data` is Some.
>> > +                unsafe { initial_data.take().unwrap_unchecked() },
>> > +            ),
>> > +            GFP_KERNEL,
>> > +        )?);
>> > +        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointe=
r to `serdev_device`.
>> > +        unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw()=
, Self::OPS) };
>> > +        Ok(())
>> > +    }

<snip>

>> > +    extern "C" fn initial_receive_buf_callback(
>> > +        sdev: *mut bindings::serdev_device,
>> > +        buf: *const u8,
>> > +        length: usize,
>> > +    ) -> usize {
>> > +        if !T::HAS_RECEIVE_INITIAL {
>> > +            return 0;
>> > +        }
>> > +
>> > +        // SAFETY: The serial device bus only ever calls the receive =
buf callback with a valid
>> > +        // pointer to a `struct serdev_device`.
>> > +        //
>> > +        // INVARIANT: `sdev` is valid for the duration of `receive_bu=
f_callback()`.
>> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreIntern=
al>>() };
>> > +
>> > +        // SAFETY: `buf` is guaranteed to be non-null and has the siz=
e of `length`.
>> > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length)=
 };
>> > +
>> > +        // SAFETY: `initial_receive_buf_callback` is only ever called=
 after a successful call to
>> > +        // `probe_callback`, hence it's guaranteed that `Device::set_=
drvdata()` has been called
>> > +        // and stored a `Pin<KBox<Drvdata<T>>>`.
>> > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<=
T>>() };
>> > +
>> > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
>> > +        let driver_data =3D unsafe { Pin::new_unchecked(&data.driver)=
 };
>> > +
>> > +        // SAFETY:
>> > +        // - `data.initial_data` is always Some until `InitialReceive=
Result::Ready` is
>> > +        //   returned below.
>> > +        // - It is guaranteed that we have exclusive access to `data.=
initial_data`.
>> > +        let initial_data =3D unsafe { (*data.initial_data.get()).as_m=
ut().unwrap_unchecked() };
>> > +
>> > +        match T::receive_initial(sdev, driver_data, initial_data, buf=
) {
>> > +            Ok(InitialReceiveResult::Pending(size)) =3D> size,
>> > +            Ok(InitialReceiveResult::Ready(size)) =3D> {
>> > +                // SAFETY:
>> > +                // - It is guaranteed that we have exclusive access t=
o `data.initial_data` and
>> > +                //   `data.late_probe_data`.
>> > +                // - We just initialized `data.initial_data` with Som=
e.
>> > +                if let Err(err) =3D unsafe { Self::do_late_probe(sdev=
, data) } {

We are calling late_probe() again from initial_receive_buf_callback()? Why?

>> > +                    dev_err!(sdev.as_ref(), "Unable to late probe dev=
ice: {err:?}\n");
>> > +                    // SAFETY: `sdev.as_raw()` is guaranteed to be a =
valid pointer to
>> > +                    // `serdev_device`.
>> > +                    unsafe { bindings::serdev_device_set_client_ops(s=
dev.as_raw(), Self::NO_OPS) };
>> > +                    return length;
>> > +                }
>> > +                size
>> > +            }
>> > +            Err(err) =3D> {
>> > +                dev_err!(
>> > +                    sdev.as_ref(),
>> > +                    "Unable to receive initial data for probe: {err:?=
}.\n"
>> > +                );
>> > +                // SAFETY: `sdev.as_raw()` is guaranteed to be a vali=
d pointer to `serdev_device`.
>> > +                unsafe { bindings::serdev_device_set_client_ops(sdev.=
as_raw(), Self::NO_OPS) };
>> > +                length
>> > +            }
>> > +        }
>> > +    }

<snip>

> There currently is only one serial device bus driver in the kernel,
> which needs initial data:
> drivers/bluetooth/hci_uart.h
> drivers/bluetooth/hci_ldisc.c
> drivers/bluetooth/hci_serdev.c
>
> This driver retrieves this initial data after probe (not in the probe)
> and then initializes it with a workqueue. Given it is part of the
> kernel, I assume this is the intended behaviour.

In this case I assume the driver has a lock protected buffer in its private
data? Which would be entirely different than what you implement above, no?
