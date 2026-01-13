Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08812EA498
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321283; cv=none; b=ICdCRui5694nJL6XZaFQbQ2R2B/gjqF4mHkyy71ecBPMBU6UjmRxYkJUal7FX3Z5i1sWqyLBrliE7Bgc6og192/2nHWXUZur11QJ6rUmhauDwNqBhY00Fz3E+Kc5nYGC0XL6vKhCR7iKI67GeeWXOOvTX3wFXl0Zt3f8EPF6eEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321283; c=relaxed/simple;
	bh=QedjHwKMK1bwCqd62BK1kNRoeIo/ckTqAShnkRuuPAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LyEwZGqhqlxqxYaCI4dYPXRmHzeZfYSglCSccQGPntbMhMU7BsVpnDkV7dPdAyDpUTzLb5Vt1FVA5jc+yDRNj+7HDDVSkxXn7a2RO0fmEFhGY7xIgTSqmSm75YFaI2UcSoTGBt6/cxMpXCveB/mWueMdEMWobLx1192wuC5/Z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=OBAMakFn; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="OBAMakFn"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3D167240104
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 17:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1768320933; bh=Dq7A5ijKDXsyk5CY8zZIt5XqggCoWqHBdReeQoHszaA=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=OBAMakFnJTWobGg3ahVgLzCSYfCaX1B9X0Av2CNhiL6dh3xcXe38Au3zxPoMxkpb1
	 6ZHMkO1SWXuqaXxk7gkUzv1xAd9+mnEuPH7bv2xdUR6VIrWvy7Lj8doE5LqrCsZhoH
	 Nucr3FWxj+CZ+F3Gcvhd+aCCxqmfLsZzSEQ20RdRXBvzeE/bNCvBHMG8WhNIdVxQ8J
	 iVt5ZP4k608bTxi+Ml0UHEQj/N6jn3O5HV27aWpRHmYJlpzLE1MKHkxsivhmqIKPBc
	 F/gscSPO2GqYIUK5jw53FIfFO7Zq8adPR0hzDUtdYrTiGsqqCpcJOmGzwNS7CWPSrJ
	 22k7cRmGKlA/w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4drDqj53zyz9rxW;
	Tue, 13 Jan 2026 17:15:29 +0100 (CET)
Message-ID: <76491897ad6e0ff2749935c39702b93adc9951d6.camel@posteo.de>
Subject: Re: [PATCH RFC 2/4] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Kari Argillander <kari.argillander@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda	 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Date: Tue, 13 Jan 2026 16:15:31 +0000
In-Reply-To: <CAC=eVgSmD+bYh48gZteAaqwSHvcHes3CFmbUUBu=6UQ6fKCUJg@mail.gmail.com>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
	 <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
	 <CAC=eVgSmD+bYh48gZteAaqwSHvcHes3CFmbUUBu=6UQ6fKCUJg@mail.gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-hGeqApWjMDwbKh1QvrbP"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-hGeqApWjMDwbKh1QvrbP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-25 at 17:13 +0200, Kari Argillander wrote:
> On 20.12.2025 klo 20.44 Markus Probst (markus.probst@posteo.de) kirjoitti=
:
> >=20
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
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index a067038b4b42..bec6c6d0913a 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -79,6 +79,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/sched.h>
> >  #include <linux/security.h>
> > +#include <linux/serdev.h>
> >  #include <linux/slab.h>
> >  #include <linux/task_work.h>
> >  #include <linux/tracepoint.h>
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 79c72762ad9c..834e9fbb897d 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -50,6 +50,7 @@
> >  #include "regulator.c"
> >  #include "scatterlist.c"
> >  #include "security.c"
> > +#include "serdev.c"
> >  #include "signal.c"
> >  #include "slab.c"
> >  #include "spinlock.c"
> > diff --git a/rust/helpers/serdev.c b/rust/helpers/serdev.c
> > new file mode 100644
> > index 000000000000..c52b78ca3fc7
> > --- /dev/null
> > +++ b/rust/helpers/serdev.c
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/serdev.h>
> > +
> > +__rust_helper
> > +void rust_helper_serdev_device_driver_unregister(struct serdev_device_=
driver *sdrv)
> > +{
> > +       serdev_device_driver_unregister(sdrv);
> > +}
> > +
> > +__rust_helper
> > +void rust_helper_serdev_device_put(struct serdev_device *serdev)
> > +{
> > +       serdev_device_put(serdev);
> > +}
> > +
> > +__rust_helper
> > +void rust_helper_serdev_device_set_client_ops(struct serdev_device *se=
rdev,
> > +                                             const struct serdev_devic=
e_ops *ops)
> > +{
> > +       serdev_device_set_client_ops(serdev, ops);
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index f812cf120042..cc71195466b6 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -136,6 +136,8 @@
> >  pub mod scatterlist;
> >  pub mod security;
> >  pub mod seq_file;
> > +#[cfg(CONFIG_SERIAL_DEV_BUS)]
> > +pub mod serdev;
> >  pub mod sizes;
> >  pub mod slice;
> >  mod static_assert;
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > new file mode 100644
> > index 000000000000..0f5ef325a054
> > --- /dev/null
> > +++ b/rust/kernel/serdev.rs
> > @@ -0,0 +1,815 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Abstractions for the serial device bus.
> > +//!
> > +//! C header: [`include/linux/serdev.h`](srctree/include/linux/serdev.=
h)
> > +
> > +use crate::{
> > +    acpi,
> > +    container_of,
> > +    device,
> > +    driver,
> > +    error::{
> > +        from_result,
> > +        to_result,
> > +        VTABLE_DEFAULT_ERROR, //
> > +    },
> > +    of,
> > +    prelude::*,
> > +    time::Jiffies,
> > +    types::{AlwaysRefCounted, Opaque}, //
> > +};
> > +
> > +use core::{
> > +    cell::UnsafeCell,
> > +    marker::PhantomData,
> > +    mem::offset_of,
> > +    num::NonZero,
> > +    ptr::{
> > +        addr_of_mut, //
> > +        NonNull,
> > +    }, //
> > +};
> > +
> > +/// Parity bit to use with a serial device.
> > +#[repr(u32)]
> > +pub enum Parity {
> > +    /// No parity bit.
> > +    None =3D bindings::serdev_parity_SERDEV_PARITY_NONE,
> > +    /// Even partiy.
> > +    Even =3D bindings::serdev_parity_SERDEV_PARITY_EVEN,
> > +    /// Odd parity.
> > +    Odd =3D bindings::serdev_parity_SERDEV_PARITY_ODD,
> > +}
> > +
> > +/// Timeout in Jiffies.
> > +pub enum Timeout {
> > +    /// Wait for a specific amount of [`Jiffies`].
> > +    Value(NonZero<Jiffies>),
> > +    /// Wait as long as possible.
> > +    ///
> > +    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
> > +    MaxScheduleTimeout,
> > +}
> > +
> > +impl Timeout {
> > +    fn into_jiffies(self) -> isize {
> > +        match self {
> > +            Self::Value(value) =3D> value.get().try_into().unwrap_or_d=
efault(),
> > +            Self::MaxScheduleTimeout =3D> 0,
> > +        }
> > +    }
> > +}
> > +
> > +/// An adapter for the registration of serial device bus device driver=
s.
> > +pub struct Adapter<T: Driver>(T);
> > +
> > +// SAFETY: A call to `unregister` for a given instance of `RegType` is=
 guaranteed to be valid if
