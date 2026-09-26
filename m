Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1334D4CE
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440567; cv=none; b=lComqdhxCvzDNwon5s6ie7B9hAQO8KgAIbxPrc5dV0qlGmELNL8Jhs8dR2DlU2DwPYhHCfECAxAnFUVNsgjCTcmLrPIcjQkZzgzkWChRa6XpshjlEou78DkaNSuulSdYesxeF4YDXQ6eoieG2HQqjKWkSsN62rr45+icL4p+OhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440567; c=relaxed/simple;
	bh=kF13SbON5k5Arvp0ikMg5xGDnjZmmTCAm+geeOVzYi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQkvj+Um7/yQoHljDXnjr3Uz02CyD0KmVti6DfQW74b7eyJcVFN0r+NC03mJBBWcN3sBxsiPOfTuVgKjAXwycM11A4u/iMsMUGzIE7DRgxHJQOnm4407yyECZJiGtwQk5HgHaQ7Kh8+YENdMd8Z4+djedprkX2GW9hPSXu8VuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sxKLAyYx; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxKLAyYx"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso1382102f8f.0
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440560; x=1791045360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JwW6U3iTEHgPApFOC8Hbz3JJt/r5iD7r/z62SOkAVw=;
        b=sxKLAyYxgqLF4SScP7aPvwZpR17nsPHFBYwqcyxJ6OsKV/6XxSkoW6GAD43S4j9pxT
         +BK7Ja+ChIfRiAKKxMpM6u6yiAb+YUwTPlvM9I2LTl/lXZGnlVhTx775WlWBTc5aZ6Ck
         HOO19A6Zrz9BpGWgYCq85qFuZNgYbtnVGvH6TYC4WMQGmSyyUwXVyVlCuHr5NATwrSfC
         WXUlhivM3ocZPNiVbAvsTYPntSB6xiQuaeQ35W9d1e4yEdJuBewiub75vfMp1RVd78+u
         FfKYp7uZfUR8fWA7uYJwYFfpAkvCkDG/o5daZX0QNlz2ewU5qE1tGPUF1+KULOoWt1cL
         QvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440560; x=1791045360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JwW6U3iTEHgPApFOC8Hbz3JJt/r5iD7r/z62SOkAVw=;
        b=dTl/161bVYK4y6PdrvlTTjT4YgZEiUDrg+ZkutY+xcLv9UAXH5feKuZ2sUnTui4PH+
         NedfJKXXySB+kVWFSoKRKsiG8OoSv+kxaof1lU+MBDAuKtCpErYn4Zv+o2358BX2sjyg
         W0C7I//fl+auZL73IubpXztlf3xpuLdMA730vrY/F0UbtMVXGnRYdUp+eHGA3agzyz5G
         HFEaREdnZuF+A73YLhmsnC9eOpI98dsN/Yd7UP6IaXjOTw5uhE/fCiU4S4fqaot+ae7t
         NiOS1c+5dgKZJf4GLTbVUohley3+crhc8AwOczS+UdAb/4QlHcJwrPL9ACKgiQjkzlwW
         7fNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlDXK/wkXQjjoIZDkh+xV+2lC2rVZpyttVdAzMvya5C5BBpR+XOIDZt5zof8MCrE9rc/Ugudcb4qcnqfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBeBB/1qLmCoTec+F17khI3vI2yKX3yZLEXe2cDg4IoJaxyuC3
	sb91zUtdG2omuxytsEunol+JVxji6LOsKLPehBQ+x0retctGP3E/gEhC
X-Gm-Gg: AYBFou09hGgWgfYpfQB+CemgHcmTmufDhUlfCouawt0AELiNW3PrCqzihhSE3Yq2mVl
	BmQ3j49j6FcTrq26GDgwdibB26piaVBSh0KGREkYRvH7saIsk0N2WFa0xXgNZt4X37KH5rMTm79
	StSTuw4h7ttagMI3DrIPUctJSzKXKGOmxcq1U9PDvCXHuiF6XrF3vnVASobXkkgUSWYI/0sw2g5
	cfViDSDkgtxpWivFsQldcXBDKa8aHPB/gwXsYME/HZksuo5E7jcjuYZEkV19gyMW73b4jF+i2ve
	gD60e4D7njxLm/ZMGDHpvdAxi5afxRx9aB22Ywip8QUfe3sOF4m5h9qI3QH9a1nPsSwT+nHl88P
	hjDW//5yVqJFd6C3Dp5q4ARak4mEf13mgoqr6A0AMM+CpOhGNHTomAsxCeXKNqAe2zckSQpl7Uf
	ln+9+UI7zugTiEKnkWl/vSjg0cL9rxNOqZEhL87WweJIss6ZY/iXuHCt/194PMygDjSIQaAUiMV
	r6+ktYNl4vlWTtzWAQ6ncvZQPNv0hSKlKKjWMm556nC9XLVM8l0fDTfuu0KLBsVtxM=
X-Received: by 2002:a05:6000:386:b0:488:8c99:fbc8 with SMTP id ffacd0b85a97d-4888c99fcccmr179322f8f.50.1790440559714;
        Sat, 26 Sep 2026 09:35:59 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:35:59 -0700 (PDT)
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
Subject: [PATCH v2 3/5] rust: block: gen_disk: use DropGuard
Date: Sat, 26 Sep 2026 19:35:49 +0300
Message-ID: <20260926163551.52371-4-mohamed.osama189110@gmail.com>
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

Replace the ScopeGuard instances in the Rust block layer generic disk
implementation with DropGuard.

DropGuard provides the same scope-exit cleanup behavior while using the
new Rust kernel memory API.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/block/mq/gen_disk.rs | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..d9019fbbb361 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -10,11 +10,12 @@
     block::mq::{Operations, TagSet},
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
+    mem::DropGuard,
     prelude::*,
     static_lock_class,
     str::NullTerminatedFormatter,
     sync::Arc,
-    types::{ForeignOwnable, ScopeGuard},
+    types::ForeignOwnable,
 };
 
 /// A builder for [`GenDisk`].
@@ -102,7 +103,7 @@ pub fn build<T: Operations>(
         queue_data: T::QueueData,
     ) -> Result<GenDisk<T>> {
         let data = queue_data.into_foreign();
-        let recover_data = ScopeGuard::new(|| {
+        let recover_data = DropGuard::new((), |_| {
             // SAFETY: T::QueueData was created by the call to `into_foreign()` above
             drop(unsafe { T::QueueData::from_foreign(data) });
         });
@@ -150,7 +151,7 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
-        let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
+        let cleanup_failure = DropGuard::new((gendisk, data), |(gendisk, data)| {
             // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
             // has not been added to the VFS on this cleanup path.
             unsafe { bindings::put_disk(gendisk) };
@@ -161,7 +162,7 @@ pub fn build<T: Operations>(
 
         // The failure guard now owns both pieces of cleanup; the early guard
         // must not run on this path anymore.
-        recover_data.dismiss();
+        DropGuard::dismiss(recover_data);
 
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
@@ -185,7 +186,7 @@ pub fn build<T: Operations>(
             },
         )?;
 
-        cleanup_failure.dismiss();
+        DropGuard::dismiss(cleanup_failure);
 
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
-- 
2.43.0

