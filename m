Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C5483BF4;
	Thu, 13 Aug 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634700; cv=none; b=StXANhp+HG0piKoNSOUGbK87I/z+4f6f2/CK/XMlFcS17yowK46DLylMWxvG79SFP2PEXx/6tSglyky6SFCyraP9m+hNqPpa8A6vQ/BRgFKBPU2KJEsaBUgUknqPiBmef4cXBjue0aT6Y7RxmohLtB/j2tGxkyRM7UMoY09CCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634700; c=relaxed/simple;
	bh=SuWG8aA9nGYj5PmNtAx+oxAwEwtJKnAZ6IGJ5YhHqAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWtdvmofVk5muTGf8PyBf+IX8Sw8EVvvmMEDqdUyxyArxAPgnHYO/RyTJ0UEIUiOe1p5mJEGTTL2O4H7dXZrYf420fgRxTufbtsnvQPzFNR/JbvaPN5B0RQZ+B8gwgI715JotAX7ZGEdsX/XkkqK0Jh0y7cV96La4w+5Eo8900s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drqiBzn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drqiBzn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884531F00A3A;
	Thu, 13 Aug 2026 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634697;
	bh=BL6aeg2XUs2pIQwUHE/ZkMvRSZowduK7k2b5fXuit3Y=;
	h=From:To:Cc:Subject:Date;
	b=drqiBzn2hqLoStHvJbtPkmxcZoXFE8q/TC5bInoyLKqsXXGzvSFY2UQI6rvF8MzSA
	 isikLjBc1n49NgjPrZLwK+VpYRpSg07lRK1vLgR5VeR53QQylOpaG6SKNqCCT2+pzC
	 pWE6+nLAVpesldSHtO2IQ7iZhQCnnH8jPi8o/jaWyIagn2flSVHCBfGt6jDfVrhcrm
	 W7kOysRNjoiRSEKtfbwNa8tj0q6VaRcoTkETDg8Gfygr25Z/pzmkoXVRH4lwzRJhbO
	 j4mVaUFT92ileAa5IM/HPxTERkJjibnLSkdZXRgR/V0m19R1r5FuUOGd3kcTicpIpk
	 gVYqAXvgSk1Ow==
From: Danilo Krummrich <dakr@kernel.org>
To: markus.probst@posteo.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev
Cc: driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: serdev: use ThisModule::as_ptr() instead of field access
Date: Thu, 13 Aug 2026 17:24:41 +0200
Message-ID: <20260813152444.514580-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The THIS_MODULE series [1] applied to rust-next moved ThisModule from
lib.rs into a module.rs submodule, making the tuple struct field private
outside the module. This breaks the module.0 field access in serdev in
driver-core-next.

Update the call to __serdev_device_driver_register() to use the public
module.as_ptr() accessor to fix the build.

Link: https://lore.kernel.org/all/20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev/ [1]
Closes: https://lore.kernel.org/all/DKNAS52KYWLD.M15VEC6U0F6R@kernel.org/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/serdev.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index c0cd24481ee3..eecb1117095c 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -87,7 +87,7 @@ unsafe fn register(
         }
 
         // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
-        to_result(unsafe { bindings::__serdev_device_driver_register(sdrv.get(), module.0) })
+        to_result(unsafe { bindings::__serdev_device_driver_register(sdrv.get(), module.as_ptr()) })
     }
 
     unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {

base-commit: 8364d0e36cbbdfe9adb65a170a70cbe3cdb02ff9
-- 
2.55.0

