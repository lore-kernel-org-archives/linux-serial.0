Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480D369D59
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473024; cv=none; b=VCNoLSemIRC+0id02tTMcO+LoefnTJPFBUI2MvchYJJwRE8hW9C45xHUZk7n4UXsxd4jJsSB2s0UkPyJwLTYmDdPct3knlNUCQrCAiv32BIKETmZBwVGkVv1Etbx5x8PRItewv9aX2MNwZBafDMCWLb8V36kBaiclPW6cTuOMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473024; c=relaxed/simple;
	bh=GBcmJnaMQpbIfjUTpYg/eaQYX68BPiVFso1vleOF5JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PMebZV97pVDWe4nIZ9uxrrZJa28NIJX+386uI5PWcRCe26RdeEZ9nDcSyWnEjFWRjPvLiiiWQ1Zn8di5OOw/vHq2lq0kqrYhiaMtlNfRTaowvV+mjLq/p7HpxwYlKmBE3F2xDTuZNTpw3Bh+MiC2qog54SDs3olWi0aVQLsu6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=mtvrc02C; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="mtvrc02C"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6B286240105
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 00:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788473020;
	bh=t950fm6K9o0wlrR7qcQVGGcoXGuaXBIxlX9nhhQ5wF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=mtvrc02C85jC4poA5pa8BYa+3yGc6lVN3Qiv1YxYCf4fyHgm1aSW7rtqFozp3a+to
	 /C/E10apcOmVApzF/8gjnudexctFIKZMQX7WNa710utup6XMx0mfOys4OqfFYAaaIA
	 BxDBcuEM/1keUsORnTKAzYMo4fv1Swbmd9NFDp5KLOquqCft+WjdAZidbi4XpjyTvc
	 WnAmlau4oLQHWy3XLJfH2unuQSPjDqhT0ZF5BTVfmhpBrjdKGblzzFQFDFBiV9JnnY
	 KfJC0K0veh7jfZpy+suwqjNMK5WSNGJLBDjhV9wijL2UjY9kdDnABx8DN8uMkNqEqN
	 HX2/67jYbPLyQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hbYWq6p5Tz9rxB;
	Fri,  4 Sep 2026 00:03:35 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Thu, 03 Sep 2026 22:03:39 +0000
Subject: [PATCH] rust: serdev: Synchronize receive callback before calling
 unbind
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-rust_serdev_ref_mut-v1-1-245db7eb09af@posteo.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2N2wrCMBBEfyXss5E0aqP9FSkhTVaNkLbmhlD67
 67Wx8PMmVkgYfSYoGMLRKw++WkkaHYM7MOMd+TeEYMUshUXceCxpKxJclh1xJsOJfOjk/J8Uqo
 12ACZMwX+/Vu99hunMjzR5u/UvxHxVegubzUYTEJupxB87lhVe3qyDfTr+gGS3FeTowAAAA==
X-Change-ID: 20260903-rust_serdev_ref_mut-4d2285776ae1
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
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>
Cc: greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7396;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=GBcmJnaMQpbIfjUTpYg/eaQYX68BPiVFso1vleOF5JQ=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqme63DlBXFmgI+F3sVeW8gzAxj3Flb6wujjIqg
 4buAtnIEVqJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapnutxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KUexAAhh9NIP08wIeNAfAdQ2c02DyYjOULpzi
 TRk4yQeGHRixDw8uscIAy+Luw6aglvsJz/vs+aorjHNpyckbJKI9myfF48v4Z3C4GPUq5WnqT9/
 UNGzlFXWGSXi0oKsQTjd+/2WZzrepieYxnv/wTGnvFHBSRfjjcqe1YAlqj+/cu6mxPigbHgQwXH
 +KzO6Tk+Pji6QF7Q5TN/ye+No6Qp9TMtGE5twbVGBKSZZzc3EdH0pIb742CuLCoszHRvgh+QGqT
 4Z7C+Bo5diP79hyBppnz6tK1DgHg2dmkX1Gu6fokZ7eGeFm/j6s+ZrFPnlPib2PjqHhjoFiJfaf
 BZ5N3132rihYAB9AmrJYp7CjOjO2IRr+urcvOu5cnwi6R6cPN7BT8w0+yBTnHuZY73ryzZK42go
 oSMZXg7+QJOp4Qcyu1NM5s4gJ4/DZPH3GB4aSSaRnQO1StwaZrG8aFP9it6jlRTJAjzw93WH5pG
 FXttWmKLaWUBdHpNWaUHDBtBta/f6GxhNkE+kSoIkz057Yl6DqD7qSneWHXmYsoe3MWahSHJyo4
 IqXE3dQxAvyXfIJL2Th3J8pEZDwzmK/qf8PYhPInj4yVC1l8MMn7wr4uDTByzMboy4CkLEcarZf
 fqMggP++5BY92GTB4lhAoKhp62G+eN2LjMl/oujcqi5n0IFFec10=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

