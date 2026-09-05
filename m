Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A7352C2C
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634049; cv=none; b=pFyY08Y8/CueJyvw2QD4UpXl163Fbfm5nsi/Y6ZziitH9dvyoehHmcV/tyWeLHp8vBSUr4PyNGTfOn7UcluOEt19tlUxf1FtfOZf8DSJdYMoakYiqCZqbHzrNMSlBvfN/XFzc0YnvL3Z+BqsqSYE5EiFfPyEzVUC3M6WF38NBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634049; c=relaxed/simple;
	bh=o/ZuesuPC4jvCYksIb0EkV7sO86FmYjBkDa7SK+0/ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JwJlPPYL2jYCqI72PS8NDvQAYtv1kcah6cM2nl+VHFMF2H/Mgc4q+G3eecTorR57RShwqUmYOU2gUrYBCZUvghm2nmLQdgg13mhTqUXZrLNsyRdIhjxF1Otnqoie+dnpIC8rRRGPPrWVLF4OSEdAmu3Q43k0vwt3gYTfUcc/5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=KebWxYx5; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="KebWxYx5"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3524B240104
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 20:47:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788634045;
	bh=oigscXGTpJQB4Kl3D2vzx/9L2fPbaTa0C5Ge7FLEu34=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=KebWxYx5AF1TuPp6JfuBpCBMMINnB6thkfoaq3GaBLKAf3/vsPH3CCEZNexOtnGRf
	 Z+F+l056T89PH/C6npOXzGLyVMVSPGtXnYam8KYJa/yUC8RfpuA8K8IPgTTdbhwO0H
	 02+fiHggu9QzHpEtGKNEu5y3JD4gEU8iMuWm6sVVLrNZYrpP450rJDEFlVAZ64M0kD
	 uSNG89D9MtDZIvIZR90xK64phKowYr0a73PJDgHvfU6DZWiOF3mwcOlqjE+Ur0tYOt
	 QnZoUAT21/Rjl8XFUnt+6bGr4rqurksyl/IW51QNchOZvMtrU+6DNneJzaDGki1asl
	 +P295li3lGA/g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcj4W2h5Fz9rxB;
	Sat,  5 Sep 2026 20:47:23 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 05 Sep 2026 18:47:24 +0000
