Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA743A0EB8
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505936; cv=none; b=OWcOBay7TXEWIwDHHaEfStOZCM6BsLm1q+VrBnORDIGXpWy6PK8nF462tfvFfSpm0I91Lr+PbXUevBD83lje5Q6pkpxgO9mfhdEqHkvv3iocl2Egz19MmojNbmG2IjEZnzj4mbHkzg5iJwMO9vrfGaDuGyGRxZZ2GUH1ulP7yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505936; c=relaxed/simple;
	bh=D+PPLTDoy1BMZdBIKZnJBleicfxyVmZ6wM/9g5CxMsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGZkgHj+BRxNIoFeerrUtkpFEOPrzgDkf1v4Th2OdnUcbCOozR7BtfszoqZ4dSYobu24VsjimYiIn7Rh+sw2XiZYI95V2QEINJiD/0WppSgdOCzd/zab8vsMusjc5AQbeeeQJDXbLwUjSqTAxUvMISc9E/MPQs9aPiCQKJG6zd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+5R8jWk; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+5R8jWk"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so11522015e9.3
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790505933; x=1791110733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxv+Z2Smk33JrKxjz4dLy9oowfBjQSsd5GaEq0kknSw=;
        b=G+5R8jWk5EFRvhYyIzzX1TTnZohX79XxWUan/UqSJnm2i/xH7/noEIcKpz38Bu8Gn2
         lxEHZGsDvKGyCv+mgAKAE7i8Hv0W2TitaM+XpdrHIgj23fEE1sdOMyb8+8uVMfmhNCtZ
         k718NXF/wRALtroJVrdp3BH/pxGlxn0OjurHJiKWcmXC0ImpUEYZFD8y5WzFZMwmZgo2
         XaPxGayVNe69JqCc/P0Cu2VKFWY9FB37kin6gmLyChogkcKjWJnE7NjAFLinoUMeT1b/
         O1e5dBn8TRSAnCMva39S9Luzj2E6ochriqmel3bT5kttZIdSa2VeRz2GIajLctumLmvl
         3GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790505933; x=1791110733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxv+Z2Smk33JrKxjz4dLy9oowfBjQSsd5GaEq0kknSw=;
        b=rWoeBSF2I6nr/ukH3YvLwB9prDwZih5IxI9He7ZFwu6hGuazqv6CPyCPSGR8M/5Lg9
         jSj/bFr+uUzcI7uwKfjA3RPSkjfu0MJr8o7bojAUMRYRMgY2DHLXkNwnXfF128Ny7Es5
         E+jYyS7s8Bu5xrc8BXgDWuUZsaml+IvKMoRrqwyfL75nFwJ7zGHx6YjX9k1NwhwvhULF
         FiUhLLkT0ikOv58LkIKBlyAdPxrZcIrgxboZuzQDyYDb/zlCy1Pde3r5l83NUihfLUY3
         X5RY4w4DxzvKGIJ0k5Hhovzn2SzVj02XkaavTapgxMTpjUkiz1aJeJ5W7g79EEOOav+C
         OgPQ==
X-Forwarded-Encrypted: i=1; AKwUvByqND3He0OUPRGkWpeaXhxJHBIiCKNOfyaSPChPGYKwUobrXH8jO32sbwWm+0xFlZjJc6aeJ/eOtdxnWiA=@vger.kernel.org
X-Gm-Message-State: AFuF++nHOuZs44ubrHcJgthowXmxB/WbPbWIpj/0saCrApf9S5GobCWS
	85DykUgwpG9J4kdqbtcHa/oYxOUdbZRZ+2iYQkRGnGcwdJbkOJHKUPQi
X-Gm-Gg: AYBFou3izev6UNtptOUIxMKdOL4zBj554HgCsXTyWBUtVd0RNPFokfYywjJD6/PqLpf
	1ozs+Xisdwkyja2ePP2ElQ1Hqfe0BFQ4dlIzZ0tyqw5HaggWQYFdn4NC2iFjaSc7bRCeIOdc+yX
	uAT5idJHMZmX1PZfYM7tqq8k18KbD8ecf6AYv6LhSJQ8p1px2Kwn6xZqJyeXPOg6/cll8bEKM7G
	zPzxxjJZqUQWwhSiBvI3j7qm9at80D+fCv0nWbhzdvvxf6I4+X5VAfiEPCA5BKzx7mwSj6y1mOu
	5SqU4+8wHbZk2M6d06NcIITzN5ZtRYjOaIPSGLeCsG3cSmtnXwdl9Moc70uIQZrsZVxd1uIRl8l
	q8+CGw0Sl/a6etux+O/79ls8h/M2mZdwYC0iSoc03zdm5PEf+lmY8A4YkwXPShs/oyjOlb15MsH
	KAlNnfWUOD1xqUvtT9mvslgU5TByV0CkPTqoQb7RUEcjXQjXQEVIOtryotFe918iyoDYeWU9M5G
	4ZS5AxcA5UEjkhKlR5lxbWkZmhK3WPwSF3HbNcKCBtTVtckKhp9CNPOAu6sBFnhVt8=
