Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5032573F
	for <linux-serial@vger.kernel.org>; Thu, 25 Dec 2025 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766675608; cv=none; b=frxAvXkvsG+UNBhoZ8uF420ixP6YYSKwI8Mt1zKmy4VdO4hpYKqJgr7CllCV/OQ1LklhipHk5OkUqwuT86gBEEps+KrQ/PtqVDX6Sr+SLo1ZEz42KyrX0/M7oPE59108vtsj1Vu7wLKA0+lXG1X0esuWxUgYvz21ml3SehYHeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766675608; c=relaxed/simple;
	bh=JIqisi1vufngFYXptwuppWO3XDlnKyKhSAnGL3vypPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7e/NeirPS/r2bG6enb4i196twbbOrI3UvnSflSx+7m9DKWantU/L6C3O3glp0re/HcHLdhvaVrPXM+gkmeVOW+C3/W5RueXxUpdDCqYOVmOB2iWW24sawrEy1oOZ5cr+bkPhCNz+yFO4W9tlZH/9YUqeKnP+tSRKkEvmoNB49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOVSySmy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOVSySmy"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so7013066b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 25 Dec 2025 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766675605; x=1767280405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pyl5lg4Yl4r51Pe2uzolQdz2JMhX2ozLY8vfkU++A0=;
        b=WOVSySmyTrz3yKIvcEsd/V2Li+uXNfMZ9W++OXgn6eNTqfeMwJiM1Asrg0W3VKAjBd
         KyHk9fsI8KNc3U9c59lzMNw8mEqMFgVSq6WuyTJ2uoktTXM5U35EHFhJatBQpyAcj/bZ
         h1A/L+NYgZd8Evn4mD7vWTzJCvmd8lCoUMwbF/1AIwaECQGKdR5sgj7pwKpofH1+Ti45
         K/5pDaAcR3bwfnUtMdtLAcsAISBpRUGvLOkliCmpXTr93IeUXBvWJ1xlfrqNUtT2vLAY
         au3+FZYrtOJRaHF/W7bXOFrSDo/H94DZOmjGsxNdOAurdnDgY7NJ1WogVjTMMiLH4V/y
         57uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766675605; x=1767280405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Pyl5lg4Yl4r51Pe2uzolQdz2JMhX2ozLY8vfkU++A0=;
        b=HGe/18aIaBCiyh9o4kBhc0MnvF7s29ncVSuajwQlmAIMJRkpmkEQ9n5EeUC4HvsbOK
         3rCub9MSXApuhLHmji/YMMDEzbG8CDgnthUBAPmKvhzYfW8O0OE0gaGN9Hnlh15geLqt
         3FlkkBLulktwq6Uv/U33rIPVXrbjOTsXeaMjqV3Mnl79PnEFzBw4RMvT7YxYLD+R2VkW
         ZLCuJn/JMj7Om7KnKROVt2iMp+ifsUq55GmxyxizjHN/0tAMOhPZuGgb0HVLHuYdpYLJ
         RBvnMZTNP60zTkT9aqx0ZaBQsmQkivM7ZY6kP809r20tfjVXrTQmwGiuNeWkGpW+x9Sl
         pWJA==
X-Forwarded-Encrypted: i=1; AJvYcCXwNdo8E2qmH00QSo7JQbZQFcXJFH3N49/E6kA7Ux1cNAGDcuZog6FNw59eZ5b8ahQflnLqReghPxueT/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwYHak/4ZZOHuq+Acu8ZJJbfL7LEDAvdMZaNDMXx9Nj4tR4BYg
	imPkR8hdJGD1A6fIuyaxy9i6kfLmv9wSd1B30OQkRU8hBwZDJRbnNssBbkCTmieOV/t0gs6zAPq
	apjvkbC06OLECy8Vo61CS+pE0C7QHQiY=
X-Gm-Gg: AY/fxX5Nls0fTOBuY22ZbFsqB4k3eXBtg3NICev0dktx0UuAL29OcH1HR2N8VeKvtZH
	vc3ZeXZVq4Ff49KUvFOgxFP53WRT4o6VfguNa93MKUHNajBwSyAWk94+CYuhqR6aFJvUBJgGNDx
	iQLGhby8v3/nC6eGS/DMU9ucQrk/Odk+C4TxZdcDkPd/rsdTE+ns9YKyL0NlcytE2NQCtnQ4Ra/
	XpFo21RstLKzrI11vvqE3lWaoFukpxdWdeKxi7+y2FbtEPdFh4BwkHZbJBZsAaOTLApv+OrFz0w
	DseJunHzrzSUtoDOXz5pXTK4ibuN
X-Google-Smtp-Source: AGHT+IFwnG0pPoIhPxkrU+IV20TyaWNYwU9HtTyc2IdW5Cvz7Gr26QtOUES1lJ8R8cXnpNFzzj38+HQIlR0CM5uLpaE=
X-Received: by 2002:a05:6a20:72a7:b0:35a:80f2:fa3c with SMTP id
 adf61e73a8af0-376a8cbe357mr20935619637.31.1766675604796; Thu, 25 Dec 2025
 07:13:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de> <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
