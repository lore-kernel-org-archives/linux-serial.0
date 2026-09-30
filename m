Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191D33D6FD;
	Wed, 30 Sep 2026 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741638; cv=none; b=PxuBTKHcHHJaOdrF4yNp1rqt/ksMaz9ZZOaMGHto/VJHxkj1T7ZPZvV5qY2vAm3+mdBX5CkwK3X3ccvrYWA+r5PNv61wwz2SVtpsXrDhc3yvPd81GTDBOn6D23ij6RXvmMUxEZkvz4JjnkFY4GQ1UC0u1e1GsKpUcu3QOK43u/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741638; c=relaxed/simple;
	bh=ezTzgfhnFILc7w4d2qRXTxst+WJHEKR5XnGxGPC6+28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I//azd3FC2CuSTDQL3ysR9ZATG3mzjVUYY2dpck5JChV4L1wdYb5g+4tbO9FhmaWJcyA6yPnPxiF4GccsRaGM5kOBV4+BCR8GuGzpBzF2U1jwkjFi1uol2/RlmZX4K4vMJDLYHG05khPsoRg2XyyTlM7q56JP4UXMKBNvNXNn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=emGqt13R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XB2nyDSw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="emGqt13R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XB2nyDSw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C1537A072D;
	Wed, 30 Sep 2026 00:13:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 00:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1790741635; x=1790828035; bh=3cIH4jjHstv4/8azYvhn2
	+xscnKHGQ3jR0PevXwSrq0=; b=emGqt13RNzwjqb9KPbtx7UsydDz+oR8uwhDrh
	ddbZ1B5Yo8hGX4l+jLAC03ldAMl3NK26cxFkxG8h8L6LRiPU76cclmRUO7nvXEwW
	R/S7qm1EzYzxJbHxOFk5/jPnOaYL0x1Hj7EQ4hLuhNnFN6PJQXliiNQLtPFx7vdj
	x3MHLF+5yzFmnnv4aNOwxBwxZlTvTn5YT94QvBvLk9lymTy2zGv5Gc6LsjKWgLhD
	GdFgO+mYtqgimCruYIz/RItezVTz2DDdHLTycXGMsFDwS9pj5abkcPnBeofrD7Xu
	NNyglre6fL1f6s3g62BoDQPXstHNTQejXwFlm1ewFupDpQtDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790741635; x=1790828035; bh=3cIH4jjHstv4/8azYvhn2+xscnKHGQ3jR0P
	evXwSrq0=; b=XB2nyDSwlq7dkpdMNd4oVuqLYhNL0C0CL66MzFvGhunBsIq4SNk
	f8/jqOicWbrgZk8ZB1k4MBpHk7Sr0fNJFUl/bcXlLbxkBNujk2ObH+4ncEcKExGk
	rsNJY6DudyIoJt9hjzf2EysXQ8Gwv3ivQGbBJ9HurBOC4Bd3OZ4VwvSUOvood6bJ
	hdfK2vTzQGECE4XIbOZ0WsPJuC8TVYpImuNetyC2dHq9K/5LAXPtRPnRga0j9QjU
	6LDbfxNNshCP5/pHPu6LkbrXEjRa+PdMmTMabofhtXeHtZmCj/aBkkP5+cKJ5pT4
	6HZYg2t05eggL13V811Hh5UrEK92Bl73iMw==
X-ME-Sender: <xms:goy8anWH5JJ4hCjnlUZ9l6uZTQyRkljta0-001gYabcl0oaiaYi0uA>
    <xme:goy8ao8WQwSNTim7qhx3EWc8k2BmGtdE84bRpr7Akxke7MQkmdlVmv_GuySTAEYO9
    WICZAFuN98vrZD_-G3F-w_5UuqIBsGj2aBH-KzN6RWIt-t02l07FvzF>
