Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44338252906
	for <linux-serial@vger.kernel.org>; Fri, 26 Dec 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766761817; cv=none; b=UFfdlkY3BDMzthimLzKEJGq1jpcvsn2RAgYvV7f3HwmkhTUGJuBOkiWlbW/vX1p8a7mmyqllLUMoEZv5K2UYSR5RRl42QxDef5JY/j1Inwqz4jsnP0/Gi9dyVMbcOLPbutCqGNx/5WXYybJ5Fz+Ggh6dOpkDY/paCRUthT84cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766761817; c=relaxed/simple;
	bh=7Vq2oZ4TXN7gEy7yy3JkMPjKjhu775k0GOzgiKeabK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON5MgspI0jbtI9wkgVYnUwIBFeqOwJ9YzO7AFzQY4H3wQotL2Hedn1rPmIH4yLugDMPDGRD5EhcQhRKczhjHgTUk6SInKQa6dZkQIswwIz8oAr47M2HI3PbmLOx+Ez6FLOOW6v2zaJOsHeagUPhz7PUtthmdEOggk4gz/FXzKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfmFzuR6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfmFzuR6"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso8411326b3a.2
        for <linux-serial@vger.kernel.org>; Fri, 26 Dec 2025 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766761812; x=1767366612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jXjhecXMvTuilyVrt8i61jpnzXKHviPZ0AeF4RHpqT4=;
        b=JfmFzuR6TUnifuhwNIwJDmBOURu/dsv2xg5qXeXikNCmpljJMzEcozOslwPk6rd4e3
         u6ErvHI82kAzZmbjbHm/fhe5Y7Jknnytwji+V6FbgzLjajqn1l+zHb1cz8H5SxJrJcB4
         dNIW2QlLjh7MC+kqO59qYCjqwZm/mpWMi4Jls2ApIlLzhcdyzisxLRj9KctUAozMb6uJ
         AeI33F3fUZDNQqok2Eb+HX6KOMec7cJHgvyfYj8lAAUScIapqbhAKwEffUK4rscvmdUn
         N4hYho6KO/+H71t2J+KxrARTNpWvr1uJUhi6HU+5Ii7rdud39/zjN1H2aSchRe48Qybd
         PT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766761812; x=1767366612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXjhecXMvTuilyVrt8i61jpnzXKHviPZ0AeF4RHpqT4=;
        b=cRU4gy+hoFTcgAENCulG4IqDoxPl6kmmPaSpL+qDARCknltQ5/S6Qic9o3rqIQVtBE
         EXalOX7DT6mSdyUY3SX+2KCuQcAU4PbJPG0r8M44sheO+DnewmTBb+gTSlQHMnnbmN1j
         t+1DLhhm4iw29OFttbDi62DuhiganMPxB0TkDHWBjH0QCa8y+bTIxD+A91MWFZHmGuVT
         QzqL7tg996TWumwVid/lV8mz4PMbrLxdkv28PJuigyNwjHvV7V4zgGRvwlmceIBiEOvY
         qlj3daFHp7QkT2GwL5X9YlS69yOkEGcC8MgsZYpGqLQrCI/sNJmwnyFOMrYX3A5SL66a
         Gekw==
X-Forwarded-Encrypted: i=1; AJvYcCUouo++cA2IwAmZQHHyWVLB4+Zz0t9k24kT0UFg4Nqzs9IB2mSuyTmppx6zY+oQ8vXAFnNsBrDyco7OHgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMwVDoPgYqHCD7d4EtwJRUX9Q8F5lVcutpSlGzDSSrnitrBQN
	AMXNqvDxli9UcIeu/1HG77u5EKJwmJMtzwt9a7FgqL4yGxsYxW/BPFCgCu4RrPJy6vJu9nrpgsD
	eu4LqbuSkXDYvHZRLtVkix8cvq1/mKjc=
