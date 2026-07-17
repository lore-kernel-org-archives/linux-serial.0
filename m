Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19123F4112
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287661; cv=none; b=j3HzFCUPNwo0T5OCYlZOqgzB95ksEhfOfofTduZmNAS2ybMPT0lF/CsKkh2HGJdgBvBeoWFEMyouC+iCL2/nvk+3RK70N2xd7kEt5q7WAmK3wFfA0WslGGmiu9txKh5NB3eEoE3lhq0bos4nyWoHSK2xbvS0NQLrcJye30ZX1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287661; c=relaxed/simple;
	bh=xXl7bd8T23fbXEfyS8QCnoE1JJwEFxZt/wdAHcbw+i4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmCL9isPJwK5t+jukzDsHJjjiklAs48JuQKLlq63FIdbGceIhLx+/k/FjGDl9AzWpDWF9pHNJ+tDsaNwEG884Q3w0+MeKuYYIMZMOtvBVjELhhpqyh5u5Oa13CiWIf4poOd2Zv89E5U82tozz1m8LX/mF/5a2RuanzXT8B2IBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=j2cZ/T6F; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="j2cZ/T6F"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1638F240027
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 13:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784287648;
	bh=KgGrfZJb8F2oUjHX7SP+Q8bU/IJwWWfjUbqUHn3SBI4=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=j2cZ/T6FzZ0CFC24R3iEX6QsNF7t1v06fFqjQ4xOJZmPKpt7bnSEBC46De4vUZ6OA
	 gKLig5GuM6ELUCErKTgIYWUs98blsxrsyaqVr74G1j3OrfmMCmsaS4n+se03M1QaJf
	 jfu5csoYbGS6Vo7VK7XKJBI+eYCUXWzSG+zs/fHPWPWCZ6h6K8MUqF+nupkguTF11d
	 SYvH19YlMkxu5l7PEwf/IHRWUkTQ6lKx/OfqE8uWDxyM6j0w31+A1fwoElU6ztb2dy
	 qBFcSQv2BFFXN3ssUEM35nIHt3aj0z6297cFf3znhDmJ15c/WdeaM5CR9za9u1eWoL
	 9irPeQxp3vC+w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h1ngw4q0Fz6twQ;
	Fri, 17 Jul 2026 13:27:24 +0200 (CEST)
Message-ID: <939b0abb0b9926468606ef602e2f0e96364e32a0.camel@posteo.de>
Subject: Re: [PATCH v14 1/3] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Rob Herring <robh@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Kari Argillander	
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>, Daniel
 Almeida <daniel.almeida@collabora.com>, Tamir Duberstein	
 <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?=	 <work@onurozkan.dev>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Date: Fri, 17 Jul 2026 11:27:26 +0000
In-Reply-To: <DK0SX3P5K1J6.1OV4ETJMXW83R@garyguo.net>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
	 <20260715-rust_serdev-v14-1-b4ed5c93606f@posteo.de>
	 <DK0SX3P5K1J6.1OV4ETJMXW83R@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-4YlAqU8J+DrCh9skCs+6"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-4YlAqU8J+DrCh9skCs+6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-17 at 12:15 +0100, Gary Guo wrote:
