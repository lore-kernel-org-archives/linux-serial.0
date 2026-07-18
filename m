Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF2039D6C8
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384910; cv=none; b=ftajIajDkswKgUMY66iUL8lTs/qctcZmC4gUSfGPxO2pmNCmCgdzi8/NB6OccjY2FGtw/Vld3Ku3INV9hoohxYicFOa7bRPEs+DL5GyoEVam4CVek++b5b7OFnCVvUCbFuseOdz5NyXgmvvnUFvKmio/oC21Hwt84Vd9YPtrHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384910; c=relaxed/simple;
	bh=XGdBnlFeluYX7ANXTUq+Dsnzw2No2xxTg/K49MKAXiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apVbErRRkZ+fl2bzYKDBy0LC3G/KMivl4Dsw7j+8iAxssBGh4sMbaB9Zs6/ZuCjbYySD6EHqXvjvr9mIwJsyUlmg2zgGTNkKxxs+NpYtmvIfdMkDuzclL6U+MJtWwLGVpyunuHAhTHLIqBirbZA3ql9ZbQZY6++9RfYyuVbLm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QngU9CFc; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QngU9CFc"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 47F36240108
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 16:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784384898;
	bh=it/WDWtNGsWHOA8PCwtsAr3wvCkue3DohciAQiqG+9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=QngU9CFcbEk8DxiEHnRFwo1MKQlqxfhNKiy+9LnIMI7w8P0ASU4XrgPeJ1PYc0v6N
	 HxpB8tUoD0ZUVBEvEBNsb7XWPjNBMynCNZrhuj7x4eJmmd0rvpxDBKjuQCfc9T92ni
	 ZIVD0IvsoRbWDN8H7GINfmZxJx65vpcBXeZwR3mAxAYDch/aioSDPJbmZtpTREzDla
	 YDGJ3aqCrb7KhckplO7XrQsHF/mf8Op/hREPrxP/qNMwvHMnPxpmT3I8LvEhztZVSn
	 IrRNsQ3DW6NntwNumzruxN3ijCaPJJTDR6dk9W1SnnURUy9WnHCcdLjfNI7vHN2/AY
	 44Zpu0Wj26TFg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2Tf74f9Nz6tvy;
	Sat, 18 Jul 2026 16:28:15 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 18 Jul 2026 14:28:17 +0000
Subject: [PATCH v15 1/3] rust: add basic serial device bus abstractions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-rust_serdev-v15-1-208ed2e6ec15@posteo.de>
References: <20260718-rust_serdev-v15-0-208ed2e6ec15@posteo.de>
In-Reply-To: <20260718-rust_serdev-v15-0-208ed2e6ec15@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=27472;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=XGdBnlFeluYX7ANXTUq+Dsnzw2No2xxTg/K49MKAXiw=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW417zpUFWhMLGmdDyPqBWJmJYTobixvxGG//X
 wapFKqZUxuJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaluNexsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IK0xAAqHSPDbeb6RlNhF8Fg7RiY6M5dF8kphZ
 KtWRbIa/Gk7SCZaNDKMt9aoNOPsLSSL2tSLqm+R6HAWB2cl5+pMdev3lPCfy+DHY80L8AGkVY9c
 gi/PVTJYD833RXOMceW7jFAQasoTTOWjteYpgXDexJ7SWMXrNWGSoBdvmdE+nzbub8bAdesVM7J
 5/RpvSwOZl41xtNjRDXbHgFbWyCOkMckaKJH7a8WfiMFcdPs4scK0oEHqgTWnk95N+eU+4ewLH7
 Cso0IjNPQdtaD7zneqw+asTaebRj4NxfL9d1IRSxCNI/wQh+vcg0N4qlevoKgG7YTaYl5CXgo81
 uzv23oVXgBXpY7jHPhI4VrcwIhvcebVFogrTkpwklZZCn6SjL1EDq2R9KgcPWP5P61BrPyOO2kl
 EWvcHsKBkFcFCed15udkiSj3bs9nzTJVBKeOkPi9xoKG2ib1wDk7v0rbDAZfbnM3ZSGukVTBDTr
 Xp+3R4XRqkYEsbYUJYckarKexD6PsDMywe4hgVsb2BthBTb3VQcivGKUQ9quGS2hlzkjng+M0gI
 eNoGSyT5gFTPXLtRNb9IONc0t8kCJiXDp304PTMWFYVQcUTeFH2Fv5v5y9m0h79B5Bn+rY6fzOw
 MH1bjlblzQ3xWfExRvTLwJfRQm4sG1BqL28QcNDWaQoTUt4ERgbo=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement the basic serial device bus abstractions required to write a
