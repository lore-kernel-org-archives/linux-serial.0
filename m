Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4937703B
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784374626; cv=none; b=Wj7UDGupo/GD2HFRVUetZMnXPqP03Xp9Wigb6pY8lL2/1EFCF2ynL/Hh7Wt2gj3YOYzN0IOajGKT1eH5nQ5IOVkfgIdJzM3542bZlPElq1LBJP70H4s0qZdE4UWcZ1umUHrMdGPsxiQ9BUoDz7Y/HzXL+RL6wHRviKmj03jCels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784374626; c=relaxed/simple;
	bh=LWG/xU/gWy5BpMDMua+aJnjyVbTyKX+yHFE5GjyVz2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2EVJ+i1ELi9aa1MYSEVrNTs42vbF5fI2vCx9ujZNyoBObUWOAcs2JfejEij+DOQXQhqnw50FqeUaeGRJU1hylFOUZye/h73taik70UIwaRciFDRhU6TvVu/ZaWWq9ycs7/c0LyPsoXb8Hhn7tX1GdNRRoVOAFIvb0Krh6NF9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=J++lZzoX; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="J++lZzoX"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 44841240101
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 13:36:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784374617;
	bh=oAAcYcyS9CI0mS14njYT6nch2/6Ab6PkYsuhk40Vh+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=J++lZzoXcdYd1xoqslB/N/sg+5kAd+1RKRyi5FCnBjlS1NlA7TYaXH4BgcEK4Y4MI
	 V7/kX6SuOnwMpLLX5N8h6cRL+KJ/Q8Dt+fxe5aqqHG3I1YKHfzyI5wBJEQg3i/uW4J
	 6fSJfr69tl3sBxPAZSSYnpFmzvL8QcfEwiqDmtfFV/Hqy8AnxY9vrDzL4TbLttB178
	 JX58rvvSfvzXa6wTDDrzFR80X/vkcZecTivNk5PLvDvTR2ZzhswkCFuGWr3e2mMMu7
	 lCj4ZVaNQIB+kmEabpiKBYOck9UCfRu/sVXuRM5EG5z1cmKad7ZqcRRwH5vQzZZMVr
	 vP875/gfomWRg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2PrR4PgSz6tyL;
	Sat, 18 Jul 2026 13:36:55 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 18 Jul 2026 11:36:56 +0000
Subject: [PATCH 3/4] rust: serdev: document `PrivateData::active`
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-rust_serdev_fixes-v1-3-35433b6dce0f@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=LWG/xU/gWy5BpMDMua+aJnjyVbTyKX+yHFE5GjyVz2o=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW2VSSaVBiF2HjuWrPdyrxT4hn145+0u+emlyX
 4rgUnq6BniJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaltlUhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KCmRAAmUi6UbLmbUpCBbZyNJtOYoKQT32hCVQ
 qrBUrxTiLJzpUmgZtUOYEIo2KDnuHJWdoYwKZMAHqiGrEQW8s0JFCMI2KObn+E4S0/kvqq83ziY
 b9niuvWPJrcd6/IaBihPX6amNXLI2tqllW/40+DLxc0qq0QC0vrvmu9dhfTWUuOIzwltiEaYjA0
 HLtzPqiQ4nh7EQaSnRux0rNgyIiviPAJwJmMHaojxEZtTxsJt7NmXv0njqlm6ldzaoYBOC8l5Mj
 VRw+ZDsTNE5iv6jR7n7X5Okhpo0PWJLU/Osot4Ajp9/+H2qeiQ+bjn50FotU3nY0waaqL4qdJuS
 2eLQpBLvw0nWwo7GyoOnsPKTBqUmQqnOGzRsi6osS36YN0Vbq6vPhFnxa1OET90EpWyZgZsj4l9
 O+eg5dVO6DJVfL1OrLZg2T9ytb5y99lFFFE0ZEvziO3Qj4qX73DPpDiuxHBCuhvt75hLFPirj/Z
 b1N36fzUXrDSqxl30+ovvaiJQoBD7WLqwnXZoO4XIYRfUheGHiD4YrRFBXoWXAQ8pkXoYrg5fH8
 EyAOKAMnb/15FeQNYg4dqfdjncQtkCtnx09IV5lDvvu1AnoJJEwJKE0FCFbXa06urR0G/3wZ/fh
 mqnCt4IujWxGWjN17kbbYRIQOXVKkduN6AmNnCVBhODfpmG4g3Kw=
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
index 79d61c6ceeec..3556fe066ace 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -132,6 +132,23 @@ pub struct PrivateData<'bound, T: Driver> {
     #[pin]
     driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
     open: UnsafeCell<bool>,
+    /// Whether `receive_buf_callback` is allowed to call `Driver::receive_buf`.
+    ///
+    /// If locked, the receive_buf_callback will be blocked on data receival.
+    /// This is the case while the driver is being probed or while [`PrivateData`] is being dropped.
+    /// This is necessary, because we need to open the serdev device before the driver has been
+    /// probed in order to allow it to be configured, which allows [`Adapter::receive_buf_callback`]
+    /// to be called. Thus we need to block data until probe completes and the driver data becomes
+    /// initialized.
+    ///
+    /// If unlocked and true, the receive_buf_callback will forward the data to
+    /// `Driver::receive_buf`. This is the normal state of operation.
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

