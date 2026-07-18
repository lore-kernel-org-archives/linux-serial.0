Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CA30DD2A
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784374625; cv=none; b=FVzr1pD6enUQOQ7COkRDzoSz/niJwLmor8UCCK5QAKXTiq1H//YVxwMj7h1VYrhjcixvKgQ+4kDm0Kyl1RcBX3mWxIbIi5rbeFrISx7ZvsEgxhjxSER+mMobuE0kwa2LMkIlgn8nICp09nkUhdoBht26jY+fBefa7lGcnYFbPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784374625; c=relaxed/simple;
	bh=ejBjjZoyNnpyxaqkTKNHNkHtdFFEL9SeyoIKLMqQlYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYrm26jjEkXdsdBO78sOUqz205W6HpeYlbSSoGzF2M1pssRkZAsAgSEdOUjyJf8ETGMeY7iUftE2vW1gwb/LPSWOho8jU82svWGypIx8poL0Obq9vUC3ficRJvk1OShZMi8oJUg8WLUgZ2TGT81bczM8Nam/mAW2LzEC6kdFIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=CUb3qN9k; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="CUb3qN9k"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5E7C7240029
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 13:36:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784374616;
	bh=ulyF8m79sw5U2CfdPGNsD4XEEokVxvg7p9l8hRTjR9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=CUb3qN9kk4SxYqj8Io13wDXQTEPmg0ipIoN120QiwRp/6edupLT5pZ5vjDWaIz8+v
	 62xd9OvGf6Y/GpvUPQG4H2HuraU53CuxrvmkNOfsHJU4WZIY56o58FNpyD2ij1mK8S
	 Em4NdNFUMLKsw1QPcYMeQmgmzW9odGaicVmOxqIggvTXf8l8vW74W6RIkndX+g9beo
	 YujR9ioX4eK5v7KdTm8FaLqkbwKEudKIVnTYuf5kT9RV+XLcpud19PUzreDLlgexGf
	 eIvVcyABU+6JjxYfDrFbSqwviwYn8ZxuljNE+zLRTIX2Io4pR30VHJ6clUl2Jidpsc
	 FUi67kb941Maw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2PrQ2MKcz6tx8;
	Sat, 18 Jul 2026 13:36:54 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 18 Jul 2026 11:36:55 +0000
Subject: [PATCH 2/4] rust: serdev: mark small functions as `#[inline]`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-rust_serdev_fixes-v1-2-35433b6dce0f@posteo.de>
References: <20260718-rust_serdev_fixes-v1-0-35433b6dce0f@posteo.de>
In-Reply-To: <20260718-rust_serdev_fixes-v1-0-35433b6dce0f@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3954;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=ejBjjZoyNnpyxaqkTKNHNkHtdFFEL9SeyoIKLMqQlYA=;
 b=kA0DAAgBNHYf+OetQ9IByyZiAGpbZVKgTltNEyNJkZWgJniJc8XSu0AuaPcj4GNXyRvFxPUGQ
 YkCTwQAAQgAORYhBIJ0GMT0rFjncjDEczR2H/jnrUPSBQJqW2VSGxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjEyLDIsMgAKCRA0dh/4561D0tCTEACicEF95ADLKEzGUlOk+fnClGB8XAQBBt4ex6+zpl+
 G11tuwvqM+t5ab1wddzOGgpbTX21bs4gXLMKwe8gtqfM9giG4lcx8hg/+eNFwuNae9rfQ3NxXbn
 eoCwUM7eaC9LJYgwzsdHhoahyIvKYJEpGWf3Rz5df63o8zJfKquMz2sDf8NO29xswQVztyd32Vl
 6TKmYbdFaMQn+VnJaLLQnSIbT37n4kx50Hf3dNsummS7mqHr1Y39MhKlPNecEbUfM7pgpRO2+J1
 kKLT98owurR9U5TSHHTJqkUxQjF7U9paZTdrmiGNh7kPRDQ276CkKf5zdyQdqm78Rqi+4Hmd/KC
 pkp1KsER3OtNr5OyQmC5kTCH+MFZ4ZGGYgzoVbkNCTHNpd9FQnTuvYnuIQ0pA1y6pGP3hV1E8XJ
 6l7HDWewoyqNSlU5tWg398mAQvrCWjgeSB8PgoFhr7T+O+61LYHo96frqeUw6R98GfhtJpyvwpG
 o54N/907bMcsFhSP/X9Ndvdl8mvdOjLZ+Z7q2LiIpcgokxbiZgIuVUuWKJ0m5XPXEzQVM0P4WcN
 A+6OjHI5ZS8fTL4l7tsRE/PJ7iM/Kwc5YAEpkElGjJuGBmjCy81m3g6CNmMxppm/FJJnE+qqcsW
 MTx2tGKqR36SdpRQmbArkeX6r7/l2Qi+LwjSZ+8w6NA==
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

