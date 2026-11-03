Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668361;
	b=gitl2rEvPoUxvizP9m1TEHvF2UaU+bUUGorR2QTG8v1NTMt+fuKFANifYqaYLakWDGeG
	 bpxcfh2oNE+WM48leXtDiQ4uIkpQIT5VjnZgCiOkCaXazpkdEsFG/59M18e2veLzKZZst
	 rDySblfBWir48NZasAJXx+7K33uSTHecSOjQujO/BRvRoHZXNQIWEIjm6KmnRlNrJ3mE0
	 aM2o3aa6fTJf7HurwYXP6mFIa6pA5HpOuowpnncLmDOXSeMBDYUORqcWAnWVn+ZttdO+o
	 X5zecyW8yc5TToQhZQKRNAwp1TdGsgDW6foyzMC7gmwnAo+qQO1JM+bjdgK0JPDtZOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668361;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qOlIMt/VAbUi9N2qK2exmjaT47x7u5m/ec3vtblEW9c=;
	b=hHcPZnQGHmOXIVZ7bnjl3Pa6h1fOOu4n52hG/h7Bo1OHqryCSA1kGCp54cYG2xtbj3Qe
	 GtUwkbKfYJBMAtfVj9OEaJuzpl8BeGhs4EhfG6fq78PqcPWHSAIacSu2uVvScmgkUkPCK
	 guNIjZ1Pbkvk9ZCldWvI9gnIqmUxgPZzlQZTrBrdw9urloxzx5PpdA+tOdkWG8SLCNIC9
	 DuPtCIew0Ssm60Lu4UfExyj/DsWsADb0CxV9BMTMqKupcsVVEi4dz7UoFu/4cDTwtV0Xx
	 pe9mrLhnYdx8uEf3qaEfWBgiVxGZefIZ/1aFiesRQNhhLTPKtTfaw/451Kj6TacoIzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=YqzRVsMm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RkwYjAvj;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B2606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 01:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF0B2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=YqzRVsMm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RkwYjAvj
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1DAD3EC091E
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:12:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Nov 2026 20:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1793668360; x=1793754760; bh=qOlIMt/VAbUi9N2qK2exm
	jaT47x7u5m/ec3vtblEW9c=; b=YqzRVsMmf5Flw7wGZXBwys9MAUz3wY8ACmvmo
	1WBIZ1+oWl03tMZ34DZztprcdQ1hmVN0YY+vf7Eu82h7QcFEkmeZKFXQo30O6ms3
	N9ZZADb6ASH+WGrExR05VMWFlETBvNUXahLabPOUmDDiAh+SS+gZs609q0aJxMUZ
	mi8W+skHTKYLP0iH4B7KjsMBnUNyMkTPHlP6+bYNqzBO6E1MGxolQnwfrPsSRjdz
	Y+5JMaV3dOeBY0EXConeHHV/JojJuP+sNjdWiXcBiQhT3yr1Q9EgPP58OUfseYtG
	3MfNmr7s//FTA+ahFQ2CFMdm1VwncYL622ORn0xZC5h3ww61g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793668360; x=1793754760; bh=qOlIMt/VAbUi9N2qK2exmjaT47x7u5m/ec3
	vtblEW9c=; b=RkwYjAvjKlB7CfnPN2+mxfNsHynS141yU2EcYjTizZ8LJMX7U8M
	O7+b/fSbtFUdUQas8jjia2kMtTvpM1WvWleH8jTs11Yal7uZFBOjNRa8YRVxb0PC
	ZDNNWEP4j+qIhpvKN0zAUP0lASONN1uzhrKTDkPUvt4eao8V4nuwN9gHF7Ya63kT
	cSNXoxPO5hoKY+ZhNoE0K+oeNVqm1ZBripJhOM6hgyHGqNjV6aE/fWcnftp62V/6
	+9HlQ1a4ipOh5xY8WBdukPQF0NP4prvEe2lWSlfWtSQ8rJwP/6c0I43KyGlohSjO
	GgzpVmMHAFR0Xx+ZliBx8b2ZSIoyjo8nSgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793668360; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:A3CWDo4KikvsaaIMGyNXpJfV/9MnrrinnK7i6yXQI6iRVco
	XBdnQgyr1rM6ZoMBbUBlHVwleVJqIqd0/Xye84tWPFaumv2tFw9ipKMhqZaMFtOb
	pKip5i3ZibVtQAwfALlAK++7RqjTf0Qn2sisiGgjc+gf7XQuVEjJSdKHguCAw/M7
	Ka8DC0W5xNZ43QDc6nHlrItEsz1fii+L9/T/H64pHY+dd7rRuqBCd91n+5bmDbwF
	52zCR8Sr4HJWCePGQyfd0wy9ijLNvCWiD3gzie+j0u7Oc2TI66xeLTOoR+2xWxhR
	FKPUXszF7QmF95Dh3tNVplL8aoOWx6XFxCpSuZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:N3aOoxO/okT7eqpssHNErTArrC7V/UfOROBEMrZAnz8=:ClVgow8D4E+9r3mXdSGATBEe10Jp+Z6/XM29peOQ1lY=;
