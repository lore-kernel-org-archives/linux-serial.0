Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016493783C8
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440575; cv=none; b=alJQJoI4w3Sd6mIt3qFerFjSNuXcsuYwRoD1oE7CsFoqR9FW2fig1/03d4rIuwgQIxyzs+2a7A6a5JkWCz2P4+BAkBrXmIg/r70bUuUaPBdpGcWZ+gMJov5vTw9HqM469ZE9dwbttiIoIKIEEkmCwxVfk4sFwlngwgwEmHjhJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440575; c=relaxed/simple;
	bh=bG4MyftsdfdbaBykmDiiNfkzsWo9nnA1ngVnb4LMZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ros7OCkTnojczBvrdUbQZjrMTlL6azN4lg9Tp3H1uAHt94ryzMqi6T5h95Nu/dzm7d3UOXbpG1fD9KeHu+HbYZ17MjX2eY8TRUJRr1yBlj4zyXE1rl1giMYhUTVGvzKeuE8zTf5OSXki8DTvlFhsBla/CBES6eEnwQucGMLzb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYLy7tXS; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYLy7tXS"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so984956f8f.3
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440563; x=1791045363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=iYLy7tXShZxTAhG2W3NNlmxf6L4RtJ38na9e0k0glaO097X12jiRsivDkfbSyepjNU
         3pZlupDMTTZxyjrRJBXMkORkTV7uqGPkKP4MY9832Zj3Va5oa4ZfHOWACt+JrlVuE3hH
         7daMOWjwXyXxE4pTP7lsJ5nzRipcmElXadRxRY5OhrdwclMXFwTVHo/lLs6W9ro7Cicg
         OhObvRR8xsXr6FcsG3tuz13C/F/+JmWMrnWG68OuWA761fCDy0utcPCfHqAExz9YUB/A
         dwDCh+05CYuMU24D9C1CtIvYjY4A3maP0kPbJkaX0QJT0nj0r3+Xoa1Gwv6G/wH8J3wb
         zRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440563; x=1791045363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=rDGzXIpWHIH0cbokzPvTo2jhcVtgR6vo7y60LkwKbRhzXXguxv9DkFDMzwlT5/Oyc+
         am4/CPov2UlqIh5oduN6QilrtUxRaDZe5uXoCWz3T0wLW6Qa7v94qUFBkN55WyOU75iu
         p7twcB/LTCPQxSEMLnkWL31IzfZ6/C8Pcti2tQEFja00SaFwWhthePKswXVqk3QetWRZ
         iII3Ye6J1yKy6sA5ldeHwbRdYfs2pC3D0/8KDqdv1+nXg/dHp0N5BqdNrj6aezhbp+II
         GZcsZN6yv6G6xOglq5FydSidDSJxFOvcM/w97a0MUGqzeyIjdGygY4nQ7H0M3oie022Y
         Iyng==
X-Forwarded-Encrypted: i=1; AKwUvBwLsk1ITqEEF2CwhfjKa7gzRGl4d1z84b5W9/04RlTekGcsrybxHlIc7nqAGgNOh6ugY+TkssBlNjH5yXc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLe0u57PoBx/lVrixMgLXyFWDYSVhxFl+wmab9nW8Yom7snxs0O
	1kNnmK6qN7TwiaZ61dlyAlQnHZtzkgSA7pvZpmhAnzxNSVbvq7D/UDd6
X-Gm-Gg: AYBFou0P173BVeQQDEljS0ot8fXxEEMTphIjv9/wsnrSPddw1xsz07/xl0ATRSIskjX
	Ir6h/jJluBkjJg4OG3TOmJ7+qKkfJmdI/2HIv0cfdY6jvduTKF4VUbfDp6dN4O/j2/vC/KC2msb
	OdaPzQMgtzq3XxNlhVgMzBWDjs4GgblfDzFlVFnpmdfCvV61eHBFhpTotXuDr29hMG9V7yPeUkJ
	J/Dw4333hIqCzDJgNFSs71MXxyzQfoYa2rZJdZYb93kEHLEWQb46EKrIeXPLMEkVIHlL0BzI2k+
	D+KgCwnNvFl9zBCjt3HVN4jpOT50tpjOECaL89kIGXpLKuf1qFoarx4ZG4gQJI4c3gvuTLUjwdr
	SGQyr6QYiQUY+AUqYfoiEeHwTjsv/zNGDeuaZ3OojabLwC33VEgQJ/B1XsMmPRC0glQF1Y6/TF7
	WdgEzBHG6L54AXjxUklLb0WQw/c1iNWKBxGMzHZD9m8ewj8Y2drVBCsDSoz7hdkaEmAdP8zVAJm
	xMYJMTMhZxBr7FYWgG/UQcEnz+9lcq9Og0dpSULi8sE9OnaTWX0/ocNd4jpULz36UI=
X-Received: by 2002:a05:6000:2999:10b0:488:79e5:cb2b with SMTP id ffacd0b85a97d-48879e5ce9emr7985352f8f.43.1790440563055;
        Sat, 26 Sep 2026 09:36:03 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:36:02 -0700 (PDT)
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
Subject: [PATCH v2 5/5] rust: sync: lock: use DropGuard
Date: Sat, 26 Sep 2026 19:35:51 +0300
Message-ID: <20260926163551.52371-6-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
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

