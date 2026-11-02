Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793580740;
	b=gHG22RfoX4W2n9dgWaH+pBqLEVZSgTTzdTKwbdKxawvDql2/aPOJw9UosuT7fDAYQX8e
	 RjwS97FqH/yU38E+y5X5FOZ1ewsl9DHJjJysxq+kgbZFRXk7tiJoM9Aowxk/Pij1ktABt
	 9wJwVcC/aTCX/N3WbUXL0I5lyjQqGZTOq0PngiV2WxCZmb+qO97G+Zeg7rpbzgAVr/fw4
	 +zLclq/ouOGt/vjrMo2m1nwJsdVlshN+/r3P4Z7FbQ1vOtAeQGcIOwaihdiUFh+CTjGLs
	 bW6HaBYYo6YoFL909mdlP2613vXFGthfrBHAEojM3AwEsRNgVZkFlTyrw/SrR8A5/RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793580740;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/tNBJjhxqZtBE2PNxTczNqzfiXqB3O+K85CqGOnS27s=;
	b=ESml6Ld5HUh2ce6G2ocqYXvJTZUzFjKlzOqS3EH/pqbAPCYT1dNFl/3uyucO4UN3YlvS
	 hF/9XaEo6pjtyG9xmVmb1dlMmQObFt2hO7Vskm5wc7oUEUXJ2lVbsezlzRG8qP5xUi/vH
	 FJIlerYzYN95ecF8k+znX8Z5809L2tNweq92BamDrRAMFnJ5TAQbql3jcOXz5mS45hgyF
	 6HVrEItakMuuYKTyHGf5DrsZXxf/3agUju5C2qheX714Hr6o99W7zJd6xcCQkGPobGFEH
	 gFKbKuoyJ2z+B556jG7xbOaCi7kpxfDyHRy3SgBfFip6IfkD5zS0xbYzMkDQSkWSnZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=qWWnx325;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Cnv3jiLQ;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50246606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 00:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50246606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=qWWnx325;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Cnv3jiLQ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9734314001BB
	for <linux-serial@vger.kernel.org>; Sun,  1 Nov 2026 19:52:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 01 Nov 2026 19:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1793580738; x=1793667138; bh=/tNBJjhxqZtBE2PNxTczN
	qzfiXqB3O+K85CqGOnS27s=; b=qWWnx325/vYih5r8tLD5b6EO5oHhKMoGtDoxV
	tAqXALDWag9MGlZUCbEzhnOUA9U4/jS3tjY9dsyOq+8MREpDLzOo7eN0SVbQdK6d
	kQh98xrjJWea8ZBf212YS0Cz9XKvmKhqfNxUvL9PADX5pg3SfdABvETW61t2XGHk
	33IAJ4YEcR8eDnDEHJ+KS8LYr9DRveYiFUDJtkqPvENqDBtZhy8VZjrZsMG1FWPQ
	rPmgbB80ILH+lsQ/Nih11fJsBrqNJqYNm7/Zy4dcFneIEejCFLiXr51rjwTjo8Cv
	Kyr38l/uyKeIWNv/geuO1Ph3ZEqKYwGTkebgK+OuGLRNzb6Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793580738; x=1793667138; bh=/tNBJjhxqZtBE2PNxTczNqzfiXqB3O+K85C
	qGOnS27s=; b=Cnv3jiLQQ/qmv6RKp+hTBfpkqfS5Ge5+BBu+cjrAl6h0pEm9I8T
	h1b5HcEnjIybVyTKAWNMl9TQuN02Z+x1BJyp2hQT+iz4kBZfhk35ncWAW3Sar4fX
	usJTnUt3HyPKw8TRBWuP6X10wbhuSSn2I9NGs2+wMS9zgl7y7qiOpTZmQkSiRyEO
	dmLmbKN37BVU1qvkMilK6X0QxBaQkwOiaT97WOOwHV5wAZ6yA4Nrh7xw+vqcjqEh
	GfHyR0zEn+KxziCQthvNlADHEs/Mg7LPsvZDSy1NC5m0ZMG990egEV/j/T2HzoOu
	hKKidWfmzMZGHAw/NYCmRWKPAAX5OSxku9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793580738; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:g7px57uFkQGbAY/sriZtcOOLOZkA69cJ9a1um8e7hPiAu2a
	GPdNLIXhc8LalhqNnnpda4qugrwC5I67rZ+frETOskyPf/5P4Eunj+W7Ul73CBCL
	UPSZBBYBYtTFVX1NP20IqaEVksRaIVdeC4R8y9baA3qaP21yMeTxIyUA8VMGgn2G
	kI9aui2dXHNPoN+VxSeXi8qPlGioNNIg03xHLw8gBeoIIBu7VDfQlRiIlcvjwr7Z
	NFfFeApnYgt5MZ2UW+KjHLyAPWY3Rr4HIW1EJPulEiETV0idZoNTrWuxwmHT8loh
	80CBsDF4C0JDxYoXPZX6BpCsS8W3t5h8WTWUdHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:JJrmzy7bujF50mtKMQemATtCWI2Kee6IZ9qIPXB23/Q=:yy15yJnylfMxYd4DjApGHB2o8DS8feXDXnSepQAu6zg=;
