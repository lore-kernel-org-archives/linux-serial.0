Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0755383987
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444016; cv=none; b=lZ6pGWZ2V0eirFNABqI8RIRx/56nMXFGipw/5zpF2d5x0Ml110DeMmnp7BY838FDjKIAgUkNv00bqNn7XG90tTmD88f7fcfIvf3DkYv1OAlbwv7KaAfRDjCOUwmx3EzUkLrPN7QbUZW6obQFL8FR7jUOfCyqRezdrvgQwrKyOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444016; c=relaxed/simple;
	bh=bG4MyftsdfdbaBykmDiiNfkzsWo9nnA1ngVnb4LMZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma94RghfPMHGoFWeK2Z+slD/AkcKRUPtIsDhjPxkIhK8ZFg8jCW69oY7/mUJIzGf+pbyrUEa1ED32DWgrFahdOlb2Y2XXiuSH1vzmxppf4pFIXzRb40YV8V8AyRCL669TC0Lgd4IxEggjtlVqzr8tTfNQyzeiVcYGmjl7h5rNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivEIc817; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivEIc817"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48879d4fd8aso1004031f8f.2
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444007; x=1791048807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=ivEIc817Nrhsx8H6zckRL3AMyp6wCnxfhrQkSLJcJgRgU6q/awHL2kbs/H9giNSkOn
         aqGAH4w/Kx67BixNnZU4ahXzYlJMZqYoZPxeg+H8oUvBlqR7TUVXI0s1UDp2u5lPSTuO
         3nAEvmF4uS9+QBd8RikJZylI5a1BnuBDLbeQDIXQb/UECTjKXl0DQGRb4IUbcADjNoA1
         Rtyz3FSA19TWzoRT23diGMqKBZqsbbHStqhvA1YLvUC5oiAIucjsqh9OAelSVsRYRqhH
         XaaI2x+fRMZOUGqpbqLZLfqqB7VJzyqN8fRFqtCcLJJcvkgRmEzh9IKo12LA+D1jxk8f
         ikxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444007; x=1791048807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=WKOkfCKzz8g8utXsYS5u2ljNwr9qXUV6hpTYmFApebHeA097myw+Q2sQH4U9a1q6Av
         rqvClOB3SjpLi83L+w0I/dJGHtw3kc1I66zyudrwTDAnP0EXJwPNzo8lHsO84Lh7Gb/o
         1hNhD/c92rUwybRdUa22gDXu6xE+FbP/RUhAjhE1LJVP5BTZQhe7v/AR3gqGRP6Is/wn
         nlABwCXWuUdbVq4V+tG5x8idfP61NZZFn+NeAezBGrq3UOF+k9wKyCyowZTTEy75tjw5
         hAgUGBty+b5frk4luWz3Deegt4qqz+YIjEGyecyZ/khnPdfDZTMIWqHXtcgVH9zdt6z0
         LfRg==
X-Forwarded-Encrypted: i=1; AKwUvBw1kLPkVzoNljcxdVKt0kEV8QrPd4N54j7t/fk5cSssuNxcYfb6iw1xE5qqgqtgk7m1NT2woIhxBohddi8=@vger.kernel.org
X-Gm-Message-State: AFuF++lnr+M98QFyn+zsPfoaLFNeo5a992XIddrUVhz6wsn6Tluo4psp
	ipYzyr2USszLMwTM4HAlnFq20VSUeE0G/NF9M3vShRb1ahvujeUX4ru8
X-Gm-Gg: AYBFou2tDw6m8rmPTmKkt6XkKrI5sSbCIZu5Yi4bIZA0VyK0JIui0e/KTkA9FR0ps33
	T0Tqj+gu7se5lL64olHjVot8qp6fZipMChd+jfd+56EDVuZCInBpMCXaHVViw7wo/RdqsBNpYZV
	Xe8MriMmGzb41OeadYryhnXs6N0Ou4gA/8luU+9Vjkwc05QPVC6iArO3I9ZcrWHpqokPSxyNciH
	GFzKQgxHRLM9bxxUY3ILY8OycT/1IfXQycy/BY3UjwnnlqjEyqxNeMdWqC4vGRmYFMpSv7oqaxv
	oMf2t9VQstsSd8krupQCRBvKfXGChVxtEPYicbuyWkM9m0HLCbpllvyclYD6cvnupibp5zDWNm/
	PyZlw8fgJki8XJOo+DA1lRWfz+qTTdrXYvfbJ8VHVEXXrcbowvmeW/nAGxOFG4M00b+HCn2F89R
	AsGNJqTBkiFyHrDqWICc2imrghm5H8iFAQn3wJdLIzFbeJBTK3FlTBOx2GVQALED5oakX+Tp2nz
	qarXutxWWMvuv4dHtBNIPovKZcOAZ+hnNNFCNuC6K5aLSIs/epFkjBJyYIZDt7ZR78=
X-Received: by 2002:a05:600c:1c1b:b0:49f:bc28:e8b1 with SMTP id 5b1f17b1804b1-49fe66d6c9bmr166175805e9.14.1790444006652;
        Sat, 26 Sep 2026 10:33:26 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:26 -0700 (PDT)
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
Subject: [PATCH v3 5/5] rust: sync: lock: use DropGuard
Date: Sat, 26 Sep 2026 20:33:15 +0300
Message-ID: <20260926173315.56772-6-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
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

