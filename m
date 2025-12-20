Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F52D73A7
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256252; cv=none; b=T7SLn2k2i/ZxS+7PircVtVtdGDQP/dnNW+fRd8d403ym5vkQ6PmF3lPtKnO+qpN5NSkhm/5Kl3lht3mpX9gGTv42jRj9DjyTzAcq75IX2pp0pWntAP0p3cyfIqxMcYC8/S+J5pCOV939/0EzcrBJtTh+3PFywy8EZJUQtNR22MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256252; c=relaxed/simple;
	bh=9Jvsn7l5YbOt0di3XZLCVFZSASckH2ZyciBuEFUb0tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dj+y+8sQOoIRtxhSel+d+MpmGJO+PjR4ZL9AonGQwR/vre8FyHOPbMMEF0JpL6uhW1av+NZQhjChMaJVP/kUmprh+b5R/+KqEpZf63PqVW8Ri2uRw7NlKvTFDiCLUysjNL98e2lVplFkuXqH5LNHZj6R87HK1dMHbIsDo4UhlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=IognUFd2; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="IognUFd2"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 39A9524002A
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 19:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766256247; bh=7H3YhDYBNKq5GtrLwrm86gKeSlPYZm94Ra+gOByp63k=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=IognUFd2Q5zigq3JfAdRNPfJrEZloKWZUDiVktsebcw2rM419fud3kKnuQLJ7JWq3
	 gXymOgTSnqohCWRnkCuEyGaRiapRmg4p+I042OBv85lg5s87VzxXuxDzMm6x8d1kLd
	 Tsdr86HMtYgIr8TlNAqhIwjo5QEwDmih/RNTQ2KJg6XD75VfOhMbgrbwBmmU6Me6ZS
	 pBBaASvYYz6IuyjJ11SDZI64zU+FH3WNBGDKNLK6RAuwxLSFaOZmgY6eFXhp7OSexv
	 2av0OWMBB0MBHAuMjDP2Jon54HKHeWTPphFZ7IvAm+QjaLQ/wx5NKDr69zS48hR+Re
	 7Jpk6O0WlKWDQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dYYGF3BHfz9rxM;
	Sat, 20 Dec 2025 19:44:05 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 20 Dec 2025 18:44:06 +0000
Subject: [PATCH RFC 2/4] rust: add basic serial device bus abstractions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
In-Reply-To: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=35353;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=9Jvsn7l5YbOt0di3XZLCVFZSASckH2ZyciBuEFUb0tg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBpRu5yTPIGIbgB6Ye9fvXJGvMF7oWiG3cpKoaV8
 dtHA9fcNGyJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaUbuchsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9KBgxAAqoPUIHBLv1L5d/vWXzcqce+KgHmgdGz
 l/KvZGTOH1/kczp8nu8Mlkg/uI9hsgBAk8Eu/TROcvg9yvJDCl9Agl3oBQNIscRqigfFG/nJWxd
 syeoA6rFVUDGobnnL30/ZEKPAsMqjT/1bjqwIO4WKUxjWJFuTeEKON7q8NgJt5KO70GWJloJxUZ
 L84HIEc76JS9RXiTYZ0b8pd9QwjdBVnnDogkdDWC7LuMcoZ9gjWHPrZ+5/EX3i1CZAMO0yoBCm/
 usJjg7NwxQ4Pti5AKgyZhIaWsLujrtIn2l2z5BvCHKkLPCSSLhIEmqWqUyg1hKnHL+/3ZJjm9rF
 a65wpkmOw8XVFdEwIaBLsQ61ivCcasd8K6Tosu8NvEVQsG0dMZTcAbZ+AnHEHMNSH/x/wgX8bSi
 KrEtEEBe+JVsOJZoZrd+SL7buiqjzg+meYSYvUHfxOmjPK1dayJaz7Nts9pa9NCS0GDBXiPIOrJ
 F9kvd12TtbdE7zWccFOEjMonw+p/FMyuYxYg3XzErIMJcjJKdqWcmCLcwSYw/scLC/nfyowvhND
 j9Xl2HtmVZttigTZpOb4CVNbuQHK6se73rdplweYjBYSU5hBQPd9QEJFHKU/FZc25JydeBxjbLm
 uFS8plOBCPt8c2TAb+PYKEkl93jGHjYtM/eF1nYhr9IkFy/Mmh2Q=
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