X-ME-Sender: <xms:wd7narlEoRXlXfbJSLpG2qmJMD86kSLVYE0FQleBpKMNU7A4wIB0fQ>
    <xme:wd7naoPEWrP4QBPe93DGB9jX5CDr1bzUwh666iuQvAWdmyg12yGh6yCBxhB7ZgMtN
    7e4UWG-2Z9cCR1iOmGObPmPRKoPi7U9BmTJjaQ9BlgVBGNT2CF177lyLw>
X-ME-Received: <xmr:wd7naqKb9nzNp5W1QSjTAA10_CZcji9pRdQvbcQvSL7Z0AakcLgr2ytAuyxVkltzO21j0WVKSc0UboYAvg8>
X-ME-Proxy-Cause: dmFkZTFDwNUF972Wxm72PrAPg3CB/Z2c+S/BN5f0rWH71EHmO8BIImRYAxTOy5uY3o0sG4
    H9MquJpdvrcPAeBHfgDYQ5E7oS9eajdlD0Ej52V2kvkRZb7bCnZrFxkTOsY01FmxWKh83W
    OeDQVH/YG8JrM1alHmpWCZoqNNv6rQQtjw/Ypnw8cnWva1g0fM2tuFp7wKEGiKd9bzHiRr
    qHOWSsnjIr9a/WHkiD/i7AL6BhpOtgxqPwerOFuA4/QPzAA8yVEtz3g/ujnvTqBTuU+4XR
    +09u1hdDQF091bsqpQ56QgMc+QP5jboQUVKvwbmrhbELw7Z1QUFieU9660ZID4xiM6mhin
    7Mw/32SkQDL1Q/foOSzL6hcWlk1SFf6MKYMnCDI75MYURGb+Y2uDf2TY1JM8+906huPyMX
    6Syb0RKU0GAj48K8+0yXpt39AFzem1g0PT9YAOiDHIg68dnS8UgIRCKy8is83kj/Av7GHK
    UHhk5a2M9oT4xdu1JnwdCv+6jJ8AuLB88ZvglTMC95OdLiITKxogyzjQQRU9FM9rC1SI2Q
    BMJXOBW3oSTFfLasmVk+mkWR06n9Fsljey6JzcA4rmjgjubeuaBnCb/a1JXSRC8izAueib
    DHVKe/dhW9YCudyCXcfJJ3AD3bcf1y/lPnX8RjI3T/Mw/IoPAPKbbVs/jAyg