serial device bus device driver with or without the need for initial device
data. This includes the following data structures:

The `serdev::Driver` trait represents the interface to the driver.

The `serdev::Device` abstraction represents a `struct serdev_device`.

In order to provide the Serdev specific parts to a generic
`driver::Registration` the `driver::RegistrationOps` trait is
implemented by `serdev::Adapter`.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS                     |   2 +
 drivers/tty/serdev/Kconfig      |   7 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/serdev.c           |  22 ++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/serdev.rs           | 605 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 640 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d15..cd735d227892 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24568,6 +24568,8 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/serial/serial.yaml
 F:	drivers/tty/serdev/
 F:	include/linux/serdev.h
+F:	rust/helpers/serdev.c
+F:	rust/kernel/serdev.rs
 
 SERIAL IR RECEIVER
 M:	Sean Young <sean@mess.org>
diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index 46ae732bfc68..e6dfe949ad01 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -9,6 +9,13 @@ menuconfig SERIAL_DEV_BUS
 
 	  Note that you typically also want to enable TTY port controller support.
 
+config RUST_SERIAL_DEV_BUS_ABSTRACTIONS
+	bool "Rust Serial device bus abstractions"
+	depends on RUST
+	select SERIAL_DEV_BUS
+	help
+	  This enables the Rust abstraction for the serial device bus API.
+
 if SERIAL_DEV_BUS
 
 config SERIAL_DEV_CTRL_TTYPORT
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b..fe7c505da236 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -85,6 +85,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/security.h>
+#include <linux/serdev.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 998e31052e66..6921a5ecb78a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -87,6 +87,7 @@
 #include "regulator.c"
 #include "scatterlist.c"
 #include "security.c"