Subject: [PATCH v4] rust: serdev: Mitigate race conditions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-rust_serdev_fix-v4-1-31e1bbcc0c00@posteo.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOy27CMBREfyXyuhf5EZuEFf+BKuTHdXElMNiO1
 Qrl32sCC0QXLGc0Z2auJGMKmMmmu5KENeQQT030Hx2xB336QgiuacIpV3SkPaQpl32DHNa9Dz9
 gUHg/2kFLHEijzgmbvTTuPu86T+YbbbnVPBIJL1ObKvcYMToj2Hg8hrLp6nolIFlGbvQh5BLT7
 3KvsiX8eCL/PakMGHDUIzdM9lqZ7TnmgnHlcOmq/A3PgYKQzltHFXqOr7x4w4u2bwZFpbLCr3X
 /zM/z/AfPJO0LbAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3402;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=o/ZuesuPC4jvCYksIb0EkV7sO86FmYjBkDa7SK+0/ac=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnGO7KLpMTXKl33nXtPNgH6ll0dqR55m8o0VqL
 kytWAeuhsmJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapxjuxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JOaQ//UiwR8aEn1dOtqTx1ldOydSdbtb9Hkux
 jZg4aXVgiqPrMMU3sfezdR6FkkBUexCXQxGXiquw8sOhDV2YnYfW/3oMXPydYr5CDSYgYTZ9iXV
 iwuOZ+xcB/JOgfqmHHsBe+jMZp9xi1hLWSKqTXs85Y6EvJOJMAy0vGafd5/PNC5RX/jO24rmNJb
 D4OvBeqYzVsAQALUPzeniVB7A55ZObhQ8sVZ1kUSRIfDMiYLWRav4rBkFWd3wOu3gzam1HHdj4E
 o0mAEznT9d2iHxbad8gsxd7QmdqYHLmWKAQepQrA4DJnOa+98vQdLISZOVjupmyBgYpA2kd47SH
 DQsZGqS7eT4NasQR8LT3+dGgRXP7TQLSZja2rVI3DtxKBMugLK1pRspmJerhd/OTo5Q7mcqf7Q5
 Mo16dRV5zbXAvIpzRw+DXQdgOhSV4EksAQ5MqD1zhAS0u4MrLvybkBtK/mVl1pmD7Zg1PMWEe0Z
 ZlII6UZ84ZbyCxMhWasJS872v34kN1n9t94zM0UQAxDctd5b9qFz6tMAdqq2RF0aluzG2KH2r2/
 ArPDOxOcTC/24e4Xlq7KXXVtZnk8QQky6E8XGCYSmDYsJZB392zLI6r5otWTLg/Y5XF0t1TPENO
 xAem6KyihcwtY5F1T8vBfnMw2eHw5Mpx/CxMurqcw+eT1e30r/MY=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=xsFNBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93qReNLkO
  WguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVAm76Ww+
  /pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt9k5JA
  RhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbmfAja
  oT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwTjRQ
  xBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1J+
  FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN6
  OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
  8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJC
  XCeMe4BO4iaxUQARAQABzRdtYXJrdXMucHJvYnN0QHBvc3Rlby5kZcLBkQQTAQgAOxYhBIJ0GMT0
  rFjncjDEczR2H/jnrUPSBQJog714AhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEDR2
  H/jnrUPSgdkQAISaTk2D345ehXEkn5z2yUEjaVjHIE7ziqRaOgn/QanCgeTUinIv6L6QXUFvvIfH
  1OLPwQ1hfvEg9NnNLyFezWSy6jvoVBTIPqicD/r3FkithnQ1IDkdSjrarPMxJkvuh3l7XZHo49GV
  HQ8i5zh5w4YISrcEtE99lJisvni2Jqx7we5tey9voQFDyM8jxlSWv3pmoUTCtBkX/eKHJXosgsuS
  B4TGDCVPOjla/emI5c9MhMG7O4WEEmoSdPbmraPw66YZD6uLyhV4DPHbiDWRzXWnClHSyjB9rky9
  lausFxogvu4l9H+KDsXIadNDWdLdu1/enS/wDd9zh5S78rY2jeXaG4mnf4seEKamZ7KQ6FIHrcyP
  ezdDzssPQcTQcGRMQzCn6wP3tlGk7rsfmyHMlFqdRoNNv+ZER/OkmZFPW655zRfbMi0vtrqK2Awm
  9ggobb1oktfd9PPNXMUY+DNVlgR2G7jLnenSoQausLUm0pHoNE8TWFv851Y6SOYnvn488sP1Tki5
  F3rKwclawQFHUXTCQw+QSh9ay8xgnNZfH+u9NY7w3gPoeKBOAFcBc2BtzcgekeWS8qgEmm2/oNFV
  G0ivPQbRx8FjRKbuF7g3YhgNZZ0ac8FneuUtJ2PkSIFTZhaAiC0utvxk0ndmWFiW4acEkMZGrLaM
  L2zWNjrqwsD2zsFNBGiDvXgBEADCXQy1n7wjRxG12DOVADawjghKcG+5LtEf31WftHKLFbp/HArj
  BhkT6mj+CCI1ClqY+FYU5CK/s0ScMfLxRGLZ0Ktzawb78vOgBVFT3yB1yWBTewsAXdqNqRooaUNo
  8cG/NNJLjhccH/7PO/FWX5qftOVUJ/AIsAhKQJ18Tc8Ik73v427EDxuKb9mTAnYQFA3Ev3hAiVbO
  6Rv39amVOfJ8sqwiSUGidj2Fctg2aB5JbeMln0KCUbTD1LhEFepeKypfofAXQbGwaCjAhmkWy/q3
  IT1mUrPxOngbxdRoOx1tGUC0HCMUW1sFaJgQPMmDcR0JGPOpgsKnitsSnN7ShcCr1buel7vLnUMD
  +TAZ5opdoF6HjAvAnBQaijtK6minkrM0seNXnCg0KkV8xhMNa6zCs1rq4GgjNLJue2EmuyHooHA4
  7JMoLVHcxVeuNTp6K2+XRx0Pk4e2Lj8IVy9yEYyrywEOC5XRW37KJjsiOAsumi1rkvM7QREWgUDe
  Xs0+RpxI3QrrANh71fLMRo7LKRF3Gvw13NVCCC9ea20P4PwhgWKStkwO2NO+YJsAoS1QycMi/vKu
  0EHhknYXamaSV50oZzHKmX56vEeJHTcngrM8R1SwJCYopCx9gkz90bTVYlitJa5hloWTYeMD7FNj
  Y6jfVSzgM/K4gMgUNDW/PPGeMwARAQABwsF2BBgBCAAgFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IF
  AmiDvXgCGwwACgkQNHYf+OetQ9LHDBAAhk+ab8+WrbS/b1/gYW3q1KDiXU719nCtfkUVXKidW5Ec
  Idlr5HGt8ilLoxSWT2Zi368iHCXS0WenGgPwlv8ifvB7TOZiiTDZROZkXjEBmU4nYjJ7GymawpWv
  oQwjMsPuq6ysbzWtOZ7eILx7cI0FjQeJ/Q2baRJub0uAZNwBOxCkAS6lpk5Fntd2u8CWmDQo4SYp
  xeuQ+pwkp0yEP30RhN2BO2DXiBEGSZSYh+ioGbCHQPIV3iVj0h6lcCPOqopZqyeCfigeacBI0nvN
  jHWz/spzF3+4OS+3RJvoHtAQmProxyGib8iVsTxgZO3UUi4TSODeEt0i0kHSPY4sCciOyXfAyYoD
  DFqhRjOEwBBxhr+scU4C1T2AflozvDwq3VSONjrKJUkhd8+WsdXxMdPFgBQuiKKwUy11mz6KQfcR
  wmDehF3UaUoxa+YIhWPbKmycxuX/D8SvnqavzAeAL1OcRbEI/HsoroVlEFbBRNBZLJUlnTPs8ZcU
  4+8rq5YX1GUrJL3jf6SAfSgO7UdkEET3PdcKFYtS+ruV1Cp5V0q4kCfI5jk25iiz8grM2wOzVSsc
  l1mEkhiEPH87HP0whhb544iioSnumd3HJKL7dzhRegsMizatupp8D65A2JziW0WKopa1iw9fti3A
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
Changes in v4:
- remove comments
- Link to v3: https://patch.msgid.link/20260905-rust_serdev_fix-v3-1-b86056c3f7a4@posteo.de

