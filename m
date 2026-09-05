Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E047377EAF
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615027; cv=none; b=l4DmNdoI4ODIuHKeOQe+NpOXskD7V/9t74vPgU99zYPuDnXDLo9K85NvTtHQr1PRDZTXd4lLv1CGbubmQA3bssjUu9xh/XCqhSY4cE1PLGcp6Higqk+N1rarUCUWfmS7ZdOQwHMciu1/ctaQbYjD7ByGPgBSGbGHi8tmHvKZw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615027; c=relaxed/simple;
	bh=BZQUtMHrD+me98+Sj/eBVIJBH6xrBlHO3wfkHw8pxXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uz6WKa61umy5kH+GIcVCGrry7IYhurPAMEq5tRUY3U0ZdgiQh4fsB2z+nrzzzCyvn0xQtZovtmRSMmG+znfgVL2iO9G1I1lXlhdsnI2icyu3lC+Uuv6r1hqs/b5ybpONLdG49ysbBZkKQB8+YBBkbmQaRDhgu/XsO81HkYx4D3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QiUshLNJ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QiUshLNJ"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1EEC724002A
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 15:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788615012;
	bh=MrDkKb4gk1/O+1BEUuWrVty7ZyLmE9+t9jPdH84ytmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=QiUshLNJs8RYDPLI+Aa4TqLMk7YS0hzUiyeQE4cET39XEPW1FSWNTMGy94fctnOal
	 HOBTAd3mqLuQaXbSI7ucbYvNToncz+ekELnCSoTEVknEAGS4YwcyVjYF0JadnwmI6m
	 XftSgrtpkVsmcdSyPPgyeUr8d/tdkQ6c6nRqkqS9eL1GG9KR0y6/6Z71gqwYii5GLE
	 1FBvQau+VNOmQH1t9mySynd6iqiVzXzAf3ba+itJOLgxfkyizFYNPvZWwxGmyItS3X
	 Aj1TAytyhvzLmYjtN9H6SE3PmzUZIaSPtR04M3D3fE/DYv2LlEtYzVv7s4HNfaWQPn
	 vZ4UmSN9Kpd+g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcZ2T55DMz9rxN;
	Sat,  5 Sep 2026 15:30:09 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 05 Sep 2026 13:30:10 +0000
Subject: [PATCH v2 1/2] rust: serdev: Fix race condition on driver unbind
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-rust_serdev_fix-v2-1-35dfcd06ef2e@posteo.de>
References: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
In-Reply-To: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 Markus Probst <markus.probst@posteo.de>, 
 Sashiko Bot <sashiko-bot@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3695;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=BZQUtMHrD+me98+Sj/eBVIJBH6xrBlHO3wfkHw8pxXg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnBlfwrgbxrP39RWc0Un3ocC38mN8MvT3bVFn1
 rXK3vAGKJGJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapwZXxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JY/g/9HYQlJiyM2DHtMe8umM9Qvu710zYhew9
 AkLL4wgfJ0qK5rb9cvcvyAxOdE0KnTsjRYuC+zC94IvVnTAK8s9X/Y1v4cvG7w1ETC3dRZoqEBX
 UJenMuj1LAN+kIYpWM7+orq8ZxlYAUEtWFqtH1ANy8wSbI5VS0Ove4YSSdVk8BfPkjQJgXmT4KT
 hodcJ2ZSxvy+vrUvwMQ6gJgy1mT00FslDZc9HzEMQSGvyzgTQj87i8U5ymRVEc8GRATK3ySipKN
 jUHemxLa7qz892q9YKraHAdXbg4Metda1znwzsYHw6jO+LNgDzZhX98A8xzNT8f6jtJ/nvkxoWu
 EuklbtEiCpHf9YgHlalryLs7dxldLZx0uHDBnJ/yEYyGHs7JkPlLAwnaECndfwsq4PhlrUjkhIs
 iJ6NYpkl/mYpZk6peFKT8wuGbRg+tGYlHlc+eMAhLbvqo05LBE1bHK/uaOoioIlj0KidYjveajb
 p80uh8KaGRsgJnse+DKwsLhxZmH2d6Ifxux9iyw8UFowZhWUQTtw2rUSuwM9Kz9LP3KnrIAzIli
 XWhFzKptfHKiYOncXzqx/5965Rf24FZZaZ+9/rMcEjt9pj0BAa0JYDKbRTuRzaW0Jed7pPfSSZv
 2+6a0sTZ1hdXmoyCVAdlzPtWfYbBuLVJdarCm6b4T3rTCn6BBx8k=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

On device unbind, the pointer to the driver data (`PrivateData`) will first
be set to NULL by `drvdata_obtain` and only after that the serdev device
will be closed by Drop. Thus there is a small window in which the serdev
device is still open, but the pointer to the driver data is NULL. Therefore
it is possible that `receive_buf_callback` might try to access the `active`
mutex on a null pointer.

Add function `drvdata_drop` that leaves the pointer to the driver data
valid until the Drop has completed. Use it in the post unbind callback.

Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@smtp.kernel.org/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/device.rs | 27 +++++++++++++++++++++++++++
 rust/kernel/driver.rs |  2 +-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849..3886cc713c28 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -219,6 +219,7 @@ pub fn set_drvdata<T>(&self, data: impl PinInit<T, Error>) -> Result {
     ///
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
+    /// - Must only be called before the device is fully unbound.
     pub(crate) unsafe fn drvdata_obtain<T>(&self) -> Option<Pin<KBox<T>>> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
@@ -236,6 +237,32 @@ pub(crate) unsafe fn drvdata_obtain<T>(&self) -> Option<Pin<KBox<T>>> {
         //   in `into_foreign()`.
         Some(unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) })
     }
+
+    /// Drop the private data stored in this [`Device`].
+    ///
+    /// The pointer to the private data remains valid until the drop is complete.
+    ///
+    /// # Safety
+    ///
+    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
+    ///   [`Device::set_drvdata`].
+    pub(crate) unsafe fn drvdata_drop<T>(&self) {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
+
+        if ptr.is_null() {
+            return;
+        }
+
+        // SAFETY:
+        // - If `ptr` is not NULL, it comes from a previous call to `into_foreign()`.
+        // - `dev_get_drvdata()` guarantees to return the same pointer given to `dev_set_drvdata()`
+        //   in `into_foreign()`.
+        drop(unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) });
+
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        unsafe { bindings::dev_set_drvdata(self.as_raw(), core::ptr::null_mut()) };
+    }
 }
 
 impl<Ctx: InternalBoundContext> Device<Ctx> {
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index c9c74c4dde8f..83410141ef1c 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -204,7 +204,7 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         //
         // SAFETY: By the safety requirements of the `Driver` trait, `T::DriverData` is the
         // driver's bus device private data type.
-        drop(unsafe { dev.drvdata_obtain::<T::DriverData<'_>>() });
+        unsafe { dev.drvdata_drop::<T::DriverData<'_>>() };
     }
 
     /// Attach generic `struct device_driver` callbacks.

-- 
2.55.0

