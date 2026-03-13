Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291973DD515
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425560; cv=none; b=DDYFB3XzDRZoc+xbxKVvefw9oHzCgAu4o0Z+ESJHm5S8uXezpb6xX+12E1xWuDczp5WLpQR7IDjLznDEp7mIKeGtQMWkhR3U22Qjsm2T4lWqhPHH/5kr5wRpO5vm1A79seZ2nlGnBB8GsbpWeTrRnevV6GH+M4C2xVKUKCBavrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425560; c=relaxed/simple;
	bh=keqz28rKvxuSgS9woVzrUhaF71wCeQ6RBjDla6L6OYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEo/gWRmLgXh2+QF5BKYyUQGBt1Mz7ZEhkNkvGdpEuN+BTtF3q+P+j3cLpmZ3OO9443RnNUpA8jh7t8M9COxSXAznbjfMcr0dTKIzOwdQye+5MwQSIR4gPzvBzVgCQg9MfmXCmG+neOQaiZWxlHchNQQ+6FuyWz45a0RjGzh/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=EJBc90ci; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="EJBc90ci"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C5A6E24002A
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 19:12:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1773425550; bh=HVPpVZG7q91124YZI/Aaqk7D7oF9wWOqNzAvI9ipxxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=EJBc90ciqStILTS58+xx9ZQSJHxcbz8a0uPdxx+L+wxq4E5JTRAby/DAYNCxXc+vp
	 8GJC+jDoinDkHiBKnqskc7OdReASX23CmfM/n7NfjmQmwEGP+vVV3PRQvAOgHFOikh
	 tH3DekWJzfz3Ju9JUa+eQIKR+zbPRba6aNHh8PXSOrRYXWdPiKcdbY33dSBG1MBFS3
	 dxcmjDFj/ZXBZeXIIa6cRkUUNV+rsEQm898gCYSpJdE/MBkNVv/He39Ng2b1M46lez
	 3orAOl/WnPZgaPAMUxAX2w32s4ljPyczzXKbGgaGPQEsfbAnZph2ixe4P9TnHzvcfH
	 SaZ7k7SzUbo9g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fXXdR3sJbz6twH;
	Fri, 13 Mar 2026 19:12:27 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Fri, 13 Mar 2026 18:12:29 +0000
Subject: [PATCH v3 1/4] rust: devres: return reference in
 `devres::register`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-rust_serdev-v3-1-c9a3af214f7f@posteo.de>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
In-Reply-To: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
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
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2571;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=keqz28rKvxuSgS9woVzrUhaF71wCeQ6RBjDla6L6OYM=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBptFN9OVuNhJqcH4ra1bSheygLt4ZfzA+F4c7xh
 /vWo+AEepKJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCabRTfRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9KUohAAm4rMGurhjYoODB7kiH4xTfowXrAT9Qr
 NKyXRXGHVG4zDzAnEtpm2uLHc3rl7TceKiVt7sM5G5VrKkPKtzn028dDXTRfOYXz4Fz8GnOU4jA
 tbRLW7V4xhg+TSDfPFcGDsqVgfSXE2ytSfs9a9CzS2ChDSNCRpm1EF0bSvNHpakTR6ZjKS/Hdiv
 XVMQi3RXnbEaaW/D/+IzD+eRJo9MuObzhi+aNRjF/1xpuxkavw50kcw1XurathwMfN4o/F4exEf
 kDiHiRs4SfBMhe9FSv5xzsLddBGy7BJh6B21fAxjAGTQA7Um4Pm1BdB0WJw3DawXG6xOjgMx1nR
 YgBmC79//e1O+w2VkSV7fLqKUPSopf+vIxKII0vSfkdRXyS8+rTTHLC5K+5f/WWSFct5vcPcSVZ
 HbqMnVY14EgetWKwzIud20skEUxPWwcsGaQnb+lJXoZXoiQ2gipUwYuS2GDm39oZK4MR2Ihd24F
 sWZPSsc2P9cP7UvsTLreH0dyJFwWvd5rvroDbJT7EWt7IQGQ8SgmvpeevQa/A3yHvZyVkuJ+q2u
 Sj2od32Og9MfOeNIPucEj2R9M34oQKFYs0SWi7BFwCQ7chI4Z1zW2oSz6umrspwABL+dM/WZBsP
 MfGQOhvtaEdq9ACfNcmCiUH5ZkDwt9anbLGuvLXUr1a6PZhw2/Ww=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Return the reference to the initialized data in the `devres::register`
function.

This is needed in a following commit (rust: add basic serial device bus
abstractions).

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/cpufreq.rs    |  3 ++-
 rust/kernel/devres.rs     | 15 +++++++++++++--
 rust/kernel/drm/driver.rs |  3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 76faa1ac8501..8cf86bb8e0f4 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1051,7 +1051,8 @@ pub fn new_foreign_owned(dev: &Device<Bound>) -> Result
     where
         T: 'static,
     {
-        devres::register(dev, Self::new()?, GFP_KERNEL)
+        devres::register(dev, Self::new()?, GFP_KERNEL)?;
+        Ok(())
     }
 }
 
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 6afe196be42c..f882bace8601 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -326,15 +326,26 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 /// }
 ///
 /// fn from_bound_context(dev: &Device<Bound>) -> Result {
-///     devres::register(dev, Registration::new(), GFP_KERNEL)
+///     devres::register(dev, Registration::new(), GFP_KERNEL)?;
+///     Ok(())
 /// }
 /// ```
-pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flags) -> Result
+pub fn register<'a, T, E>(
+    dev: &'a Device<Bound>,
+    data: impl PinInit<T, E>,
+    flags: Flags,
+) -> Result<&'a T>
 where
     T: Send + 'static,
     Error: From<E>,
 {
     let data = KBox::pin_init(data, flags)?;
 
+    let data_ptr = &raw const *data;
+
     register_foreign(dev, data)
+        // SAFETY: `dev` is valid for the lifetime of 'a. As long as there is a reference to
+        // `Device<Bound>`, it is guaranteed that the device is not unbound and data has not been
+        // dropped. Thus `data_ptr` is also valid for the lifetime of 'a.
+        .map(|()| unsafe { &*data_ptr })
 }
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index e09f977b5b51..51e0c7e30cc2 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -145,7 +145,8 @@ pub fn new_foreign_owned(
 
         let reg = Registration::<T>::new(drm, flags)?;
 
-        devres::register(dev, reg, GFP_KERNEL)
+        devres::register(dev, reg, GFP_KERNEL)?;
+        Ok(())
     }
 
     /// Returns a reference to the `Device` instance for this registration.

-- 
2.52.0

