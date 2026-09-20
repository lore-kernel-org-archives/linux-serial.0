Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15093EC805
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789914618; cv=none; b=dm3yiGyiCb7gMmmqLDYNR/tMvpzS/hO21HMmoGQc+T/nQ3IEf/Bhddh3NRy6pYAHiZNBVxeQdZtXFUjCS36ErRl/AYGMT2ZqoWcg4zgG82Vm68W1gugREWtav7YGZMED3ZisOpLH2+rkFpu7Ax/aqSO5DBxEMr1prEfmOypEfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789914618; c=relaxed/simple;
	bh=WQslHMs2svOlSFQafK7q53v+0G7DlzBK6lZSGEX3Nu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEqxdOHt65OkSR7dL2za/tidQR6xCQW69TLUkRLnnXb9OvlTSOf6zuiRphQTUYKVsFkm3CtgIYcPKOqBEXb3x1dd7Z/kWt7/NohDLLw9oz/QEjCwgVdVhP15j6lnQTb6JgcIf/UsKxq1odGqvEllU00yu7VwDbDQmu8jL+MKjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ksLpQgFD; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ksLpQgFD"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 3EBBA240031
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 16:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1789914604;
	bh=v2EF/fsRX2gtP/07bUp+y+QrpNj7xZBjUZMkm63RIN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=ksLpQgFDxFyxH1OSgbqyhzGsrQKvDGYkkmqrnXRV3fkdR91lfgKfasIw+d2sMEx0W
	 VRvUGVYyh9CQ9oygt4bTfVg8mboizrT0wl+EBeb8AprrtBrE/IISkndwW9STznfYs5
	 P5dwctQFX7LEnOAV42pLznTBbBD+8aky6NuAjmOjqYSl529fJCaH0m0NKN4zt2ag7+
	 z21uSr4OSaJIqkvKeMMRpYrRfwxdhCx3/iPP1myXOxKWorgp292QRsjahL1v1bLKVA
	 anPrRpYXBgMgwXmaTycTbG8ThWjLymVS+gQgIFgkMGpGeavZRTxa5l3oTyK5F8cGyf
	 872LTqyo4MfWw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hnpfc3gzqz9rxK;
	Sun, 20 Sep 2026 16:30:00 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 20 Sep 2026 14:30:02 +0000
Subject: [PATCH v2 3/3] rust: serdev: Simplify callbacks
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-rust_serdev_probe_refactor-v2-3-43b855162f5d@posteo.de>
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
In-Reply-To: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
To: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8348;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=WQslHMs2svOlSFQafK7q53v+0G7DlzBK6lZSGEX3Nu4=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqr+3hXnkwSElbMhKBY/wt8YrQadUQeSi6NeGQh
 zRgtKx5mHWJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaq/t4RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KEFxAAhIKOPibUkb71SAF587krLQ5cMwqa6Si
 80t2thOKksTx98YJluDMqUQaks6ukr2ZHSHQyjv6bNmma/Z2wQmPimnimPmtvPCiNqZGamsloOF
 GZpXjx0JW8uAkO2S2E5Ps5uAZpMbB2Q+WGIEsTGcAriRk6n893wDn7LDlDZhmf4bh4SDoBekeCk
 /78yczYSBCV5klu5BffDVl0wd4FqI5arN7j3GXiRVf/0Z92ivtzreNmgYG1R3FcPkLyMFP9XeuO
 AMGe/eRYtWgdTQ5zhbqjs4w+1nN8UfVvqWVJzkt8uzoKG+C5N4q+NpGLxdI5+l3iqfWs2cKvGLm
 W2SPGdrc9vety62MLMaCxerGGEnTXYNa3wUb6VzVQd9MrKUoWn9IHTZfN/v2mP03GvjzFCzbsmq
 O8oACs9zorM7DTwVjGxQOEQc/w6hefzwJxzAEIs1C8QN6u5tOVfdeZMv31qh0JlOK4RNHZL1RJ2
 DxI2M2w8ZO1IcSSkb1TSsgyK5NzAgZ9JRISw8AJ3GKea3x6tFKCwSquGyYs+w5qvx5dewIEnNRd
 kCrnj3mQPX3U1hxhvhRbQQGCEaG8z2s9fl7zOJb4b4j/VRXGvNaIJPhlFl1ChM8AJDn9TmpGeJZ
 JwuocnCA1ILoWh+F6QwTC5Aru1lpr4teIHKz92q0DD7qfUsozqNE=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Initialize the driver's private data directly on `PrivateData`.

Introduce `OpenGuard` for resource cleanup.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/serdev.rs | 131 ++++++++++++++++++++------------------------------
 1 file changed, 52 insertions(+), 79 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index c16d6593a8d2..3f9165e16776 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -17,16 +17,12 @@
     prelude::*,
     sync::aref::AlwaysRefCounted,
     time::Jiffies,
-    types::{
-        Opaque,
-        ScopeGuard, //
-    }, //
+    types::Opaque, //
 };
 
 use core::{
-    cell::UnsafeCell,
     marker::PhantomData,
-    mem::{offset_of, MaybeUninit},
+    mem::offset_of,
     ptr::NonNull, //
 };
 
@@ -92,24 +88,36 @@ unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {
     }
 }
 
