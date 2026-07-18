Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846338B7D8
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784378877; cv=none; b=dFHPWXs5Wi08NIRGICn5FQSyqEcp1C8/5Ncjej0f65Yj1DS0qZyuiibCwge2z5/RWz/M/6/CMP6XWUw1h/0I/W11F0JUbRPHt8K0lyla8MXW2e6pwOqqTfgKgC0FQdF/f97ZlndVKqWvPsfMAVymnYVfHkzZEityD+WziXAMpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784378877; c=relaxed/simple;
	bh=5Upn3XgzNHsfFjssw0UXmxtjmmJmk1QhUiVZAnpqPnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGAKXd6E6AqdBgpRkU4pcxMl62/Pbetngo4jd6v6VwVGjm2xM2EzPHw/r5DqPGMXk5j1BvQe7BJB69tkueAZJq9hNchBaf6Bwbi7nwWW8EL7prKz5DKkZBYIfYNk9Y824cfTUODUAnviGZaSmdUxPxn8J04liuRuxcCp0xl/vkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=MZXSOBwD; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="MZXSOBwD"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E5F7024002A
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 14:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784378871;
	bh=9ZZOAvXfJWsCMzdmVLuGtcsnNAcVrXzkXiB16u34YRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=MZXSOBwDEU9rWDX6MDGhigeBdG6AUqHamEVTFx09yPmhl9cAFEERU7fIQuUF/cYY4
	 ccAsnIHIhU/otGF8I20IXbjJ0LBse1ftXz7DyWm6oyn5vl/jhtmEZ42qNFwRUbR+Hx
	 fHO11EnLAllrROi/toW13vz/yMKl0pReASjZ7b7f9BqWLfsFxp/Qm4fvKSKqsR5oO9
	 ywdPtbBrdzUJfWbcDQZr/OPcOOREFLejF872qqhWmvmaNzzVzY/qavZ3jDFEjRhNgb
	 9ttnyP1+4NSnsLwujTP0uOSfGpyoppBNKQobMxEJG4ZHrqL3Kdp/aRdx1jWYdLW5BH
	 jYMd9XVi9Q6Ug==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2RQF6tBzz6v1n;
	Sat, 18 Jul 2026 14:47:49 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 18 Jul 2026 12:47:50 +0000
Subject: [PATCH v2 4/4] rust: serdev: remove `serdev::Timeout`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-rust_serdev_fixes-v2-4-e5214e03de13@posteo.de>
References: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
In-Reply-To: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4550;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=5Upn3XgzNHsfFjssw0UXmxtjmmJmk1QhUiVZAnpqPnM=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW3XxQaZWKBfIoPHQ0xqtJOQJf30Vd4j874k+F
 LRFG6vOUDOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalt18RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9J+uw//ftD82kdrBl1jStYpm5bqkSD84Zk/8xM
 7z1pO5oHR2ERlVVhhkfTQE7Mpvn6AjzQu0Q6VKfR9/VOtuPjK1xbg9m10BzXaqm7Anpb8gSykhJ
 cqPgOMXOHGoVLlOyyeSP420hi7VfBzVhZsyXE+RxGymux2BOC4lPXQOR9jogsWpX3bNPUtkIEh2
 1b22sLFocBq0I2ubylbxSPgVOGyrHtIo9GL68x0esFucFkNsfKdDLcC3bBSb1vQmok6ZiiUH/rJ
 ONDEgFFfMyMwM+zsHCxQw3YOsPkLml5Elo2qkxTeW5tIuiegD1S/5TDrVqEd24jKQWizXvOb+X2
 A22tKu2eWSEyg/fsNftv7lNINH+qskGNRFjWNSFyINPf2q/xTTrDrRA0dMwFN9tqC5Yy2ZqPCf+
 tDZa84VgMClyoB6NiwMhwX1/Q2fmMqAuSKgPx5QOft8/AoGTXALM88Yd2rMWmXNFalzgYy+Mf9D
 TVq6tIqSj8B7t4PgNZyPn4yDsTrlbIDO8iRHJ84nZU3MEZIn5Ovf8Vhep4vPrtknBIe03AsKCOy
 kuekn9KO+Qg1kZPuoLjOWXfLeKlQeWYwCOmQcU9Avs4w29v2cXclreNzuY/c5C3rSopnygG7U3v
 Js/wE4mQpvc9TU4q4hHxJxawIPqwvrUxd33z80/2j7T5lAm0XcK8=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Instead of relying on its own timeout types, the abstraction should make