X-Gm-Gg: AY/fxX77Qq1IJ8ZUUgQMWBeQUvenFaMDd1U4GUuxgzVpTrp5I6gT1Zhf2oYhtsSdK/H
	//YrsKj8IEg2lL/s5VcDzKakjDnsGCrmncOjlSVZly43xaOA5ojxZz8Mr8X52EljEo07LBM1pRU
	Kd7pA+pduCpW8KNvWSUZPtHSLw2ao0G+83dWJhQacQ0+CCvNhnC65L+F52y+p7gDmUIPA/GO8vT
	yFVlyD0CC1R6Cf6IETXs9RNaglVSosOZxmSEVngKoXFSFrZRzvFMsh179W9sQUOR7e02fFb2RYg
	kqq3hfKrDEwTrbnR0bv+PGd3Dw29
X-Google-Smtp-Source: AGHT+IERcIrcwrVJEGeIZm4sLXjLrAVReoxd3b/5xXknLM0RzGjp6+qaUzZtMUitadrwkhEKQz7WC3glpJZB9C/GqVg=
X-Received: by 2002:a05:6a20:a11a:b0:35d:bb66:5ce3 with SMTP id
 adf61e73a8af0-376a81e2e1dmr22165293637.12.1766761811826; Fri, 26 Dec 2025
 07:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de> <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
In-Reply-To: <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
From: Kari Argillander <kari.argillander@gmail.com>
Date: Fri, 26 Dec 2025 17:09:55 +0200
X-Gm-Features: AQt7F2pCDe7cDhXUZ15f4DdLyxson5tv60wheiTBAZG4umQWI61H2Og0B_bjhR4
Message-ID: <CAC=eVgR2WYdDTW3kOeemyQPP-H0aAUsrzn5Gk5zCe2hQEB709w@mail.gmail.com>
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

Here are some review comments. Overall it seems that this will be quite hard to
get right, safe and easy to use. Example many null pointer dereferences can
happen with C API if things are not done in right order. That currently force
this abstraction to do those things in right order (like you have done and kudos
for that). That however makes this probably too rigid for many use cases. Maybe
right thing to do is to fix C API so it is safer to use. That way we can call
things in wrong order and that is still safe but just logic bug in driver.

On 20.12.2025 20.44 +0200 Markus Probst (markus.probst@posteo.de) wrote:
>
> Implement the basic serial device bus abstractions required to write a
> serial device bus device driver with or without the need for initial device
> data. This includes the following data structures:
>
> The `serdev::Driver` trait represents the interface to the driver.
>
> The `serdev::Device` abstraction represents a `struct serdev_device`.
>
> In order to provide the Serdev specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is
> implemented by `serdev::Adapter`.

Maybe add more info about design decisions here.

