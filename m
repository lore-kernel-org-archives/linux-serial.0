Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6F37F739
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440566; cv=none; b=L3Hw4JMTYTu1lwB3h3GzwtGLLaOKDea8e3VJoc+5Sbq5pyV0OHvqkgU3Z56EME5MsQx3E1gWrTinDqlcN5F+sz1j1KRYfti5yRe0wxUeMfOfd7tLIK63+EkyeKqwyjeeWzMWyo6cbYUGFHb+mjIj1tgs6ZTbQkcRPBw1koNqA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440566; c=relaxed/simple;
	bh=homsJuCQjKnZ0xNxouQDRH+hnm4JjTgYjqEZCArzYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afSLxtv+Yi3Vx/9jNJkgozP1xiogYLeXtnF0l6mmhPcneQcwfU8SPtkwMEgqxES68xNQsHxwauRg7zrEaKTJP/kSYLrMDsbfYrvdUP5K+vvvdfKN90fylnY3jcRsMT4nc5OVSzLV+o9a5b/CgPwHaPiWk8Fhjc5UA3NRvX4vsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDk6RWCO; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDk6RWCO"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887635e952so747159f8f.1
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440561; x=1791045361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=iDk6RWCOBJSBW04OJUhZECHaKyxqjcKQSSR4qMu3CLMP2c21hdHwXjduwSW1uvg6GP
         g+45Zch6/ufh7FTJp+rpyWG7PvLnvKXp3aMAH7b+ocseRt9kUA7a/T12PfeMujaG5pDv
         uRJuapewlnnhZ/KyViJ0yg3EXQdlsgVTIX0wTYKqeq1O7vZPUxOMbDiRQguvtn68DJc7
         pHtOSH1qTr1Pbea57l2PCDf+8n9wjoms7z33nBO8Mz+xUT6FrHmHD9xzXonEN0X70830
         8ua9oO0bgTl1oIFKyYU06qEbaPrxqbxxI+7V1HFZwyHWT5hDF0CI4m0WaADgl9uJyQin
         h8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440561; x=1791045361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=t8rks7pxge8r9mPUvmBUKSqmFzFX5wSXEtMWmosQvgOPl49yK96spK72U46vwiOH0h
         18d10iH2kvZa6pWE3IJVclkEtHuwkv8gtHW6FnfVf1bTCmxx9cZjSqP5P9fHx/UnQFz8
         aPgrUYQpkEs8i/RnAMwjVrDPgPKX8RJw/UjsxbF8tZF5ajTbq3AC2TfuUWtCCArPFGwt
         CCCh+gfOmwCTg/JDJsNdg8jYFG3FaFtewCq8JFOuvROddOiK777nadtKRfgfitKZqYJV
         7tIN9SB5ZAqjmVhIFYjVpid0pZPl5sbZKhS8gdyrkW+rr9ZKzxb+qcHPsqkvKCm5U3Pz
         DyZA==
X-Forwarded-Encrypted: i=1; AKwUvBz5AlCE5xsdTuUhSnlBV+gS5ZObeO1cO27YKxXNwYjth3aMmy/qgQpO3lJGiWZ1U90Zu+QC/xOoPcKcAJM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2+QPR4UVsSabvQ4F/vwgwgwOp3CqDnZMlnJT40b5p1JPzkeqS
	L0lXNR5d6Gv4w4xOkibeHAMhpexkV64PSCF4kl+jSyIpQwqxjRDH761e
X-Gm-Gg: AYBFou3NNZ4uVRSYKkNtHMhC1GjtfO5Rqs/itu+v0tWHi6f5isovfW64W/rttsPTTKF
	Utip2uCs+t7/HMqePl6V0hwTnbm2x/0OQg6jljOFuqDqSEsmcMp00hSCXckFsvEGplNBAbu8Fds
	8UsJWZKJOSmIr32+3pGSsrXLzK34luKaplpTlhzAsb7jV8/LlctIa54z2mdZVenomkFIvOdPXLp
	+X+H0GpxxLUSIJPDqwR66paK6v7kvuoz8JTFah6ytfd60hepq100kvMGrnMhBbAT9mzbXj4lFWi
	H9Kjj6foQSQWMkkKcB7PPnHL6WZ1ewvzFgLtA1oobqe/9bFOGFbOu0bBm/d+IG8hlzVoMqjZxCZ
	E/3tKnU6S5+fov6xB26JffivzVaX7/bcxAu6KXg3mMK+cTcyZf/C7J634ZkH17KFJhrAEyJeLMZ
	V6IE7mKOX6/K4hCIIKONQTs+mDOFpunS0to3Wthyy42+WzfvUDFCGTTHHYnDt2ax+Ct0ByumFuW
	JkstqEx0eXqVtCGS+tbVnjpAxw5ZIDslaRAhQkjXuLacaMWnEWC49Fs6vVsyQLyvh0=
X-Received: by 2002:a05:6000:2383:b0:488:81d4:8bfc with SMTP id ffacd0b85a97d-48881d48c0bmr9652514f8f.11.1790440561402;
        Sat, 26 Sep 2026 09:36:01 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:36:01 -0700 (PDT)
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
Subject: [PATCH v2 4/5] rust: serdev: use DropGuard
Date: Sat, 26 Sep 2026 19:35:50 +0300
Message-ID: <20260926163551.52371-5-mohamed.osama189110@gmail.com>
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