> > +// a preceding call to `register` has been successful.
> > +unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T=
> {
> > +    type RegType =3D bindings::serdev_device_driver;
> > +
> > +    unsafe fn register(
> > +        sdrv: &Opaque<Self::RegType>,
> > +        name: &'static CStr,
> > +        module: &'static ThisModule,
> > +    ) -> Result {
> > +        let of_table =3D match T::OF_ID_TABLE {
> > +            Some(table) =3D> table.as_ptr(),
> > +            None =3D> core::ptr::null(),
> > +        };
> > +
> > +        let acpi_table =3D match T::ACPI_ID_TABLE {
> > +            Some(table) =3D> table.as_ptr(),
> > +            None =3D> core::ptr::null(),
> > +        };
> > +
> > +        // SAFETY: It's safe to set the fields of `struct serdev_devic=
e_driver` on initialization.
> > +        unsafe {
> > +            (*sdrv.get()).driver.name =3D name.as_char_ptr();
> > +            (*sdrv.get()).probe =3D Some(Self::probe_callback);
> > +            (*sdrv.get()).remove =3D Some(Self::remove_callback);
> > +            (*sdrv.get()).driver.of_match_table =3D of_table;
> > +            (*sdrv.get()).driver.acpi_match_table =3D acpi_table;
> > +        }
> > +
> > +        // SAFETY: `sdrv` is guaranteed to be a valid `RegType`.
> > +        to_result(unsafe { bindings::__serdev_device_driver_register(s=
drv.get(), module.0) })
> > +    }
> > +
> > +    unsafe fn unregister(sdrv: &Opaque<Self::RegType>) {
> > +        // SAFETY: `sdrv` is guaranteed to be a valid `RegType`.
> > +        unsafe { bindings::serdev_device_driver_unregister(sdrv.get())=
 };
> > +    }
> > +}
> > +
> > +#[pin_data]
> > +struct Drvdata<T: Driver + 'static> {
> > +    #[pin]
> > +    driver: T,
> > +    initial_data: UnsafeCell<Option<T::InitialData>>,
> > +    late_probe_data: UnsafeCell<Option<Pin<KBox<T::LateProbeData>>>>,
> > +}
> > +
> > +impl<T: Driver + 'static> Adapter<T> {
> > +    const OPS: &'static bindings::serdev_device_ops =3D &bindings::ser=
dev_device_ops {
> > +        receive_buf: if T::HAS_RECEIVE {
> > +            Some(Self::receive_buf_callback)
> > +        } else {
> > +            None
> > +        },
> > +        write_wakeup: if T::HAS_WRITE_WAKEUP {
> > +            Some(Self::write_wakeup_callback)
> > +        } else {
> > +            Some(bindings::serdev_device_write_wakeup)
> > +        },
> > +    };
> > +    const INITIAL_OPS: &'static bindings::serdev_device_ops =3D &bindi=
ngs::serdev_device_ops {
> > +        receive_buf: Some(Self::initial_receive_buf_callback),
> > +        write_wakeup: if T::HAS_WRITE_WAKEUP_INITIAL {
> > +            Some(Self::initial_write_wakeup_callback)
> > +        } else {
> > +            Some(bindings::serdev_device_write_wakeup)
> > +        },
> > +    };
> > +    const NO_OPS: &'static bindings::serdev_device_ops =3D &bindings::=
serdev_device_ops {
> > +        receive_buf: None,
> > +        write_wakeup: Some(bindings::serdev_device_write_wakeup),
> > +    };
> > +
> > +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -=
> kernel::ffi::c_int {
> > +        // SAFETY: The serial device bus only ever calls the probe cal=
lback with a valid pointer to
> > +        // a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `probe_callb=
ack()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l>>() };
> > +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_ref())=
;
> > +
> > +        from_result(|| {
> > +            let data =3D try_pin_init!(Drvdata {
> > +                driver <- T::probe(sdev, info),
> > +                initial_data: Some(Default::default()).into(),
> > +                late_probe_data: None.into(),
> > +            });
> > +
> > +            sdev.as_ref().set_drvdata(data)?;
> > +
> > +            // SAFETY: We just set drvdata to `Drvdata<T>`.
> > +            let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvda=
ta<T>>() };
> > +
> > +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid poi=
nter to `serdev_device`.
> > +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_ra=
w(), Self::INITIAL_OPS) };
> > +
> > +            // SAFETY: The serial device bus only ever calls the probe=
 callback with a valid pointer
