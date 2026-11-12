Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504619;
	b=SIaZH/p34/VC+PyNB3/0bm/6ym/pbHBcHEgqBQ/7t6QqsqFoSAeUDDpy7s7Q8TymNoPw
	 simWp/iukpqqk9n5erN+kDrg6qxoGS7w53MeLX9zXuYVoMUTBYcGNQ5z27n9kVcV6KEiM
	 9/vf7YRmKn35holZaE6qI9R0nMiFq9eJp/ugtDGGqvjY0Gknd9ihreCQySXUae9XS7pQO
	 XXnZBW/FpKQ9tRuDmY7sDcylQlKOi0USPZ9EsZI7//dacbIOk8qh+ad6JH2nj7wjhHz+Z
	 b3dy4JuKrM/jfkFg2sxYY+dg1Iy0eXYFRzGsJ3ANeTqfKAmZUuhsVNvRZuroavyORIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=4vCDq9k0q+x+v9e6cvOrU+eOcZALpKUpoEMbKDEPbk4=;
	b=MM6RoajtpeB0XnC/fXBX0rbxK/vOrIwJYNPDohKm829Um01ZMez0NuDF6F5/pU+i57aA
	 Gg0Bt1oDJMzacty8m9ib8zvKE94LhzSH7OT29jGLwrc/objQGw43pc3gRC3uwU/uqy4bP
	 MAf5OmagYXCwPdosteZqNHlFeRJcpnn0GmT1sAR+XYsSebEMKsu6pewFn5WDe9j8JzJWo
	 hs29m2QDnYUogeHRX3Bnmr/lvAQ/Weu2CJu15oEoLwW2vaYwfmhvOoyERlEEAZ/0FdIxd
	 dJSlfNsKjFjH5BmH3G+9/D+uzWPUSrks1EU10U7uBstWoBk+S3JqaGIQMhC92+Arltg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=cG0l6vX3;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC6606A31C
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 17:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFC6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=cG0l6vX3
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 82E94240104
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 18:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794504617;
	bh=4vCDq9k0q+x+v9e6cvOrU+eOcZALpKUpoEMbKDEPbk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=cG0l6vX3u9ywoQRP2VRLl28u7Okq9Be2pkkjpth3GAherUh0mYbkDtfHTC38214eW
	 pxLSn1SBT7iAw5HvCT040qsK08InCLh7nccIZxDzwUso/xfXVpfM5FJ0LK0D4gkxhU
	 uRnRsyIQLqqC9PpyQQBj13BiSVnUINX5VGP7o0Ph9ktiJ21ZxN6eBiG6vCdkDfXf1S
	 Ti5nX4my7DdyR81RntBgDJ+yOumn6JZkeY+bUCmEkPcZGZKu83JHFAtGzBi9Krwc+K
	 moqtJNZLXjJZ7O5tOmgy2ImJQL2hGdD/EEpVF2OXtmEfrU2EsP9nvzX/ixRYy1VDqa
	 PgnlxQPr7RYYA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQS850Klyz9rxL;
	Thu, 12 Nov 2026 18:30:13 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Thu, 12 Nov 2026 17:30:16 +0000
Subject: [PATCH v6 3/4] rust: serdev: Replace `active` mutex with receive
 pause
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-rust_serdev_probe_refactor-v6-3-3568ed56264c@posteo.de>
References: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
In-Reply-To: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
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
 driver-core@lists.linux.dev, Markus Probst <markus.probst@posteo.de>, 
 Sashiko Bot <sashiko-bot@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6639;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=GxJ6N8YswjY2fvcRNNwGrAOUIWnEc7KjW7fVBPvhNHk=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9feawY78m6AeYDi98I+lFtoe5PHzLLjpV0qWf
 3p8kXHtbdmJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavX3mhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9K+iQ/8DHUtGcx+1ZIswtkO36fxurLfyw94oS4
 ev+HBwy5uOxUSSD05ntWC8IwLDuHQXwCtVVPzO8bj6pc+tnkHO7WTP3+FO7UySuxdaspzV0Y/+5
 Jss/exhDnwWB2L+CDZpRVVAH2T/W5qZWfKNikRYVgQg5yPJgXo/t2HZJbAEmRfnp421uSLfPWv8
 4LW9U5/G8dlM7Lln0CqrfEoDYiftLQVEsZEf82RbShbVE5Y2mfPEw1+6zdco/l7DAttNQs718Uk
 hW0utwrqwR9RzNb19A7YH+sgTwBRDiu6Q7b5SpgBsND0D+Evk9GCxSpvkPGluzyuevqPnXQ/n0d
 FkI+8GI9VXZB1ecM5Txs2g06/YWye2CqIzVCbwtNzxhQYkzXlY9AS0F3RUdgMlzXVRV5K/RHJCT
 HxPZmTEwl/muuVzwckvbkG3L8QblPm9YjT/xdCR4MVw8CxxVyvaXAEB+xN/pxT2D9WU38SEV5a+
 N3SIywgyUCWrqYvyDiDngUqzJB5XaCvp+XAg1nDG7ICiPY5/imR6niwCKY2V8F04netUM5+MJI4
 ORoUT4V1UHXfWQBWE5Ve043LaKsvToHejFRPa5eN1+n2MV8pKkjQvGYtlA/SdZVbIwS90kWNdDK
 hr1alwA4SurP/NyjkUh3Ja9NwxyvIl1iBb3ADBI15DUo2oaj7Bjg=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