In-Reply-To: <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
From: Kari Argillander <kari.argillander@gmail.com>
Date: Thu, 25 Dec 2025 17:13:08 +0200
X-Gm-Features: AQt7F2ocyoOzegI1cMjgObR4bUxo61MQlmy5-1z_qJm3q_BwKpy6keQboSkX914
Message-ID: <CAC=eVgSmD+bYh48gZteAaqwSHvcHes3CFmbUUBu=6UQ6fKCUJg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] rust: add basic serial device bus abstractions
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 20.12.2025 klo 20.44 Markus Probst (markus.probst@posteo.de) kirjoitti:
>
> Implement the basic serial device bus abstractions required to write a
> serial device bus device driver with or without the need for initial devi=
ce
> data. This includes the following data structures:
>
> The `serdev::Driver` trait represents the interface to the driver.
>
> The `serdev::Device` abstraction represents a `struct serdev_device`.
>
> In order to provide the Serdev specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is
> implemented by `serdev::Adapter`.
>
> Co-developed-by: Kari Argillander <kari.argillander@gmail.com>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/serdev.c           |  22 ++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/serdev.rs           | 815 ++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 841 insertions(+)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index a067038b4b42..bec6c6d0913a 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -79,6 +79,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> +#include <linux/serdev.h>
>  #include <linux/slab.h>
>  #include <linux/task_work.h>
>  #include <linux/tracepoint.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 79c72762ad9c..834e9fbb897d 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -50,6 +50,7 @@
>  #include "regulator.c"
>  #include "scatterlist.c"
>  #include "security.c"
> +#include "serdev.c"
>  #include "signal.c"
>  #include "slab.c"
>  #include "spinlock.c"
> diff --git a/rust/helpers/serdev.c b/rust/helpers/serdev.c
> new file mode 100644
> index 000000000000..c52b78ca3fc7
> --- /dev/null
> +++ b/rust/helpers/serdev.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/serdev.h>
> +
> +__rust_helper
> +void rust_helper_serdev_device_driver_unregister(struct serdev_device_dr=
iver *sdrv)
> +{
> +       serdev_device_driver_unregister(sdrv);
> +}
> +
> +__rust_helper
> +void rust_helper_serdev_device_put(struct serdev_device *serdev)
> +{
> +       serdev_device_put(serdev);
> +}
> +
> +__rust_helper
> +void rust_helper_serdev_device_set_client_ops(struct serdev_device *serd=
ev,
> +                                             const struct serdev_device_=
ops *ops)
> +{
> +       serdev_device_set_client_ops(serdev, ops);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f812cf120042..cc71195466b6 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -136,6 +136,8 @@
>  pub mod scatterlist;
>  pub mod security;
>  pub mod seq_file;
> +#[cfg(CONFIG_SERIAL_DEV_BUS)]
> +pub mod serdev;
>  pub mod sizes;
>  pub mod slice;
>  mod static_assert;
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> new file mode 100644
> index 000000000000..0f5ef325a054
> --- /dev/null
> +++ b/rust/kernel/serdev.rs
> @@ -0,0 +1,815 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for the serial device bus.
> +//!
> +//! C header: [`include/linux/serdev.h`](srctree/include/linux/serdev.h)
> +
> +use crate::{
> +    acpi,
> +    container_of,
> +    device,
> +    driver,
> +    error::{
> +        from_result,
> +        to_result,
> +        VTABLE_DEFAULT_ERROR, //
> +    },
> +    of,
> +    prelude::*,
> +    time::Jiffies,
> +    types::{AlwaysRefCounted, Opaque}, //
> +};
> +
> +use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
> +    mem::offset_of,
> +    num::NonZero,
> +    ptr::{
> +        addr_of_mut, //
> +        NonNull,
> +    }, //
> +};
> +
> +/// Parity bit to use with a serial device.
> +#[repr(u32)]
> +pub enum Parity {
> +    /// No parity bit.
> +    None =3D bindings::serdev_parity_SERDEV_PARITY_NONE,
> +    /// Even partiy.
> +    Even =3D bindings::serdev_parity_SERDEV_PARITY_EVEN,
> +    /// Odd parity.
> +    Odd =3D bindings::serdev_parity_SERDEV_PARITY_ODD,
> +}
> +
> +/// Timeout in Jiffies.
> +pub enum Timeout {
> +    /// Wait for a specific amount of [`Jiffies`].
> +    Value(NonZero<Jiffies>),
> +    /// Wait as long as possible.
> +    ///
> +    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
> +    MaxScheduleTimeout,
> +}
> +
> +impl Timeout {
> +    fn into_jiffies(self) -> isize {
> +        match self {
> +            Self::Value(value) =3D> value.get().try_into().unwrap_or_def=
ault(),
> +            Self::MaxScheduleTimeout =3D> 0,
> +        }
> +    }
> +}
> +
> +/// An adapter for the registration of serial device bus device drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +// SAFETY: A call to `unregister` for a given instance of `RegType` is g=
uaranteed to be valid if
> +// a preceding call to `register` has been successful.
> +unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> =
{
> +    type RegType =3D bindings::serdev_device_driver;
> +
> +    unsafe fn register(
> +        sdrv: &Opaque<Self::RegType>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        let of_table =3D match T::OF_ID_TABLE {
> +            Some(table) =3D> table.as_ptr(),
> +            None =3D> core::ptr::null(),
> +        };
> +
> +        let acpi_table =3D match T::ACPI_ID_TABLE {
> +            Some(table) =3D> table.as_ptr(),
> +            None =3D> core::ptr::null(),
> +        };
> +
> +        // SAFETY: It's safe to set the fields of `struct serdev_device_=
driver` on initialization.
> +        unsafe {
> +            (*sdrv.get()).driver.name =3D name.as_char_ptr();
> +            (*sdrv.get()).probe =3D Some(Self::probe_callback);
> +            (*sdrv.get()).remove =3D Some(Self::remove_callback);
> +            (*sdrv.get()).driver.of_match_table =3D of_table;
> +            (*sdrv.get()).driver.acpi_match_table =3D acpi_table;
> +        }
> +
> +        // SAFETY: `sdrv` is guaranteed to be a valid `RegType`.
> +        to_result(unsafe { bindings::__serdev_device_driver_register(sdr=
v.get(), module.0) })
> +    }
> +
> +    unsafe fn unregister(sdrv: &Opaque<Self::RegType>) {
> +        // SAFETY: `sdrv` is guaranteed to be a valid `RegType`.
> +        unsafe { bindings::serdev_device_driver_unregister(sdrv.get()) }=
;
> +    }
> +}
> +
> +#[pin_data]
> +struct Drvdata<T: Driver + 'static> {
> +    #[pin]
> +    driver: T,
> +    initial_data: UnsafeCell<Option<T::InitialData>>,
> +    late_probe_data: UnsafeCell<Option<Pin<KBox<T::LateProbeData>>>>,
> +}
> +
> +impl<T: Driver + 'static> Adapter<T> {
> +    const OPS: &'static bindings::serdev_device_ops =3D &bindings::serde=
v_device_ops {
> +        receive_buf: if T::HAS_RECEIVE {
> +            Some(Self::receive_buf_callback)
> +        } else {
> +            None
> +        },
> +        write_wakeup: if T::HAS_WRITE_WAKEUP {
> +            Some(Self::write_wakeup_callback)
> +        } else {
> +            Some(bindings::serdev_device_write_wakeup)
> +        },
> +    };
> +    const INITIAL_OPS: &'static bindings::serdev_device_ops =3D &binding=
s::serdev_device_ops {
> +        receive_buf: Some(Self::initial_receive_buf_callback),
> +        write_wakeup: if T::HAS_WRITE_WAKEUP_INITIAL {
> +            Some(Self::initial_write_wakeup_callback)
> +        } else {
> +            Some(bindings::serdev_device_write_wakeup)
> +        },
> +    };
> +    const NO_OPS: &'static bindings::serdev_device_ops =3D &bindings::se=
rdev_device_ops {
> +        receive_buf: None,
> +        write_wakeup: Some(bindings::serdev_device_write_wakeup),
> +    };
> +
> +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> =
kernel::ffi::c_int {
> +        // SAFETY: The serial device bus only ever calls the probe callb=
ack with a valid pointer to
> +        // a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `probe_callbac=
k()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal>=
>() };
> +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_ref());
> +
> +        from_result(|| {
> +            let data =3D try_pin_init!(Drvdata {
> +                driver <- T::probe(sdev, info),
> +                initial_data: Some(Default::default()).into(),
> +                late_probe_data: None.into(),
> +            });
> +
> +            sdev.as_ref().set_drvdata(data)?;
> +
> +            // SAFETY: We just set drvdata to `Drvdata<T>`.
> +            let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata=
<T>>() };
> +
> +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid point=
er to `serdev_device`.
> +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(=
), Self::INITIAL_OPS) };
> +
> +            // SAFETY: The serial device bus only ever calls the probe c=
allback with a valid pointer
> +            // to a `struct serdev_device`.
> +            to_result(unsafe {
> +                bindings::devm_serdev_device_open(sdev.as_ref().as_raw()=
, sdev.as_raw())
> +            })?;
> +
> +            // SAFETY: `&data.driver` is guaranteed to be pinned.
> +            T::configure(sdev, unsafe { Pin::new_unchecked(&data.driver)=
 }, info)?;
