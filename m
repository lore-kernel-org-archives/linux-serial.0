Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D9485CD1
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633186; cv=none; b=aG3KC5GJuboEbtXpkirKW7Va4YM+UrhOCAWjdjV2CqSYc36Geb7EsAVU3v8ErmdVsm9kTguVcPAovLV6iWuIV7FKV8JOsZUa/m/d9DO0Beva5z9K5ixJ9WI+WSonyPKxIWZxASl5O6E/qrnTjm96CwPTzvHhcnLG/DL+Kho9LnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633186; c=relaxed/simple;
	bh=ZwCXo2nWzgLVER8cP9lqFRd3/QBZCVEeWPr0IeyYbI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h38+JdoJ40tjWdaq+L5lqJFIdoA5iPBHfqMYXUYJjqI0zwwMUlneeGJujnu0CgIfsthkbs5koWG9UALi+WRp2nTZ5TolZPf1hxyBac+1a9wk0sKNnSFp8gLygQtoUU5O2kWPzzT8TbJyySBLnb29AVq2aKSdedq9LMz2lHjpNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Is7r7INw; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Is7r7INw"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E895E240106
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 20:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788633180;
	bh=5Ib5CDwdwsFPJNjr6rUO5OvYsnss9ywTuFe17SO+608=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=Is7r7INw0IGamZGZD3P/H26AKY4Q0vCVda54XH5VdsAogGAjpjMbUa6Aq9MDvOlvk
	 a78pYJphCfplwJVvwiZoFchOsmX03nd+7AMb2vECJF/JRavjSHQ80BRS4/zGaFUOX2
	 N24c+1EpTXD+rbXi2Mtpwb0/va6U7oVRKFGOSSiTmyv5yhP5OA+zWucdYQ+AV7ftbi
	 CVQhWzhi0D/FZRHyEPDMcBK4NkeCv9Z43+m+hy6WpLCMg9u0fm93jT+9soMsYbvlVE
	 VN/9lvpdrJKjT13ogvVPn7doB8KYU3ZyJCdPDKZFRGJxspeEBPfVdyzkHMlzigej9c
	 QoaBpAq4dXaiA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hchls6kNBz9rxD;
	Sat,  5 Sep 2026 20:32:57 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 05 Sep 2026 18:33:00 +0000
Subject: [PATCH v3] rust: serdev: Mitigate race conditions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-rust_serdev_fix-v3-1-b86056c3f7a4@posteo.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw7CIBBFf6Vh7RigD21X/ocxhsegmFgqUKIx/
 XdpdWHiwuWd3HPnPElAbzGQrngSj8kG6/ocylVB1Fn0JwSrcyac8oa2tAI/hnjMkMZ0NPYOEkt
 jWrUVNW5JpgaP+bws7g/vHEZ5QRXnmU/D423Mr+K7RqQICMpdrzZ2RdqsS/CKkZk+2xCdfyx6i
 S3lj0n9Y5IYMOAoWi5ZXYlG7gYXIrq1xmUr8T88BwplrY3StEHD8ZufpukFJjvJ+SwBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=ZwCXo2nWzgLVER8cP9lqFRd3/QBZCVEeWPr0IeyYbI8=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnGBZKsnMMZ4+2RWqYhNeE1wZNGtHg7+H41cTL
 QO8RJm1FnWJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapxgWRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JZRxAApNQLr1IEHWenloO42fffvz68fY2ZsEl
 cfFHsl37dwDLwWppYBOooviInDrZrzcT2l77WPs6gONSn3wDG38kxRDVjalLnaCGWdfVecirr3j
 vRkXsW4oOwUd9/TLFdAdb42i1Uq8epr2SN9IVDVHlko2bzRMnrCTl/5DnabaXs/kwJ6OaMbbKc0
 Kk0lCn3ZOHTH2fEvfkgj3VHzyjHPSK2JK/toieZSsUcXDA/nErJR2mbDf/AybnIjy7vFAgJnGAY
 jCVyDbVsYa7Azsu4BifpxhSwkOndiGUwT/m9ThO7ualOt8gwB++8ANCZ52VhQibOu7G/gmBBhGu
 jEJxzpHIGVPV0Dn8L+ePIktmtmhBA3ismSDVeeRcuo6Rd1w/EkMKcJtHSFJtZVGb/b9gXuz44VX
 9+fRpQpq9SguwyDLDQVc2IjoHFnG0Bg1uYCe84vy1Xncjo6Z3n9Dmq0Mz6AU2W/i9cnmdbSC6TS
 GIXxIh9yl727Cy9tISJ3+y7og0pVJIpMSDqYbYIMIT7ubJdxIrpy5kgqGhIBfER2jzo8aodALK7
 3/BPQX6954NVNaq/1Q2ukSaVYV1Asp1YkWeNwGQlz5gSoNgGHHz/A6Nw0FRe4pK7S5EqhZe8mlW
 qYQKi70mG70FR2kcLiYnLVZU6vDyxwX/gUsBOy+C5S7MvnmkfPTo=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