> > +            // to a `struct serdev_device`.
> > +            to_result(unsafe {
> > +                bindings::devm_serdev_device_open(sdev.as_ref().as_raw=
(), sdev.as_raw())
> > +            })?;
> > +
> > +            // SAFETY: `&data.driver` is guaranteed to be pinned.
> > +            T::configure(sdev, unsafe { Pin::new_unchecked(&data.drive=
r) }, info)?;
> > +
> > +            if !T::HAS_RECEIVE_INITIAL {
> > +                // SAFETY:
> > +                // - It is guaranteed that we have exclusive access to=
 `data.initial_data` and
> > +                //   `data.late_probe_data`.
> > +                // - We just initialized `data.initial_data` with Some=
.
> > +                unsafe { Self::do_late_probe(sdev, data)? };
> > +            }
> > +
> > +            Ok(0)
> > +        })
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// The caller must guarantee, that we have exclusive access to `d=
ata.initial_data` and
> > +    /// `data.late_probe_data`. `data.initial_data` must be Some.
> > +    /// (i. e. `late_probe` has not been called yet).
> > +    unsafe fn do_late_probe(sdev: &Device<device::CoreInternal>, data:=
 Pin<&Drvdata<T>>) -> Result {
> > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> > +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) =
};
> > +
> > +        // SAFETY: The function contract guarantees that we have exclu=
sive access to
> > +        // `data.initial_data`.
> > +        let initial_data =3D unsafe { &mut *data.initial_data.get() };
> > +
> > +        // SAFETY: The function contract guarantees that we have exclu=
sive access to
> > +        // `data.late_probe_data`.
> > +        let late_probe_data =3D unsafe { &mut *data.late_probe_data.ge=
t() };
> > +
> > +        *late_probe_data =3D Some(KBox::pin_init(
> > +            T::late_probe(
> > +                sdev,
> > +                data_driver,
> > +                // SAFETY: The function contract guarantees that `data=
.initial_data` is Some.
> > +                unsafe { initial_data.take().unwrap_unchecked() },
> > +            ),
> > +            GFP_KERNEL,
> > +        )?);
> > +        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer=
 to `serdev_device`.
> > +        unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(),=
 Self::OPS) };
> > +        Ok(())
> > +    }
> > +
> > +    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) =
{
> > +        // SAFETY: The serial device bus only ever calls the remove ca=
llback with a valid pointer
> > +        // to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `remove_call=
back()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l>>() };
> > +
> > +        // SAFETY: `remove_callback` is only ever called after a succe=
ssful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<T>>`.
> > +        let data =3D unsafe { sdev.as_ref().drvdata_obtain::<Drvdata<T=
>>() };
> > +
> > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> > +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) =
};
> > +
> > +        // SAFETY:
> > +        // - `data.late_probe_data` is guaranteed to be pinned.
> > +        // - It is guaranteed that we have exclusive access to `data.l=
ate_probe_data`.
> > +        let late_probe_data =3D unsafe {
> > +            (*data.late_probe_data.get())
> > +                .as_deref()
> > +                .map(|data| Pin::new_unchecked(data))
> > +        };
> > +
> > +        T::unbind(sdev, data_driver, late_probe_data);
> > +    }
> > +
> > +    extern "C" fn receive_buf_callback(
> > +        sdev: *mut bindings::serdev_device,
> > +        buf: *const u8,
> > +        length: usize,
> > +    ) -> usize {
> > +        // SAFETY: The serial device bus only ever calls the receive b=
uf callback with a valid
> > +        // pointer to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `receive_buf=
_callback()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l>>() };
> > +
> > +        // SAFETY: `receive_buf_callback` is only ever called after a =
successful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T=
>>() };
> > +
> > +        // SAFETY: `buf` is guaranteed to be non-null and has the size=
 of `length`.
> > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) =
};
> > +
> > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> > +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) =
};
> > +
> > +        // SAFETY:
> > +        // - `data.late_probe_data` is guaranteed to be Some.
> > +        // - `data.late_probe_data` is guaranteed to be pinned.
> > +        let late_probe_data =3D unsafe {
> > +            Pin::new_unchecked((*data.late_probe_data.get()).as_deref(=
).unwrap_unchecked())
> > +        };
> > +
> > +        T::receive(sdev, data_driver, late_probe_data, buf)
> > +    }
> > +
> > +    extern "C" fn write_wakeup_callback(sdev: *mut bindings::serdev_de=
vice) {
> > +        // SAFETY: The serial device bus only ever calls the write wak=
eup callback with a valid
> > +        // pointer to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `write_wakeu=
p_callback()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l>>() };
> > +
> > +        // SAFETY: `write_wakeup_callback` is only ever called after a=
 successful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T=
>>() };
> > +
> > +        // SAFETY: `sdev.as_raw()` is guaranteed to be a pointer to a =
valid `serdev_device`.
> > +        unsafe { bindings::serdev_device_write_wakeup(sdev.as_raw()) }=
;
> > +
> > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> > +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) =
};
> > +
> > +        // SAFETY:
> > +        // - `data.late_probe_data` is guaranteed to be Some.
> > +        // - `data.late_probe_data` is guaranteed to be pinned.
> > +        let late_probe_data =3D unsafe {
> > +            Pin::new_unchecked((*data.late_probe_data.get()).as_deref(=
).unwrap_unchecked())
> > +        };
> > +
> > +        // SAFETY: As long as the driver implementation meets the safe=
ty requirements, this call
> > +        // is safe.
> > +        unsafe { T::write_wakeup(sdev, data_driver, late_probe_data) }=
;
> > +    }
> > +
> > +    extern "C" fn initial_receive_buf_callback(
> > +        sdev: *mut bindings::serdev_device,
> > +        buf: *const u8,
> > +        length: usize,
> > +    ) -> usize {
> > +        if !T::HAS_RECEIVE_INITIAL {
> > +            return 0;
> > +        }
> > +
> > +        // SAFETY: The serial device bus only ever calls the receive b=
uf callback with a valid
> > +        // pointer to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `receive_buf=
_callback()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l>>() };
> > +
> > +        // SAFETY: `buf` is guaranteed to be non-null and has the size=
 of `length`.
> > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) =
};
> > +
> > +        // SAFETY: `initial_receive_buf_callback` is only ever called =
after a successful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T=
>>() };
> > +
> > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> > +        let driver_data =3D unsafe { Pin::new_unchecked(&data.driver) =
};
> > +
> > +        // SAFETY:
> > +        // - `data.initial_data` is always Some until `InitialReceiveR=
esult::Ready` is
> > +        //   returned below.
> > +        // - It is guaranteed that we have exclusive access to `data.i=
nitial_data`.
> > +        let initial_data =3D unsafe { (*data.initial_data.get()).as_mu=
t().unwrap_unchecked() };
> > +
> > +        match T::receive_initial(sdev, driver_data, initial_data, buf)=
 {
> > +            Ok(InitialReceiveResult::Pending(size)) =3D> size,
> > +            Ok(InitialReceiveResult::Ready(size)) =3D> {
> > +                // SAFETY:
> > +                // - It is guaranteed that we have exclusive access to=
 `data.initial_data` and
> > +                //   `data.late_probe_data`.
> > +                // - We just initialized `data.initial_data` with Some=
.
> > +                if let Err(err) =3D unsafe { Self::do_late_probe(sdev,=
 data) } {
> > +                    dev_err!(sdev.as_ref(), "Unable to late probe devi=
ce: {err:?}\n");
> > +                    // SAFETY: `sdev.as_raw()` is guaranteed to be a v=
alid pointer to
> > +                    // `serdev_device`.
> > +                    unsafe { bindings::serdev_device_set_client_ops(sd=
ev.as_raw(), Self::NO_OPS) };
> > +                    return length;
> > +                }
> > +                size
> > +            }
> > +            Err(err) =3D> {
> > +                dev_err!(
> > +                    sdev.as_ref(),
> > +                    "Unable to receive initial data for probe: {err:?}=
.\n"
> > +                );
> > +                // SAFETY: `sdev.as_raw()` is guaranteed to be a valid=
 pointer to `serdev_device`.
> > +                unsafe { bindings::serdev_device_set_client_ops(sdev.a=
s_raw(), Self::NO_OPS) };
> > +                length
> > +            }
> > +        }
> > +    }
> > +
> > +    extern "C" fn initial_write_wakeup_callback(sdev: *mut bindings::s=
erdev_device) {
> > +        // SAFETY: The serial device bus only ever calls the write wak=
eup callback with a valid
> > +        // pointer to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `write_wakeu=
p_callback()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l>>() };
> > +
> > +        // SAFETY: `initial_write_wakeup_callback` is only ever called=
 after a successful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T=
