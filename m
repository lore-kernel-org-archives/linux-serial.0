Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053083D1CD7
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505945; cv=none; b=L8Do51659+YMC9kEbNHFwnwDQGuKBdh6nraeAE+UK5hThZHfSHCkLmFaBqUVT7cHNr9TfP8hYaqPCleQbnC1cGz1Vbtaq2r4ms9jZO5Yqz+I+L/4uOR1At75UQNQ5aXWJqW3NsT81epYgZCtJE4sFaHKczd2E7kfT0DJVlj7QPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505945; c=relaxed/simple;
	bh=bG4MyftsdfdbaBykmDiiNfkzsWo9nnA1ngVnb4LMZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhwhGwMB/TgjX1jg/tCpd6qJrSZd6dtWQTDq2wtM7GYAk2EifdxmvQ2RWcQe9weunWh5GeJdn7YQX17scwr56U9TDELLcv4pkqmgtYxg7gmccS4cFSSr/RcQmw1rEiyLdsHmvSDCPcmg6PXRmqT/Y/BwQIcfJY0Khr/zeYLPOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqskYMRb; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqskYMRb"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso15242295e9.2
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790505938; x=1791110738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=OqskYMRbZd61iQb9qDsr+rsuQD+5SZWdBQ+TQZbfvMOpNhcR9mDjA4ODiE10gIehEi
         Af/ocXLrPkzxENkzhYM41nxZ3Iy0Q3FSuBRE3Gw1WX7BSedLjdJ3P6a7pOBM130CBZkr
         Gk58OMXL5Q3Tru8M3/WJWKONUZbDSHKl6l3zvx6SWnJezL4VOUCQs8Et1bVc6VNLLTqB
         BTEj3puiTw+d+t4mOYGJ2pV+vCZBaILbXj5MExVYBEZkBFAazfOQ/Q6GAH+ZKT765BeE
         unGk/I37xeT8mVqzRCqKZ/WFQrd6qnILADAO1gjMI2l3pPIzRsPiVLloUsvOA0q6FZkh
         bHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790505938; x=1791110738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=L0uRNEXRFH7hOifOUNsuyI5EmnUMScawmAjP0djQgMSMcAXuh1whXrLBBPnBedOQ4f
         lC9XM9EncrquBzMLW95Veq3qsPLbyC0drlf2hQSZHUl7s1rBm9OFWE7FJH4l1tsGbuqC
         qjqj7i8SkytShFhmb1psXC4qV9qOOgOXlPNZytDpZWy7WYHf33adSIecDOBfpX4xJxVK
         onDMt/xs4gBsvLIdfTR9FHcA/J3IPeg2+QGgRixGCx+gYHRzy+3D3D/q85danippBE4F
         pJSzd3BLhzw0htveUVl02RHr7hgWnueEMb4KQlNxm1vFMCPZGqopIcmPDQy/8kb1F5hP
         9q7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxNW+9O1GNYngKqgHj+JNDClPi1p34LVqFwncOLJo6SxdLB+r6WQsXIv6Q0cnqnmzXiNIywXJcDd2pLreQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nydYbSr4wGHdFuKbbv3b2r53Bb20tE2uDlnDfbPxUkgDoqmcsM
	7N9MOOVshDinw9/pZ5Ve7N7HHdUZiy9uD72Jih1fgh/FVlvFUHmz3AVY
X-Gm-Gg: AYBFou0NUaRaK3bkfGsihIPLXloV4WUqN+nQ622l4jguS9rXobLbN60AmMD9/0Xmfs7
	8VAhpBTVLjKRnkPGi3KDnqRxni90ysepwLploTQVA5kxZ3n0a+YSHUyQ/4j0JBTl/zhkdfoUHgb
	30+LMzVRiIJN5UahONr9n9lClzSUXrPhfcfIkLnTsR15DMIqD3pMKbJrExUFyi7UHkLBvfoEB3h
	7r6Lw7QPYSXzKnYPNR2y2c/aU9nmZZ1ZTGHHLkB5fcT80XwV3Bz7nlVyMokfgWceuQqbGBsKSQs
	vMRQFgvs2H/Tp9wUdWqMsk3xFeTBvCwy0+6Wy/cg9oBMJ2y9dXhsocxMTTLG2Z95avQId1IYrgD
	wtpjijV5X/URTcXCvuHyZy9TmUZrfJY6CrsO6mv7fyJHjnZFvUm4DkhVOJZMmvG7Of/LZ3KhxLl
	/odQkCWuJIskUH1RzY0loQOMREVd3WCylk2YZ/niCfHG7l5sImG0HL76l840Muo3fud7690kkKk
	iw5vuQ9BhLxzEnlS9o0P5I09bgzwU4lBdGDVOMMflEN/2N14YsEv0kAqBRcvimV8T8q3EPZ8pp+
	6w==
X-Received: by 2002:a05:600d:6502:10b0:49e:7cfc:a9b7 with SMTP id 5b1f17b1804b1-49fe67bc27amr127421625e9.18.1790505937936;
        Sun, 27 Sep 2026 03:45:37 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001915fc2sm46005195e9.14.2026.09.27.03.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:45:37 -0700 (PDT)
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
Subject: [PATCH 4/4] rust: sync: lock: use DropGuard
Date: Sun, 27 Sep 2026 13:45:28 +0300
Message-ID: <20260927104528.103881-5-mohamed.osama189110@gmail.com>
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

Replace the ScopeGuard usage in the Rust locking implementation with
DropGuard.

The guard preserves the existing scope-exit cleanup behavior while using
the DropGuard API from the Rust kernel memory module.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/sync/lock.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 10b6b5e9b024..15f9cbe76c8d 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,8 +7,9 @@
 
 use super::LockClassKey;
 use crate::{
+    mem::DropGuard,
     str::{CStr, CStrExt as _},
-    types::{NotThreadSafe, Opaque, ScopeGuard},
+    types::{NotThreadSafe, Opaque},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
 use pin_init::{pin_data, pin_init, PinInit, Wrapper};
@@ -242,7 +243,7 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 
-        let _relock = ScopeGuard::new(||
+        let _relock = DropGuard::new((), |_|
                 // SAFETY: The lock was just unlocked above and is being relocked now.
                 unsafe { B::relock(self.lock.state.get(), &mut self.state) });
 
-- 
2.43.0