> Co-developed-by: Kari Argillander <kari.argillander@gmail.com>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/serdev.c           |  22 ++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/serdev.rs           | 815 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 841 insertions(+)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
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
> +void rust_helper_serdev_device_driver_unregister(struct serdev_device_driver *sdrv)
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
> +void rust_helper_serdev_device_set_client_ops(struct serdev_device *serdev,
> +                                             const struct serdev_device_ops *ops)
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
> +    None = bindings::serdev_parity_SERDEV_PARITY_NONE,
> +    /// Even partiy.
> +    Even = bindings::serdev_parity_SERDEV_PARITY_EVEN,
> +    /// Odd parity.
> +    Odd = bindings::serdev_parity_SERDEV_PARITY_ODD,
> +}
> +
> +/// Timeout in Jiffies.
> +pub enum Timeout {
> +    /// Wait for a specific amount of [`Jiffies`].
> +    Value(NonZero<Jiffies>),

Maybe better name this Jiffies than value. As Jiffies is not yet real unit. Also
many C drivers use msecs_to_jiffies() maybe also have Msecs variant that takes
NonZero<Msecs>. Then into_jiffies() can call msecs_to_jiffies() for that. That
would make construction easier. Also that way people can have const
Timeout::Msecs which is quite nice. Probably people usually will define timeouts
as consts and then use those consts.

> +    /// Wait as long as possible.
> +    ///
> +    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
> +    MaxScheduleTimeout,

As enum is already Timeout maybe Max or MaxSchedule is better name than
MaxScheduleTimeout.

> +}
> +
> +impl Timeout {
> +    fn into_jiffies(self) -> isize {
> +        match self {
> +            Self::Value(value) => value.get().try_into().unwrap_or_default(),
> +            Self::MaxScheduleTimeout => 0,
> +        }
> +    }
> +}
> +
> +/// An adapter for the registration of serial device bus device drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
> +// a preceding call to `register` has been successful.
> +unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
> +    type RegType = bindings::serdev_device_driver;
> +
> +    unsafe fn register(
> +        sdrv: &Opaque<Self::RegType>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        let of_table = match T::OF_ID_TABLE {
> +            Some(table) => table.as_ptr(),
> +            None => core::ptr::null(),
> +        };
> +
> +        let acpi_table = match T::ACPI_ID_TABLE {
> +            Some(table) => table.as_ptr(),
> +            None => core::ptr::null(),
> +        };
> +
> +        // SAFETY: It's safe to set the fields of `struct serdev_device_driver` on initialization.
> +        unsafe {
> +            (*sdrv.get()).driver.name = name.as_char_ptr();
> +            (*sdrv.get()).probe = Some(Self::probe_callback);
> +            (*sdrv.get()).remove = Some(Self::remove_callback);
> +            (*sdrv.get()).driver.of_match_table = of_table;
> +            (*sdrv.get()).driver.acpi_match_table = acpi_table;
> +        }
> +
> +        // SAFETY: `sdrv` is guaranteed to be a valid `RegType`.
> +        to_result(unsafe { bindings::__serdev_device_driver_register(sdrv.get(), module.0) })
> +    }
> +
> +    unsafe fn unregister(sdrv: &Opaque<Self::RegType>) {
> +        // SAFETY: `sdrv` is guaranteed to be a valid `RegType`.
> +        unsafe { bindings::serdev_device_driver_unregister(sdrv.get()) };
> +    }
> +}
> +
> +#[pin_data]
> +struct Drvdata<T: Driver + 'static> {
> +    #[pin]
> +    driver: T,
> +    initial_data: UnsafeCell<Option<T::InitialData>>,

Maybe also box initial_data as that can be destroyed in after late_probe.