These methods should be inlined for optimization reasons.

Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DK0SX3P5K1J6.1OV4ETJMXW83R@garyguo.net/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/serdev.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 47ca57966abf..79d61c6ceeec 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -440,6 +440,7 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
 );
 
 impl<Ctx: device::DeviceContext> Device<Ctx> {
+    #[inline]
     fn as_raw(&self) -> *mut bindings::serdev_device {
         self.0.get()
     }
@@ -451,6 +452,7 @@ impl Device<device::Bound> {
     /// Common baudrates are 115200, 9600, 19200, 57600, 4800.
     ///
     /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
+    #[inline]
     pub fn set_baudrate(&self, speed: u32) -> Result<(), u32> {
         // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
         let ret = unsafe { bindings::serdev_device_set_baudrate(self.as_raw(), speed) };
@@ -464,6 +466,7 @@ pub fn set_baudrate(&self, speed: u32) -> Result<(), u32> {
     /// Set if flow control should be enabled.
     ///
     /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
+    #[inline]
     pub fn set_flow_control(&self, enable: bool) {
         // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
         unsafe { bindings::serdev_device_set_flow_control(self.as_raw(), enable) };
@@ -472,6 +475,7 @@ pub fn set_flow_control(&self, enable: bool) {
     /// Set parity to use.
     ///
     /// Use [`Device::write_flush`] before calling this if you have written data prior to this call.
+    #[inline]
     pub fn set_parity(&self, parity: Parity) -> Result {
         // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
         to_result(unsafe { bindings::serdev_device_set_parity(self.as_raw(), parity as u32) })
@@ -487,6 +491,7 @@ pub fn set_parity(&self, parity: Parity) -> Result {
     /// Returns the number of bytes written (less than `data.len()` if interrupted).
     /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERESTARTSYS`] if interrupted
     /// before any bytes were written.
+    #[inline]
     pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usize> {
         if data.len() > i32::MAX as usize {
             return Err(EINVAL);
@@ -520,6 +525,7 @@ pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usize> {
     ///
     /// Returns the number of bytes written (less than `data.len()` if not enough room in the
     /// write buffer).
+    #[inline]
     pub fn write(&self, data: &[u8]) -> Result<u32> {
         if data.len() > i32::MAX as usize {
             return Err(EINVAL);
@@ -539,6 +545,7 @@ pub fn write(&self, data: &[u8]) -> Result<u32> {
     ///
     /// Note that this doesn't guarantee that the data has been transmitted.
     /// Use [`Device::wait_until_sent`] for this purpose.
+    #[inline]
     pub fn write_flush(&self) {
         // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
         unsafe { bindings::serdev_device_write_flush(self.as_raw()) };
@@ -547,6 +554,7 @@ pub fn write_flush(&self) {
     /// Wait for the data to be sent.
     ///
     /// After this function, the write buffer of the controller should be empty.
+    #[inline]
     pub fn wait_until_sent(&self, timeout: Timeout) {
         // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `serdev_device`.
         unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), timeout.into_jiffies()) };

-- 
2.54.0