> +
> +            if !T::HAS_RECEIVE_INITIAL {
> +                // SAFETY:
> +                // - It is guaranteed that we have exclusive access to `=
data.initial_data` and
> +                //   `data.late_probe_data`.
> +                // - We just initialized `data.initial_data` with Some.
> +                unsafe { Self::do_late_probe(sdev, data)? };
> +            }
> +
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// The caller must guarantee, that we have exclusive access to `dat=
a.initial_data` and
> +    /// `data.late_probe_data`. `data.initial_data` must be Some.
> +    /// (i. e. `late_probe` has not been called yet).
> +    unsafe fn do_late_probe(sdev: &Device<device::CoreInternal>, data: P=
in<&Drvdata<T>>) -> Result {
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY: The function contract guarantees that we have exclusi=
ve access to
> +        // `data.initial_data`.
> +        let initial_data =3D unsafe { &mut *data.initial_data.get() };
> +
> +        // SAFETY: The function contract guarantees that we have exclusi=
ve access to
> +        // `data.late_probe_data`.
> +        let late_probe_data =3D unsafe { &mut *data.late_probe_data.get(=
) };
> +
> +        *late_probe_data =3D Some(KBox::pin_init(
> +            T::late_probe(
> +                sdev,
> +                data_driver,
> +                // SAFETY: The function contract guarantees that `data.i=
nitial_data` is Some.
> +                unsafe { initial_data.take().unwrap_unchecked() },
> +            ),
> +            GFP_KERNEL,
> +        )?);
> +        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer t=
o `serdev_device`.
> +        unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), S=
elf::OPS) };
> +        Ok(())
> +    }
> +
> +    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
> +        // SAFETY: The serial device bus only ever calls the remove call=
back with a valid pointer
> +        // to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `remove_callba=
ck()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal>=
>() };
> +
> +        // SAFETY: `remove_callback` is only ever called after a success=
ful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<T>>`.
> +        let data =3D unsafe { sdev.as_ref().drvdata_obtain::<Drvdata<T>>=
() };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY:
> +        // - `data.late_probe_data` is guaranteed to be pinned.
> +        // - It is guaranteed that we have exclusive access to `data.lat=
e_probe_data`.
> +        let late_probe_data =3D unsafe {
> +            (*data.late_probe_data.get())
> +                .as_deref()
> +                .map(|data| Pin::new_unchecked(data))
> +        };
> +
> +        T::unbind(sdev, data_driver, late_probe_data);
> +    }
> +
> +    extern "C" fn receive_buf_callback(
> +        sdev: *mut bindings::serdev_device,
> +        buf: *const u8,
> +        length: usize,
> +    ) -> usize {
> +        // SAFETY: The serial device bus only ever calls the receive buf=
 callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal>=
>() };
> +
> +        // SAFETY: `receive_buf_callback` is only ever called after a su=
ccessful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>=
() };
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size o=
f `length`.
> +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY:
> +        // - `data.late_probe_data` is guaranteed to be Some.
> +        // - `data.late_probe_data` is guaranteed to be pinned.
> +        let late_probe_data =3D unsafe {
> +            Pin::new_unchecked((*data.late_probe_data.get()).as_deref().=
unwrap_unchecked())
> +        };
> +
> +        T::receive(sdev, data_driver, late_probe_data, buf)
> +    }
> +
> +    extern "C" fn write_wakeup_callback(sdev: *mut bindings::serdev_devi=
ce) {
> +        // SAFETY: The serial device bus only ever calls the write wakeu=
p callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `write_wakeup_=
callback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal>=
>() };
> +
> +        // SAFETY: `write_wakeup_callback` is only ever called after a s=
uccessful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>=
() };
> +
> +        // SAFETY: `sdev.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> +        unsafe { bindings::serdev_device_write_wakeup(sdev.as_raw()) };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY:
> +        // - `data.late_probe_data` is guaranteed to be Some.
> +        // - `data.late_probe_data` is guaranteed to be pinned.
> +        let late_probe_data =3D unsafe {
> +            Pin::new_unchecked((*data.late_probe_data.get()).as_deref().=
unwrap_unchecked())
> +        };
> +
> +        // SAFETY: As long as the driver implementation meets the safety=
 requirements, this call