> +    late_probe_data: UnsafeCell<Option<Pin<KBox<T::LateProbeData>>>>,
> +}
> +
> +impl<T: Driver + 'static> Adapter<T> {
> +    const OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
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
> +    const INITIAL_OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
> +        receive_buf: Some(Self::initial_receive_buf_callback),
> +        write_wakeup: if T::HAS_WRITE_WAKEUP_INITIAL {
> +            Some(Self::initial_write_wakeup_callback)
> +        } else {
> +            Some(bindings::serdev_device_write_wakeup)
> +        },
> +    };
> +    const NO_OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
> +        receive_buf: None,
> +        write_wakeup: Some(bindings::serdev_device_write_wakeup),
> +    };
> +
> +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi::c_int {
> +        // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer to
> +        // a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `probe_callback()`.
> +        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
> +        let info = <Self as driver::Adapter>::id_info(sdev.as_ref());
> +
> +        from_result(|| {
> +            let data = try_pin_init!(Drvdata {
> +                driver <- T::probe(sdev, info),
> +                initial_data: Some(Default::default()).into(),
> +                late_probe_data: None.into(),
> +            });
> +
> +            sdev.as_ref().set_drvdata(data)?;
> +
> +            // SAFETY: We just set drvdata to `Drvdata<T>`.
> +            let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
> +
> +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
> +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::INITIAL_OPS) };
> +
> +            // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer
> +            // to a `struct serdev_device`.
> +            to_result(unsafe {
> +                bindings::devm_serdev_device_open(sdev.as_ref().as_raw(), sdev.as_raw())
> +            })?;
> +
> +            // SAFETY: `&data.driver` is guaranteed to be pinned.
> +            T::configure(sdev, unsafe { Pin::new_unchecked(&data.driver) }, info)?;
> +
> +            if !T::HAS_RECEIVE_INITIAL {
> +                // SAFETY:
> +                // - It is guaranteed that we have exclusive access to `data.initial_data` and
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
> +    /// The caller must guarantee, that we have exclusive access to `data.initial_data` and
> +    /// `data.late_probe_data`. `data.initial_data` must be Some.
> +    /// (i. e. `late_probe` has not been called yet).
> +    unsafe fn do_late_probe(sdev: &Device<device::CoreInternal>, data: Pin<&Drvdata<T>>) -> Result {
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY: The function contract guarantees that we have exclusive access to
> +        // `data.initial_data`.
> +        let initial_data = unsafe { &mut *data.initial_data.get() };
> +
> +        // SAFETY: The function contract guarantees that we have exclusive access to
> +        // `data.late_probe_data`.
> +        let late_probe_data = unsafe { &mut *data.late_probe_data.get() };
> +
> +        *late_probe_data = Some(KBox::pin_init(
> +            T::late_probe(
> +                sdev,
> +                data_driver,
> +                // SAFETY: The function contract guarantees that `data.initial_data` is Some.
> +                unsafe { initial_data.take().unwrap_unchecked() },
> +            ),
> +            GFP_KERNEL,
> +        )?);
> +        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
> +        unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::OPS) };

How can this be safe? What if serdev core is accessing the ops while we are
changing them? SAFETY comment should address also concurrency issues in this
case.

> +        Ok(())
> +    }
> +
> +    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
> +        // SAFETY: The serial device bus only ever calls the remove callback with a valid pointer
> +        // to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `remove_callback()`.
> +        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
> +
> +        // SAFETY: `remove_callback` is only ever called after a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> +        // and stored a `Pin<KBox<T>>`.
> +        let data = unsafe { sdev.as_ref().drvdata_obtain::<Drvdata<T>>() };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY:
> +        // - `data.late_probe_data` is guaranteed to be pinned.
> +        // - It is guaranteed that we have exclusive access to `data.late_probe_data`.
> +        let late_probe_data = unsafe {
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
> +        // SAFETY: The serial device bus only ever calls the receive buf callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_callback()`.
> +        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
> +
> +        // SAFETY: `receive_buf_callback` is only ever called after a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> +        let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size of `length`.
> +        let buf = unsafe { core::slice::from_raw_parts(buf, length) };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY:
> +        // - `data.late_probe_data` is guaranteed to be Some.
> +        // - `data.late_probe_data` is guaranteed to be pinned.
> +        let late_probe_data = unsafe {
> +            Pin::new_unchecked((*data.late_probe_data.get()).as_deref().unwrap_unchecked())
> +        };
> +
> +        T::receive(sdev, data_driver, late_probe_data, buf)
> +    }
> +
> +    extern "C" fn write_wakeup_callback(sdev: *mut bindings::serdev_device) {
> +        // SAFETY: The serial device bus only ever calls the write wakeup callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `write_wakeup_callback()`.
> +        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
> +
> +        // SAFETY: `write_wakeup_callback` is only ever called after a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> +        let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
> +
> +        // SAFETY: `sdev.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        unsafe { bindings::serdev_device_write_wakeup(sdev.as_raw()) };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY:
> +        // - `data.late_probe_data` is guaranteed to be Some.
> +        // - `data.late_probe_data` is guaranteed to be pinned.
> +        let late_probe_data = unsafe {
> +            Pin::new_unchecked((*data.late_probe_data.get()).as_deref().unwrap_unchecked())
> +        };
> +
> +        // SAFETY: As long as the driver implementation meets the safety requirements, this call
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
> +        // SAFETY: The serial device bus only ever calls the receive buf callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_callback()`.
> +        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size of `length`.
> +        let buf = unsafe { core::slice::from_raw_parts(buf, length) };
> +
> +        // SAFETY: `initial_receive_buf_callback` is only ever called after a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> +        let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let driver_data = unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY:
> +        // - `data.initial_data` is always Some until `InitialReceiveResult::Ready` is
> +        //   returned below.
> +        // - It is guaranteed that we have exclusive access to `data.initial_data`.
> +        let initial_data = unsafe { (*data.initial_data.get()).as_mut().unwrap_unchecked() };
> +
> +        match T::receive_initial(sdev, driver_data, initial_data, buf) {
> +            Ok(InitialReceiveResult::Pending(size)) => size,
> +            Ok(InitialReceiveResult::Ready(size)) => {
> +                // SAFETY:
> +                // - It is guaranteed that we have exclusive access to `data.initial_data` and
> +                //   `data.late_probe_data`.
> +                // - We just initialized `data.initial_data` with Some.
> +                if let Err(err) = unsafe { Self::do_late_probe(sdev, data) } {
> +                    dev_err!(sdev.as_ref(), "Unable to late probe device: {err:?}\n");

Not an abstraction job to log this.

> +                    // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to
> +                    // `serdev_device`.
> +                    unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::NO_OPS) };

What if write_wakeup is accessed by serdev core while we are changing the ops? I
checked and even taking serdev write lock does not prevent that as checking
write_wakeup ops is done outside the lock. We could probably change that however
if necessary.

> +                    return length;
> +                }
> +                size
> +            }
> +            Err(err) => {
> +                dev_err!(
> +                    sdev.as_ref(),
> +                    "Unable to receive initial data for probe: {err:?}.\n"
> +                );

Same here. Not an abstraction job to log this.

> +                // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
> +                unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::NO_OPS) };
> +                length
> +            }
> +        }
> +    }
> +
> +    extern "C" fn initial_write_wakeup_callback(sdev: *mut bindings::serdev_device) {
> +        // SAFETY: The serial device bus only ever calls the write wakeup callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `write_wakeup_callback()`.

initial_write_wakeup_callback

> +        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
> +
> +        // SAFETY: `initial_write_wakeup_callback` is only ever called after a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> +        // and stored a `Pin<KBox<Drvdata<T>>>`.
> +        let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
> +
> +        // SAFETY: `sdev.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        unsafe { bindings::serdev_device_write_wakeup(sdev.as_raw()) };
> +
> +        // SAFETY: `&data.driver` is guaranteed to be pinned.
> +        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
> +
> +        // SAFETY: As long as the driver implementation meets the safety requirements, this call
> +        // is safe.
> +        unsafe { T::write_wakeup_initial(sdev, data_driver) };
> +    }
> +}
> +
> +impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
> +    type IdInfo = T::IdInfo;
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
> +/// Declares a kernel module that exposes a single serial device bus device driver.
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