There are currently 2 race conditions:
- in probe if `Driver::probe` returns Err
- in unbind
. In those cases the driver data will be set to NULL before the serdev
device was closed. If data is received while the driver data is dropped,
the `receive_buf_callback` might try to access the `active` mutex on a
null pointer.

Removing the need for `receive_buf_callback` to lock the `active` mutex
fixes these.

Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@smtp.kernel.org/
Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@smtp.kernel.org/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/serdev.rs | 63 ++++++++++++++-------------------------------------
 1 file changed, 17 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..559d142ce557 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -13,13 +13,9 @@
         to_result,
         VTABLE_DEFAULT_ERROR, //
     },
-    new_mutex,
     of,
     prelude::*,
-    sync::{
-        aref::AlwaysRefCounted,
-        Mutex, //
-    },
+    sync::aref::AlwaysRefCounted,
     time::Jiffies,
     types::{
         Opaque,
@@ -103,40 +99,11 @@ pub struct PrivateData<'bound, T: Driver> {
     #[pin]
     driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
     open: UnsafeCell<bool>,
-    /// Whether `receive_buf_callback` is allowed to call `Driver::receive`.
-    ///
-    /// If locked, the receive_buf_callback will be blocked on data reception.
-    /// This is the case while the driver is being probed or while [`PrivateData`] is being dropped.
-    /// This is necessary, because we need to open the serdev device before the driver has been
-    /// probed in order to allow it to be configured, which allows `receive_buf_callback` to be
-    /// called. Thus we need to block data until probe completes and the driver data becomes
-    /// initialized.
-    ///
-    /// If unlocked and true, the receive_buf_callback will forward the data to
-    /// `Driver::receive`. This is the normal state of operation.
-    ///
-    /// If unlocked and false, the receive_buf_callback will throw away the data.
-    /// This is only the case, if the serdev device is open and
-    /// - the driver returned an error in probe
-    /// or
-    /// - the driver data already has been dropped, because it was unbound.
-    #[pin]
-    active: Mutex<bool>,
 }
 
 #[pinned_drop]
 impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
     fn drop(self: Pin<&mut Self>) {
-        let mut active = self.active.lock();
-        if *active {
-            // SAFETY:
-            // - We have exclusive access to `self.driver`.
-            // - `self.driver` is guaranteed to be initialized.
-            unsafe { (*self.driver.get()).assume_init_drop() };
-            *active = false;
-        }
-        drop(active);
-
         // SAFETY: We have exclusive access to `self.open`.
         if unsafe { *self.open.get() } {
             // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointer to a valid
@@ -170,7 +137,6 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
                 sdev: &**sdev,
                 driver: MaybeUninit::<T::Data<'_>>::zeroed().into(),
                 open: false.into(),
-                active <- new_mutex!(false),
             }))?;
             // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
             let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
@@ -178,11 +144,12 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
                 // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
                 drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
             });
-            let mut active = private_data.active.lock();
-
             // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
             unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::OPS) };
 
+            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+            unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
+
             // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer
             // to a `serdev_device`.
             to_result(unsafe { bindings::serdev_device_open(sdev.as_raw()) })?;
@@ -199,12 +166,12 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             // - `private_data.driver` is pinned.
             let result = unsafe { pin_init::raw_try_init(driver.as_mut_ptr(), data) };
 
-            *active = result.is_ok();
-
-            drop(active);
-
             result.map(|()| {
                 private_data.dismiss();
+
+                // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+                unsafe { bindings::serdev_device_resume_rx(sdev.as_raw()) };
+
                 0
             })
         })
@@ -231,6 +198,15 @@ extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
         let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
 
         T::unbind(sdev, data_pinned);
+
+        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+        unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
+
+        // SAFETY: We have exclusive access to `private_data.driver`.
+        let data = unsafe { &mut *private_data.driver.get() };
+
+        // SAFETY: We already established that `data` is guaranteed to be initialized.
+        unsafe { data.assume_init_drop() };
     }
 
     extern "C" fn receive_buf_callback(
@@ -248,11 +224,6 @@ extern "C" fn receive_buf_callback(
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
         let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
-        let active = private_data.active.lock();
-
-        if !*active {
-            return length;
-        }
 
         // SAFETY: No one has exclusive access to `private_data.driver`.
         let data = unsafe { &*private_data.driver.get() };

-- 
2.56.1