X-ME-Received: <xmr:goy8ar5SqLRrHC4akM7CgIwphisu4NGs4OudA6kJax86Coyn038Q3aGGmVm0PG4dELRwZ-pau9GlqtWfJvs>
X-ME-Proxy-Cause: dmFkZTGkWpff4LOKbAfkA39sXqhaHCbKLWbwce++Zbl+TVA5uWwxZp5Ex0L7hNhx0eiBQX
    XRXG3TJZec9s8yFx/e9aIz4fWlMi6YfNjspKSxsjhVApnpJIRew9ZugiIMGK+bd15ZqqK7
    dASKoGFe/LlUomPGIbmeacHgPzhfw3I5a3vfj0PxfxDfB+NJZqEzlFSxn21MEv8BfJFn35
    3dtzzEoO3qK9dFyMFqW7iJDLLkpTw81p1ahW3DIcQPqq7QGO6kMCJjgpnjiKlRrdILmVhX
    QLStzNigPE7xdHsW2lI7vNSykhyt18NH71bqL5yITuRoc1UWlodGiOKsxba9FluiIdQ8fO
    vcBHABGvuT9VN3XK2clCaTSKk9qzTEwvAUw5jdPpkM83ud7tReCCkHw7KxK+xMBlB9WHKt
    SOGdSVnT/InQSeKMH4PgR/Vl4TLpa5uO+qU1cIBy2+B9fMHFoaautd3exjaWhDssHesTs1
    ktnS3atEMeSgbfj//p+bnQp+FFpJQV0YJOaEw9o3/a30Z8+3RiWXjIgQLE9cQLDRfuZAdY
    +lcfyPSEerzIo2ETpr8gn6S0ILsWVRC5h+7B8vZXkoDjRTOvoCUcCee1+dk+Z1YHkY1mfO
    HYtcxyE+MAymoqWvqGOrA+82iRo3VTrEDkDbfgkqT9gdp44oPFGuFUDywzBA
X-ME-Proxy: <xmx:goy8ah1tYm1coBnE_ye4tTeoa4MXH447yWj6BOBz1FTfrNhjMF0Aog>
    <xmx:goy8aiyJWZwSEoNUNBneyu_KJksVopRrdJzO2VluMhhDbocpETtVZg>
    <xmx:goy8aqm5bk1aqjXXGF3Sb0qmBUhP-v6XmV15F1XYqE5j1oK6Nn8LdA>
    <xmx:goy8al-FtOKDGyHa1sJt8kHL8WM-OrjLP-7M3_uC6DIHAX4MB1pTDg>
    <xmx:g4y8ajyK6Y_UTXUpaf_f7zVZb4_3noO4U_NXB7o_PwKifO38Bz41kWt6>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 00:13:51 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: dakr@kernel.org,
	markus.probst@posteo.de,
	ojeda@kernel.org
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	lossin@kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
Date: Wed, 30 Sep 2026 13:13:39 +0900
Message-ID: <20260930041339.1551129-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

write_all() and wait_until_sent() take the timeout as a raw Jiffies,
which is a c_ulong alias. The type does not show the unit.

Take the timeout as Delta<Jiffy> instead. Clamp a negative timeout to
0, as the current code does for a value larger than isize::MAX.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/serdev.rs | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..094503f059ff 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -20,7 +20,10 @@
         aref::AlwaysRefCounted,
         Mutex, //
     },
-    time::Jiffies,
+    time::{
+        Delta,
+        Jiffy, //
+    },
     types::{
         Opaque,
         ScopeGuard, //
@@ -481,22 +484,19 @@ pub fn set_parity(&self, parity: Parity) -> Result {
     /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
     /// before any bytes were written. [`kernel::error::code::EINVAL`] if `data.len() > i32::MAX`.
     #[inline]
-    pub fn write_all(&self, data: &[u8], timeout: Jiffies) -> Result<usize> {
+    pub fn write_all(&self, data: &[u8], timeout: Delta<Jiffy>) -> Result<usize> {
         if data.len() > i32::MAX as usize {
             return Err(EINVAL);
         }
 
+        let timeout = isize::max(timeout.as_jiffies(), 0);
+
         // SAFETY:
         // - `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
         // - `data.as_ptr()` is guaranteed to be a valid array pointer with the size of
         //   `data.len()`.
         let ret = unsafe {
-            bindings::serdev_device_write(
-                self.as_raw(),
-                data.as_ptr(),
-                data.len(),
-                isize::try_from(timeout).unwrap_or_default(),
-            )
+            bindings::serdev_device_write(self.as_raw(), data.as_ptr(), data.len(), timeout)
         };
         // CAST: negative return values are guaranteed to be between `-MAX_ERRNO` and `-1`,
         // which always fit into a `i32`.
@@ -547,14 +547,11 @@ pub fn write_flush(&self) {
     ///
     /// Use a timeout of 0 to wait indefinitely.
     #[inline]
-    pub fn wait_until_sent(&self, timeout: Jiffies) {
+    pub fn wait_until_sent(&self, timeout: Delta<Jiffy>) {
+        let timeout = isize::max(timeout.as_jiffies(), 0);
+
         // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
-        unsafe {
-            bindings::serdev_device_wait_until_sent(
-                self.as_raw(),
-                isize::try_from(timeout).unwrap_or_default(),
-            )
-        };
+        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), timeout) };
     }
 }
 

base-commit: f1850e443b0e4f2429ddf42a8d5033ea54ae8a90
-- 
2.43.0