To be consistent with other bus module macros this should be named
module_serdev_driver. Also change in example.

> +    ($($f:tt)*) => {
> +        $crate::module_driver!(<T>, $crate::serdev::Adapter<T>, { $($f)* });
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
> +/// Drivers must implement this trait in order to get a serial device bus device driver registered.
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
> +///     type IdInfo = ();
> +///     type LateProbeData = ();
> +///     type InitialData = ();
> +///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
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
> +    /// The type holding driver private data about each device id supported by the driver.
> +    // TODO: Use associated_type_defaults once stabilized:
> +    //
> +    // ```
> +    // type IdInfo: 'static = ();
> +    // type LateProbeData: Send + 'static = ();
> +    // type InitialData: Default + Send + 'static = ();
> +    // ```
> +    type IdInfo: 'static;
> +
> +    /// Data returned in `late_probe` function.
> +    type LateProbeData: Send + 'static;
> +    /// Data used for initial data.
> +    type InitialData: Default + Send + 'static;
> +
> +    /// The table of OF device ids supported by the driver.
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
> +
> +    /// The table of ACPI device ids supported by the driver.
> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
> +
> +    /// Serial device bus device driver probe.
> +    ///
> +    /// Called when a new serial device bus device is added or discovered.
> +    /// Implementers should attempt to initialize the device here.
> +    fn probe(sdev: &Device, id_info: Option<&Self::IdInfo>) -> impl PinInit<Self, Error>;

As probe has serdev::Device. This means we cannot example enable let's say
regulators as those needs device::Device<Bound>. So we could enable those just
in configure(). That means open() is called before we can do preparations. This
seems to be a problem to me. It might not be so someone else can comment if this
is actually a problem.

If we cannot do any preparation before open() we might as well call open()
before probe() and have probe() receive Device<Core>. So something does not seem
quite right here.

Also like I said in another thread I think user should be able to control when
open() is called.

> +
> +    /// Serial device bus device driver configure.
> +    ///
> +    /// Called directly after the serial device bus device has been opened.
> +    /// This should be used for setting up the communication (i. e. baudrate, flow control, parity)
> +    /// and sending an initial hello if required.
> +    fn configure(
> +        sdev: &Device<device::Core>,
> +        this: Pin<&Self>,
> +        id_info: Option<&Self::IdInfo>,
> +    ) -> Result;
> +
> +    /// Serial device bus device data receive callback (initial).
> +    ///
> +    /// Called when data got received from device, before `late_probe` has been called.
> +    /// This should be used, to get information about the device for `late_probe`.
> +    ///
> +    /// Returns `InitialReceiveResult::Pending` if more data is still required for `late_probe`.
> +    /// Otherwise `InitialReceiveResult::Ready`. The inner data is the number of bytes accepted.
> +    fn receive_initial(
> +        sdev: &Device<device::Bound>,
> +        this: Pin<&Self>,
> +        initial_data: &mut Self::InitialData,
> +        data: &[u8],
> +    ) -> Result<InitialReceiveResult> {
> +        let _ = (sdev, this, initial_data, data);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }

Maybe just let implementors could just write to `this` in receive_initial and
then we do not need initial_data at all. That would simplify things a bit. That
would mean some "locking" from implementors is required though. But I think that
is acceptable. Maybe same for late_probe data.

> +    /// Serial device bus device write wakeup callback (initial).
> +    ///
> +    /// Called when ready to transmit more data, before `late_probe` has been called.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must not sleep.
> +    unsafe fn write_wakeup_initial(sdev: &Device<device::Core>, this: Pin<&Self>) {
> +        let _ = (sdev, this);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }

This seems useless as during probe we can just do sequential writes as nothing
else is happening. After late_probe we can use the normal write_wakeup.

> +
> +    /// Serial device bus device late probe.
> +    ///
> +    /// Called after the initial data is available.
> +    /// If `receive_initial` isn't implemented, this will be called directly after configure.
> +    fn late_probe(
> +        sdev: &Device<device::Bound>,
> +        this: Pin<&Self>,
> +        initial_data: Self::InitialData,
> +    ) -> impl PinInit<Self::LateProbeData, Error>;
> +
> +    /// Serial device bus device driver unbind.
> +    ///
> +    /// Called when a [`Device`] is unbound from its bound [`Driver`]. Implementing this callback
> +    /// is optional.
> +    ///
> +    /// This callback serves as a place for drivers to perform teardown operations that require a
> +    /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
> +    ///
> +    /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
> +    fn unbind(
> +        sdev: &Device<device::Core>,
> +        this: Pin<&Self>,
> +        late_probe_this: Option<Pin<&Self::LateProbeData>>,
> +    ) {
> +        let _ = (sdev, this, late_probe_this);
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
> +        let _ = (sdev, this, late_probe_this, data);
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

Maybe add hint here that implementors should enable DEBUG_ATOMIC_SLEEP when
developing to catch accidental sleeps.

> +    unsafe fn write_wakeup(
> +        sdev: &Device<device::Bound>,
> +        this: Pin<&Self>,
> +        late_probe_this: Pin<&Self::LateProbeData>,
> +    ) {
> +        let _ = (sdev, this, late_probe_this);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }

I do not see how writing can actually be done. Only place we can actually write
after late probe is receive(). This is because all write functions are in
serdev::Device<Bound>. Also we cannot use those in write_wakeup as that is
atomic context. We should schedule work there but if we schedule work there is
no way to actually call any write function in there as we only have
Aref<serdev::Device> and that has no write functions. So this seems like a very
big problem.

Also I fear that as we do OPS swap we lost first write wakeup call. That means
as this usually schedules work we might never schedule that work if we miss the
first call. I'm not sure of if this is a real problem or not.

> +}
> +
> +/// The serial device bus device representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct serdev_device`. The
> +/// implementation abstracts the usage of an already existing C `struct serdev_device` within Rust
> +/// code that we get passed from the C side.
> +///
> +/// # Invariants
> +///
> +/// A [`Device`] instance represents a valid `struct serdev_device` created by the C portion of
> +/// the kernel.
> +#[repr(transparent)]
> +pub struct Device<Ctx: device::DeviceContext = device::Normal>(
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
> +    /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
> +    pub fn set_baudrate(&self, speed: u32) -> u32 {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        unsafe { bindings::serdev_device_set_baudrate(self.as_raw(), speed) }
> +    }

Here I'm wondering two things. Could we just have Baudare enum instead. That
would mean that return value is not needed as it will always succeed.

Another thing is if we do not use enum is that should we do something like

```rust
    pub fn set_baudrate(&self, speed: u32) -> Result<(), u32> {
       // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a
valid `serdev_device`.
       let ret = unsafe {
bindings::serdev_device_set_baudrate(self.as_raw(), speed) };
       if ret != speed {
           Err(ret)
       }

       Ok(())
    }

```

I'm still not quite convinced for this idea. So I still think maybe enum is good
idea. But then again there must be reason why C API does not use enum?
It might be
historical reason only and we should not make same thing again.

Another idea is to have enum which have all bauderates but last one is
Custom(u32). But having this kind of work done during this abstraction layer
seems a bit off so I'm totally ok if we just use u32 here.

> +    /// Set if flow control should be enabled.
> +    ///
> +    /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
> +    pub fn set_flow_control(&self, enable: bool) {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        unsafe { bindings::serdev_device_set_flow_control(self.as_raw(), enable) };
> +    }
> +
> +    /// Set parity to use.
> +    ///
> +    /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
> +    pub fn set_parity(&self, parity: Parity) -> Result {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        to_result(unsafe { bindings::serdev_device_set_parity(self.as_raw(), parity as u32) })
> +    }
> +
> +    /// Write data to the serial device until the controller has accepted all the data or has
> +    /// been interrupted by a timeout or signal.
> +    ///
> +    /// Note that any accepted data has only been buffered by the controller. Use
> +    /// [ Device::wait_until_sent`] to make sure the controller write buffer has actually been
> +    /// emptied.
> +    ///
> +    /// Returns the number of bytes written (less than data if interrupted).
> +    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
> +    /// before any bytes were written.
> +    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usize> {
> +        // SAFETY:
> +        // - `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        // - `data.as_ptr()` is guaranteed to be a valid array pointer with the size of
> +        //   `data.len()`.
> +        let ret = unsafe {
> +            bindings::serdev_device_write(
> +                self.as_raw(),
> +                data.as_ptr(),
> +                data.len(),
> +                timeout.into_jiffies(),
> +            )
> +        };

Use to_result()

> +        if ret < 0 {
> +            // CAST: negative return values are guaranteed to be between `-MAX_ERRNO` and `-1`,
> +            // which always fit into a `i32`.
> +            Err(Error::from_errno(ret as i32))
> +        } else {
> +            Ok(ret.unsigned_abs())
> +        }
> +    }
> +
> +    /// Write data to the serial device.
> +    ///
> +    /// If you want to write until the controller has accepted all the data, use
> +    /// [`Device::write_all`].
> +    ///
> +    /// Note that any accepted data has only been buffered by the controller. Use
> +    /// [ Device::wait_until_sent`] to make sure the controller write buffer has actually been
> +    /// emptied.
> +    ///
> +    /// Returns the number of bytes written (less than data if interrupted).
> +    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
> +    /// before any bytes were written.
> +    pub fn write(&self, data: &[u8]) -> Result<u32> {
> +        // SAFETY:
> +        // - `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        // - `data.as_ptr()` is guaranteed to be a valid array pointer with the size of
> +        //   `data.len()`.
> +        let ret =
> +            unsafe { bindings::serdev_device_write_buf(self.as_raw(), data.as_ptr(), data.len()) };

Use to_result()

> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret.unsigned_abs())
> +        }
> +    }
> +
> +    /// Send data to the serial device immediately.
> +    ///
> +    /// Note that this doesn't guarantee that the data has been transmitted.
> +    /// Use [`Device::wait_until_sent`] for this purpose.
> +    pub fn write_flush(&self) {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        unsafe { bindings::serdev_device_write_flush(self.as_raw()) };
> +    }
> +
> +    /// Wait for the data to be sent.
> +    ///
> +    /// After this function, the write buffer of the controller should be empty.
> +    pub fn wait_until_sent(&self, timeout: Timeout) {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
> +        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), timeout.into_jiffies()) };
> +    }
> +}
> +
> +// SAFETY: `serdev::Device` is a transparent wrapper of `struct serdev_device`.
> +// The offset is guaranteed to point to a valid device field inside `serdev::Device`.
> +unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
> +    const OFFSET: usize = offset_of!(bindings::serdev_device, dev);
> +}
> +
> +// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
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
> +        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
> +        unsafe { bindings::serdev_device_put(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
> +    fn as_ref(&self) -> &device::Device<Ctx> {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
> +        // `struct serdev_device`.
> +        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };

Now days `&raw mut` is preferred instead of `addr_of_mut!`.

> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> TryFrom<&device::Device<Ctx>> for &Device<Ctx> {
> +    type Error = kernel::error::Error;
> +
> +    fn try_from(dev: &device::Device<Ctx>) -> Result<Self, Self::Error> {
> +        // SAFETY: By the type invariant of `Device`, `dev.as_raw()` is a valid pointer to a
> +        // `struct device`.
> +        if !unsafe { bindings::is_serdev_device(dev.as_raw()) } {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: We've just verified that the device_type of `dev` is
> +        // `serdev_device_type`, hence `dev` must be embedded in a valid `struct
> +        // serdev_device_driver` as guaranteed by the corresponding C code.
> +        let sdev = unsafe { container_of!(dev.as_raw(), bindings::serdev_device, dev) };
> +
> +        // SAFETY: `sdev` is a valid pointer to a `struct serdev_device_driver`.
> +        Ok(unsafe { &*sdev.cast() })
> +    }
> +}
> +
> +// SAFETY: A `Device` is always reference-counted and can be released from any thread.
> +unsafe impl Send for Device {}
> +
> +// SAFETY: `Device` can be shared among threads because all methods of `Device`
> +// (i.e. `Device<Normal>) are thread safe.
> +unsafe impl Sync for Device {}