>>() };
> > +
> > +        // SAFETY: `sdev.as_raw()` is guaranteed to be a pointer to a =
valid `serdev_device`.
> > +        unsafe { bindings::serdev_device_write_wakeup(sdev.as_raw()) }=
;
> > +
> > +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> > +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) =
};
> > +
> > +        // SAFETY: As long as the driver implementation meets the safe=
ty requirements, this call
> > +        // is safe.
> > +        unsafe { T::write_wakeup_initial(sdev, data_driver) };
> > +    }
> > +}
> > +
> > +impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
> > +    type IdInfo =3D T::IdInfo;
> > +
> > +    fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
> > +        T::OF_ID_TABLE
> > +    }
> > +
> > +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
> > +        T::ACPI_ID_TABLE
> > +    }
> > +}
> > +
> > +/// Declares a kernel module that exposes a single serial device bus d=
evice driver.
> > +///
> > +/// # Examples
> > +///
> > +/// ```ignore
> > +/// kernel::module_serdev_device_driver! {
> > +///     type: MyDriver,
> > +///     name: "Module name",
> > +///     authors: ["Author name"],
> > +///     description: "Description",
> > +///     license: "GPL v2",
> > +/// }
> > +/// ```
> > +#[macro_export]
> > +macro_rules! module_serdev_device_driver {
> > +    ($($f:tt)*) =3D> {
> > +        $crate::module_driver!(<T>, $crate::serdev::Adapter<T>, { $($f=
)* });
> > +    };
> > +}
> > +
> > +/// Result for `receive_initial` in [`Driver`].
> > +pub enum InitialReceiveResult {
> > +    /// More data is required.
> > +    ///
> > +    /// The inner data is the number of bytes accepted.
> > +    Pending(usize),
> > +    /// Ready for late probe.
> > +    ///
> > +    /// The inner data is the number of bytes accepted.
> > +    Ready(usize),
> > +}
> > +
> > +/// The serial device bus device driver trait.
> > +///
> > +/// Drivers must implement this trait in order to get a serial device =
bus device driver registered.
> > +///
> > +/// # Examples
> > +///
> > +///```
> > +/// # use kernel::{
> > +///     acpi,
> > +///     bindings,
> > +///     device::{
> > +///         Bound,
> > +///         Core, //
> > +///     },
> > +///     of,
> > +///     serdev, //
> > +/// };
> > +///
> > +/// struct MyDriver;
> > +///
> > +/// kernel::of_device_table!(
> > +///     OF_TABLE,
> > +///     MODULE_OF_TABLE,
> > +///     <MyDriver as serdev::Driver>::IdInfo,
> > +///     [
> > +///         (of::DeviceId::new(c"test,device"), ())
> > +///     ]
> > +/// );
> > +///
> > +/// kernel::acpi_device_table!(
> > +///     ACPI_TABLE,
> > +///     MODULE_ACPI_TABLE,
> > +///     <MyDriver as serdev::Driver>::IdInfo,
> > +///     [
> > +///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
> > +///     ]
> > +/// );
> > +///
> > +/// #[vtable]
> > +/// impl serdev::Driver for MyDriver {
> > +///     type IdInfo =3D ();
> > +///     type LateProbeData =3D ();
> > +///     type InitialData =3D ();
> > +///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(=
&OF_TABLE);
> > +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D S=
ome(&ACPI_TABLE);
> > +///
> > +///     fn probe(
> > +///         _sdev: &serdev::Device,
> > +///         _id_info: Option<&Self::IdInfo>,
> > +///     ) -> impl PinInit<Self, Error> {
> > +///         Err(ENODEV)
> > +///     }
> > +///
> > +///     fn configure(
> > +///         dev: &serdev::Device<Core>,
> > +///         _this: Pin<&Self>,
> > +///         _id_info: Option<&Self::IdInfo>,
> > +///     ) -> Result {
> > +///         dev.set_baudrate(115200);
> > +///         Ok(())
> > +///     }
> > +///
> > +///     fn late_probe(
> > +///        _dev: &serdev::Device<Bound>,
> > +///        _this: Pin<&Self>,
> > +///        _initial_data: Self::InitialData,
> > +///    ) -> impl PinInit<Self::LateProbeData, Error> {
> > +///        Ok(())
> > +///    }
> > +/// }
> > +///```
> > +#[vtable]
> > +pub trait Driver: Send {
> > +    /// The type holding driver private data about each device id supp=
orted by the driver.
> > +    // TODO: Use associated_type_defaults once stabilized:
> > +    //
> > +    // ```
> > +    // type IdInfo: 'static =3D ();
> > +    // type LateProbeData: Send + 'static =3D ();
> > +    // type InitialData: Default + Send + 'static =3D ();
> > +    // ```
> > +    type IdInfo: 'static;
> > +
> > +    /// Data returned in `late_probe` function.
> > +    type LateProbeData: Send + 'static;
> > +    /// Data used for initial data.
> > +    type InitialData: Default + Send + 'static;
> > +
> > +    /// The table of OF device ids supported by the driver.
> > +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D None;
> > +
> > +    /// The table of ACPI device ids supported by the driver.
> > +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D None;
> > +
> > +    /// Serial device bus device driver probe.
> > +    ///
> > +    /// Called when a new serial device bus device is added or discove=
red.
> > +    /// Implementers should attempt to initialize the device here.
> > +    fn probe(sdev: &Device, id_info: Option<&Self::IdInfo>) -> impl Pi=
nInit<Self, Error>;
> > +
> > +    /// Serial device bus device driver configure.
> > +    ///
> > +    /// Called directly after the serial device bus device has been op=
ened.
> > +    /// This should be used for setting up the communication (i. e. ba=
udrate, flow control, parity)
> > +    /// and sending an initial hello if required.
> > +    fn configure(
> > +        sdev: &Device<device::Core>,
> > +        this: Pin<&Self>,
> > +        id_info: Option<&Self::IdInfo>,
> > +    ) -> Result;
> > +
> > +    /// Serial device bus device data receive callback (initial).
> > +    ///
> > +    /// Called when data got received from device, before `late_probe`=
 has been called.