> +        // is safe.
> +        unsafe { T::write_wakeup(sdev, data_driver, late_probe_data) };
> +    }
> +
> +    extern "C" fn initial_receive_buf_callback(
> +        sdev: *mut bindings::serdev_device,
> +        buf: *const u8,
> +        length: usize,
> +    ) -> usize {
> +        if !T::HAS_RECEIVE_INITIAL {
> +            return 0;
> +        }
> +
> +        // SAFETY: The serial device bus only ever calls the receive buf=
 callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal>=
>() };
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size o=
f `length`.
> +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) };
> +
> +        // SAFETY: `initial_receive_buf_callback` is only ever called af=
ter a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>=
() };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let driver_data =3D unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY:
> +        // - `data.initial_data` is always Some until `InitialReceiveRes=
ult::Ready` is
> +        //   returned below.
> +        // - It is guaranteed that we have exclusive access to `data.ini=
tial_data`.
> +        let initial_data =3D unsafe { (*data.initial_data.get()).as_mut(=
).unwrap_unchecked() };
> +
> +        match T::receive_initial(sdev, driver_data, initial_data, buf) {
> +            Ok(InitialReceiveResult::Pending(size)) =3D> size,
> +            Ok(InitialReceiveResult::Ready(size)) =3D> {
> +                // SAFETY:
> +                // - It is guaranteed that we have exclusive access to `=
data.initial_data` and
> +                //   `data.late_probe_data`.
> +                // - We just initialized `data.initial_data` with Some.
> +                if let Err(err) =3D unsafe { Self::do_late_probe(sdev, d=
ata) } {
> +                    dev_err!(sdev.as_ref(), "Unable to late probe device=
: {err:?}\n");
> +                    // SAFETY: `sdev.as_raw()` is guaranteed to be a val=
id pointer to
> +                    // `serdev_device`.
> +                    unsafe { bindings::serdev_device_set_client_ops(sdev=
.as_raw(), Self::NO_OPS) };
> +                    return length;
> +                }
> +                size
> +            }
> +            Err(err) =3D> {
> +                dev_err!(
> +                    sdev.as_ref(),
> +                    "Unable to receive initial data for probe: {err:?}.\=
n"
> +                );
> +                // SAFETY: `sdev.as_raw()` is guaranteed to be a valid p=
ointer to `serdev_device`.
> +                unsafe { bindings::serdev_device_set_client_ops(sdev.as_=
raw(), Self::NO_OPS) };
> +                length
> +            }
> +        }
> +    }
> +
> +    extern "C" fn initial_write_wakeup_callback(sdev: *mut bindings::ser=
dev_device) {
> +        // SAFETY: The serial device bus only ever calls the write wakeu=
p callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `write_wakeup_=
callback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal>=
>() };
> +
> +        // SAFETY: `initial_write_wakeup_callback` is only ever called a=
fter a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>=
() };
> +
> +        // SAFETY: `sdev.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> +        unsafe { bindings::serdev_device_write_wakeup(sdev.as_raw()) };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver =3D unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY: As long as the driver implementation meets the safety=
 requirements, this call
