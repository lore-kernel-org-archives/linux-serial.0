Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4D36F906
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444013; cv=none; b=EyyQAt4ovyGcXBdPRCbIcBy4KaLKyjXfQbNjbY+F706bhnDJfFJPsdIQaLWilW7KMRc4WjL1GZ+on2r/T0UxhZyPFfJ96IYrZ5Hg7yQeX5XTPEn6pwQIpuZccOm7qTFDKhQIX1qoq6Qpa/KDtqIVhbf7EHQeXhzch5Ugn/lwHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444013; c=relaxed/simple;
	bh=homsJuCQjKnZ0xNxouQDRH+hnm4JjTgYjqEZCArzYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ5Wl5fz8U+XROTMtawudRt4F/VqO71QkECEUSih6izR2BdDGUrMlLamiIK8zkc5bPt7CvC/iamHn0QS9F6VGnekwBTtIvOA3Vd2Jx8eJZ/q3zNgt9vOG0S9N24FGVh2OI9QkcmiyFGygHvuXBDqeXvbgLpz1i8OLPnlk4RuWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH8kiDZs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH8kiDZs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so10396985e9.1
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444005; x=1791048805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=DH8kiDZsinWXHkuLDmdFp6BNs2gcCQ3SwEmHQz366D6QpjmhArX04KpKOGHWY5gug8
         IQW6LSGK+TcWwZxyQ6lhpWhWq8JKLyXxr7SMvBe9ZnxUoFiHSIS3hM8b69QZ+t3LlwKJ
         37Gz1wYm4t2sKqde82rBY3ayLJ9cP6OGzHyHa38Le5xsfJpNmQgYrsOMZGeINICs88+3
         FCv7ZQEbRBIc+6c7s/xsQttA2mazzVU/QKZkgFvA7l/ZJ5RsHI/ALG8mhA/CZeE//v4i
         nOJT9AX+pIjLpcAohRbp5mmX4YCx1SJIoSIYmE+068fUUhGsMF0pQLt5sG7P4Tns7faF
         c7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444005; x=1791048805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=IKe5zZkyBu0c7NTa+7RgWK1y06X9yA9Y+ma+tCOG3e4XATro3pGXWeaOzpoQ50Cz/A
         PNLIQZ2wbQeUU+00EDXhhX4zAAiRHModzk1+WYTxRoxkobbRJk8Cm6ElhL6WtQ1JTZLO
         w/CBNPbJxvdhPNrj6CqD5J2N0wApvTSYhabfaTGf1ZrKJ9SMRByEDDGdAtC6FlSGss8o
         xVfq0Yg8nTgiirmE/Tt32lflmd7zX0XYQLihXaxrAdYWnn64w5qcrH6VPlHBnPmsTx1n
         3j2qp0lStItD9auDqtkZyXnuVuIZekKDmdSmjmxxqrcpNMe0EENyYwO/dVh09CAhzpsz
         y9Bw==
X-Forwarded-Encrypted: i=1; AKwUvBwsZUyvtHcKt7YFyjcKWlC3n8qzhFHZM8cKf71uNBShue0LF4omZvvvIrC1kJPW/RqRi1Maf23TiA1n0y4=@vger.kernel.org
X-Gm-Message-State: AFuF++lvBFfYiT+evpTP3P8mLxDnbKSQ4dIoyXqUJyvvjfcXGH8AvvTM
	qlptaGORp8W4KwqHv1ZCdUJdH+RElVEaYaJVVLa3ittQaKX9Gz6CzI/C
X-Gm-Gg: AYBFou246gXZiXbMAMZHHf4EDwrSmuHMl93R0gh+Ul+inmczrBNhTZsmYzT4WtOGHTz
	QY2oIAgd5cVz2T6d7l9Cv05oAKyks4aGmCbufrJPFSeqPt2HLfpneWZQOR3Rh+BNegjhHSXP0JZ
	5Z6In5MFuY0r02BYWIUGgVHZNJ4m+4qaPatVvpM4O2f0LHzR2yKh7rtPo2czps89djvAr1P2qrm
	SqAUMYXuy1Ezn66IOZsrat9CrszAG/TmvJmUq9aduU4wX6tYvpbovSL+Mq7oO2RzZ2rYdBfm6J1
	Xp2qf/YIUFyzyE6u3bfPHzq6iFW1zduvnhSRgBWi8A8lrg6UeQAeKzPwXFlHZ4d6pARJbX/e84p
	txD5GxhhcHC3iP3GqE/hR1o0SJy94txf3uMF0CDKw2XIFtHr9E/atW/Rq8IXOm5Y7Jg3WIeKbRa
	NEnAG+w8WvrU3SamB1VGoKbWtUxQj4tQLOX+87d44/b4dE6bvEDe5Wtivpmg+59iRHe7qj0uNaT
	T9oDBkbMG0IiyEZiqZXb0RLieiqk49RobHqBAx4w0wK+OI4YE4Z7IHzWvXoDxpaHS8=
X-Received: by 2002:a05:600d:6409:20b0:49f:f099:6f8c with SMTP id 5b1f17b1804b1-49ff0996fd6mr68193415e9.9.1790444004921;
        Sat, 26 Sep 2026 10:33:24 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:24 -0700 (PDT)
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
Subject: [PATCH v3 4/5] rust: serdev: use DropGuard
Date: Sat, 26 Sep 2026 20:33:14 +0300
Message-ID: <20260926173315.56772-5-mohamed.osama189110@gmail.com>
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

Replace the ScopeGuard usage in the serial device bus implementation
with DropGuard.

Use DropGuard::dismiss() when ownership of the private data needs to be
transferred without running the cleanup callback.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/serdev.rs | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..dd43b159b461 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -13,6 +13,7 @@
         to_result,
         VTABLE_DEFAULT_ERROR, //
     },
+    mem::DropGuard,
     new_mutex,
     of,
     prelude::*,
@@ -21,10 +22,7 @@
         Mutex, //
     },
     time::Jiffies,
-    types::{
-        Opaque,
-        ScopeGuard, //
-    }, //
+    types::Opaque, //
 };
 
 use core::{
@@ -174,7 +172,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             }))?;
             // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
             let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
-            let private_data = ScopeGuard::new_with_data(private_data, |_| {
+            let private_data = DropGuard::new(private_data, |_| {
                 // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
                 drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
             });
@@ -204,7 +202,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             drop(active);
 
             result.map(|()| {
-                private_data.dismiss();
+                DropGuard::dismiss(private_data);
                 0
             })
         })
-- 
2.43.0

