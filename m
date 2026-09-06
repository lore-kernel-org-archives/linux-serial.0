Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0F3793C1
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710141; cv=none; b=GjWomNMnjidGvfMVdL/wxOfeZNbyYvVkWnzBl9NeQgkUdnJ1ltsmdKhTjz3DsAYQbeQLNgCjQr7SS524QHbPB0R7vJyjusmVbljOfIM/ybbXvn9OIw4njeW5AATcn4mNO+tJRYZLuBGsWK6f5yvwDFr7DN3Iwnu5Zti36wwUHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710141; c=relaxed/simple;
	bh=wWGgnov65ZJqhT9zXloo5ac7Dq5BL+le5LUIaHFssg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDeshGerh72Klo4LGWg3FMMz+teCsfFWJtbEe6vBL2jZ6XFh2I3u6iqhqzdX4jlNgFOr0Py/iiJnKb+MfxywiaR7iOvDGjfgLaIMD8keuhQMaZqQiWr5jt71uYiJHYdAt6a/ESYHnuqJYib/j4+vog03wV8N9/ai6IeIMMtvywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=O4pMx1oH; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="O4pMx1oH"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 00E8A240101
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 17:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788710138;
	bh=H1usViq0rGSlCgRtIfdfxljYpLCz0O0luhM/wP/Mhdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=O4pMx1oH6kw12cszaeRvtdG2aYDvcnEPy9zzjtgKsrYD+orWLuoPKcmPQozcaXb12
	 7rrVOSX/YNQEOvMKWeNnAx7kmr8o4eQQXea9fmnsLWA81qZ+Mkz0CMAysz/Gauk9KC
	 fPohU9zy0K+vSdKV/8M0qHoEkDncCmTuV4+EthuOSsNksF5pWz+0Gkq+bNfpWpTjeP
	 CH2wPr2vDEwFZtcJ7JqM4zWloM4CQ4ua3vt+cZK5gY0YqLJg17cUFDOJGgiOqdQSlv
	 6y2IW37ivYSOXGbO7k2r/bsgFZ8L9qdq0zhPxIsfTX9a2ry+drYcBteO7qtO39AAzK
	 F3DzvEfX9t81g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hdFCp2bqdz6tsg;
	Sun,  6 Sep 2026 17:55:34 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 06 Sep 2026 15:55:35 +0000
Subject: [PATCH 5/5] rust: serdev: Pause receive callback before calling
 unbind
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-rust_serdev_probe_refactor-v1-5-69cdae0074ec@posteo.de>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5586;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=wWGgnov65ZJqhT9zXloo5ac7Dq5BL+le5LUIaHFssg4=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnYzqL9li5x5gN5EmZDfiI0wa3kL6wZcVpyvy8
 juxF/4VPwqJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCap2M6hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LwtA//UxEEr+R22CvNQ3VHemKSdgP9TSGAQkO
 q0Fu8+es04maTv2GQDc4cEJUvpg+slftg49jOL2z2hzQixFpWgQMyf71F027p3uyRKbAFId5cNo
 QgP9fRgr8U7vDm9FVQi0YNMUpYlCvf8sQIH+unPw5x1cMeEyF1KYmG4Ry+IOVjrGEhiwzsCg7Hp
 5cbNXKIjT+UiHAzgmHwM/4mpJE9aMSIxx8FNeE6sEb665hwifvBfGsbZB+hF5+2bX/Q3zXldTik
 v/0pVNV97HuR6QJf1wGSOJP1sol5HskQNlWjMZ9hqNlQ88EPNsbMsCQ9ExHNBCzvos8xytgCJVs
 rhk4uQXof5i4lbtaoSuYnImIfyhDM4H3aG3wzU1hHQFoxhvsFaR/sqjoEDWHdphCvT9YX+kPFyk
 RKfFJszptzwz6A/eN6Tv9L4TgUfP+uRBbP+tqOlunSSsMl/XlYyzb7iL+jzkJd8yzVhjlOGdPLV
 R/UhzBgX/k72IDh1g0UwuOsja907ZhDOFq8ruzCVnFJDrsVizhddQZiGyUjxDmDiNgo2rzwZPTX
 nBblJ/7sUkkkijuzDJwnO9ZjRHVQDR5crDQayVp7uabUtvgL3Ls9r6iKOIZSudtWv3rUuWTcXYM
 s88TsqVKJ729ZnEvubvLfeCoUwOtjhAMZyuZxW53GLUCI6OqqizQ=
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
 rust/kernel/serdev.rs              | 39 ++++++++++++++++++++++----------------
 samples/rust/rust_driver_serdev.rs |  2 +-
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 66543108ec2f..7d47d91e3bc3 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -111,12 +111,12 @@ pub struct PrivateData<'bound, T: Driver> {
 }
 
 impl<'bound, T: Driver> PrivateData<'bound, T> {
-    fn driver_data(self: Pin<&Self>) -> Pin<&T::Data<'bound>> {
+    fn driver_data(self: Pin<&mut Self>) -> Pin<&mut T::Data<'bound>> {
         // SAFETY: We treat the result as pinned.
         let inner = unsafe { Pin::into_inner_unchecked(self) };
 
         // SAFETY: `self.driver` is pinned.
-        unsafe { Pin::new_unchecked(&inner.driver) }
+        unsafe { Pin::new_unchecked(&mut inner.driver) }
     }
 }
 
