Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6C39185F;
	Sat, 11 Apr 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920248; cv=none; b=tQB0skbySQR/qHOpffd/slCTRQ4c9yRaIo2ialWnedfrqDYyGJWr1vMYuInpdaNe3+AbHA0OFvtW0A3kgjot6AKI66IKh9NHsr+24XU5L0sel0M/JAjugYQgaAlY43XZhaxXgdfhxRmluTXYYFD+7KubwhcM434/VCJy17p9H+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920248; c=relaxed/simple;
	bh=GtNjMzQcL+Jt+Tr4/As8pwNXCGbFboINwOFxtiYT7sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cek2bS9gKZCbmN0wZHekP6xqrUuLoI4vgCCs4SrVd17WaoQ8CpUgiEFVf3V+ryfeFU/7LcuVzVO3aE4kjxCd6yMxfp1ZhJLB9TGKAGh8SNBL/dVCwYnTImR71d5kVXufKC9Z5toXVfIDT1NbjammoBzu4RjoK1dkSFKoUYLe3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7bJfykp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7bJfykp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A864C4CEF7;
	Sat, 11 Apr 2026 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775920248;
	bh=GtNjMzQcL+Jt+Tr4/As8pwNXCGbFboINwOFxtiYT7sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y7bJfykpezkTvtZyh+VP277vd6h4T0h6teTSTjou5kYQqlBd2Mi05RsaBrJvJWEHu
	 av5enXoxlszDnb0EiHNtCAXt02S6PIXnwhM8rnDu+hgS8xKZsm2iHgSW1ZzGHD6w6e
	 nC6Pq2+RT8sxrNaNUCbEl4yE5QAxhiYa7EgojG4OFJ7gwnvC4NKgAwDQpN0rwD2d+G
	 tcyy4CLqqHkKHiZhn32WMKk5+Iv14jCz3k81b5unzYowImx+9PURxydx+oO+kUXu40
	 m1WIOHpZeDvFrujD69kPpaVtHUm2pnWSuTC+V41smfVWao+ZqUUTRJHFCKdZckDvW5
	 eQ3YqKXrGkofA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894C6F3ED54;
	Sat, 11 Apr 2026 15:10:47 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Sat, 11 Apr 2026 17:10:35 +0200
Subject: [PATCH v4 1/4] rust: devres: return reference in
 `devres::register`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-rust_serdev-v4-1-845e960c6627@posteo.de>
References: <20260411-rust_serdev-v4-0-845e960c6627@posteo.de>
In-Reply-To: <20260411-rust_serdev-v4-0-845e960c6627@posteo.de>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2571;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=hxd+EOpJlRj8rnPcKpkmiK251FfJu4VZQV19A2UTrTw=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp2mR0Woq76R69PGX5hvMWIgwVx4Bowhh0BkP7O
 X0dOsI6b7OJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCadpkdBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IYnA/+Opn807/XvSDs3Ep1Ojnb7yx/LgYjZRr
 x96NxpMkIL1k3FNEWnLBVi5TAZu/vrEsEH2UYrKuVgN/jf5UrPjlhkcLgxRcNDHi4H7roAJuEWt
 0UgNVCLyCoAO45ZrWmk9RnMAo+2fQrsk/4Tz3SUSKDHvAWJIparuYkTYKwvNfGKgmfdoGqksztb
 iLh4SFjKYHKkcp2/n4ZpQ6GmeGX90xpJj3OYTjbC1fnVlSLml2AlMHnn/xBWvuBe6yJTfta8Y1V
 K5NDnuIrHIdKJZeScxeTBDrsi9bH+R/hyl02djhy/Ik0IKjAP+YleFqL9qxW2+4AYCoFqd7fxTc
 C+Iv+sKwEXsZca6V0XtzHybjUl1rbhQFUKNuWIIoyfL/s+NmtlKeASmAR4YSCs36yOJxhC/EGfP
 ydBS74Qhn016Lg8adupvh9Qhi9kM/d41r1nP7MxmsiWZGBpIYc9Ctze5wooppByfo5dHZUy+eUE
 USLWRbNbPeuuw9a08lfGqTFJ5RvwZpVuoSsOhD4tGPpFbECk7QjhYflgXD6Ay3aCYQQJWbWCNJr
 xFAcLcdwUlpSk13NbFC3WC2se1U9qzsZPZyNtOYJ/HnWYdIEoD4NfX5JxuA24EM2wBYcx2cwJ+L
 zOBL6WE5d+aB+Q+KXpMJpHnLRuZDELtBvBNCyyW9r417h17XGxhI=
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

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/cpufreq.rs    |  3 ++-
 rust/kernel/devres.rs     | 15 +++++++++++++--
 rust/kernel/drm/driver.rs |  3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f5adee48d40c..31bf7e685097 100644
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