> +        // is safe.
> +        unsafe { T::write_wakeup_initial(sdev, data_driver) };
> +    }
> +}
> +
> +impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
> +    type IdInfo =3D T::IdInfo;
> +
> +    fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
> +        T::OF_ID_TABLE
> +    }
> +
> +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
> +        T::ACPI_ID_TABLE
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single serial device bus dev=
ice driver.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// kernel::module_serdev_device_driver! {
> +///     type: MyDriver,
> +///     name: "Module name",
> +///     authors: ["Author name"],
> +///     description: "Description",
> +///     license: "GPL v2",
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! module_serdev_device_driver {
> +    ($($f:tt)*) =3D> {
> +        $crate::module_driver!(<T>, $crate::serdev::Adapter<T>, { $($f)*=
 });
> +    };
> +}
> +
> +/// Result for `receive_initial` in [`Driver`].
> +pub enum InitialReceiveResult {
> +    /// More data is required.
> +    ///
> +    /// The inner data is the number of bytes accepted.
> +    Pending(usize),
> +    /// Ready for late probe.
> +    ///
> +    /// The inner data is the number of bytes accepted.
> +    Ready(usize),
> +}
> +
> +/// The serial device bus device driver trait.
> +///
> +/// Drivers must implement this trait in order to get a serial device bu=
s device driver registered.
> +///
> +/// # Examples
> +///
> +///```
> +/// # use kernel::{
> +///     acpi,
> +///     bindings,
> +///     device::{
> +///         Bound,
> +///         Core, //
> +///     },
> +///     of,
> +///     serdev, //
> +/// };
> +///
> +/// struct MyDriver;
> +///
> +/// kernel::of_device_table!(
> +///     OF_TABLE,
> +///     MODULE_OF_TABLE,
> +///     <MyDriver as serdev::Driver>::IdInfo,
> +///     [
> +///         (of::DeviceId::new(c"test,device"), ())
> +///     ]
> +/// );
> +///
> +/// kernel::acpi_device_table!(
> +///     ACPI_TABLE,
> +///     MODULE_ACPI_TABLE,
> +///     <MyDriver as serdev::Driver>::IdInfo,
> +///     [
> +///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
> +///     ]
> +/// );
> +///
> +/// #[vtable]
> +/// impl serdev::Driver for MyDriver {
> +///     type IdInfo =3D ();
> +///     type LateProbeData =3D ();
> +///     type InitialData =3D ();
> +///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&O=
F_TABLE);
> +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Som=
e(&ACPI_TABLE);
> +///
> +///     fn probe(
> +///         _sdev: &serdev::Device,
> +///         _id_info: Option<&Self::IdInfo>,
> +///     ) -> impl PinInit<Self, Error> {
> +///         Err(ENODEV)
> +///     }
> +///
> +///     fn configure(
> +///         dev: &serdev::Device<Core>,
> +///         _this: Pin<&Self>,
> +///         _id_info: Option<&Self::IdInfo>,
> +///     ) -> Result {
> +///         dev.set_baudrate(115200);
> +///         Ok(())
> +///     }
> +///
> +///     fn late_probe(
> +///        _dev: &serdev::Device<Bound>,
> +///        _this: Pin<&Self>,
> +///        _initial_data: Self::InitialData,
> +///    ) -> impl PinInit<Self::LateProbeData, Error> {
> +///        Ok(())
> +///    }
> +/// }
> +///```
> +#[vtable]
> +pub trait Driver: Send {
> +    /// The type holding driver private data about each device id suppor=
ted by the driver.
> +    // TODO: Use associated_type_defaults once stabilized:
> +    //
> +    // ```
> +    // type IdInfo: 'static =3D ();
> +    // type LateProbeData: Send + 'static =3D ();
> +    // type InitialData: Default + Send + 'static =3D ();
> +    // ```
> +    type IdInfo: 'static;
> +
> +    /// Data returned in `late_probe` function.
> +    type LateProbeData: Send + 'static;
> +    /// Data used for initial data.
> +    type InitialData: Default + Send + 'static;
> +
> +    /// The table of OF device ids supported by the driver.
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D None;
> +
> +    /// The table of ACPI device ids supported by the driver.
> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D None;
> +
> +    /// Serial device bus device driver probe.
> +    ///
> +    /// Called when a new serial device bus device is added or discovere=
d.
> +    /// Implementers should attempt to initialize the device here.
> +    fn probe(sdev: &Device, id_info: Option<&Self::IdInfo>) -> impl PinI=
nit<Self, Error>;
> +
> +    /// Serial device bus device driver configure.
> +    ///
> +    /// Called directly after the serial device bus device has been open=
ed.
> +    /// This should be used for setting up the communication (i. e. baud=
rate, flow control, parity)
> +    /// and sending an initial hello if required.
> +    fn configure(
> +        sdev: &Device<device::Core>,
> +        this: Pin<&Self>,
> +        id_info: Option<&Self::IdInfo>,
> +    ) -> Result;
> +
> +    /// Serial device bus device data receive callback (initial).
> +    ///
> +    /// Called when data got received from device, before `late_probe` h=
as been called.
> +    /// This should be used, to get information about the device for `la=
te_probe`.
> +    ///
> +    /// Returns `InitialReceiveResult::Pending` if more data is still re=
quired for `late_probe`.
> +    /// Otherwise `InitialReceiveResult::Ready`. The inner data is the n=
umber of bytes accepted.
> +    fn receive_initial(
> +        sdev: &Device<device::Bound>,
> +        this: Pin<&Self>,
> +        initial_data: &mut Self::InitialData,
> +        data: &[u8],
> +    ) -> Result<InitialReceiveResult> {
> +        let _ =3D (sdev, this, initial_data, data);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Serial device bus device write wakeup callback (initial).
> +    ///
> +    /// Called when ready to transmit more data, before `late_probe` has=
 been called.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must not sleep.
> +    unsafe fn write_wakeup_initial(sdev: &Device<device::Core>, this: Pi=
n<&Self>) {
> +        let _ =3D (sdev, this);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Serial device bus device late probe.
> +    ///
> +    /// Called after the initial data is available.
> +    /// If `receive_initial` isn't implemented, this will be called dire=
ctly after configure.
> +    fn late_probe(
> +        sdev: &Device<device::Bound>,
> +        this: Pin<&Self>,
> +        initial_data: Self::InitialData,
> +    ) -> impl PinInit<Self::LateProbeData, Error>;
> +
> +    /// Serial device bus device driver unbind.
> +    ///
> +    /// Called when a [`Device`] is unbound from its bound [`Driver`]. I=
mplementing this callback
> +    /// is optional.
> +    ///
> +    /// This callback serves as a place for drivers to perform teardown =
operations that require a
> +    /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
> +    ///
> +    /// Otherwise, release operations for driver resources should be per=
formed in `Self::drop`.
> +    fn unbind(
> +        sdev: &Device<device::Core>,
> +        this: Pin<&Self>,
> +        late_probe_this: Option<Pin<&Self::LateProbeData>>,
> +    ) {
> +        let _ =3D (sdev, this, late_probe_this);
> +    }
> +
> +    /// Serial device bus device data receive callback.
> +    ///
> +    /// Called when data got received from device.
> +    ///
> +    /// Returns the number of bytes accepted.
> +    fn receive(
> +        sdev: &Device<device::Bound>,
> +        this: Pin<&Self>,
> +        late_probe_this: Pin<&Self::LateProbeData>,
> +        data: &[u8],
> +    ) -> usize {
> +        let _ =3D (sdev, this, late_probe_this, data);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Serial device bus device write wakeup callback.
> +    ///
> +    /// Called when ready to transmit more data.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must not sleep.
> +    unsafe fn write_wakeup(
> +        sdev: &Device<device::Bound>,
> +        this: Pin<&Self>,
> +        late_probe_this: Pin<&Self::LateProbeData>,
> +    ) {
> +        let _ =3D (sdev, this, late_probe_this);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// The serial device bus device representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct serde=
v_device`. The
> +/// implementation abstracts the usage of an already existing C `struct =
serdev_device` within Rust
> +/// code that we get passed from the C side.
> +///
> +/// # Invariants
> +///
> +/// A [`Device`] instance represents a valid `struct serdev_device` crea=
ted by the C portion of
> +/// the kernel.
> +#[repr(transparent)]
> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
> +    Opaque<bindings::serdev_device>,
> +    PhantomData<Ctx>,
> +);
> +
> +impl<Ctx: device::DeviceContext> Device<Ctx> {
> +    fn as_raw(&self) -> *mut bindings::serdev_device {
> +        self.0.get()
> +    }
> +}
> +
> +impl Device<device::Bound> {
> +    /// Set the baudrate in bits per second.
> +    ///
> +    /// Common baudrates are 115200, 9600, 19200, 57600, 4800.
> +    ///
> +    /// Use [`Device::write_flush`] before calling this if you have writ=
ten data prior to this call.
> +    pub fn set_baudrate(&self, speed: u32) -> u32 {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> +        unsafe { bindings::serdev_device_set_baudrate(self.as_raw(), spe=
ed) }
> +    }
> +
> +    /// Set if flow control should be enabled.
> +    ///
> +    /// Use [`Device::write_flush`] before calling this if you have writ=
ten data prior to this call.
> +    pub fn set_flow_control(&self, enable: bool) {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> +        unsafe { bindings::serdev_device_set_flow_control(self.as_raw(),=
 enable) };
> +    }
> +
> +    /// Set parity to use.
> +    ///
> +    /// Use [`Device::write_flush`] before calling this if you have writ=
ten data prior to this call.
> +    pub fn set_parity(&self, parity: Parity) -> Result {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> +        to_result(unsafe { bindings::serdev_device_set_parity(self.as_ra=
w(), parity as u32) })
> +    }
> +
> +    /// Write data to the serial device until the controller has accepte=
d all the data or has
> +    /// been interrupted by a timeout or signal.
> +    ///
> +    /// Note that any accepted data has only been buffered by the contro=
ller. Use
> +    /// [ Device::wait_until_sent`] to make sure the controller write bu=
ffer has actually been
> +    /// emptied.
> +    ///
> +    /// Returns the number of bytes written (less than data if interrupt=
ed).
> +    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERE=
STARTSYS`] if interrupted
> +    /// before any bytes were written.
> +    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usi=
ze> {
> +        // SAFETY:
> +        // - `self.as_raw()` is guaranteed to be a pointer to a valid `s=
erdev_device`.
> +        // - `data.as_ptr()` is guaranteed to be a valid array pointer w=
ith the size of
> +        //   `data.len()`.
> +        let ret =3D unsafe {
> +            bindings::serdev_device_write(
> +                self.as_raw(),
> +                data.as_ptr(),
> +                data.len(),
> +                timeout.into_jiffies(),
> +            )
> +        };
> +        if ret < 0 {
> +            // CAST: negative return values are guaranteed to be between=
 `-MAX_ERRNO` and `-1`,
> +            // which always fit into a `i32`.
> +            Err(Error::from_errno(ret as i32))
> +        } else {
> +            Ok(ret.unsigned_abs())
> +        }
> +    }
> +
> +    /// Write data to the serial device.
> +    ///
> +    /// If you want to write until the controller has accepted all the d=
ata, use
> +    /// [`Device::write_all`].
> +    ///
> +    /// Note that any accepted data has only been buffered by the contro=
ller. Use
> +    /// [ Device::wait_until_sent`] to make sure the controller write bu=
ffer has actually been
> +    /// emptied.
> +    ///
> +    /// Returns the number of bytes written (less than data if interrupt=
ed).
> +    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERE=
STARTSYS`] if interrupted
> +    /// before any bytes were written.
> +    pub fn write(&self, data: &[u8]) -> Result<u32> {
> +        // SAFETY:
> +        // - `self.as_raw()` is guaranteed to be a pointer to a valid `s=
erdev_device`.
> +        // - `data.as_ptr()` is guaranteed to be a valid array pointer w=
ith the size of
> +        //   `data.len()`.
> +        let ret =3D
> +            unsafe { bindings::serdev_device_write_buf(self.as_raw(), da=
ta.as_ptr(), data.len()) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret.unsigned_abs())
> +        }
> +    }
> +
> +    /// Send data to the serial device immediately.
> +    ///
> +    /// Note that this doesn't guarantee that the data has been transmit=
ted.
> +    /// Use [`Device::wait_until_sent`] for this purpose.
> +    pub fn write_flush(&self) {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> +        unsafe { bindings::serdev_device_write_flush(self.as_raw()) };
> +    }
> +
> +    /// Wait for the data to be sent.
> +    ///
> +    /// After this function, the write buffer of the controller should b=
e empty.
> +    pub fn wait_until_sent(&self, timeout: Timeout) {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> +        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), =
timeout.into_jiffies()) };
> +    }
> +}
> +
> +// SAFETY: `serdev::Device` is a transparent wrapper of `struct serdev_d=
evice`.
> +// The offset is guaranteed to point to a valid device field inside `ser=
dev::Device`.
> +unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Dev=
ice<Ctx> {
> +    const OFFSET: usize =3D offset_of!(bindings::serdev_device, dev);
> +}
> +
> +// SAFETY: `Device` is a transparent wrapper of a type that doesn't depe=
nd on `Device`'s generic
> +// argument.
> +kernel::impl_device_context_deref!(unsafe { Device });
> +kernel::impl_device_context_into_aref!(Device);
> +
> +// SAFETY: Instances of `Device` are always reference-counted.
> +unsafe impl AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        self.as_ref().inc_ref();
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s non-zero.
> +        unsafe { bindings::serdev_device_put(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<C=
tx> {
> +    fn as_ref(&self) -> &device::Device<Ctx> {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
> +        // `struct serdev_device`.
> +        let dev =3D unsafe { addr_of_mut!((*self.as_raw()).dev) };
> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> TryFrom<&device::Device<Ctx>> for &Devi=
ce<Ctx> {
> +    type Error =3D kernel::error::Error;
> +
> +    fn try_from(dev: &device::Device<Ctx>) -> Result<Self, Self::Error> =
{
> +        // SAFETY: By the type invariant of `Device`, `dev.as_raw()` is =
a valid pointer to a
> +        // `struct device`.
> +        if !unsafe { bindings::is_serdev_device(dev.as_raw()) } {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: We've just verified that the device_type of `dev` is
> +        // `serdev_device_type`, hence `dev` must be embedded in a valid=
 `struct