+#include "serdev.c"
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
diff --git a/rust/helpers/serdev.c b/rust/helpers/serdev.c
new file mode 100644
index 000000000000..c52b78ca3fc7
--- /dev/null
+++ b/rust/helpers/serdev.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/serdev.h>
+
+__rust_helper
+void rust_helper_serdev_device_driver_unregister(struct serdev_device_driver *sdrv)
+{
+	serdev_device_driver_unregister(sdrv);
+}
+
+__rust_helper
+void rust_helper_serdev_device_put(struct serdev_device *serdev)
+{
+	serdev_device_put(serdev);
+}
+
+__rust_helper
+void rust_helper_serdev_device_set_client_ops(struct serdev_device *serdev,
+					      const struct serdev_device_ops *ops)
+{
+	serdev_device_set_client_ops(serdev, ops);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df..d5ca17336739 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -119,6 +119,8 @@
 pub mod scatterlist;
 pub mod security;
 pub mod seq_file;
+#[cfg(CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS)]
+pub mod serdev;
 pub mod sizes;
 #[cfg(CONFIG_SOC_BUS)]
 pub mod soc;
diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
new file mode 100644
index 000000000000..0fdb37cff15d
--- /dev/null
+++ b/rust/kernel/serdev.rs
@@ -0,0 +1,605 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the serial device bus.
+//!
+//! C header: [`include/linux/serdev.h`](srctree/include/linux/serdev.h)
+
+use crate::{
+    acpi,
+    device,
+    driver,
+    error::{
+        from_result,
+        to_result,
+        VTABLE_DEFAULT_ERROR, //
+    },
+    new_mutex,
+    of,
+    prelude::*,
+    sync::{
+        aref::AlwaysRefCounted,
+        Mutex, //
+    },
+    time::Jiffies,
+    types::{
+        Opaque,
+        ScopeGuard, //
+    }, //
+};
+
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
+    mem::{offset_of, MaybeUninit},
+    ptr::NonNull, //
+};
+
+/// Parity bit to use with a serial device.
+#[repr(u32)]
+pub enum Parity {
+    /// No parity bit.
+    None = bindings::serdev_parity_SERDEV_PARITY_NONE,
+    /// Even partiy.
+    Even = bindings::serdev_parity_SERDEV_PARITY_EVEN,
+    /// Odd parity.
+    Odd = bindings::serdev_parity_SERDEV_PARITY_ODD,
+}
+
+/// An adapter for the registration of serial device bus device drivers.
+pub struct Adapter<T: Driver>(T);
+
+// SAFETY:
+// - `bindings::serdev_device_driver` is a C type declared as `repr(C)`.
+// - `PrivateData<'bound, T>` is the type of the driver's device private data.
+// - `struct serdev_device_driver` embeds a `struct device_driver`.
+// - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
+    type DriverType = bindings::serdev_device_driver;
+    type DriverData<'bound> = PrivateData<'bound, T>;
+    const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
+}
+
+// SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
+    unsafe fn register(
+        sdrv: &Opaque<Self::DriverType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        let of_table = match T::OF_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
+        let acpi_table = match T::ACPI_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
+        // SAFETY: It's safe to set the fields of `struct serdev_device_driver` on initialization.
+        unsafe {
+            (*sdrv.get()).driver.name = name.as_char_ptr();
+            (*sdrv.get()).probe = Some(Self::probe_callback);
+            (*sdrv.get()).remove = Some(Self::remove_callback);
+            (*sdrv.get()).driver.of_match_table = of_table;
+            (*sdrv.get()).driver.acpi_match_table = acpi_table;
+        }
+
+        // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
+        to_result(unsafe { bindings::__serdev_device_driver_register(sdrv.get(), module.0) })
+    }
+
+    unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {
+        // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
+        unsafe { bindings::serdev_device_driver_unregister(sdrv.get()) };
+    }
+}
+
+#[doc(hidden)]
+#[pin_data(PinnedDrop)]
+pub struct PrivateData<'bound, T: Driver> {
+    sdev: &'bound Device<device::Bound>,
+    #[pin]
+    driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
+    open: UnsafeCell<bool>,
+    /// Whether `receive_buf_callback` is allowed to call `Driver::receive`.
+    ///
+    /// If locked, the receive_buf_callback will be blocked on data reception.
+    /// This is the case while the driver is being probed or while [`PrivateData`] is being dropped.
+    /// This is necessary, because we need to open the serdev device before the driver has been
+    /// probed in order to allow it to be configured, which allows `receive_buf_callback` to be
+    /// called. Thus we need to block data until probe completes and the driver data becomes
+    /// initialized.
+    ///
+    /// If unlocked and true, the receive_buf_callback will forward the data to
+    /// `Driver::receive`. This is the normal state of operation.
+    ///
+    /// If unlocked and false, the receive_buf_callback will throw away the data.
+    /// This is only the case, if the serdev device is open and
+    /// - the driver returned an error in probe
+    /// or
+    /// - the driver data already has been dropped, because it was unbound.
+    #[pin]
+    active: Mutex<bool>,
+}
+
+#[pinned_drop]
+impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
+    fn drop(self: Pin<&mut Self>) {
+        let mut active = self.active.lock();
+        if *active {
+            // SAFETY:
+            // - We have exclusive access to `self.driver`.
+            // - `self.driver` is guaranteed to be initialized.
+            unsafe { (*self.driver.get()).assume_init_drop() };
+            *active = false;
+        }
+        drop(active);
+
+        // SAFETY: We have exclusive access to `self.open`.
+        if unsafe { *self.open.get() } {
+            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointer to a valid
+            // `struct serdev_device`.
+            unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
+        }
+    }
+}
+
+impl<T: Driver> Adapter<T> {
+    const OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
+        receive_buf: if T::HAS_RECEIVE {
+            Some(Self::receive_buf_callback)
+        } else {
+            None
+        },
+        write_wakeup: Some(bindings::serdev_device_write_wakeup),
+    };
+
+    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi::c_int {
+        // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer to
+        // a `struct serdev_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `probe_callback()`.
+        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal<'_>>>() };
+        let info = <Self as driver::Adapter>::id_info(sdev.as_ref());
+
+        from_result(|| {
+            sdev.as_ref().set_drvdata(try_pin_init!(PrivateData::<T> {
+                sdev: &**sdev,
+                driver: MaybeUninit::<T::Data<'_>>::zeroed().into(),
+                open: false.into(),
+                active <- new_mutex!(false),
+            }))?;
+            // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
+            let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
+            let private_data = ScopeGuard::new_with_data(private_data, |_| {
+                // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
+                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
+            });
+            let mut active = private_data.active.lock();
+
+            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::OPS) };
+
+            // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer
+            // to a `serdev_device`.
+            to_result(unsafe { bindings::serdev_device_open(sdev.as_raw()) })?;
+
+            // SAFETY: We have exclusive access to `private_data.open`.
+            unsafe { *private_data.open.get() = true };
+
+            let data = T::probe(sdev, info);
+
+            // SAFETY: We have exclusive access to `private_data.driver`.
+            let driver = unsafe { &mut *private_data.driver.get() };
+            // SAFETY:
+            // - `driver.as_mut_ptr()` is a valid pointer to uninitialized data.
+            // - `private_data.driver` is pinned.
+            let result = unsafe { data.__pinned_init(driver.as_mut_ptr()) };
+
+            *active = result.is_ok();
+
+            drop(active);
+
+            result.map(|()| {
+                private_data.dismiss();
+                0
+            })
+        })
+    }
+
+    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
+        // SAFETY: The serial device bus only ever calls the remove callback with a valid pointer
+        // to a `struct serdev_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `remove_callback()`.
+        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal<'_>>>() };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
+        let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
+
+        // SAFETY: No one has exclusive access to `private_data.driver`.
+        let data = unsafe { &*private_data.driver.get() };
+        // SAFETY:
+        // - `private_data.driver` is pinned.
+        // - `remove_callback` is only ever called after a successful call to `probe_callback`,
+        //   hence it's guaranteed that `private_data.driver` was initialized.
+        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
+
+        T::unbind(sdev, data_pinned);
+    }
+
+    extern "C" fn receive_buf_callback(
+        sdev: *mut bindings::serdev_device,
+        buf: *const u8,
+        length: usize,
+    ) -> usize {
+        // SAFETY: The serial device bus only ever calls the receive buf callback with a valid
+        // pointer to a `struct serdev_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `receive_buf_callback()`.
+        let sdev = unsafe { &*sdev.cast::<Device<device::BoundInternal>>() };
+
+        // SAFETY: `receive_buf_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
+        let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
+        let active = private_data.active.lock();
+
+        if !*active {
+            return length;
+        }
+
+        // SAFETY: No one has exclusive access to `private_data.driver`.
+        let data = unsafe { &*private_data.driver.get() };
+        // SAFETY:
+        // - `private_data.driver` is pinned.
+        // - `receive_buf_callback` is only ever called after a successful call to `probe_callback`,
+        //   hence it's guaranteed that `private_data.driver` was initialized.
+        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
+
+        // SAFETY: `buf` is guaranteed to be non-null and has the size of `length`.
+        let buf = unsafe { core::slice::from_raw_parts(buf, length) };
+
+        T::receive(sdev, data_pinned, buf)
+    }
+}
+
+impl<T: Driver> driver::Adapter for Adapter<T> {
+    type IdInfo = T::IdInfo;
+
+    fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
+        T::OF_ID_TABLE
+    }
+
+    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
+        T::ACPI_ID_TABLE
+    }
+}
+
+/// Declares a kernel module that exposes a single serial device bus device driver.
+///
+/// # Examples
+///
+/// ```ignore
+/// kernel::module_serdev_device_driver! {
+///     type: MyDriver,
+///     name: "Module name",
+///     authors: ["Author name"],
+///     description: "Description",
+///     license: "GPL v2",
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_serdev_device_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::serdev::Adapter<T>, { $($f)* });
+    };
+}
+
+/// The serial device bus device driver trait.
+///
+/// Drivers must implement this trait in order to get a serial device bus device driver registered.
+///
+/// # Examples
+///
+///```
+/// # use kernel::{
+///     acpi,
+///     bindings,
+///     device::{
+///         Bound,
+///         Core, //
+///     },
+///     of,
+///     serdev, //
+/// };
+///
+/// struct MyDriver;
+///
+/// kernel::of_device_table!(
+///     OF_TABLE,
+///     MODULE_OF_TABLE,
+///     <MyDriver as serdev::Driver>::IdInfo,
+///     [
+///         (of::DeviceId::new(c"test,device"), ())
+///     ]
+/// );
+///
+/// kernel::acpi_device_table!(
+///     ACPI_TABLE,
+///     MODULE_ACPI_TABLE,
+///     <MyDriver as serdev::Driver>::IdInfo,
+///     [
+///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
+///     ]
+/// );
+///
+/// #[vtable]
+/// impl serdev::Driver for MyDriver {
+///     type IdInfo = ();
+///     type Data<'bound> = Self;
+///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+///
+///     fn probe<'bound>(
+///         sdev: &'bound serdev::Device<Core<'_>>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+///         sdev.set_baudrate(115200);
+///         sdev.write_all(b"Hello\n", 0usize)?;
+///         Ok(MyDriver)
+///     }
+/// }
+///```
+#[vtable]
+pub trait Driver {
+    /// The type holding driver private data about each device id supported by the driver.
+    // TODO: Use associated_type_defaults once stabilized:
+    //
+    // ```
+    // type IdInfo: 'static = ();
+    // ```
+    type IdInfo: 'static;
+
+    /// The type of the driver's bus device private data.
+    type Data<'bound>: Send + Sync + 'bound;
+
+    /// The table of OF device ids supported by the driver.
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+
+    /// The table of ACPI device ids supported by the driver.
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+
+    /// Serial device bus device driver probe.
+    ///
+    /// Called when a new serial device bus device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe<'bound>(
+        sdev: &'bound Device<device::Core<'_>>,
+        id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
+
+    /// Serial device bus device driver unbind.
+    ///
+    /// Called when a [`Device`] is unbound from its bound [`Driver`]. Implementing this callback
+    /// is optional.
+    ///
+    /// This callback serves as a place for drivers to perform teardown operations that require a
+    /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
+    ///
+    /// Otherwise, release operations for driver resources should be performed in `Drop`.
+    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
+        let _ = (sdev, this);
+    }
+
+    /// Serial device bus device data receive callback.
+    ///
+    /// Called when data got received from device.
+    ///
+    /// Returns the number of bytes accepted.
+    fn receive<'bound>(
+        sdev: &'bound Device<device::Bound>,
+        this: Pin<&Self::Data<'bound>>,
+        data: &[u8],
+    ) -> usize {
+        let _ = (sdev, this, data);
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// The serial device bus device representation.
+///
+/// This structure represents the Rust abstraction for a C `struct serdev_device`. The
+/// implementation abstracts the usage of an already existing C `struct serdev_device` within Rust
+/// code that we get passed from the C side.
+///
+/// # Invariants
+///
+/// A [`Device`] instance represents a valid `struct serdev_device` created by the C portion of
+/// the kernel.
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::serdev_device>,
+    PhantomData<Ctx>,
+);
+
+impl<Ctx: device::DeviceContext> Device<Ctx> {
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::serdev_device {
+        self.0.get()
+    }
+}
+
+impl Device<device::Bound> {
+    /// Set the baudrate in bits per second.
+    ///
+    /// Common baudrates are 115200, 9600, 19200, 57600, 4800.
+    ///
+    /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
+    #[inline]
+    pub fn set_baudrate(&self, speed: u32) -> Result<(), u32> {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        let ret = unsafe { bindings::serdev_device_set_baudrate(self.as_raw(), speed) };
+        if ret == speed {
+            Ok(())
+        } else {
+            Err(ret)
+        }
+    }
+
+    /// Set if flow control should be enabled.
+    ///
+    /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
+    #[inline]
+    pub fn set_flow_control(&self, enable: bool) {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe { bindings::serdev_device_set_flow_control(self.as_raw(), enable) };
+    }
+
+    /// Set parity to use.
+    ///
+    /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
+    #[inline]
+    pub fn set_parity(&self, parity: Parity) -> Result {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        to_result(unsafe { bindings::serdev_device_set_parity(self.as_raw(), parity as u32) })
+    }
+
+    /// Write data to the serial device until the controller has accepted all the data or has
+    /// been interrupted by a timeout or signal.
+    ///
+    /// Note that any accepted data has only been buffered by the controller. Use
+    /// [`Device::wait_until_sent`] to make sure the controller write buffer has actually been
+    /// emptied.
+    ///
+    /// Use a timeout of 0 to wait indefinitely.
+    ///
+    /// Returns the number of bytes written (less than `data.len()` if interrupted).
+    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
+    /// before any bytes were written. [`kernel::error::code::EINVAL`] if `data.len() > i32::MAX`.
+    #[inline]
+    pub fn write_all(&self, data: &[u8], timeout: impl Into<Jiffies>) -> Result<usize> {
+        if data.len() > i32::MAX as usize {
+            return Err(EINVAL);
+        }
+
+        // SAFETY:
+        // - `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        // - `data.as_ptr()` is guaranteed to be a valid array pointer with the size of
+        //   `data.len()`.
+        let ret = unsafe {
+            bindings::serdev_device_write(
+                self.as_raw(),
+                data.as_ptr(),
+                data.len(),
+                isize::try_from(timeout.into()).unwrap_or_default(),
+            )
+        };
+        // CAST: negative return values are guaranteed to be between `-MAX_ERRNO` and `-1`,
+        // which always fit into a `i32`.
+        to_result(ret as i32).map(|()| ret.unsigned_abs())
+    }
+
+    /// Write data to the serial device.
+    ///
+    /// If you want to write until the controller has accepted all the data, use
+    /// [`Device::write_all`].
+    ///
+    /// Note that any accepted data has only been buffered by the controller. Use
+    /// [`Device::wait_until_sent`] to make sure the controller write buffer has actually been
+    /// emptied.
+    ///
+    /// Returns the number of bytes written (less than `data.len()` if not enough room in the
+    /// write buffer).
+    #[inline]
+    pub fn write(&self, data: &[u8]) -> Result<u32> {
+        if data.len() > i32::MAX as usize {
+            return Err(EINVAL);
+        }
+
+        // SAFETY:
+        // - `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        // - `data.as_ptr()` is guaranteed to be a valid array pointer with the size of
+        //   `data.len()`.
+        let ret =
+            unsafe { bindings::serdev_device_write_buf(self.as_raw(), data.as_ptr(), data.len()) };
+
+        to_result(ret as i32).map(|()| ret.unsigned_abs())
+    }
+
+    /// Send data to the serial device immediately.
+    ///
+    /// Note that this doesn't guarantee that the data has been transmitted.
+    /// Use [`Device::wait_until_sent`] for this purpose.
+    #[inline]
+    pub fn write_flush(&self) {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe { bindings::serdev_device_write_flush(self.as_raw()) };
+    }
+
+    /// Wait for the data to be sent.
+    ///
+    /// After this function, the write buffer of the controller should be empty or the timeout
+    /// elapsed.
+    ///
+    /// Use a timeout of 0 to wait indefinitely.
+    #[inline]
+    pub fn wait_until_sent(&self, timeout: impl Into<Jiffies>) {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe {
+            bindings::serdev_device_wait_until_sent(
+                self.as_raw(),
+                isize::try_from(timeout.into()).unwrap_or_default(),
+            )
+        };
+    }
+}
+
+// SAFETY: `serdev::Device` is a transparent wrapper of `struct serdev_device`.
+// The offset is guaranteed to point to a valid device field inside `serdev::Device`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::serdev_device, dev);
+}
+
+// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
+// argument.
+kernel::impl_device_context_deref!(unsafe { Device });
+kernel::impl_device_context_into_aref!(Device);
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        self.as_ref().inc_ref();
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::serdev_device_put(obj.cast().as_ptr()) }
+    }
+}
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct serdev_device`.
+        let dev = unsafe { &raw mut (*self.as_raw()).dev };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+// SAFETY: A `Device` is always reference-counted and can be released from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all methods of `Device`
+// (i.e. `Device<Normal>) are thread safe.
+unsafe impl Sync for Device {}
+
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct serdev_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}

-- 
2.54.0