X-ME-Proxy: <xmx:wd7najFOZPaf_9SaYChWqo_RqenXPc3h_8AcOby9U2G51-88qrcdJA>
    <xmx:wd7narBWznjjSnnaKRCxEmtLyh2p4FJtaOO9Ewmw0ALyCHHQiiJbRQ>
    <xmx:wd7nat3SfgkCzxQ3mDOc7Lvr668IEWxH5C1mA8FqdREoaZxk3jgc_g>
    <xmx:wd7naoP4I8DjDj_xzyNjq3KbD_lo2ZFWqNTQrSaGT3JDTkNhvB4PtQ>
    <xmx:wt7narA-YLRwgoJPvv500oy2IbeaxeY9aUrRkYPblcDsuZnL2wyzJZN2>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 19:52:13 -0500 (EST)
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
Subject: [PATCH v2] rust: serdev: use Delta<Jiffy> for timeouts
Date: Mon,  2 Nov 2026 09:51:25 +0900
Message-ID: <20261102005125.626125-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

write_all() and wait_until_sent() take the timeout as a raw Jiffies,
which is a c_ulong alias. The type does not show the unit.

Take the timeout as Delta<Jiffy> instead.

The C side treats a timeout of 0 as "wait indefinitely". The Rust API
does not keep that meaning. A timeout of 0 or negative is rounded up
to one jiffy. A caller that wants to wait indefinitely passes
Delta::from_jiffies(isize::MAX). That value is MAX_SCHEDULE_TIMEOUT.
The C side replaces 0 with MAX_SCHEDULE_TIMEOUT before it waits, so
this gives the same wait as a timeout of 0 did before.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
v2:
- Round a timeout of 0 or negative up to one jiffy instead of passing 0,
  which the C side treats as "wait indefinitely" (Gary)
- Document Delta::from_jiffies(isize::MAX) for an indefinite wait
v1: https://lore.kernel.org/rust-for-linux/20260930041339.1551129-1-tomo@flapping.org/
---
 rust/kernel/serdev.rs | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..656598602d7a 100644
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
@@ -433,6 +436,16 @@ fn as_raw(&self) -> *mut bindings::serdev_device {
     }
 }
 
+/// Convert a timeout to the `long` the C side takes.
+///
+/// The C side treats a timeout of 0 as "wait indefinitely", so a timeout of 0 or negative is
+/// rounded up to one jiffy. `isize::MAX` is `MAX_SCHEDULE_TIMEOUT`, so it is passed through
+/// unchanged and the C side waits indefinitely.
+#[inline]
+fn timeout_jiffies(timeout: Delta<Jiffy>) -> isize {
+    isize::max(timeout.as_jiffies(), 1)
+}
+
 impl Device<device::Bound> {
     /// Set the baudrate in bits per second.
     ///
@@ -475,28 +488,26 @@ pub fn set_parity(&self, parity: Parity) -> Result {
     /// [`Device::wait_until_sent`] to make sure the controller write buffer has actually been
     /// emptied.
     ///
-    /// Use a timeout of 0 to wait indefinitely.
+    /// A `timeout` of 0 or negative is rounded up to one jiffy. Pass
+    /// `Delta::from_jiffies(isize::MAX)` to wait indefinitely.
     ///
     /// Returns the number of bytes written (less than `data.len()` if interrupted).
     /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
     /// before any bytes were written. [`kernel::error::code::EINVAL`] if `data.len() > i32::MAX`.
     #[inline]
-    pub fn write_all(&self, data: &[u8], timeout: Jiffies) -> Result<usize> {
+    pub fn write_all(&self, data: &[u8], timeout: Delta<Jiffy>) -> Result<usize> {
         if data.len() > i32::MAX as usize {
             return Err(EINVAL);
         }
 
+        let timeout = timeout_jiffies(timeout);
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
@@ -545,16 +556,14 @@ pub fn write_flush(&self) {
     /// After this function, the write buffer of the controller should be empty or the timeout
     /// elapsed.
     ///
-    /// Use a timeout of 0 to wait indefinitely.
+    /// A `timeout` of 0 or negative is rounded up to one jiffy. Pass
+    /// `Delta::from_jiffies(isize::MAX)` to wait indefinitely.
     #[inline]
-    pub fn wait_until_sent(&self, timeout: Jiffies) {
+    pub fn wait_until_sent(&self, timeout: Delta<Jiffy>) {
+        let timeout = timeout_jiffies(timeout);
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
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

