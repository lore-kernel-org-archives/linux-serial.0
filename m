Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E73AA510
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566067; cv=none; b=EGFJQREMWvJWm5rTCCQ3wXl1ahE+wgYhVFk3KnPCUcB40xaKYDKIQuHo6sdnNP8Lw/XEMZKK16oURWQnhxeaRsVrYEBTAfOsbnW/EHJTkcOhIxoEhcyJ5s3NA1s/bP+voV46xTe1/MSJdwzA+bfRRAQBBqiSGAUMgmAKNDM+JPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566067; c=relaxed/simple;
	bh=TsLlC/ioR2Jkk2VjlrQwE6V5V/wGi6NqPBQrCfB1OMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SClLZWMYX7a9L/Jy4oXf8RakQxeJdWhDZlX3hnMWd5eyaiS8DOWF+fv5v7ff+WKgOCy3KP0EHrBi/xSZMZOYrfSlJWXlIjr7OEOtwkDfpxZKMktpptvir/RBrVEOVPADy/3E6EByncWwGDaVg8vD+Bt75pfvu7Txz2LKaoevWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gJ62v+Tw; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gJ62v+Tw"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1A15F240028
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 01:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788566063;
	bh=OLVuQVX/N+WqEGKjo8hMMDcUIB5e77LBvfhRra0r9vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=gJ62v+Tw1mvkhGE6eS70qIHJpYuGEBSjIBNNYJke2GDCF5gi+3a38Vi8/4hziRnTU
	 o2omSzEHUXhbed7sBC6TAmlPiJ88sVqXOR24sr4kj5v1dZLgYwMr18D1J2qnGE54YD
	 yh4YDlOpSLxxwoQWDSmfKkUKyeE4rZDQyDGTF0tYi2CP0vnQYmTgCzT2adBfQo7trx
	 QHUddqupTk+TMP1ceeTZrTRC9QxqlCAN7LMKVTEh027MqE8/yrUgZrBls01V69EsqM
	 q5vwVQ9Qc/JRZ4dRm+VYFRD1SQAh9HqByQ/KWcyvVqYSR/qUaN2eYSJJskRyVEt7P1
	 dZTKxm3U9J8HA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcCx905wxz6tw4;
	Sat,  5 Sep 2026 01:54:20 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Fri, 04 Sep 2026 23:54:22 +0000
Subject: [PATCH] rust: serdev: Fix race condition on driver probe fail
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2N2w6CMBBEf6XZZ2sKeAF+xRDSlq3WhIvdtjEh/
 Lur+Hgmc2ZWIAweCVqxQsDsyc8TQ3EQYB96uqP0AzOUqryoRp1kSBR7lgbMvfNvabByrrG1PmM
 NbC0BOf4t3rqdKZkn2vid+TcCvhJfxb0GRhNKO4+jj63I12Mlgy2g27YPBHlXu58AAAA=
X-Change-ID: 20260904-rust_serdev_fix-be3ff9c8a5e8
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2685;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=TsLlC/ioR2Jkk2VjlrQwE6V5V/wGi6NqPBQrCfB1OMI=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqm1os3x+aGsYe8+aBt32QdQAXk64jLH1gSuRO5
 we5VNT3dqOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaptaLBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LXKw/+I5pNcgjvni4F4IIHxVhJpsZ22VknLX9
 u+dLZwxY+vYlqWxqHs3nsCtQ9SiQLMjjxXalbpugLe88A8Hj+Tu7YYIkm6qTXFfZ86f6lmyjIGs
 6yDXUQcFE5CVl14ZEg24jMm6qhZbtyu50rCm/mEA/A7PhS+ymQRLah+ghhnfHtsG7rcHuEbINtd
 R1XZd17XI0JO0ANfrONEnh0aGZQYS11pK0QHS8dL9jeavV3rybXJr88d1w3uSbitHCusKvKdVRO
 BDGc68ybgvX4lXvuE9s6oZ3GK/WdXrdqf5/nCLzlTnazUAI590wlDXcQpYhc62npSvpaWezrAMa
 NWH2foDS9e1MjggoFP2rsp00vreJDYmidBzS+/JbVGca6Z1J+prY5zHrI8chWQ1S/gGm41Bc08F
 tCGkT6VGQ0Q66Ar8M2jtrRGQSu8KwdJLNgZOnERg2U4aqd/Im+fDmYS4R5WD+hqBOPqZGELDzPM
 /V1Z+EstImMv6xO+b8T3nSbN0zoLQKqVq2SPByGglXeFVbKScJGPKXmmbeJ592KPh3eIvJMUB0B
 t9o/QHmx7BCqQLivan2e0pnLq8dKe1wpJq4KnIeg++4ttKE7a0lFb/i5awmo5YQpi05CaolGMvO
 d3u1/J3/ANHysFQd60D9NnW16w9ZJbHQsrV1gZCP1CYLtkOJKEoE=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

If `Driver::probe` fails, the pointer to the driver data (`PrivateData`)
will first be set to NULL by `drvdata_obtain` and only after that the
serdev device will be closed by Drop. Thus there is a small window in
which the serdev device is still open, but the pointer to the driver data
is NULL. Therefore it is possible that `receive_buf_callback` might try to
access the `active` mutex on a null pointer.

Add a separate `ScopeGuard` that will close the device before the driver
data will be set to NULL on probe failure.

Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@smtp.kernel.org/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Unfortunately, this also makes the code in probe even more convoluted
than it already is. I will submit a patch (for the next merge cycle)
soon, which will address this concern.
---
 rust/kernel/serdev.rs | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..4f57f4c45329 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -190,6 +190,16 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             // SAFETY: We have exclusive access to `private_data.open`.
             unsafe { *private_data.open.get() = true };
 
+            let open_guard = ScopeGuard::new(|| {
+                // SAFETY:
+                // - `private_data.sdev.as_raw()` is guaranteed to be a pointer to a valid
+                //   `struct serdev_device`.
+                // - We just opened the device, thus it is guaranteed to be open.
+                unsafe { bindings::serdev_device_close(private_data.sdev.as_raw()) };
+                // SAFETY: We have exclusive access to `private_data.open`.
+                unsafe { *private_data.open.get() = false };
+            });
+
             let data = T::probe(sdev, info);
 
             // SAFETY: We have exclusive access to `private_data.driver`.
@@ -203,10 +213,12 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
 
             drop(active);
 
-            result.map(|()| {
-                private_data.dismiss();
-                0
-            })
+            result?;
+
+            open_guard.dismiss();
+            private_data.dismiss();
+
+            Ok(0)
         })
     }
 

---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260904-rust_serdev_fix-be3ff9c8a5e8