> +        // serdev_device_driver` as guaranteed by the corresponding C co=
de.
> +        let sdev =3D unsafe { container_of!(dev.as_raw(), bindings::serd=
ev_device, dev) };
> +
> +        // SAFETY: `sdev` is a valid pointer to a `struct serdev_device_=
driver`.
> +        Ok(unsafe { &*sdev.cast() })
> +    }
> +}
> +
> +// SAFETY: A `Device` is always reference-counted and can be released fr=
om any thread.
> +unsafe impl Send for Device {}
> +
> +// SAFETY: `Device` can be shared among threads because all methods of `=
Device`
> +// (i.e. `Device<Normal>) are thread safe.
> +unsafe impl Sync for Device {}
>
> --
> 2.51.2
>
>

Currently I'm not a huge fan that we need to have configure(),
receive_initial(), write_wakeup_initial() and late_probe(). Also I do not
like that we hide hide open() completely from user. Maybe user want's to do
something if there is error. This does not feel very ergonomic or standard
kernel way. So after thinking a bit more about this idea I have come up wit=
h
a different approach.

We will have just probe() as usual. In probe() user will be forced to do op=
en()
and finnish() on serdev device. Between open() and finnish() user can
configure the device and do initial reads / writes as needed. After probe i=
s
finished we will switch to runtime ops.