There are currently 2 race conditions:
- in probe if `Driver::probe` returns Err
- in unbind
. In those cases the driver data will be set to NULL before the serdev
device was closed. If data is received while the driver data is dropped,
the `receive_buf_callback` might try to access the `active` mutex on a
null pointer. The race conditions can only occur if `Driver::receive` is
implemented.

The issue cannot be cleanly fixed without rewriting some logic, which
might introduce new regressions.

Temporarily disable the use of `Driver::receive`, until fixed in the
next release.

Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@smtp.kernel.org/
Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@smtp.kernel.org/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
I will submit a patch (for the next merge cycle) soon, which will
address this issue and make the probe and unbind code less convoluted.
---
Changes in v3:
- mitigate it
- Link to v2: https://patch.msgid.link/20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de

Changes in v2:
- also fix race condition on unbind
- Link to v1: https://patch.msgid.link/20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de
---
 rust/kernel/serdev.rs              | 7 ++++++-
 samples/rust/rust_driver_serdev.rs | 6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..63b489404558 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -148,10 +148,14 @@ fn drop(self: Pin<&mut Self>) {
 
 impl<T: Driver> Adapter<T> {
     const OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
-        receive_buf: if T::HAS_RECEIVE {
+        /* receive_buf: if T::HAS_RECEIVE {
             Some(Self::receive_buf_callback)
         } else {
             None
+        }, */
+        receive_buf: {
+            const_assert!(!T::HAS_RECEIVE);
+            None
         },
         write_wakeup: Some(bindings::serdev_device_write_wakeup),
     };
@@ -233,6 +237,7 @@ extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
         T::unbind(sdev, data_pinned);
     }
 
+    #[expect(dead_code)]
     extern "C" fn receive_buf_callback(
         sdev: *mut bindings::serdev_device,
         buf: *const u8,
diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_driver_serdev.rs
index 51b4898cd855..863db75d3b5a 100644
--- a/samples/rust/rust_driver_serdev.rs
+++ b/samples/rust/rust_driver_serdev.rs
@@ -5,7 +5,7 @@
 use kernel::{
     acpi,
     device::{
-        Bound,
+        // Bound,
         Core, //
     },
     of,
@@ -61,13 +61,13 @@ fn probe<'bound>(
         Ok(Self { sdev: sdev.into() })
     }
 
-    fn receive<'bound>(
+    /*fn receive<'bound>(
         sdev: &'bound serdev::Device<Bound>,
         _this: Pin<&Self>,
         data: &[u8],
     ) -> usize {
         sdev.write(data).unwrap_or_default() as usize
-    }
+    }*/
 }
 
 impl Drop for SampleDriver {

---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260904-rust_serdev_fix-be3ff9c8a5e8

