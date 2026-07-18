Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9FA383C6E
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784378874; cv=none; b=VnC1iyis/4VaXOpFQvUTfJyUufhaiwQSDtIFBhTUTqccxnhRsCr1KB/rJoM+0bCKUa9MkNkJUXCH8K7LpFWda+yGsPrz2skHfxajWkBzka3csEUEuYSfI7h+qEgJvGsH8dAUZZQNwkUlf0yVF7agLKpUwPlhA8rKhjBRlccbNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784378874; c=relaxed/simple;
	bh=J1tI9f3jC5ts0Ly/hfiH6lrfbcMCqQ3s2pmza6gp4rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1J6JdvyVYsAo3k2yD1LrWR5kih7SUX+c3NUU2ijlXCyEmT5knY4+KlrEC5bc7cF3mIZwN1DBEZHV393j4h5TAbNjhE/LzamkTZb/TF8PTOpfUzhC8ryQhEPuYAWXeb+c1AniKJGWVubM8Va3sBIyBjG9cTZ3H+Cs5YCtYPStbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ft2sR6LH; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ft2sR6LH"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 377C7240027
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 14:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784378871;
	bh=t7BKnS7EMjRmW4YFV6NvV7lNwNUcrxmXMtnTvDUuTuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=ft2sR6LHTC15/ylp02eroha4SrBRQ6KhSB2WqzLw76jLjWFlDBRlwX51yAZwRNaHZ
	 YGrzO+NcnPFeiyWlZSFr3ZIf/MQvBy7hSjWwR8BGg4WX7tMPSPxMUCnvMv0eNL0fSp
	 9t+ZnEbKZTUWM6mmVIWI72ngCTi2chfGODTyjhiOM4FL89oHAHL+r/FDNt9pQNOKv+
	 0ew02KbDRkhA9HVhtMuc129s/Yh29QUFNmDgUTCziA1mJKG+Gk0fWJYVQ5mg3FOjRW
	 uYxHpUjFWt4r907fhhi31fp0TEMFuv1TrlLxTRnYwggW8JweusWLNNBhwI6TDYKjPi
	 2OJyGWn+HFBdA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2RQF0M4Sz6tvs;
	Sat, 18 Jul 2026 14:47:49 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 18 Jul 2026 12:47:49 +0000
Subject: [PATCH v2 3/4] rust: serdev: document `PrivateData::active`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-rust_serdev_fixes-v2-3-e5214e03de13@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=J1tI9f3jC5ts0Ly/hfiH6lrfbcMCqQ3s2pmza6gp4rc=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW3XxWhPwlxiGPuQEnb8IJpyzpY29d1TKVbU5V
 gzl2zaPqFKJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalt18RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Juow/+OSuutmdqe37PozLg3bwDHNTNqzQslfH
 QVDJiB+9ekown05G7rVN5+NQLVvsTQoi5xyE9NfiR+2aJdJlxqBPyQDud3foZvQrYHOO7ck7tIX
 Zeu1+1iuA2fQEnIRmkLQeI3yZ6Qtkdz7fkvaXgbMjkURz6glzVmjtPZKbUff/L1i1nD71QzGthk
 w7i24fQ0Ozqh6rOVnSqcYytoZ9xw95rB4MJGFnWi8bcOIRmNVhxFZAPAeACGO4tU91gyOw2rhPi
 NoSPPaWLSE6eokiUN0GlXGqe7JYV89xOCAUthFkDR367ksq+vj5zJGJ24C95zthSGg7pTO7sQc+
 bJadf960GIiKGXvyUxOy3l8ZlrezsgVPbcl90bT1sNvKxZlJvPyKgB65XyvJFYP1gvAIeTxDmUT
 IUUepkVBiFUornXof4yDj2VMcXdcBlvH2HvdlwhjUBc8tlX4PZDtauKp/6r/MS6we4UJh50vzA/
 6xKqWR7IrwEJfutjNq8N0IrtuPyMc/95fFSAOo+8i4Tyf/gpupv6LPHG+MiTO+NdbRiTmJCPTwM
 gDOlsvNAsLD8i2l8MWEiSGEzkYD066db2zzHQiIU9NfZOw09ak/8yUREQgZvmYROS2vxbYUSjjd
 Xprh20ZqP7tygI73ntPNCXA839TkylCanoBPzNEUC5oQWBJuNLmM=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Gary pointed out that it isn't clear for what the mutex is used for,
thus adding documentation comments for it.

Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DK0SX3P5K1J6.1OV4ETJMXW83R@garyguo.net/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/serdev.rs | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 79d61c6ceeec..a78dfa6e2c27 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -132,6 +132,23 @@ pub struct PrivateData<'bound, T: Driver> {
     #[pin]
     driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
     open: UnsafeCell<bool>,
+    /// Whether `receive_buf_callback` is allowed to call `Driver::receive`.
+    ///
+    /// If locked, the receive_buf_callback will be blocked on data reception.
+    /// This is the case while the driver is being probed or while [`PrivateData`] is being dropped.
+    /// This is necessary, because we need to open the serdev device before the driver has been
+    /// probed in order to allow it to be configured, which allows `receive_buf_callback` to be
+    /// called. Thus we need to block data until probe completes and the driver data becomes
+    /// initialized.
+    ///
+    /// If unlocked and true, the receive_buf_callback will forward the data to
+    /// `Driver::receive`. This is the normal state of operation.
+    ///
+    /// If unlocked and false, the receive_buf_callback will throw away the data.
+    /// This is only the case, if the serdev device is open and
+    /// - the driver returned an error in probe
+    /// or
+    /// - the driver data already has been dropped, because it was unbound.
     #[pin]
     active: Mutex<bool>,
 }

-- 
2.54.0