> > +    /// This should be used, to get information about the device for `=
late_probe`.
> > +    ///
> > +    /// Returns `InitialReceiveResult::Pending` if more data is still =
required for `late_probe`.
> > +    /// Otherwise `InitialReceiveResult::Ready`. The inner data is the=
 number of bytes accepted.
> > +    fn receive_initial(
> > +        sdev: &Device<device::Bound>,
> > +        this: Pin<&Self>,
> > +        initial_data: &mut Self::InitialData,
> > +        data: &[u8],
> > +    ) -> Result<InitialReceiveResult> {
> > +        let _ =3D (sdev, this, initial_data, data);
> > +        build_error!(VTABLE_DEFAULT_ERROR)
> > +    }
> > +
> > +    /// Serial device bus device write wakeup callback (initial).
> > +    ///
> > +    /// Called when ready to transmit more data, before `late_probe` h=
as been called.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// This function must not sleep.
> > +    unsafe fn write_wakeup_initial(sdev: &Device<device::Core>, this: =
Pin<&Self>) {
> > +        let _ =3D (sdev, this);
> > +        build_error!(VTABLE_DEFAULT_ERROR)
> > +    }
> > +
> > +    /// Serial device bus device late probe.
> > +    ///
> > +    /// Called after the initial data is available.
> > +    /// If `receive_initial` isn't implemented, this will be called di=
rectly after configure.
> > +    fn late_probe(
> > +        sdev: &Device<device::Bound>,
> > +        this: Pin<&Self>,
> > +        initial_data: Self::InitialData,
> > +    ) -> impl PinInit<Self::LateProbeData, Error>;
> > +
> > +    /// Serial device bus device driver unbind.
> > +    ///
> > +    /// Called when a [`Device`] is unbound from its bound [`Driver`].=
 Implementing this callback
> > +    /// is optional.
> > +    ///
> > +    /// This callback serves as a place for drivers to perform teardow=
n operations that require a
> > +    /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
> > +    ///
> > +    /// Otherwise, release operations for driver resources should be p=
erformed in `Self::drop`.
> > +    fn unbind(
> > +        sdev: &Device<device::Core>,
> > +        this: Pin<&Self>,
> > +        late_probe_this: Option<Pin<&Self::LateProbeData>>,
> > +    ) {
> > +        let _ =3D (sdev, this, late_probe_this);
> > +    }
> > +
> > +    /// Serial device bus device data receive callback.
> > +    ///
> > +    /// Called when data got received from device.
> > +    ///
> > +    /// Returns the number of bytes accepted.
> > +    fn receive(
> > +        sdev: &Device<device::Bound>,
> > +        this: Pin<&Self>,
> > +        late_probe_this: Pin<&Self::LateProbeData>,
> > +        data: &[u8],
> > +    ) -> usize {
> > +        let _ =3D (sdev, this, late_probe_this, data);
> > +        build_error!(VTABLE_DEFAULT_ERROR)
> > +    }
> > +
> > +    /// Serial device bus device write wakeup callback.
> > +    ///
> > +    /// Called when ready to transmit more data.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// This function must not sleep.
> > +    unsafe fn write_wakeup(
> > +        sdev: &Device<device::Bound>,
> > +        this: Pin<&Self>,
> > +        late_probe_this: Pin<&Self::LateProbeData>,
> > +    ) {
> > +        let _ =3D (sdev, this, late_probe_this);
> > +        build_error!(VTABLE_DEFAULT_ERROR)
> > +    }
> > +}
> > +
> > +/// The serial device bus device representation.
> > +///
> > +/// This structure represents the Rust abstraction for a C `struct ser=
dev_device`. The
> > +/// implementation abstracts the usage of an already existing C `struc=
t serdev_device` within Rust
> > +/// code that we get passed from the C side.
> > +///
> > +/// # Invariants
> > +///
> > +/// A [`Device`] instance represents a valid `struct serdev_device` cr=
eated by the C portion of
> > +/// the kernel.
> > +#[repr(transparent)]
> > +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
> > +    Opaque<bindings::serdev_device>,
> > +    PhantomData<Ctx>,
> > +);
> > +
> > +impl<Ctx: device::DeviceContext> Device<Ctx> {
> > +    fn as_raw(&self) -> *mut bindings::serdev_device {
> > +        self.0.get()
> > +    }
> > +}
> > +
> > +impl Device<device::Bound> {
> > +    /// Set the baudrate in bits per second.
> > +    ///
> > +    /// Common baudrates are 115200, 9600, 19200, 57600, 4800.
> > +    ///
> > +    /// Use [`Device::write_flush`] before calling this if you have wr=
itten data prior to this call.
> > +    pub fn set_baudrate(&self, speed: u32) -> u32 {
> > +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a =
valid `serdev_device`.
> > +        unsafe { bindings::serdev_device_set_baudrate(self.as_raw(), s=
peed) }
> > +    }
> > +
> > +    /// Set if flow control should be enabled.
> > +    ///
> > +    /// Use [`Device::write_flush`] before calling this if you have wr=
itten data prior to this call.
> > +    pub fn set_flow_control(&self, enable: bool) {
> > +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a =
valid `serdev_device`.
> > +        unsafe { bindings::serdev_device_set_flow_control(self.as_raw(=
), enable) };
> > +    }
> > +
> > +    /// Set parity to use.
> > +    ///
> > +    /// Use [`Device::write_flush`] before calling this if you have wr=
itten data prior to this call.
> > +    pub fn set_parity(&self, parity: Parity) -> Result {
> > +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a =
valid `serdev_device`.
> > +        to_result(unsafe { bindings::serdev_device_set_parity(self.as_=
raw(), parity as u32) })
> > +    }
> > +
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
> > +
> > +    /// Send data to the serial device immediately.
> > +    ///
> > +    /// Note that this doesn't guarantee that the data has been transm=
itted.
> > +    /// Use [`Device::wait_until_sent`] for this purpose.
> > +    pub fn write_flush(&self) {
> > +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a =
valid `serdev_device`.
> > +        unsafe { bindings::serdev_device_write_flush(self.as_raw()) };
> > +    }
> > +
> > +    /// Wait for the data to be sent.
> > +    ///
> > +    /// After this function, the write buffer of the controller should=
 be empty.
> > +    pub fn wait_until_sent(&self, timeout: Timeout) {
> > +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a =
valid `serdev_device`.
> > +        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw()=
, timeout.into_jiffies()) };
> > +    }
> > +}
> > +
> > +// SAFETY: `serdev::Device` is a transparent wrapper of `struct serdev=
_device`.
> > +// The offset is guaranteed to point to a valid device field inside `s=
erdev::Device`.
> > +unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for D=
evice<Ctx> {
> > +    const OFFSET: usize =3D offset_of!(bindings::serdev_device, dev);
> > +}
> > +
> > +// SAFETY: `Device` is a transparent wrapper of a type that doesn't de=
pend on `Device`'s generic
> > +// argument.
> > +kernel::impl_device_context_deref!(unsafe { Device });
> > +kernel::impl_device_context_into_aref!(Device);
> > +
> > +// SAFETY: Instances of `Device` are always reference-counted.
> > +unsafe impl AlwaysRefCounted for Device {
> > +    fn inc_ref(&self) {
> > +        self.as_ref().inc_ref();
> > +    }
> > +
> > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > +        // SAFETY: The safety requirements guarantee that the refcount=
 is non-zero.
> > +        unsafe { bindings::serdev_device_put(obj.cast().as_ptr()) }
> > +    }
> > +}
> > +
> > +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device=
<Ctx> {
> > +    fn as_ref(&self) -> &device::Device<Ctx> {
> > +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is=
 a pointer to a valid
> > +        // `struct serdev_device`.
> > +        let dev =3D unsafe { addr_of_mut!((*self.as_raw()).dev) };
> > +
> > +        // SAFETY: `dev` points to a valid `struct device`.
> > +        unsafe { device::Device::from_raw(dev) }
> > +    }
> > +}
> > +
> > +impl<Ctx: device::DeviceContext> TryFrom<&device::Device<Ctx>> for &De=
vice<Ctx> {
> > +    type Error =3D kernel::error::Error;
> > +
> > +    fn try_from(dev: &device::Device<Ctx>) -> Result<Self, Self::Error=
> {
> > +        // SAFETY: By the type invariant of `Device`, `dev.as_raw()` i=
s a valid pointer to a
> > +        // `struct device`.
> > +        if !unsafe { bindings::is_serdev_device(dev.as_raw()) } {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        // SAFETY: We've just verified that the device_type of `dev` i=
s
> > +        // `serdev_device_type`, hence `dev` must be embedded in a val=
id `struct
> > +        // serdev_device_driver` as guaranteed by the corresponding C =
code.
> > +        let sdev =3D unsafe { container_of!(dev.as_raw(), bindings::se=
rdev_device, dev) };
> > +
> > +        // SAFETY: `sdev` is a valid pointer to a `struct serdev_devic=
e_driver`.
> > +        Ok(unsafe { &*sdev.cast() })
> > +    }
> > +}
> > +
> > +// SAFETY: A `Device` is always reference-counted and can be released =
from any thread.
> > +unsafe impl Send for Device {}
> > +
> > +// SAFETY: `Device` can be shared among threads because all methods of=
 `Device`
> > +// (i.e. `Device<Normal>) are thread safe.
> > +unsafe impl Sync for Device {}
> >=20
> > --
> > 2.51.2
> >=20
> >=20
>=20
> Currently I'm not a huge fan that we need to have configure(),
> receive_initial(), write_wakeup_initial() and late_probe(). Also I do not
> like that we hide hide open() completely from user. Maybe user want's to =
do
> something if there is error. This does not feel very ergonomic or standar=
d
> kernel way. So after thinking a bit more about this idea I have come up w=
ith
> a different approach.
>=20
> We will have just probe() as usual. In probe() user will be forced to do =
open()
> and finnish() on serdev device. Between open() and finnish() user can
> configure the device and do initial reads / writes as needed. After probe=
 is