> On Wed Jul 15, 2026 at 10:00 PM BST, Markus Probst wrote:
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
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  MAINTAINERS                     |   2 +
> >  drivers/tty/serdev/Kconfig      |   7 +
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/helpers/helpers.c          |   1 +
> >  rust/helpers/serdev.c           |  22 ++
> >  rust/kernel/lib.rs              |   2 +
> >  rust/kernel/serdev.rs           | 599 ++++++++++++++++++++++++++++++++=
++++++++
> >  7 files changed, 634 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 806bd2d80d15..cd735d227892 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24568,6 +24568,8 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/serial/serial.yaml
> >  F:	drivers/tty/serdev/
> >  F:	include/linux/serdev.h
> > +F:	rust/helpers/serdev.c
> > +F:	rust/kernel/serdev.rs
> > =20
> >  SERIAL IR RECEIVER
> >  M:	Sean Young <sean@mess.org>
> > diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
> > index 46ae732bfc68..e6dfe949ad01 100644
> > --- a/drivers/tty/serdev/Kconfig
> > +++ b/drivers/tty/serdev/Kconfig
> > @@ -9,6 +9,13 @@ menuconfig SERIAL_DEV_BUS
> > =20
> >  	  Note that you typically also want to enable TTY port controller sup=
port.
> > =20
> > +config RUST_SERIAL_DEV_BUS_ABSTRACTIONS
> > +	bool "Rust Serial device bus abstractions"
> > +	depends on RUST
> > +	select SERIAL_DEV_BUS
> > +	help
> > +	  This enables the Rust abstraction for the serial device bus API.
> > +
> >  if SERIAL_DEV_BUS
> > =20
> >  config SERIAL_DEV_CTRL_TTYPORT
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 1124785e210b..fe7c505da236 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -85,6 +85,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/sched.h>
> >  #include <linux/security.h>
> > +#include <linux/serdev.h>
> >  #include <linux/slab.h>
> >  #include <linux/sys_soc.h>
> >  #include <linux/task_work.h>
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 998e31052e66..6921a5ecb78a 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -87,6 +87,7 @@
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
> > +	serdev_device_driver_unregister(sdrv);
> > +}
> > +
> > +__rust_helper
> > +void rust_helper_serdev_device_put(struct serdev_device *serdev)
> > +{
> > +	serdev_device_put(serdev);
> > +}
> > +
> > +__rust_helper
> > +void rust_helper_serdev_device_set_client_ops(struct serdev_device *se=
rdev,
> > +					      const struct serdev_device_ops *ops)
> > +{
> > +	serdev_device_set_client_ops(serdev, ops);
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 9512af7156df..d5ca17336739 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -119,6 +119,8 @@
> >  pub mod scatterlist;
> >  pub mod security;
> >  pub mod seq_file;
> > +#[cfg(CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS)]
> > +pub mod serdev;
> >  pub mod sizes;
> >  #[cfg(CONFIG_SOC_BUS)]
> >  pub mod soc;
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > new file mode 100644
> > index 000000000000..0ffcef1849d2
> > --- /dev/null
> > +++ b/rust/kernel/serdev.rs
> > @@ -0,0 +1,599 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Abstractions for the serial device bus.
> > +//!
> > +//! C header: [`include/linux/serdev.h`](srctree/include/linux/serdev.=
h)
> > +
> > +use crate::{
> > +    acpi,
> > +    device,
> > +    driver,
> > +    error::{
> > +        from_result,
> > +        to_result,
> > +        VTABLE_DEFAULT_ERROR, //
> > +    },
> > +    new_mutex,
> > +    of,
> > +    prelude::*,
> > +    sync::{
> > +        aref::AlwaysRefCounted,
> > +        Mutex, //
> > +    },
> > +    time::{
> > +        msecs_to_jiffies,
> > +        Jiffies,
> > +        Msecs, //
> > +    },
> > +    types::{
> > +        Opaque,
> > +        ScopeGuard, //
> > +    }, //
> > +};
> > +
> > +use core::{
> > +    cell::UnsafeCell,
> > +    marker::PhantomData,
> > +    mem::{offset_of, MaybeUninit},
> > +    num::NonZero,
> > +    ptr::NonNull, //
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
> > +    Jiffies(NonZero<Jiffies>),
> > +    /// Wait for a specific amount of [`Msecs`].
> > +    Milliseconds(NonZero<Msecs>),
> > +    /// Wait as long as possible.
> > +    ///
> > +    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
> > +    Max,
> > +}
> > +
> > +impl Timeout {
> > +    fn into_jiffies(self) -> isize {
> > +        match self {
> > +            Self::Jiffies(value) =3D> value.get().try_into().unwrap_or=
_default(),
> > +            Self::Milliseconds(value) =3D> {
> > +                msecs_to_jiffies(value.get()).try_into().unwrap_or_def=
ault()
> > +            }
> > +            Self::Max =3D> 0,
> > +        }
> > +    }
> > +}
>=20
> FWIW this shouldn't be part of serdev abstraction. See
> https://lore.kernel.org/rust-for-linux/20260717042247.3634961-1-tomo@flap=
ping.org
>=20
> > +
> > +/// An adapter for the registration of serial device bus device driver=
s.
> > +pub struct Adapter<T: Driver>(T);
> > +
> > +// SAFETY:
> > +// - `bindings::serdev_device_driver` is a C type declared as `repr(C)=
`.
> > +// - `PrivateData<'bound, T>` is the type of the driver's device priva=
te data.
> > +// - `struct serdev_device_driver` embeds a `struct device_driver`.
> > +// - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded=
 `struct device_driver`.