X-ME-Sender: <xms:BzXpaumG5rI8J35LRNjhbVNHQN5jBEimrwTkbV_qzg0l_DBeFTiaaQ>
    <xme:BzXpahAFKIYz0FgCmnzVRfvGeXrnmvmjdtaRuBxslZkTaL1Cdb2yZ84uQATPWvJbT
    4XD-KE60DN8dfblaRxQ5K5EHgrCr8XtmsBG8osMWVAbf-SHrbC7iN1D>
X-ME-Received: <xmr:BzXpagcGj9rqvfoAsVSMDwcUYNZ4ALc65bpyqfsrx9Kq5FTXJ9Lavy-Ko1IiTdO-Elivntx8FgrbmMVzFMk>
X-ME-Proxy-Cause: dmFkZTE3KktAuiFS4FiZoMXSI9G/VsmOLsb58JEQW/IkYBDp+RQzxHlOMLpyu7pG4TZ1qE
    oZGtsQnncosMXhSVDIBzIn35K+G9bUdBUxHGOqhgtyjYDoctO2n0AykK0WsKtApBUb62iv
    Nq9Yc/h2q8U9TdHIDuDfkUtKPi/QhCVKhViExbPUJsnRUX5b+7tIXqVNfKSQfZKwQ6/mQn
    v3mngyXmhh/7tZTalUF6npmDJPn166HKpaOCYwzhMrMcZ6eJ7IvhBgUzjuypZZOuSNEMwK
    hQoX0bUEjv2/AzI6FZZi9aVKAEuSDqr8DIq6ez13lHIVjENcik+Haak9v+aAu0YgMr0LSV
    pfcu18GzzRJtYmm+pvYQe1Gm3zWQWcuSXtOgAGPFI/rxpYkCJ27GGynyAnkpFdYMmFlVM1
    ya8Gq6HNaRWqh3DX6koMJw45VIyI1XsfXQ/d5J+o4KxaDjQszuyMBRknc+veuEVvxg3SHJ
    bKUq3/d4rVnRyMX7HhoOiHZ2mZyeyzFkWt/Emoc+KjW0rMUel2hSHJXMyMBuEufUYjfyHS
    +lOv6hLGXVDbijWTwjLcrBCexBQpFiCsDkhtUPEkFcxD/HxDr8jpGVT9XlQ4mxoJbpy6Jw
    A7DyKe0UHi8qi97YtNHoysABD4QUkads5dfKMmDllHH64Lq4wOTm6Q8nYrfA
X-ME-Proxy: <xmx:BzXpas7gcA1rfk2-TQJ9q79uJESWR384JSf-BKgUwOblV4u0PUT9Uw>
    <xmx:BzXpaqOVcrKzHffjhZLl4QHbQvhiFUruX7cG0cpZWheWHnoCp0r1DA>
    <xmx:BzXpatHKc_PS92YhaKCpN7q4ZGjKp57YhnU5ubfWNC-9UWgdCOjgiw>
    <xmx:BzXpauTfdTDgRWtggJCfCRr7aAvdRxajFXvKH2iviauWw2ghDCjRXA>
    <xmx:CDXpajJyMIn3_EyuqlOh3MU-Gr-FAg807hQYhTp4N1cvN22-S-9MSyrH>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 20:12:35 -0500 (EST)
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
Subject: [PATCH v3] rust: serdev: use Delta<Jiffy> for timeouts
Date: Tue,  3 Nov 2026 10:11:43 +0900
Message-ID: <20261103011143.917147-1-tomo@flapping.org>
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

Reviewed-by: Markus Probst <markus.probst@posteo.de>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
v3:
- Fix the serdev::Driver doctest example, which still passed 0
  (sashiko, Markus)
- Add Markus' Reviewed-by
v2: https://lore.kernel.org/rust-for-linux/20261102005125.626125-1-tomo@flapping.org/
- Round a timeout of 0 or negative up to one jiffy instead of passing 0,
  which the C side treats as "wait indefinitely" (Gary)
- Document Delta::from_jiffies(isize::MAX) for an indefinite wait
v1: https://lore.kernel.org/rust-for-linux/20260930041339.1551129-1-tomo@flapping.org/
---
 rust/kernel/serdev.rs | 48 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..acad9c3cc910 100644
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
@@ -316,7 +319,8 @@ macro_rules! module_serdev_device_driver {
 ///         Core, //
 ///     },
 ///     of,
-///     serdev, //
+///     serdev,
+///     time::Delta, //
 /// };
 ///
 /// struct MyDriver;
@@ -349,7 +353,7 @@ macro_rules! module_serdev_device_driver {
 ///         _id_info: Option<&'bound Self::IdInfo>,
 ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         sdev.set_baudrate(115200);
-///         sdev.write_all(b"Hello\n", 0)?;
+///         sdev.write_all(b"Hello\n", Delta::from_jiffies(isize::MAX))?;
 ///         Ok(MyDriver)
 ///     }
 /// }
@@ -433,6 +437,16 @@ fn as_raw(&self) -> *mut bindings::serdev_device {
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
@@ -475,28 +489,26 @@ pub fn set_parity(&self, parity: Parity) -> Result {
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
@@ -545,16 +557,14 @@ pub fn write_flush(&self) {
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

