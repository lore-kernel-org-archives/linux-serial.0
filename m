Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A863314AC
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784378875; cv=none; b=RxeR8G0dTJL70vPcc3L+/VSB/WaKq5cCY5GYL9p2+bJhwEH7nQOSAEceicLzg7gCg8yXY8zGxdq63qw3oQExl/3Knh4iw0iUmSKVrPCUM5HnySyOpmyqabiPWahnZ2s7K5dOoI/mr2ZlFJF7FZAJL/gp41oT4GVjk8X9lTXCN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784378875; c=relaxed/simple;
	bh=ejBjjZoyNnpyxaqkTKNHNkHtdFFEL9SeyoIKLMqQlYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOCLh4pi11mCfjMkVkxIEJSR1mAmvz5fA63/CWoMNfvUnwd0Z3vJBPK8Reqrwgy7az/vZOUxav65HcTpj8JH0skZH3K8KL2UvrChHkLGppNju1/V56LDesYK/McW1J+4Vz9AAV7vkJFmngN2xrzJkQMR00T9TaoCf2jnIckaC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=hrcv72Y0; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hrcv72Y0"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 3E68C24002F
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 14:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784378870;
	bh=ulyF8m79sw5U2CfdPGNsD4XEEokVxvg7p9l8hRTjR9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=hrcv72Y0WfpkSHaOU+isxejHKq/l22ZPWsg8lZleJ+awtRyDVOumSski2AULAm1ho
	 noFooyPwayAVg+2Hv3gB/WhOAx4YkB5+ofvvPvMkwfYM5amGi6+CavC2WzfhuPlyPh
	 7uZJ9CEol1cxRke1kH1GIaQP/wTjDAoBqCbgSZEGWFk0j+vGOt2AVUbMppUUAvKxdH
	 fTdOl7o4hFLkr6bWvSacY3GLmRGFMFE3fly8UuCfaHmWbSWzb+tyjDiMp2zYmCiNQW
	 xje4gQW0MlUpM7XnENtDO9Qu8Gf0Mgl2kUs7mKuVvHO21cid3edIf9xVpyl5RuGajk
	 XCBsJ/ZRC5FIg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2RQD0Sz2z6txq;
	Sat, 18 Jul 2026 14:47:48 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 18 Jul 2026 12:47:48 +0000
Subject: [PATCH v2 2/4] rust: serdev: mark small functions as `#[inline]`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-rust_serdev_fixes-v2-2-e5214e03de13@posteo.de>
References: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
In-Reply-To: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
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
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW3Xx9V1C+mOfyaoDCqkwLl2e1COCCxJGggFRQ
 GgMrgAJKHGJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalt18RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IcSg/9F07LSGtuk7gd5m4x1Tu55JGG5UPXDg+
 0b1V7pHsTgdKSaztYMciZ3RCwFFO8MpBNDiQH06h0O9q+mPMKdvOkx/SgMc2W1wk4m571YN9kkJ
 3rFDLOw8gx87cw9TOFTvSCksV47a7B0UX0EHJHO3aTdua8jYyIIC+tw0ucmIDk58eYoy1L2sFtf
 i6Iv8TlcKO6G+OXiOqGtuc6bGiepLYej1dTcrJpFeZDshyMjhHB9gSmJ29BbYEQW5yxBNNjPUq0
 KlPsWXB/nyjPk9cd8mVTyw9itpEoEOrUUEvBfRCTKJrd8l2+/VeQfmxXGY9+qAxdVvTEvTISl4d
 lRaO5XXhjG/lPrgA7wQ4oXl8k9caLmFVQbim75uDW4IhhuKkT/mJT1zWTcBJUx4Ct9/1Z6nWpfF
 ob9oWKCStJQIW9Q1efQFm3el/gESnFV2QeCRgZOoy6ct3CZKugqzFsbKMKyVFXt2s7oW80+oCcQ
 PWlN+piTowqo2m7ZG3ih/8C6JCGqaB64FqEIUfl18k2oZ7zu10uVkYzCsmLm0OJNiVQv4e6lrCI
 dnxVofo8fq5NXV9qEpv4rzmNPY+1l/l2HOuPaId1C6Nq9DSStxBGTSTXzKn/1dW+OU2JFJUPdzj
 isOsJw4rO32uiW34JNe34j6pXVh0/N5Mpg8cuF8wa+MuLmAKG+1g=
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