+struct OpenGuard<'bound> {
+    sdev: &'bound Device<device::Bound>,
+}
+
+impl Drop for OpenGuard<'_> {
+    fn drop(&mut self) {
+        // SAFETY:
+        // - `self.sdev.as_raw()` is guaranteed to be a pointer to a valid
+        //   `struct serdev_device`.
+        // - The existence of self proves that the device is open.
+        unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
+    }
+}
+
 #[doc(hidden)]
-#[pin_data(PinnedDrop)]
+#[pin_data]
 pub struct PrivateData<'bound, T: Driver> {
-    sdev: &'bound Device<device::Bound>,
     #[pin]
-    driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
-    open: UnsafeCell<bool>,
+    driver: T::Data<'bound>,
+    open: OpenGuard<'bound>,
 }
 
-#[pinned_drop]
-impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
-    fn drop(self: Pin<&mut Self>) {
-        // SAFETY: We have exclusive access to `self.open`.
-        if unsafe { *self.open.get() } {
-            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointer to a valid
-            // `struct serdev_device`.
-            unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
-        }
+impl<'bound, T: Driver> PrivateData<'bound, T> {
+    #[inline]
+    fn driver_data(self: Pin<&Self>) -> Pin<&T::Data<'bound>> {
+        // SAFETY: We treat the result as pinned.
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+
+        // SAFETY: `self.driver` is pinned.
+        unsafe { Pin::new_unchecked(&inner.driver) }
     }
 }
 
@@ -134,46 +142,30 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
 
         from_result(|| {
             sdev.as_ref().set_drvdata(try_pin_init!(PrivateData::<T> {
-                sdev: &**sdev,
-                driver: MaybeUninit::<T::Data<'_>>::zeroed().into(),
-                open: false.into(),
+                open: {
+                    // SAFETY:
+                    // - `sdev.as_raw()` is guaranteed to be a valid pointer to
+                    //   `serdev_device`.
+                    // - It is safe to call before open.
+                    unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::OPS) };
+
+                    // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to
+                    // `serdev_device`.
+                    unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
+
+                    // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to
+                    // `serdev_device`.
+                    to_result(unsafe { bindings::serdev_device_open(sdev.as_raw()) })?;
+
+                    OpenGuard { sdev }
+                },
+                driver <- T::probe(sdev, info),
             }))?;
-            // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
-            let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
-            let private_data = ScopeGuard::new_with_data(private_data, |_| {
-                // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
-                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
-            });
-            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
-            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::OPS) };
 
             // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
-            unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
-
-            // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer
-            // to a `serdev_device`.
-            to_result(unsafe { bindings::serdev_device_open(sdev.as_raw()) })?;
-
-            // SAFETY: We have exclusive access to `private_data.open`.
-            unsafe { *private_data.open.get() = true };
-
-            let data = T::probe(sdev, info);
+            unsafe { bindings::serdev_device_resume_rx(sdev.as_raw()) };
 
-            // SAFETY: We have exclusive access to `private_data.driver`.
-            let driver = unsafe { &mut *private_data.driver.get() };
-            // SAFETY:
-            // - `driver.as_mut_ptr()` is a valid pointer to uninitialized data.
-            // - `private_data.driver` is pinned.
-            let result = unsafe { pin_init::raw_try_init(driver.as_mut_ptr(), data) };
-
-            result.map(|()| {
-                private_data.dismiss();
-
-                // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
-                unsafe { bindings::serdev_device_resume_rx(sdev.as_raw()) };
-
-                0
-            })
+            Ok(0)
         })
     }
 
@@ -189,21 +181,10 @@ extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
         // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
         let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
 
-        // SAFETY: No one has exclusive access to `private_data.driver`.
-        let data = unsafe { &*private_data.driver.get() };
-        // SAFETY:
-        // - `private_data.driver` is pinned.
-        // - `remove_callback` is only ever called after a successful call to `probe_callback`,
-        //   hence it's guaranteed that `private_data.driver` was initialized.
-        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
-
-        T::unbind(sdev, data_pinned);
+        T::unbind(sdev, private_data.driver_data());
 
         // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
         unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
-
-        // SAFETY: We already established that `data` is guaranteed to be initialized.
-        unsafe { data.assume_init_drop() };
     }
 
     extern "C" fn receive_buf_callback(
@@ -211,6 +192,9 @@ extern "C" fn receive_buf_callback(
         buf: *const u8,
         length: usize,
     ) -> usize {
+        // SAFETY: `buf` is guaranteed to be non-null and has the size of `length`.
+        let buf = unsafe { core::slice::from_raw_parts(buf, length) };
+
         // SAFETY: The serial device bus only ever calls the receive buf callback with a valid
         // pointer to a `struct serdev_device`.
         //
@@ -222,18 +206,7 @@ extern "C" fn receive_buf_callback(
         // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
         let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
 
-        // SAFETY: No one has exclusive access to `private_data.driver`.
-        let data = unsafe { &*private_data.driver.get() };
-        // SAFETY:
-        // - `private_data.driver` is pinned.
-        // - `receive_buf_callback` is only ever called after a successful call to `probe_callback`,
-        //   hence it's guaranteed that `private_data.driver` was initialized.
-        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
-
-        // SAFETY: `buf` is guaranteed to be non-null and has the size of `length`.
-        let buf = unsafe { core::slice::from_raw_parts(buf, length) };
-
-        T::receive(sdev, data_pinned, buf)
+        T::receive(sdev, private_data.driver_data(), buf)
     }
 }
 

-- 
2.55.0

