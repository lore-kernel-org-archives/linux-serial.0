Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64673ACF04;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313151; cv=none; b=uFsYDDLXcQakKwSHb5TL0RB4GEVbWaUIn2CeXiByToVNZzFy+swojhNEfS3VEsAmNu0UchiCZrrO3CyO61UThFOdOpr4T81FyvqiAbGddq2YLUvOuxFaNNEW3Nz0762s6NRjkPUHjm4MxnUTSUXJ2LylVyyFB3tc938v0U49yWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313151; c=relaxed/simple;
	bh=9E94tFildgqUx12/GlGdp2GUC/gHnUuATGZiGSlMpy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCD4BkwA7BZlIfpzxuW0mnzhJ37xzr0YF2TctOLTHpDSKkQ+Olk3TCiwh0tq/dGMehVDj9Z04K3v5RCuDsomcEuK+ZnPJe6Wvu3ISseeld41I/xZy0NA2+BQFQZpankfjZSqebFvWM/KKxNhymQ6LxZ0faEBRuWqVfEHKDX9zXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKh4k4sN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKh4k4sN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F795C2BCB6;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777313151;
	bh=9E94tFildgqUx12/GlGdp2GUC/gHnUuATGZiGSlMpy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uKh4k4sNxSD43XHOaRmxVsFTZ+XoC3KwhQNu8uTnYeS+ZNLdnooT36qvnMF4UJa4I
	 k5Ua+EvLr8cVptIW/MFySzKKWXQGQZIhLae3oFFaBbMMRqORg+Qy+Oo6yntHeMbOmb
	 AQncR3NqRBXUxgh0GwdmudXez4AxjWvhrLr0+Rw5r0O5fsR4l7XQ5KBpf2ComCa2C2
	 UE1pmSNkKaht1F7x6EsYoI795ImEPCymLrjRZ8iVWxYzrkhw+o0p4Zc3AZGgkXF4g/
	 e1sAgw9RusevxirO0gjJqS7BhIDO4nQAJOCsfrZTb7tcX2skqQ3tAEQcj75vd2YSvS
	 7XX0D4uBA8eIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D328FF8868;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Mon, 27 Apr 2026 20:05:41 +0200
Subject: [PATCH v6 1/4] rust: devres: return reference in
 `devres::register`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-rust_serdev-v6-1-173798d5e1a3@posteo.de>
References: <20260427-rust_serdev-v6-0-173798d5e1a3@posteo.de>
In-Reply-To: <20260427-rust_serdev-v6-0-173798d5e1a3@posteo.de>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=oQKYQhuICX5DBtHaowGZbnJGuwpyDpM+GsZaRCaIX4M=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp76V9jveQ0d8UFFWCXH/ZYKXYbx1j5Z3L5kn+E
 Syf+XW02bKJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCae+lfRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KVHhAAjJc7tGq49faeum6CZGHoCRQI0UaRoRu
 6SmBsvh1p2l28DUKaEn/dvKXyexu///bZNXPbFw/is3zD6RUn6CHPOmGQ/RHKq7Dhr9/yMCPKvb
 RwkRt/jgEL8fdG0R6doRrnQWtYVmu4CSv4H/mPq1LkoVbNv/6SSYrbhReWEpQyfzMk5ORou8Xhv
 0rEhZmD7zmItkdBdgSh/T08HvqEGCwQavXjQjGOetef8e8lrNYTZY/6GZwQWlsKycoJkmgsIuWV
 gX89cUjDlTCdkkAAWOolNHgJ7ejQOu2fo/vZ2KcDpyofLKla2fBZOw6i3T66sYb9IfnJ2m5aawQ
 ZjTq0BAbX1Lgs6BAQh3bq2UQ1aPzAzjm4usmDfXYzcbed0W5NIj9g/55sdRTJpOifmXmpHun++8
 kqKuTOjxGWpqtK1Vz+bFbjldF8iBvpo9n+D6C3uT/K1Pek7c4uqbZH2HMogF1WUCKX0RdVBa9j0
 VcTAh+543GRxWWoYH3cPkRWH4ya5bKfC4ZtvV4cQLhO8oePehDW6Ttj3P4FUK+fqAq0zjcdmIsa
 hfFR6O7+3AXDXYWISRlFV1O2z0PpctoL7fOBK/0qC4DO0ZXHUVhXCQWDR5KEXHfYBnMzkD2vnYk
 GyvJAqtOI42mCna/Hr9ypH/8EsZz9urdeQ7I21Po3E0TZHc0bhKU=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
Reply-To: markus.probst@posteo.de

From: Markus Probst <markus.probst@posteo.de>

Return the reference to the initialized data in the `devres::register`
function.

This is needed in a following commit (rust: add basic serial device bus
abstractions).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/cpufreq.rs    |  3 ++-
 rust/kernel/devres.rs     | 15 +++++++++++++--
 rust/kernel/drm/driver.rs |  3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d8d26870bea2..e1228530598f 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1052,7 +1052,8 @@ pub fn new_foreign_owned(dev: &Device<Bound>) -> Result
     where
         T: 'static,
     {
-        devres::register(dev, Self::new()?, GFP_KERNEL)
+        devres::register(dev, Self::new()?, GFP_KERNEL)?;
+        Ok(())
     }
 }
 
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..d3c9c376693d 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -419,15 +419,26 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
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
index 5233bdebc9fc..1edfd7bacddb 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -147,7 +147,8 @@ pub fn new_foreign_owned(
 
         let reg = Registration::<T>::new(drm, flags)?;
 
-        devres::register(dev, reg, GFP_KERNEL)
+        devres::register(dev, reg, GFP_KERNEL)?;
+        Ok(())
     }
 
     /// Returns a reference to the `Device` instance for this registration.

-- 
2.53.0