use of `impl Into<Jiffies>`.

Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DK0SX3P5K1J6.1OV4ETJMXW83R@garyguo.net/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/serdev.rs | 55 +++++++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index a78dfa6e2c27..0fdb37cff15d 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -20,11 +20,7 @@
         aref::AlwaysRefCounted,
         Mutex, //
     },
-    time::{
-        msecs_to_jiffies,
-        Jiffies,
-        Msecs, //
-    },
+    time::Jiffies,
     types::{
         Opaque,
         ScopeGuard, //
@@ -35,7 +31,6 @@
     cell::UnsafeCell,
     marker::PhantomData,
     mem::{offset_of, MaybeUninit},
-    num::NonZero,
     ptr::NonNull, //
 };
 
@@ -50,30 +45,6 @@ pub enum Parity {
     Odd = bindings::serdev_parity_SERDEV_PARITY_ODD,
 }
 
-/// Timeout in Jiffies.
-pub enum Timeout {
-    /// Wait for a specific amount of [`Jiffies`].
-    Jiffies(NonZero<Jiffies>),
-    /// Wait for a specific amount of [`Msecs`].
-    Milliseconds(NonZero<Msecs>),
-    /// Wait as long as possible.
-    ///
-    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
-    Max,
-}
-
-impl Timeout {
-    fn into_jiffies(self) -> isize {
-        match self {
-            Self::Jiffies(value) => value.get().try_into().unwrap_or_default(),
-            Self::Milliseconds(value) => {
-                msecs_to_jiffies(value.get()).try_into().unwrap_or_default()
-            }
-            Self::Max => 0,
-        }
-    }
-}
-
 /// An adapter for the registration of serial device bus device drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -379,7 +350,7 @@ macro_rules! module_serdev_device_driver {
 ///         _id_info: Option<&'bound Self::IdInfo>,
 ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         sdev.set_baudrate(115200);
-///         sdev.write_all(b"Hello\n", serdev::Timeout::Max)?;
+///         sdev.write_all(b"Hello\n", 0usize)?;
 ///         Ok(MyDriver)
 ///     }
 /// }
@@ -505,11 +476,13 @@ pub fn set_parity(&self, parity: Parity) -> Result {
     /// [`Device::wait_until_sent`] to make sure the controller write buffer has actually been
     /// emptied.
     ///
+    /// Use a timeout of 0 to wait indefinitely.
+    ///
     /// Returns the number of bytes written (less than `data.len()` if interrupted).
     /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
-    /// before any bytes were written.
+    /// before any bytes were written. [`kernel::error::code::EINVAL`] if `data.len() > i32::MAX`.
     #[inline]
-    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usize> {
+    pub fn write_all(&self, data: &[u8], timeout: impl Into<Jiffies>) -> Result<usize> {
         if data.len() > i32::MAX as usize {
             return Err(EINVAL);
         }
@@ -523,7 +496,7 @@ pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usize> {
                 self.as_raw(),
                 data.as_ptr(),
                 data.len(),
-                timeout.into_jiffies(),
+                isize::try_from(timeout.into()).unwrap_or_default(),
             )
         };
         // CAST: negative return values are guaranteed to be between `-MAX_ERRNO` and `-1`,
@@ -570,11 +543,19 @@ pub fn write_flush(&self) {
 
     /// Wait for the data to be sent.
     ///
-    /// After this function, the write buffer of the controller should be empty.
+    /// After this function, the write buffer of the controller should be empty or the timeout
+    /// elapsed.
+    ///
+    /// Use a timeout of 0 to wait indefinitely.
     #[inline]
-    pub fn wait_until_sent(&self, timeout: Timeout) {
+    pub fn wait_until_sent(&self, timeout: impl Into<Jiffies>) {
         // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
-        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), timeout.into_jiffies()) };
+        unsafe {
+            bindings::serdev_device_wait_until_sent(
+                self.as_raw(),
+                isize::try_from(timeout.into()).unwrap_or_default(),
+            )
+        };
     }
 }
 

-- 
2.54.0