Co-developed-by: Kari Argillander <kari.argillander@gmail.com>
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/serdev.c           |  22 ++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/serdev.rs           | 815 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 841 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a067038b4b42..bec6c6d0913a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -79,6 +79,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/security.h>
+#include <linux/serdev.h>
 #include <linux/slab.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 79c72762ad9c..834e9fbb897d 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -50,6 +50,7 @@
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
index f812cf120042..cc71195466b6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -136,6 +136,8 @@
 pub mod scatterlist;
 pub mod security;
 pub mod seq_file;
+#[cfg(CONFIG_SERIAL_DEV_BUS)]
+pub mod serdev;
 pub mod sizes;
 pub mod slice;
 mod static_assert;
diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
new file mode 100644
index 000000000000..0f5ef325a054
--- /dev/null
+++ b/rust/kernel/serdev.rs
@@ -0,0 +1,815 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the serial device bus.
+//!
+//! C header: [`include/linux/serdev.h`](srctree/include/linux/serdev.h)
+
+use crate::{
+    acpi,
+    container_of,
+    device,
+    driver,
+    error::{
+        from_result,
+        to_result,
+        VTABLE_DEFAULT_ERROR, //
+    },
+    of,
+    prelude::*,
+    time::Jiffies,
+    types::{AlwaysRefCounted, Opaque}, //
+};
+
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
+    mem::offset_of,
+    num::NonZero,
+    ptr::{
+        addr_of_mut, //
+        NonNull,
+    }, //
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
+/// Timeout in Jiffies.
+pub enum Timeout {
+    /// Wait for a specific amount of [`Jiffies`].
+    Value(NonZero<Jiffies>),
+    /// Wait as long as possible.
+    ///
+    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
+    MaxScheduleTimeout,
+}
+
+impl Timeout {
+    fn into_jiffies(self) -> isize {
+        match self {
+            Self::Value(value) => value.get().try_into().unwrap_or_default(),
+            Self::MaxScheduleTimeout => 0,
+        }
+    }
+}
+
+/// An adapter for the registration of serial device bus device drivers.
+pub struct Adapter<T: Driver>(T);
+
+// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::serdev_device_driver;
+
+    unsafe fn register(
+        sdrv: &Opaque<Self::RegType>,
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
+        // SAFETY: `sdrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe { bindings::__serdev_device_driver_register(sdrv.get(), module.0) })
+    }
+
+    unsafe fn unregister(sdrv: &Opaque<Self::RegType>) {
+        // SAFETY: `sdrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::serdev_device_driver_unregister(sdrv.get()) };
+    }
+}
+
+#[pin_data]
+struct Drvdata<T: Driver + 'static> {
+    #[pin]
+    driver: T,
+    initial_data: UnsafeCell<Option<T::InitialData>>,
+    late_probe_data: UnsafeCell<Option<Pin<KBox<T::LateProbeData>>>>,
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    const OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
+        receive_buf: if T::HAS_RECEIVE {
+            Some(Self::receive_buf_callback)
+        } else {
+            None
+        },
+        write_wakeup: if T::HAS_WRITE_WAKEUP {
+            Some(Self::write_wakeup_callback)
+        } else {
+            Some(bindings::serdev_device_write_wakeup)
+        },
+    };
+    const INITIAL_OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
+        receive_buf: Some(Self::initial_receive_buf_callback),
+        write_wakeup: if T::HAS_WRITE_WAKEUP_INITIAL {
+            Some(Self::initial_write_wakeup_callback)
+        } else {
+            Some(bindings::serdev_device_write_wakeup)
+        },
+    };
+    const NO_OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
+        receive_buf: None,
+        write_wakeup: Some(bindings::serdev_device_write_wakeup),
+    };
+
+    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi::c_int {
+        // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer to
+        // a `struct serdev_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `probe_callback()`.
+        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
+        let info = <Self as driver::Adapter>::id_info(sdev.as_ref());
+
+        from_result(|| {
+            let data = try_pin_init!(Drvdata {
+                driver <- T::probe(sdev, info),
+                initial_data: Some(Default::default()).into(),
+                late_probe_data: None.into(),
+            });
+
+            sdev.as_ref().set_drvdata(data)?;
+
+            // SAFETY: We just set drvdata to `Drvdata<T>`.
+            let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
+
+            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::INITIAL_OPS) };
+
+            // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer
+            // to a `struct serdev_device`.
+            to_result(unsafe {
+                bindings::devm_serdev_device_open(sdev.as_ref().as_raw(), sdev.as_raw())
+            })?;
+
+            // SAFETY: `&data.driver` is guaranteed to be pinned.
+            T::configure(sdev, unsafe { Pin::new_unchecked(&data.driver) }, info)?;
+
+            if !T::HAS_RECEIVE_INITIAL {
+                // SAFETY:
+                // - It is guaranteed that we have exclusive access to `data.initial_data` and
+                //   `data.late_probe_data`.
+                // - We just initialized `data.initial_data` with Some.
+                unsafe { Self::do_late_probe(sdev, data)? };
+            }
+
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// The caller must guarantee, that we have exclusive access to `data.initial_data` and
+    /// `data.late_probe_data`. `data.initial_data` must be Some.
+    /// (i. e. `late_probe` has not been called yet).
+    unsafe fn do_late_probe(sdev: &Device<device::CoreInternal>, data: Pin<&Drvdata<T>>) -> Result {
+        // SAFETY: `&data.driver` is guaranteed to be pinned.
+        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
+
+        // SAFETY: The function contract guarantees that we have exclusive access to
+        // `data.initial_data`.
+        let initial_data = unsafe { &mut *data.initial_data.get() };
+
+        // SAFETY: The function contract guarantees that we have exclusive access to
+        // `data.late_probe_data`.
+        let late_probe_data = unsafe { &mut *data.late_probe_data.get() };
+
+        *late_probe_data = Some(KBox::pin_init(
+            T::late_probe(
+                sdev,
+                data_driver,
+                // SAFETY: The function contract guarantees that `data.initial_data` is Some.
+                unsafe { initial_data.take().unwrap_unchecked() },
+            ),
+            GFP_KERNEL,
+        )?);
+        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+        unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::OPS) };
+        Ok(())
+    }
+
+    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
+        // SAFETY: The serial device bus only ever calls the remove callback with a valid pointer
+        // to a `struct serdev_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `remove_callback()`.
+        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { sdev.as_ref().drvdata_obtain::<Drvdata<T>>() };
+
+        // SAFETY: `&data.driver` is guaranteed to be pinned.
+        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
+
+        // SAFETY:
+        // - `data.late_probe_data` is guaranteed to be pinned.
+        // - It is guaranteed that we have exclusive access to `data.late_probe_data`.
+        let late_probe_data = unsafe {
+            (*data.late_probe_data.get())
+                .as_deref()
+                .map(|data| Pin::new_unchecked(data))
+        };
+
+        T::unbind(sdev, data_driver, late_probe_data);
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
+        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `receive_buf_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<Drvdata<T>>>`.
+        let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
+
+        // SAFETY: `buf` is guaranteed to be non-null and has the size of `length`.
+        let buf = unsafe { core::slice::from_raw_parts(buf, length) };
+
+        // SAFETY: `&data.driver` is guaranteed to be pinned.
+        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
+
+        // SAFETY:
+        // - `data.late_probe_data` is guaranteed to be Some.
+        // - `data.late_probe_data` is guaranteed to be pinned.
+        let late_probe_data = unsafe {
+            Pin::new_unchecked((*data.late_probe_data.get()).as_deref().unwrap_unchecked())
+        };
+
+        T::receive(sdev, data_driver, late_probe_data, buf)
+    }
+
+    extern "C" fn write_wakeup_callback(sdev: *mut bindings::serdev_device) {
+        // SAFETY: The serial device bus only ever calls the write wakeup callback with a valid
+        // pointer to a `struct serdev_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `write_wakeup_callback()`.
+        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `write_wakeup_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<Drvdata<T>>>`.
+        let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
+
+        // SAFETY: `sdev.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe { bindings::serdev_device_write_wakeup(sdev.as_raw()) };
+
+        // SAFETY: `&data.driver` is guaranteed to be pinned.
+        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
+
+        // SAFETY:
+        // - `data.late_probe_data` is guaranteed to be Some.
+        // - `data.late_probe_data` is guaranteed to be pinned.
+        let late_probe_data = unsafe {
+            Pin::new_unchecked((*data.late_probe_data.get()).as_deref().unwrap_unchecked())
+        };
+
+        // SAFETY: As long as the driver implementation meets the safety requirements, this call
+        // is safe.
+        unsafe { T::write_wakeup(sdev, data_driver, late_probe_data) };
+    }
+
+    extern "C" fn initial_receive_buf_callback(
+        sdev: *mut bindings::serdev_device,
+        buf: *const u8,
+        length: usize,
+    ) -> usize {
+        if !T::HAS_RECEIVE_INITIAL {
+            return 0;
+        }
+
+        // SAFETY: The serial device bus only ever calls the receive buf callback with a valid
+        // pointer to a `struct serdev_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `receive_buf_callback()`.
+        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `buf` is guaranteed to be non-null and has the size of `length`.
+        let buf = unsafe { core::slice::from_raw_parts(buf, length) };
+
+        // SAFETY: `initial_receive_buf_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<Drvdata<T>>>`.
+        let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
+
+        // SAFETY: `&data.driver` is guaranteed to be pinned.
+        let driver_data = unsafe { Pin::new_unchecked(&data.driver) };
+
+        // SAFETY:
+        // - `data.initial_data` is always Some until `InitialReceiveResult::Ready` is
+        //   returned below.
+        // - It is guaranteed that we have exclusive access to `data.initial_data`.
+        let initial_data = unsafe { (*data.initial_data.get()).as_mut().unwrap_unchecked() };
+
+        match T::receive_initial(sdev, driver_data, initial_data, buf) {
+            Ok(InitialReceiveResult::Pending(size)) => size,
+            Ok(InitialReceiveResult::Ready(size)) => {
+                // SAFETY:
+                // - It is guaranteed that we have exclusive access to `data.initial_data` and
+                //   `data.late_probe_data`.
+                // - We just initialized `data.initial_data` with Some.
+                if let Err(err) = unsafe { Self::do_late_probe(sdev, data) } {
+                    dev_err!(sdev.as_ref(), "Unable to late probe device: {err:?}\n");
+                    // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to
+                    // `serdev_device`.
+                    unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::NO_OPS) };
+                    return length;
+                }
+                size
+            }
+            Err(err) => {
+                dev_err!(
+                    sdev.as_ref(),
+                    "Unable to receive initial data for probe: {err:?}.\n"
+                );
+                // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+                unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::NO_OPS) };
+                length
+            }
+        }
+    }
+
+    extern "C" fn initial_write_wakeup_callback(sdev: *mut bindings::serdev_device) {
+        // SAFETY: The serial device bus only ever calls the write wakeup callback with a valid
+        // pointer to a `struct serdev_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `write_wakeup_callback()`.
+        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `initial_write_wakeup_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<Drvdata<T>>>`.
+        let data = unsafe { sdev.as_ref().drvdata_borrow::<Drvdata<T>>() };
+
+        // SAFETY: `sdev.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe { bindings::serdev_device_write_wakeup(sdev.as_raw()) };
+
+        // SAFETY: `&data.driver` is guaranteed to be pinned.
+        let data_driver = unsafe { Pin::new_unchecked(&data.driver) };
+
+        // SAFETY: As long as the driver implementation meets the safety requirements, this call
+        // is safe.
+        unsafe { T::write_wakeup_initial(sdev, data_driver) };
+    }
+}
+
+impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
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
+/// Result for `receive_initial` in [`Driver`].
+pub enum InitialReceiveResult {
+    /// More data is required.
+    ///
+    /// The inner data is the number of bytes accepted.
+    Pending(usize),
+    /// Ready for late probe.
+    ///
+    /// The inner data is the number of bytes accepted.
+    Ready(usize),
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
+///     type LateProbeData = ();
+///     type InitialData = ();
+///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+///
+///     fn probe(
+///         _sdev: &serdev::Device,
+///         _id_info: Option<&Self::IdInfo>,
+///     ) -> impl PinInit<Self, Error> {
+///         Err(ENODEV)
+///     }
+///
+///     fn configure(
+///         dev: &serdev::Device<Core>,
+///         _this: Pin<&Self>,
+///         _id_info: Option<&Self::IdInfo>,
+///     ) -> Result {
+///         dev.set_baudrate(115200);
+///         Ok(())
+///     }
+///
+///     fn late_probe(
+///        _dev: &serdev::Device<Bound>,
+///        _this: Pin<&Self>,
+///        _initial_data: Self::InitialData,
+///    ) -> impl PinInit<Self::LateProbeData, Error> {
+///        Ok(())
+///    }
+/// }
+///```
+#[vtable]
+pub trait Driver: Send {
+    /// The type holding driver private data about each device id supported by the driver.
+    // TODO: Use associated_type_defaults once stabilized:
+    //
+    // ```
+    // type IdInfo: 'static = ();
+    // type LateProbeData: Send + 'static = ();
+    // type InitialData: Default + Send + 'static = ();
+    // ```
+    type IdInfo: 'static;
+
+    /// Data returned in `late_probe` function.
+    type LateProbeData: Send + 'static;
+    /// Data used for initial data.
+    type InitialData: Default + Send + 'static;
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
+    fn probe(sdev: &Device, id_info: Option<&Self::IdInfo>) -> impl PinInit<Self, Error>;
+
+    /// Serial device bus device driver configure.
+    ///
+    /// Called directly after the serial device bus device has been opened.
+    /// This should be used for setting up the communication (i. e. baudrate, flow control, parity)
+    /// and sending an initial hello if required.
+    fn configure(
+        sdev: &Device<device::Core>,
+        this: Pin<&Self>,
+        id_info: Option<&Self::IdInfo>,
+    ) -> Result;
+
+    /// Serial device bus device data receive callback (initial).
+    ///
+    /// Called when data got received from device, before `late_probe` has been called.
+    /// This should be used, to get information about the device for `late_probe`.
+    ///
+    /// Returns `InitialReceiveResult::Pending` if more data is still required for `late_probe`.
+    /// Otherwise `InitialReceiveResult::Ready`. The inner data is the number of bytes accepted.
+    fn receive_initial(
+        sdev: &Device<device::Bound>,
+        this: Pin<&Self>,
+        initial_data: &mut Self::InitialData,
+        data: &[u8],
+    ) -> Result<InitialReceiveResult> {
+        let _ = (sdev, this, initial_data, data);
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Serial device bus device write wakeup callback (initial).
+    ///
+    /// Called when ready to transmit more data, before `late_probe` has been called.
+    ///
+    /// # Safety
+    ///
+    /// This function must not sleep.
+    unsafe fn write_wakeup_initial(sdev: &Device<device::Core>, this: Pin<&Self>) {
+        let _ = (sdev, this);
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Serial device bus device late probe.
+    ///
+    /// Called after the initial data is available.
+    /// If `receive_initial` isn't implemented, this will be called directly after configure.
+    fn late_probe(
+        sdev: &Device<device::Bound>,
+        this: Pin<&Self>,
+        initial_data: Self::InitialData,
+    ) -> impl PinInit<Self::LateProbeData, Error>;
+
+    /// Serial device bus device driver unbind.
+    ///
+    /// Called when a [`Device`] is unbound from its bound [`Driver`]. Implementing this callback
+    /// is optional.
+    ///
+    /// This callback serves as a place for drivers to perform teardown operations that require a
+    /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
+    ///
+    /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
+    fn unbind(
+        sdev: &Device<device::Core>,
+        this: Pin<&Self>,
+        late_probe_this: Option<Pin<&Self::LateProbeData>>,
+    ) {
+        let _ = (sdev, this, late_probe_this);
+    }
+
+    /// Serial device bus device data receive callback.
+    ///
+    /// Called when data got received from device.
+    ///
+    /// Returns the number of bytes accepted.
+    fn receive(
+        sdev: &Device<device::Bound>,
+        this: Pin<&Self>,
+        late_probe_this: Pin<&Self::LateProbeData>,
+        data: &[u8],
+    ) -> usize {
+        let _ = (sdev, this, late_probe_this, data);
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Serial device bus device write wakeup callback.
+    ///
+    /// Called when ready to transmit more data.
+    ///
+    /// # Safety
+    ///
+    /// This function must not sleep.
+    unsafe fn write_wakeup(
+        sdev: &Device<device::Bound>,
+        this: Pin<&Self>,
+        late_probe_this: Pin<&Self::LateProbeData>,
+    ) {
+        let _ = (sdev, this, late_probe_this);
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
+    pub fn set_baudrate(&self, speed: u32) -> u32 {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe { bindings::serdev_device_set_baudrate(self.as_raw(), speed) }
+    }
+
+    /// Set if flow control should be enabled.
+    ///
+    /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
+    pub fn set_flow_control(&self, enable: bool) {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe { bindings::serdev_device_set_flow_control(self.as_raw(), enable) };
+    }
+
+    /// Set parity to use.
+    ///
+    /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
+    pub fn set_parity(&self, parity: Parity) -> Result {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        to_result(unsafe { bindings::serdev_device_set_parity(self.as_raw(), parity as u32) })
+    }
+
+    /// Write data to the serial device until the controller has accepted all the data or has
+    /// been interrupted by a timeout or signal.
+    ///
+    /// Note that any accepted data has only been buffered by the controller. Use
+    /// [ Device::wait_until_sent`] to make sure the controller write buffer has actually been
+    /// emptied.
+    ///
+    /// Returns the number of bytes written (less than data if interrupted).
+    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
+    /// before any bytes were written.
+    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usize> {
+        // SAFETY:
+        // - `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        // - `data.as_ptr()` is guaranteed to be a valid array pointer with the size of
+        //   `data.len()`.
+        let ret = unsafe {
+            bindings::serdev_device_write(
+                self.as_raw(),
+                data.as_ptr(),
+                data.len(),
+                timeout.into_jiffies(),
+            )
+        };
+        if ret < 0 {
+            // CAST: negative return values are guaranteed to be between `-MAX_ERRNO` and `-1`,
+            // which always fit into a `i32`.
+            Err(Error::from_errno(ret as i32))
+        } else {
+            Ok(ret.unsigned_abs())
+        }
+    }
+
+    /// Write data to the serial device.
+    ///
+    /// If you want to write until the controller has accepted all the data, use
+    /// [`Device::write_all`].
+    ///
+    /// Note that any accepted data has only been buffered by the controller. Use
+    /// [ Device::wait_until_sent`] to make sure the controller write buffer has actually been
+    /// emptied.
+    ///
+    /// Returns the number of bytes written (less than data if interrupted).
+    /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
+    /// before any bytes were written.
+    pub fn write(&self, data: &[u8]) -> Result<u32> {
+        // SAFETY:
+        // - `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        // - `data.as_ptr()` is guaranteed to be a valid array pointer with the size of
+        //   `data.len()`.
+        let ret =
+            unsafe { bindings::serdev_device_write_buf(self.as_raw(), data.as_ptr(), data.len()) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret.unsigned_abs())
+        }
+    }
+
+    /// Send data to the serial device immediately.
+    ///
+    /// Note that this doesn't guarantee that the data has been transmitted.
+    /// Use [`Device::wait_until_sent`] for this purpose.
+    pub fn write_flush(&self) {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe { bindings::serdev_device_write_flush(self.as_raw()) };
+    }
+
+    /// Wait for the data to be sent.
+    ///
+    /// After this function, the write buffer of the controller should be empty.
+    pub fn wait_until_sent(&self, timeout: Timeout) {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
+        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), timeout.into_jiffies()) };
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
+        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+impl<Ctx: device::DeviceContext> TryFrom<&device::Device<Ctx>> for &Device<Ctx> {
+    type Error = kernel::error::Error;
+
+    fn try_from(dev: &device::Device<Ctx>) -> Result<Self, Self::Error> {
+        // SAFETY: By the type invariant of `Device`, `dev.as_raw()` is a valid pointer to a
+        // `struct device`.
+        if !unsafe { bindings::is_serdev_device(dev.as_raw()) } {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We've just verified that the device_type of `dev` is
+        // `serdev_device_type`, hence `dev` must be embedded in a valid `struct
+        // serdev_device_driver` as guaranteed by the corresponding C code.
+        let sdev = unsafe { container_of!(dev.as_raw(), bindings::serdev_device, dev) };
+
+        // SAFETY: `sdev` is a valid pointer to a `struct serdev_device_driver`.
+        Ok(unsafe { &*sdev.cast() })
+    }
+}
+
+// SAFETY: A `Device` is always reference-counted and can be released from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all methods of `Device`
+// (i.e. `Device<Normal>) are thread safe.
+unsafe impl Sync for Device {}

-- 
2.51.2