> finished we will switch to runtime ops.
>=20
> This is not production ready code and I have just tested the idea locally
> without kernel. Here is example how probe() could look like:
>=20
> ```rust
> fn probe(sdev: &serdev::Device<Core>, _id_info:
> Option<&Self::IdInfo>)-> impl PinInit<(Self, ProbeEndToken), Error> {
>     let sdev=3D sdev.open()?;
>     // After open we can configure and do initial reads / writes.
>     sdev.set_baudrate(9600);
>=20
>     // Here we can also write if needed.
>=20
>     for _ in 0..8 {
>         // For initial reads we will have iterator. This cannot be
> done after finish().
>         let _ =3D sdev.next_byte(Duration::from_millis(300));
>     }
>=20
>     // We do finnish so user cannot store "initial sdev" anywhere. Also g=
et
>     // end_token so probe cannot return unless open() and finnish() are c=
alled.
>     let (sdev, end_token) =3D sdev.finish();
>     Ok(try_pin_init!((Self {sdev}, end_token)))
> }
> ```
>=20
> then our receive_initial will look something like this. (Not runnable
> on kernel).
> Idea is that we have event for next_byte(). So initial read is little bit=
 slower
> but that should not be used so much that it matters in practice.
>=20
> ```rust
> extern "C" fn initial_receive_buf(dev: *mut serdev_device, buf: *const
> u8, count: usize) -> usize {
>     let abs =3D unsafe { &mut *((*dev).client_data as *mut Abstraction) }=
;
>=20
>     let mut consumed =3D 0usize;
>=20
>     loop {
>         // Wait until we can either switch or deliver one byte (slot
> must be empty).
>         let mut st =3D abs.st.lock().unwrap();
>         while !st.probe_finished && !(st.want_byte && st.slot.is_none()) =
{
>             st =3D abs.ev.wait(st).unwrap();
>         }
>=20
>         if st.probe_finished {
>             // TODO: Do we lock write lock so it is really safe to
> change OPS here?
>             unsafe { bindings::serdev_device_set_client_ops(dev,
> &RUNTIME_OPS) };
>=20
>             // Forward the *remaining* bytes that we have NOT taken
> out of this buf.
>             let rem_ptr =3D unsafe { buf.add(consumed) };
>             let rem =3D count - consumed;
>             return consumed + Self::runtime_receive_buf(dev, rem_ptr, rem=
);
>         }
>=20
>         // Deliver exactly one byte to iterator (slot is empty here).
>         let b =3D unsafe { *buf.add(consumed) };
>         st.slot =3D Some(b);
>         // wake next_byte()
>         abs.ev.notify_all();
>=20
>         // Now WAIT until next_byte really consumes it (slot becomes None=
),
>         // or probe finishes (in which case we=E2=80=99ll flush it to run=
time).
>         while !st.probe_finished && st.slot.is_some() {
>             st =3D abs.ev.wait(st).unwrap();
>         }
>         if st.probe_finished {
>             continue;
>         }
>=20
>         // Now it is truly consumed by next_byte().
>         consumed +=3D 1;
>         if consumed =3D=3D count {
>             return count;
>         }
>     }
> }
> ```
>=20
> Does anyone have opinions which is better or is there some other way
> for this which
> we have not yet discovered?

