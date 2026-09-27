Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A639F165
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505947; cv=none; b=FNV3fixvIB3gVh/+HJsHvAcWqDdLFe/4fw/llXlbc9DITNIK9o0rxYJTyEhzuehJAkJpyiZ1MTaD1hqOWXvpkvX+/RbIKgwBO/ZdeBtAoJqpFZemcqNzayI3/ub2Ihy+7w44vwlj0Ms0LrnUzSwksHMsI96BX2ZwEtZZfrOwvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505947; c=relaxed/simple;
	bh=homsJuCQjKnZ0xNxouQDRH+hnm4JjTgYjqEZCArzYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFyL9Y55i+1NYTBbkVYbA1v9xjoKjSrvA0C3Qlm3eHTdbzWUStyTMTSvwTIDOKj5AooqOSJhFAi6q5fGsncCgUOIcNrtQ3F8+uas2YIWxT5Rj4BxeBwSel/nQBNd/quzGKdHsia+WlQOQSWE9hCNsi6ukMROa1TsUKIXGqUB0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQEdWXFm; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQEdWXFm"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so1164334f8f.0
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790505936; x=1791110736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=EQEdWXFmy9ti9tUZ6xGQ5Xrd78VOiGMy/Ymq4O0XQB89MelfjgsM4Y1dW3yIJhy40X
         6HyKTERfAiF+/6wO4rs8cvgKpKDu8qcAq5d8PGZNoQDK9cM5N3hUDKxqE7HRCKAmhDjW
         QoVshXC/2OQLun4RiEsUmCUL6X39zojyjPSAYH2ACHHg1PBajhWgok4NarzuMmkzUICO
         +ktaX8BeXYvkiOnBDs4lUtqb0GHze+Hz7h13I3uvHiXFStBoEfYKmAapWKOcfUREX+Hl
         aGv6omBzA1D1uINsJ3YqSzAeFqECCOdyo/m/a1+75BVtzByqPpYj0lpqXOaZIfYpSUbJ
         +bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790505936; x=1791110736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=PuT9FmeLiaUopwXaU3FNutTQzqsn0FBYkmZ3obYAG46J4IBA+H1P8f5+ObNDJTNEOJ
         p+0sG/h3H+JPTpjyofwTMfYCJb02VEBwfVCZSbtHvWsb6wQSzUSOaV7J+rqsfUI1jsuS
         6Z0sudTEW5Hh1hV3nSkACNBBeqAanSOtv/UAvpa39tvi2gAbsYxyGxZ/0K+JD1n3CBkO
         KhwIvdWzy0ebjO+Fc5xIW9twlvdzB545i6QZLjCY9P5Bwiqroa+1z3Cyu+6DIij2MfAc
         1t4Pe18aHP3DfDZNg5nkLGEOYEycEEM4U2IXyTMaA90KuCxYHG54BHATqoGTmrMI70at
         4x5A==
X-Forwarded-Encrypted: i=1; AKwUvBx43YS9OJt8tC/2vIREN0vLcS4HJY60vFwZbmhMuyyhsNY3Tt8rEZ//XLiSGhKavv+n8dL3X+rIlOh8mNY=@vger.kernel.org
X-Gm-Message-State: AFuF++kEqZpe0/mWkXV3Gw/41Fxl6P8Sz89DYuD04MnJbxZvOybKEQn0
	hcQH2r+48UrQIR7VJdaOew0NVFIXufTRINHI1+RdxLAX0Xg1XPxYBY7S
X-Gm-Gg: AYBFou0838orPocXUMJsZsgoQ3WtHZ6uFdffa48I0+iPNDc0nQtCFioLwgj1NBJ8hhI
	g+zyYYtfNfIV6VeEUU9ac3xOaUvn4W6mMidOnxmsmY+xp4oyeCA6cFX14y4ZeW7KHmYCeV2tVHz
	roDXXg3TNxtHiYj6KFuv8+ZB5i1pVa9x3FfAw131vUekOxhWC6uli4JGlgAFPzLlXKPlm0L1r9D
	wOEreSwTHYm1AhxfSh0Km8PIOQsRg5xskTeQIPg6shumLMs4hGP3Op4YcVz82KU4tqgDSpsZ12J
	VuZNT7OlMqMH7+AeXXuCNWvx8xW/I70ffAFfO64eSJvwDe6d0zqu1Ra+anQ2efNuvzHzsGnw0J4
	xHjcFRZZDRJU/jTzBSimw6FK8JXqFWLsK0GEzV0GCucgKpX+JER1YlrC6lh+7ZtUBhgb9e+NJQr
	+/XDm9U78HwGj0EWQQAM6KV5RicxGA9+5EfNvOEDLNWjEVj9YZp4Gg5FADEICVtHVkJWJhK05op
	y25XtXQdaY+ACiuAVDvRcTmWqS3O00bHdDutRi2cAXvDunkVaSlfn9W3PowxtYnixI=
X-Received: by 2002:a05:600c:3b98:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fe66f187cmr202438815e9.21.1790505936299;
        Sun, 27 Sep 2026 03:45:36 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001915fc2sm46005195e9.14.2026.09.27.03.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:45:35 -0700 (PDT)
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
Subject: [PATCH 3/4] rust: serdev: use DropGuard
Date: Sun, 27 Sep 2026 13:45:27 +0300
Message-ID: <20260927104528.103881-4-mohamed.osama189110@gmail.com>
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