Changes in v3:
- mitigate it
- Link to v2: https://patch.msgid.link/20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de

Changes in v2:
- also fix race condition on unbind
- Link to v1: https://patch.msgid.link/20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de
---
 rust/kernel/serdev.rs              |  6 +++---
 samples/rust/rust_driver_serdev.rs | 13 +------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..f4c0f43b5273 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -148,9 +148,8 @@ fn drop(self: Pin<&mut Self>) {
 
 impl<T: Driver> Adapter<T> {
     const OPS: &'static bindings::serdev_device_ops = &bindings::serdev_device_ops {
-        receive_buf: if T::HAS_RECEIVE {
-            Some(Self::receive_buf_callback)
-        } else {
+        receive_buf: {
+            const_assert!(!T::HAS_RECEIVE);
             None
         },
         write_wakeup: Some(bindings::serdev_device_write_wakeup),
@@ -233,6 +232,7 @@ extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
         T::unbind(sdev, data_pinned);
     }
 
+    #[expect(dead_code)]
     extern "C" fn receive_buf_callback(
         sdev: *mut bindings::serdev_device,
         buf: *const u8,
diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_driver_serdev.rs
index 51b4898cd855..3fd3eef15371 100644
--- a/samples/rust/rust_driver_serdev.rs
+++ b/samples/rust/rust_driver_serdev.rs
@@ -4,10 +4,7 @@
 
 use kernel::{
     acpi,
-    device::{
-        Bound,
-        Core, //
-    },
+    device::Core,
     of,
     prelude::*,
     serdev,
@@ -60,14 +57,6 @@ fn probe<'bound>(
 
         Ok(Self { sdev: sdev.into() })
     }
-
-    fn receive<'bound>(
-        sdev: &'bound serdev::Device<Bound>,
-        _this: Pin<&Self>,
-        data: &[u8],
-    ) -> usize {
-        sdev.write(data).unwrap_or_default() as usize
-    }
 }
 
 impl Drop for SampleDriver {

---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260904-rust_serdev_fix-be3ff9c8a5e8