@@ -175,15 +175,18 @@ extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
         // INVARIANT: `sdev` is valid for the duration of `remove_callback()`.
         let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal<'_>>>() };
 
-        // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
-        let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
-
-        T::unbind(sdev, private_data.driver_data());
-
         // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
         unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
+
+        // SAFETY:
+        // - `remove_callback` is only ever called after a successful call to `probe_callback`,
+        //   hence it's guaranteed that `Device::set_drvdata()` has been called and stored a
+        //   `Pin<KBox<PrivateData<'_, T>>>`.
+        // - The call to `serdev_device_pause_rx` above guarantees that we do not overlap with
+        //   `receive_buf_callback`, thus it is guaranteed that we have exclusive access.
+        let private_data = unsafe { sdev.as_ref().drvdata_borrow_mut::<PrivateData<'_, T>>() };
+
+        T::unbind(sdev, private_data.driver_data());
     }
 
     extern "C" fn receive_buf_callback(
@@ -200,10 +203,14 @@ extern "C" fn receive_buf_callback(
         // INVARIANT: `sdev` is valid for the duration of `receive_buf_callback()`.
         let sdev = unsafe { &*sdev.cast::<Device<device::BoundInternal>>() };
 
-        // SAFETY: `receive_buf_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
-        let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
+        // SAFETY:
+        // - `receive_buf_callback` is only ever called after a successful call to `probe_callback`,
+        //   hence it's guaranteed that `Device::set_drvdata()` has been called and stored a
+        //   `Pin<KBox<PrivateData<'_, T>>>`.
+        // - `unbind_callback` calls `serdev_device_pause_rx` before accessing the driver data,
+        //   which guarantees that this function will not overlap with it. Thus we have exclusive
+        //   access.
+        let private_data = unsafe { sdev.as_ref().drvdata_borrow_mut::<PrivateData<'_, T>>() };
 
         T::receive(sdev, private_data.driver_data(), buf)
     }
@@ -305,7 +312,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data<'bound>: Send + Sync + 'bound;
+    type Data<'bound>: Send + 'bound;
 
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
@@ -331,7 +338,7 @@ fn probe<'bound>(
     /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
+    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<&mut Self::Data<'bound>>) {
         let _ = (sdev, this);
     }
 
@@ -342,7 +349,7 @@ fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<
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

-- 
2.55.0