> > +unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
> > +    type DriverType =3D bindings::serdev_device_driver;
> > +    type DriverData<'bound> =3D PrivateData<'bound, T>;
> > +    const DEVICE_DRIVER_OFFSET: usize =3D core::mem::offset_of!(Self::=
DriverType, driver);
> > +}
> > +
> > +// SAFETY: A call to `unregister` for a given instance of `DriverType`=
 is guaranteed to be valid if
> > +// a preceding call to `register` has been successful.
> > +unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
> > +    unsafe fn register(
> > +        sdrv: &Opaque<Self::DriverType>,
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
> > +        // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
> > +        to_result(unsafe { bindings::__serdev_device_driver_register(s=
drv.get(), module.0) })
> > +    }
> > +
> > +    unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {
> > +        // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
> > +        unsafe { bindings::serdev_device_driver_unregister(sdrv.get())=
 };
> > +    }
> > +}
> > +
> > +#[doc(hidden)]
> > +#[pin_data(PinnedDrop)]
> > +pub struct PrivateData<'bound, T: Driver> {
> > +    sdev: &'bound Device<device::Bound>,
> > +    #[pin]
> > +    driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
> > +    open: UnsafeCell<bool>,
> > +    #[pin]
> > +    active: Mutex<bool>,
> > +}
> > +
> > +#[pinned_drop]
> > +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        let mut active =3D self.active.lock();
> > +        if *active {
> > +            // SAFETY:
> > +            // - We have exclusive access to `self.driver`.
> > +            // - `self.driver` is guaranteed to be initialized.
> > +            unsafe { (*self.driver.get()).assume_init_drop() };
> > +            *active =3D false;
> > +        }
> > +        drop(active);
> > +
> > +        // SAFETY: We have exclusive access to `self.open`.
> > +        if unsafe { *self.open.get() } {
> > +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a poin=
ter to a valid
> > +            // `struct serdev_device`.
> > +            unsafe { bindings::serdev_device_close(self.sdev.as_raw())=
 };
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: Driver> Adapter<T> {
> > +    const OPS: &'static bindings::serdev_device_ops =3D &bindings::ser=
dev_device_ops {
> > +        receive_buf: if T::HAS_RECEIVE {
> > +            Some(Self::receive_buf_callback)
> > +        } else {
> > +            None
> > +        },
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
l<'_>>>() };
> > +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_ref())=
;
> > +
> > +        from_result(|| {
> > +            sdev.as_ref().set_drvdata(try_pin_init!(PrivateData::<T> {
> > +                sdev: &**sdev,
> > +                driver: MaybeUninit::<T::Data<'_>>::zeroed().into(),
> > +                open: false.into(),
> > +                active <- new_mutex!(false),
> > +            }))?;
> > +            // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> > +            let private_data =3D unsafe { sdev.as_ref().drvdata_borrow=
::<PrivateData<'_, T>>() };
> > +            let private_data =3D ScopeGuard::new_with_data(private_dat=
a, |_| {
> > +                // SAFETY: We just set drvdata to `PrivateData<'_, T>`=
.
> > +                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateDa=
ta<'_, T>>() });
> > +            });
> > +            let mut active =3D private_data.active.lock();
>=20
> What's this for? This gives me a strong vibe that something is off. Eithe=
r the
> serdev subsystem is not having sufficient synchronization or there is an
> abstraction issue.
There is the following issue it trys to solve:

In the rust abstraction, the driver data is only initialized after the
probe. `serdev_device_open` should be called inside or before probe,
because otherwise the driver can't configure the serdev device. But as
a sideeffect, once the serdev device is open, it is possible for
receive_buf_callback to be called, which this mutex prevents while the
driver data is not initialized yet.
>=20
> Either way, you really should have more comments about what this active m=
utex is
> for and why it is needed.
>=20
> > +
> > +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid poi=
nter to `serdev_device`.
> > +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_ra=
w(), Self::OPS) };
> > +
> > +            // SAFETY: The serial device bus only ever calls the probe=
 callback with a valid pointer
> > +            // to a `serdev_device`.
> > +            to_result(unsafe { bindings::serdev_device_open(sdev.as_ra=
w()) })?;
> > +
> > +            // SAFETY: We have exclusive access to `private_data.open`=
.
> > +            unsafe { *private_data.open.get() =3D true };
> > +
> > +            let data =3D T::probe(sdev, info);
> > +
> > +            // SAFETY: We have exclusive access to `private_data.drive=
r`.
> > +            let driver =3D unsafe { &mut *private_data.driver.get() };
> > +            // SAFETY:
> > +            // - `driver.as_mut_ptr()` is a valid pointer to uninitial=
ized data.
> > +            // - `private_data.driver` is pinned.
> > +            let result =3D unsafe { data.__pinned_init(driver.as_mut_p=
tr()) };
> > +
> > +            *active =3D result.is_ok();
> > +
> > +            drop(active);
> > +
> > +            result.map(|()| {
> > +                private_data.dismiss();
> > +                0
> > +            })
> > +        })
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
l<'_>>>() };
> > +
> > +        // SAFETY: `remove_callback` is only ever called after a succe=
ssful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<P=
rivateData<'_, T>>() };
> > +
> > +        // SAFETY: No one has exclusive access to `private_data.driver=
`.
> > +        let data =3D unsafe { &*private_data.driver.get() };
> > +        // SAFETY:
> > +        // - `private_data.driver` is pinned.
> > +        // - `remove_callback` is only ever called after a successful =
call to `probe_callback`,
> > +        //   hence it's guaranteed that `private_data.driver` was init=
ialized.
> > +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_in=
it_ref()) };
> > +
> > +        T::unbind(sdev, data_pinned);
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
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::BoundIntern=
al>>() };
> > +
> > +        // SAFETY: `receive_buf_callback` is only ever called after a =
successful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<P=
rivateData<'_, T>>() };
> > +        let active =3D private_data.active.lock();
> > +
> > +        if !*active {
> > +            return length;
> > +        }
> > +
> > +        // SAFETY: No one has exclusive access to `private_data.driver=
`.
> > +        let data =3D unsafe { &*private_data.driver.get() };
> > +        // SAFETY:
> > +        // - `private_data.driver` is pinned.
> > +        // - `receive_buf_callback` is only ever called after a succes=
sful call to `probe_callback`,
> > +        //   hence it's guaranteed that `private_data.driver` was init=
ialized.
> > +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_in=
it_ref()) };
> > +
> > +        // SAFETY: `buf` is guaranteed to be non-null and has the size=
 of `length`.
> > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) =
};
> > +
> > +        T::receive(sdev, data_pinned, buf)
> > +    }
> > +}
> > +
> > +impl<T: Driver> driver::Adapter for Adapter<T> {
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
> > +///     type Data<'bound> =3D Self;
> > +///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(=
&OF_TABLE);
> > +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D S=
ome(&ACPI_TABLE);
> > +///
> > +///     fn probe<'bound>(
> > +///         sdev: &'bound serdev::Device<Core<'_>>,
> > +///         _id_info: Option<&'bound Self::IdInfo>,
> > +///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> > +///         sdev.set_baudrate(115200);
> > +///         sdev.write_all(b"Hello\n", serdev::Timeout::Max)?;
> > +///         Ok(MyDriver)
> > +///     }
> > +/// }
> > +///```
> > +#[vtable]
> > +pub trait Driver {
> > +    /// The type holding driver private data about each device id supp=
orted by the driver.
> > +    // TODO: Use associated_type_defaults once stabilized:
> > +    //
> > +    // ```
> > +    // type IdInfo: 'static =3D ();
> > +    // ```
> > +    type IdInfo: 'static;
> > +
> > +    /// The type of the driver's bus device private data.
> > +    type Data<'bound>: Send + Sync + 'bound;
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
> > +    fn probe<'bound>(
> > +        sdev: &'bound Device<device::Core<'_>>,
> > +        id_info: Option<&'bound Self::IdInfo>,
> > +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
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
erformed in `Drop`.
> > +    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pi=
n<&Self::Data<'bound>>) {
> > +        let _ =3D (sdev, this);
> > +    }
> > +
> > +    /// Serial device bus device data receive callback.
> > +    ///
> > +    /// Called when data got received from device.
> > +    ///
> > +    /// Returns the number of bytes accepted.
> > +    fn receive<'bound>(
> > +        sdev: &'bound Device<device::Bound>,
> > +        this: Pin<&Self::Data<'bound>>,
> > +        data: &[u8],
> > +    ) -> usize {
> > +        let _ =3D (sdev, this, data);
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
>=20
> This and many other functions should be `#[inline]`. I am surprised that =
Sashiko
> didn't point out.
Yes, inline would make sense here. In this particular case, I used
platform.rs as base, so the missing inline got inherited.

Thanks
- Markus Probst

>=20
> Best,
> Gary

--=-4YlAqU8J+DrCh9skCs+6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpaEZsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSWC0QAI4a0srLg/EDOYZf2ASJ
0yo/9byO0dcXl4VTGllorzQaTnJXvbHIhoKlOYoSsLCO3+FOWYSYz8mjByZTjLyJ
BJ6VImFObUwCwppW+goUGC1an+h+aLtvxp3U5EpHrTuNZHRu7g4d3dyKs1kL2tyG
vqhGI0ulONW+WYEaHnATVmzJAeZqeH4QZataw91dklSrpV5ylmfubiRhV/xWjZUn
pqMPOd9j0D4YMickZkIbaS6oIxG3YnItSnK2B7hfsdv7xWud4Haf7TTpMJyix3EK
uT6oPvq1e96y3LhTGm1eAlSJt8waHH5cnFeFl3lfWSdBWyH6qgbHwe5Ahl+9TXfj
cglcCeshrUdTQ37dRUjS8nIg7PYNDuAfKZl/da50zxGdc1IZbHxQIBrtpPXDUr7f
M8yPFPFaM+1ovSEMi6XAFrVroUfTxAA4/LlFMwnG3ImxdQSvHpHZujYyXNU3ROjB
mIrAecdpUKTviocBYqtYwumkqhiy7haAM29TaxLeuXIs+5NRl/pvvjvKrSBEpYRe
xCYhE/e5b3A9YuHnStbH5CXOT095j6o3msHs/6HbXXBwkc/zYTbCBxu4L0uDlJhn
tx5u9zbLNrK4tnL13vCl9Vp5+0sPRWwoZngaCIPdf/gU1Q3wGTaCSdxXrWo39UDZ
lY2U1a/NJBRFWTohQe3f+br3
=zu6Q
-----END PGP SIGNATURE-----

--=-4YlAqU8J+DrCh9skCs+6--
