Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69A381E8C
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444011; cv=none; b=YrnVim3amUJQb9CfHtRUMDt6B9NYCT1PdBmIONTGxSvMbcqAQv2VkXkKq2+sqtjMxoqOfdR5e/ggu/kY7SXfkCz892qX1THU2WurPaDNemNGldYuEQlgnWxcS1GkLGGB+RIl21+gI68Eo4+qAX3O7PJkOwq20lMUptu/ttyn2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444011; c=relaxed/simple;
	bh=kF13SbON5k5Arvp0ikMg5xGDnjZmmTCAm+geeOVzYi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKqpmVobSt7isol01GlcYLQTpBvXovD4gG7PoM2Z5ijtCggEqo9xH2/dqamJOdsBzTU37iSQZdYeHrrIyh9mH7qPYDOycuLgWAF6do09d/GCEoFJcFKLtwQPzxopS5JgWPLSfSkWMqzI89sc+ek65oGK+hmb0eGHeD3yLXqTWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io5hzDwL; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io5hzDwL"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so3951445e9.0
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444003; x=1791048803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JwW6U3iTEHgPApFOC8Hbz3JJt/r5iD7r/z62SOkAVw=;
        b=Io5hzDwLZnNhse/D3h+ME/+td4XWA65rfniDJD+4WPNsQKhynYvNhga9dvh7JRtLOI
         nQuKuKKHSh9LRl1kHl00BtugSq7BpGM3FoYo3r0uXGMkoeQT+tAo73H7JX7M1uQuwtHQ
         r+3DJHkaliXquVdamFUIMd4ulRMboXGgIfXsOQy99M2ZugNPFaF3AIPAwx8Uv0NePYiW
         WanRUq15FDo0ETwrweB54kpDY/RRidmgXYiA6s4fEdix/lDAUyZ5ysqzUsfHmbeB+Sz8
         ryVwcVgKayghLGnf1H6ir36FoSZoQF1+CQvLpt5vSkpx9GKrPw3YmjGKrFVDDDbg88xd
         O64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444003; x=1791048803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JwW6U3iTEHgPApFOC8Hbz3JJt/r5iD7r/z62SOkAVw=;
        b=TRVksWWNKh/NlBHbSwmUcUG4meEZAl9fbKR0q001s3gGTzErkB1LZg/avjVoqjqZry
         LYXjkdTNETJ3/0ZsoxtvrFED5hxjDaklUyF1fvlOFXp3JAnyqxvx888BBB2VbObQLiwZ
         Z99HPZym6vmxACxapzbz1E0v57gz7WrgYllOS1OTKiFC17B1ldO1zCe1+ZuPEIruwnSJ
         x7YetpE7VykKhHvI0XRma8Mh/NZwZ+BvbsDriq2QLRQV3p5VN94PCFe3Gtr4f3ADad4X
         HKnLvb/BnftVHw1h2+p1TNRjzVlrtdUZM4oQ0j3WbstEqdpxbq1wt4Lmn8Vl5EezdGeE
         VtjA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ/orB3hGLhkJMAQTXI23a/HvS4OfI6defgFwBM5nCn/YQPrJYL8Ez7bV1+3vG+CJIbTQM2BKgYKwHtNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nvBLpfc79sG5HtB9P6rLqNOvGLHV+R0bGV5KhDvZ70VbEkaleN
	z7Wv5cxS3oxul1/Rub+yhkcag4gQJ7WzojZat/YPl8cM6vy1lx2/BfDA
X-Gm-Gg: AYBFou2eY+GkCGE+nUBfQdw75TVXF///bCyV3bWDQc/NcMSc9TUAXE7NRgwJQStA/eW
	Nt2Qam6l4k4RZ7wApR3zQ4uIu6hAM3tAWreWm2Jc27VJZTyos1mHWMkA4OgUJ1sdLvd2G8egJol
	Frn0r/I08oDlb0dBOVVg/7upi9oUizTdJlsji/9WgpkLy9ZAOklDGIol1PsgGc27KTaQAZYvq7y
	d+KE/qIOOcr13SUnc2aG9M2q+ozNRawuUf3jbxNDVdiwS09hazi+P4nAcyrHUUF3BeX+yMutnoy
	DNhvRJZFCbu6HxNenWnxYtL0wxurR+scWJWC8Cp39XN6axehY/BmTCmP0TyC7uGGA/5NUE0pOVF
	fmfKDb5FZkeDXE4i9XujVy5B5LgSjYnAU+WVnxgsim8G7R5lQBvywTamjllsyJgMv4fw4CEifIp
	/PZ1TLPJX+rI//Jo03AsIzHPGwPCCvET6nEdWWxs2qHLZU6QLyg7GaYAdP6CCXBVpCqvu4tF3Fn
	/e8FfYLtkZBewBktGZeEOBGs3Cr5EaSjXlUwnq1xOwm14iI94pb53+C1JWhq8cEGuA=
X-Received: by 2002:a05:600d:8482:20b0:49f:c451:b4ab with SMTP id 5b1f17b1804b1-49fe67bc264mr118603405e9.29.1790444003312;
        Sat, 26 Sep 2026 10:33:23 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:23 -0700 (PDT)
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
Subject: [PATCH v3 3/5] rust: block: gen_disk: use DropGuard
Date: Sat, 26 Sep 2026 20:33:13 +0300
Message-ID: <20260926173315.56772-4-mohamed.osama189110@gmail.com>
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