This is not production ready code and I have just tested the idea locally
without kernel. Here is example how probe() could look like:

```rust
fn probe(sdev: &serdev::Device<Core>, _id_info:
Option<&Self::IdInfo>)-> impl PinInit<(Self, ProbeEndToken), Error> {
    let sdev=3D sdev.open()?;
    // After open we can configure and do initial reads / writes.
    sdev.set_baudrate(9600);

    // Here we can also write if needed.

    for _ in 0..8 {
        // For initial reads we will have iterator. This cannot be
done after finish().
        let _ =3D sdev.next_byte(Duration::from_millis(300));
    }

    // We do finnish so user cannot store "initial sdev" anywhere. Also get
    // end_token so probe cannot return unless open() and finnish() are cal=
led.
    let (sdev, end_token) =3D sdev.finish();
    Ok(try_pin_init!((Self {sdev}, end_token)))
}
```

then our receive_initial will look something like this. (Not runnable
on kernel).
Idea is that we have event for next_byte(). So initial read is little bit s=
lower
but that should not be used so much that it matters in practice.

```rust
extern "C" fn initial_receive_buf(dev: *mut serdev_device, buf: *const
u8, count: usize) -> usize {
    let abs =3D unsafe { &mut *((*dev).client_data as *mut Abstraction) };

    let mut consumed =3D 0usize;

    loop {
        // Wait until we can either switch or deliver one byte (slot
must be empty).
        let mut st =3D abs.st.lock().unwrap();
        while !st.probe_finished && !(st.want_byte && st.slot.is_none()) {
            st =3D abs.ev.wait(st).unwrap();
        }

        if st.probe_finished {
            // TODO: Do we lock write lock so it is really safe to
change OPS here?
            unsafe { bindings::serdev_device_set_client_ops(dev,
&RUNTIME_OPS) };

            // Forward the *remaining* bytes that we have NOT taken
out of this buf.
            let rem_ptr =3D unsafe { buf.add(consumed) };
            let rem =3D count - consumed;
            return consumed + Self::runtime_receive_buf(dev, rem_ptr, rem);
        }

        // Deliver exactly one byte to iterator (slot is empty here).
        let b =3D unsafe { *buf.add(consumed) };
        st.slot =3D Some(b);
        // wake next_byte()
        abs.ev.notify_all();

        // Now WAIT until next_byte really consumes it (slot becomes None),
        // or probe finishes (in which case we=E2=80=99ll flush it to runti=
me).
        while !st.probe_finished && st.slot.is_some() {
            st =3D abs.ev.wait(st).unwrap();
        }
        if st.probe_finished {
            continue;
        }

        // Now it is truly consumed by next_byte().
        consumed +=3D 1;
        if consumed =3D=3D count {
            return count;
        }
    }
}
```

Does anyone have opinions which is better or is there some other way
for this which
we have not yet discovered?
