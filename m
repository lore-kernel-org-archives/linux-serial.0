Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FC37996C
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710143; cv=none; b=c1Bqs55nvuaX9sXuDVyUUL3R8NBnB3s01NMDCU3s4fCyR3BH5NbgHDFTJL0B5wHtxx19Q1BRqigA74dhtb+IK+8jfUVzOz8EPfuSTZHiFEo0g4s3l1QfBggx5HKVz/6UUuR09NzJo7xq+kHCR3CyQJuUUhKy0jq/tPlCDkWDEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710143; c=relaxed/simple;
	bh=fyxFTMFAa80FsZG990F6QCIaClCrAw8kFJBc4LVqL/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4k8K1Kc+TEhAIO4Sjw3XR64qR7Ii/M5XF1iy509xzlspgNXn/AHa+xRxSXFADj8q1XKHfg6Tvpck2Htg1lJjQurz+WslughehMnIbkcsk7w28mae4bm13cnvpgkDv+ng7m/taxNNzgAizlnigDV7VqXtQdbwKORcP7TGKVvRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=kO+B91wH; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kO+B91wH"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4F348240027
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 17:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788710136;
	bh=zVRusiE8chJT35Hfseh5oBKBImpt0sKZ2uzSGkt9OGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=kO+B91wHwCAfT3+lkYkQoxF4JKdrYPSzR4uwzq92smxIdWfOLlzCX8BNN+Fmj468A
	 2zCuUIlB0GeExqDOPgHrmSeEpGyBTDb4ti4YaNWH3VwqKXQM83hilInP2eBvsJIwHv
	 kfHcpW3nPy735z/GBcA2RDZJoXK9oPyiE0CWabfXvhokmkyANG7TUowbMVoVShhlRr
	 UNyf0kLy+cFusiZB5qQmNbMxVghDB5BML+RZtyq3VMW2N0AE1v5toMB2fDiupyaRRa
	 MiwIeQaCdFJhPeGggxr42GaCMWXx7Y6ImJgVdhddJ+mM+PnMpy5zhbG8SlDKaTivk3
	 knhN5FqYoUTow==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hdFCm55ffz6twR;
	Sun,  6 Sep 2026 17:55:32 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 06 Sep 2026 15:55:34 +0000
Subject: [PATCH 4/5] rust: Add `Device::drvdata_borrow_mut`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-rust_serdev_probe_refactor-v1-4-69cdae0074ec@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=fyxFTMFAa80FsZG990F6QCIaClCrAw8kFJBc4LVqL/U=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnYzqGuYE7hlifjnRlFzrGG5vOPR4yMeyxbAU+
 0i8m7OcniyJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCap2M6hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LgEw//VPYTzw5GSkY7fZEowBvE6bbFFAFB2JY
 rD16A1i/zIC7Pnq6aiNW0WvI4HnY0gts1kdfpCGsdYPlaAw9VPAZZeu5KYSJ6xrLYuYBphPyUn8
 xKL03SBKFwO03evBruOjZfYY/gK5C5tlk7hIQW827AaMlVZ42B6n8Wkyhjafw70v7u9L8PuJrN8
 jCDvQJd10oNuGwIBdarTfGak0dM62UKAZDjJ8rSwMcLuXI+DZQpaZJ3MWlpnPLz9DAq57cgf2D+
 T/peA0LG04oazFFj0a7myew9ZMrZrKOKjT1YN1JCynlAivk/BPShcqXg8wIDZniJPx7Jv0RNFVK
 47StNUbog6jDzD9oYoYFTpgOLpOr6L81PIjL2Cjqh7EfLOtg758pBrnmJTnL9jhaxGLI+6YxvFv
 iLT9nxmG/UG/LC8aZ7X5WG3AeDMNk3XdrgQX9i550cDyKk0pHBzW+AHPcHoAwetKBjoRb2uf3Ug
 2AXb5LdsEbZ6B57uVX5v/kESa7Noq24kONmGccd8X9g1f98wGJ+shEnN79znmu8pfGuJwpKtcIr
 E/gVjV9vly/iHoVdtvlgXZycbxNTjtVZK4q5LlTRctf5/Kx/Js3zqjDebqee6aUwODG/AxHhRy+
 nrlupKFTkFxPTahL5fQJT4EdIo8w/42g6xpig+v1WKh5dtAdbBak=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

This function allows the caller to obtain a mutable reference to the
driver's private data if he has exclusive access.

This will be used in serdev to provide mutable references in callbacks.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/device.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849..aa2d87c6f4d3 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -258,6 +258,30 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
         //   in `into_foreign()`.
         unsafe { Pin::<KBox<T>>::borrow(ptr.cast()) }
     }
+
+    /// Borrow the driver's private data bound to this [`Device`] mutable.
+    ///
+    /// # Safety
+    ///
+    /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before the
+    ///   device is fully unbound.
+    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
+    ///   [`Device::set_drvdata`].
+    /// - The caller must have exclusive access to `T`.
+    #[expect(clippy::mut_from_ref)]
+    pub unsafe fn drvdata_borrow_mut<T>(&self) -> Pin<&mut T> {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
+
+        // SAFETY:
+        // - By the safety requirements of this function, `ptr` comes from a previous call to
+        //   `into_foreign()`.
+        // - `dev_get_drvdata()` guarantees to return the same pointer given to `dev_set_drvdata()`
+        //   in `into_foreign()`.
+        // - By the safety requirements of this function, `borrow` and `borrow_mut` do not overlap
+        //   on the same object.
+        unsafe { Pin::<KBox<T>>::borrow_mut(ptr.cast()) }
+    }
 }
 
 impl<Ctx: DeviceContext> Device<Ctx> {

-- 
2.55.0