I am not sure if using this approach is intended by the serdev
subsystem. Otherwise I assume there already would be a C function in
the subsystem for reading and waiting for data on probe.

There currently is only one serial device bus driver in the kernel,
which needs initial data:
drivers/bluetooth/hci_uart.h
drivers/bluetooth/hci_ldisc.c
drivers/bluetooth/hci_serdev.c

This driver retrieves this initial data after probe (not in the probe)
and then initializes it with a workqueue. Given it is part of the
kernel, I assume this is the intended behaviour.

@Danilo: Can you share your opinion on this?

Thanks
- Markus Probst

--=-hGeqApWjMDwbKh1QvrbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmlmb5gbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPS+0MP/3jm/ipfMf+ZxHQL2lJO
UWpnwwiMpPEOd0yNKx/EyEs/m8+KUJqlaQJcdWOmLJP4IEjkRlUdSh55mlsFCo5h
EZoAeR4NAkGgQaTWbcAYPjAgIESqcgb56V+giSRZWXurFinuGbXRmyIpNT2hTZYJ
h1Arrr9QMnC+ew8dy0uK/ybY1c+nSOUCLa5CtsqwjUNUpGxeyzi6Feoob4jcUGPF
0D78ayTeUSfI2RsryoPuimhOLHLUlEbB6neF4Lynzox+TfHXz1r+E4mAi2buN0Ia
M6WFsnRwcRZpVTo6jCtB6A9EzR51DH+y6sBR9hdD6/wAHBsOtzD2bTgkjh9vv7I0
QReGFNUOLdLXrLWOZKdVbQBxsC3nh3t0GVqpoHkAaMEUQqZtoS5zpmvEvKUcsJv9
BdZQI+jE2dK+PtglOLQnVrPgWUuouHHCjgNPUu2eo/od40H2la/btR9j11xGCqaA
2lE81UFGvaK1UsRnyVjBP3faADxqN9LhiGxDyY5azDgZmwLpcg3ROkLrdqkA3zlQ
dvJHOnyh4jFZjosKfzbAYps/icm/0Ice3yygeYSLb1Xaqf1Bun6cuODeHw+uKZdw
mH8MLTSO1xDv/FEY29PelDTlzbP0ziM81NeaGy1srrWF+qO5nFzT/wSJLYbU5T4t
ELvh+y3y1XOSLTIgITz1VCUE
=aa1r
-----END PGP SIGNATURE-----

--=-hGeqApWjMDwbKh1QvrbP--

