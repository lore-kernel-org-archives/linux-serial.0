Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACE377A98
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615029; cv=none; b=oDTgiPnDe1g0v0WnTOfeaPXhP3/gi5zScqXbwObLuk06oMaZ+jX+7Wy+1uodcUQ+9KS61mB9mclv2GMwJzRg5ULERYa+H0v5oclXj1eBwUe9PXmZXUYc6q/blQ9+U2/0jPZ0oseduKMtRvu2YmoiPzF3NslRqKOH6lhiVdvCljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615029; c=relaxed/simple;
	bh=0sSBP2cprqjuaV+c2HHo+xNsGybFsYHAYG6+y+2l4nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UufIzBEyBN1U9HM6M1tnS6E1Vg7Gi1K4goHfmEKE1O0bQQ+NbtuVgDZdD8UykzJJZJhfXumQyzs7os94im/QcKcsGehAda0dxwvfu2wV0jgRj5k4n2EplqUOLSN+/VGNJIqJgOu6YR3ex1NbEsVz0JIucrEPgr/4hUkZbHAhTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=eS0WYOXm; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="eS0WYOXm"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 32FE9240029
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 15:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788615013;
	bh=bfa+sUbkpDzQYYGeZZKcZXo0idL7gh16q6bK32R5j28=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=eS0WYOXmli7nWeEa6tSmNdMlEuJkVq+NIDUd6Iui1oJZiLCiZH1uCrV6koQOX1tMJ
	 6qRzErvKtw38L37TuQWFTfHE7g1NoMhpI7Fbm+0uwl3ks5IQ16GhrgTSnEPu26S26Y
	 v/HwRAAbPaWf3gUMpL1HUgwPc0GRFdFloV0SfvwHquWl9bnR88ZjYlBZYGJsb2nfxz
	 YoLggbACG+2QtGdryeCucA+sbXE59EaV89OipHkaA+EZeFy+j6yKo1xrxWmQmu57WO
	 epsErNND8y18PzL2XUjnZQQruPLJeOHIxhKFr9hmMZYICxmBx5xurGs6AtBhSuk+7c
	 Ul+e451TuxWqQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcZ2W0Bztz9rxL;
	Sat,  5 Sep 2026 15:30:11 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 05 Sep 2026 13:30:12 +0000
Subject: [PATCH v2 2/2] rust: serdev: Fix race condition on driver probe
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-rust_serdev_fix-v2-2-35dfcd06ef2e@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3431;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=0sSBP2cprqjuaV+c2HHo+xNsGybFsYHAYG6+y+2l4nU=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnBlfx2sPL/zq72ZUWElTRxokkNvkBYNGBmbWf
 o3+JzcuPymJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapwZXxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IdLhAAhyNMuqVjsUADZqyxpUP9bzZSUF5WmyE
 rnAWo28VtYYoWXJ+DEdD1fZgUdVHvYiWduM8TcQUXC9RMy9CvX5oNZI5U0tjFPmWGEGDKDGGY+S
 EFc8y5ObBQHti0z6aM4fK/5mdCs3hl8ZXi/GNGyYc9oe2AmMtCDzCU42NK2I3Lqs+EppgpbRB8I
 QXPEYw0f2ZzjRxXZ3u9yOWdyWMzZJKKjiNnIgDag/lE98iGcgr5Av4dFm5qGalRKpkVoxhBLhqt
 BBushxqbesNgH+fvkOywUwZty8yfqoHjZmm4qfEGi9YIxYkwOntDGC0MfT6C1oECrRRLdfUT8kj
 Vk2pK5/Y4JazAc4Q85HFFyhNRWfjf/HIbnXldOYnASP2/fH3gipbA6b3Djeb9ks3xFA5x8GFqW4
 ifNm4Q8Jowirf4uHuKfpN5K4JMp1gCQpUeKQeBPVd/++MJtKs8BpQ00nCAO4IzqjxP3VX2huxy4
 TzmqM9IN0ocfDZyzr6MeTxbKxOTr79BMaDoZCR/ge+zst7HofawHa8W67yLMqVufLz7tG72R31a
 2CrIzB5waBPeE9VytsgsiHhcsZLeLJuTGJyFvsz1OSBLtS17SvCWCVGLJIojIn927bRdzL05VwS
 9u/Avb1uSeCsFIb8vL+lC9TFWIZQWm7gx78/WN1ZuwraVL4lJWeU=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

If `Driver::probe` fails, the pointer to the driver data (`PrivateData`)
will first be set to NULL by `drvdata_obtain` and only after that the
serdev device will be closed by Drop. Thus there is a small window in
which the serdev device is still open, but the pointer to the driver data
is NULL. Therefore it is possible that `receive_buf_callback` might try to
access the `active` mutex on a null pointer.

Use previously added `drvdata_drop` instead of `drvdata_obtain`, so the
serdev device will first be closed with Drop and after that the pointer to
the driver data will be set to NULL.

Remove `drvdata_obtain`, as it is now dead code.

Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@smtp.kernel.org/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/device.rs | 25 -------------------------
 rust/kernel/serdev.rs |  2 +-
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 3886cc713c28..834fea0eb0a7 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -213,31 +213,6 @@ pub fn set_drvdata<T>(&self, data: impl PinInit<T, Error>) -> Result {
         Ok(())
     }
 
-    /// Take ownership of the private data stored in this [`Device`].
-    ///
-    /// # Safety
-    ///
-    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
-    ///   [`Device::set_drvdata`].
-    /// - Must only be called before the device is fully unbound.
-    pub(crate) unsafe fn drvdata_obtain<T>(&self) -> Option<Pin<KBox<T>>> {
-        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
-        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
-
-        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
-        unsafe { bindings::dev_set_drvdata(self.as_raw(), core::ptr::null_mut()) };
-
-        if ptr.is_null() {
-            return None;
-        }
-
-        // SAFETY:
-        // - If `ptr` is not NULL, it comes from a previous call to `into_foreign()`.
-        // - `dev_get_drvdata()` guarantees to return the same pointer given to `dev_set_drvdata()`
-        //   in `into_foreign()`.
-        Some(unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) })
-    }
-
     /// Drop the private data stored in this [`Device`].
     ///
     /// The pointer to the private data remains valid until the drop is complete.
diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..a12b1dea12aa 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -176,7 +176,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
             let private_data = ScopeGuard::new_with_data(private_data, |_| {
                 // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
-                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
+                unsafe { sdev.as_ref().drvdata_drop::<PrivateData<'_, T>>() };
             });
             let mut active = private_data.active.lock();
 

-- 
2.55.0