The receive callback and unbind callback now have exclusive access to
the drivers private data. Provide mutable references in callbacks to
avoid the need for locks in the private data. Remove the Sync
requirement.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
This patch avoids the need for a SpinLock in the patch series
https://lore.kernel.org/rust-for-linux/20260827-gb-uart-transport-v2-7-a03bb1f5fbd1@beagleboard.org/
.
---
 rust/kernel/serdev.rs              | 51 ++++++++++++++++++++++----------------
 samples/rust/rust_driver_serdev.rs |  2 +-
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..44f029ed93fd 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -106,7 +106,7 @@ pub struct PrivateData<'bound, T: Driver> {
     /// Whether `receive_buf_callback` is allowed to call `Driver::receive`.
     ///
     /// If locked, the receive_buf_callback will be blocked on data reception.
-    /// This is the case while the driver is being probed or while [`PrivateData`] is being dropped.
+    /// This is the case while the driver is being probed or removed.
     /// This is necessary, because we need to open the serdev device before the driver has been
     /// probed in order to allow it to be configured, which allows `receive_buf_callback` to be
     /// called. Thus we need to block data until probe completes and the driver data becomes
@@ -127,16 +127,6 @@ pub struct PrivateData<'bound, T: Driver> {
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
@@ -176,7 +166,20 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
             let private_data = ScopeGuard::new_with_data(private_data, |_| {
                 // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
-                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
+                let private_data = unsafe {
+                    sdev.as_ref()
+                        .drvdata_obtain::<PrivateData<'_, T>>()
+                        .unwrap_unchecked()
+                };
+
+                let mut active = private_data.active.lock();
+                if *active {
+                    // SAFETY:
+                    // - We have exclusive access to `private_data.driver`.
+                    // - `private_data.driver` is guaranteed to be initialized.
+                    unsafe { (*private_data.driver.get()).assume_init_drop() };
+                    *active = false;
+                }
             });
             let mut active = private_data.active.lock();
 
@@ -222,15 +225,21 @@ extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
         // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
         let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
 
-        // SAFETY: No one has exclusive access to `private_data.driver`.
-        let data = unsafe { &*private_data.driver.get() };
+        let mut active = private_data.active.lock();
+
+        // SAFETY: We have exclusive access to `private_data.driver`.
+        let data = unsafe { &mut *private_data.driver.get() };
         // SAFETY:
         // - `private_data.driver` is pinned.
         // - `remove_callback` is only ever called after a successful call to `probe_callback`,
         //   hence it's guaranteed that `private_data.driver` was initialized.
-        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
+        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_mut()) };
 
         T::unbind(sdev, data_pinned);
+
+        // SAFETY: We already established that `data` is guaranteed to be initialized.
+        unsafe { data.assume_init_drop() };
+        *active = false;
     }
 
     extern "C" fn receive_buf_callback(
@@ -254,13 +263,13 @@ extern "C" fn receive_buf_callback(
             return length;
         }
 
-        // SAFETY: No one has exclusive access to `private_data.driver`.
-        let data = unsafe { &*private_data.driver.get() };
+        // SAFETY: We have exclusive access to `private_data.driver`.
+        let data = unsafe { &mut *private_data.driver.get() };
         // SAFETY:
         // - `private_data.driver` is pinned.
         // - `receive_buf_callback` is only ever called after a successful call to `probe_callback`,
         //   hence it's guaranteed that `private_data.driver` was initialized.
-        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
+        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_mut()) };
 
         // SAFETY: `buf` is guaranteed to be non-null and has the size of `length`.
         let buf = unsafe { core::slice::from_raw_parts(buf, length) };
@@ -365,7 +374,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data<'bound>: Send + Sync + 'bound;
+    type Data<'bound>: Send + 'bound;
 
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
@@ -391,7 +400,7 @@ fn probe<'bound>(
     /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
+    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<&mut Self::Data<'bound>>) {
         let _ = (sdev, this);
     }
 
@@ -402,7 +411,7 @@ fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<
     /// Returns the number of bytes accepted.
     fn receive<'bound>(
         sdev: &'bound Device<device::Bound>,
-        this: Pin<&Self::Data<'bound>>,
+        this: Pin<&mut Self::Data<'bound>>,
         data: &[u8],
     ) -> usize {
         let _ = (sdev, this, data);
diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_driver_serdev.rs
index 51b4898cd855..d00d547234c8 100644
--- a/samples/rust/rust_driver_serdev.rs
+++ b/samples/rust/rust_driver_serdev.rs
@@ -63,7 +63,7 @@ fn probe<'bound>(
 
     fn receive<'bound>(
         sdev: &'bound serdev::Device<Bound>,
-        _this: Pin<&Self>,
+        _this: Pin<&mut Self>,
         data: &[u8],
     ) -> usize {
         sdev.write(data).unwrap_or_default() as usize

---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260903-rust_serdev_ref_mut-4d2285776ae1