X-Received: by 2002:a05:600c:c48f:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49fe66bdfdbmr191208665e9.2.1790505932955;
        Sun, 27 Sep 2026 03:45:32 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001915fc2sm46005195e9.14.2026.09.27.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:45:32 -0700 (PDT)
From: Mohamed Osama <mohamed.osama189110@gmail.com>
To: ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	longman@redhat.com,
	lyude@redhat.com,
	linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] rust: mem: add DropGuard
Date: Sun, 27 Sep 2026 13:45:25 +0300
Message-ID: <20260927104528.103881-2-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vendor DropGuard from the Rust standard library and re-export it
from kernel::mem.

DropGuard runs a FnOnce callback when the guard is dropped and provides
dismiss() to take ownership of the wrapped value without running the
cleanup callback.

The kernel version removes unstable const-trait machinery from the
upstream implementation and adds #[inline] where appropriate.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/mem.rs        |  2 +
 rust/kernel/std_vendor.rs | 87 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
index f2d4cdf87d00..7f8ddd96f907 100644
--- a/rust/kernel/mem.rs
+++ b/rust/kernel/mem.rs
@@ -4,6 +4,8 @@
 
 use crate::prelude::*;
 
+pub use crate::std_vendor::DropGuard;
+
 /// Transmute between two types.
 ///
 /// Use this instead of [`core::mem::transmute`] when it is known that sizes are identical but this
diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
index abbab5050cc5..21a26b4eec71 100644
--- a/rust/kernel/std_vendor.rs
+++ b/rust/kernel/std_vendor.rs
@@ -7,6 +7,9 @@
 //! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright details,
 //! see <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.
 
+use core::mem::ManuallyDrop;
+use core::ops::{Deref, DerefMut};
+
 /// [`std::dbg`], but using [`pr_info`] instead of [`eprintln`].
 ///
 /// Prints and returns the value of a given expression for quick and dirty
@@ -162,3 +165,87 @@ macro_rules! dbg {
         ($($crate::dbg!($val)),+,)
     };
 }
+
+/// Wraps a value and runs a closure when dropped.
+///
+/// This is useful for running cleanup code when leaving a scope.
+///
+/// The [`DropGuard::dismiss`] function can be used to take ownership of the wrapped
+/// value without running the cleanup function.
+#[doc(alias = "ScopeGuard")]
+#[doc(alias = "defer")]
+pub struct DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    inner: ManuallyDrop<T>,
+    f: ManuallyDrop<F>,
+}
+
+impl<T, F> DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    /// Creates a new `DropGuard`.
+    #[inline]
+    #[must_use]
+    pub fn new(inner: T, f: F) -> Self {
+        Self {
+            inner: ManuallyDrop::new(inner),
+            f: ManuallyDrop::new(f),
+        }
+    }
+
+    /// Consumes the `DropGuard`, returning the wrapped value without
+    /// running the cleanup function.
+    #[inline]
+    pub fn dismiss(guard: Self) -> T {
+        let mut guard = ManuallyDrop::new(guard);
+
+        // SAFETY: We have taken ownership of the guard and prevent its destructor from running.
+        let value = unsafe { ManuallyDrop::take(&mut guard.inner) };
+
+        // SAFETY: We have taken ownership of the guard.
+        unsafe { ManuallyDrop::drop(&mut guard.f) };
+
+        value
+    }
+}
+
+impl<T, F> Deref for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &T {
+        &self.inner
+    }
+}
+
+impl<T, F> DerefMut for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    #[inline]
+    fn deref_mut(&mut self) -> &mut T {
+        &mut self.inner
+    }
+}
+
+impl<T, F> Drop for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: `DropGuard` is in the process of being dropped.
+        let inner = unsafe { ManuallyDrop::take(&mut self.inner) };
+
+        // SAFETY: `DropGuard` is in the process of being dropped.
+        let f = unsafe { ManuallyDrop::take(&mut self.f) };
+
+        f(inner);
+    }
+}
-- 
2.43.0

