Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9746353A90
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710137; cv=none; b=on/IRl4/0I1jK2K+5G9f1DUHxsLGw6lIVNWu+KbbnnzQQQ6m1A3I7IQ2dP1VcbVvfAP+jlE2V+mYaoH7kLzJWmMou6x1ATNVZZFvBe+J9BZ/fJDKBPikDH81DBVWCy7zoCMG0+QiEL7PSULplZ+8+r0G4yBLR0ndn0HEaMkNV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710137; c=relaxed/simple;
	bh=xmTFRFw7V/HU3JXIe69biF6uXSYP9tKIxk/FBu1sWo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+iclxRVShhiMxmdcOb7bGXCPKx+/YtB+1CUwE6GstKlsHVBHirwUac5YBGjqdkci4dBsGP6jbm/NaFi11dtFFWqmTKfscRm4BTFOeyebdQgvuDFZQD4yUlQCW7CuXexVpeGl22gLXq3aInLFyKsYZfx14hT8hbBBq5pP10Gmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=XH7qOOBp; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="XH7qOOBp"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C2D88240103
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 17:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788710132;
	bh=UTm4yQVbwMpMizb1S87Kb2YZ7hCkc36LgIfvhH/1KKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=XH7qOOBpC/NsVJIV/1lslRF+cZu0Qgqh5zY5c0rr6/hKg1GBqqCgMOD/o5FMMjrLf
	 Dg85S9T1QlZLYV/vE30BX3xjKL82ZVhC5wpSXqDZD4JxbCCB1pP3UEt7+BgJY68keQ
	 maS54hrLJaHrjtoJDuAUuLzExy9ciJTtoAUOm33R+g7omu67wfsbpMMfoTvpNG5MYR
	 Hp/0brIiJZNFEvmxa6SmxyZkyADNCz1YKPCnvQz4qkKqoUPGf2gHJQKOJd0CUXd/qi
	 jImfzKsUGs6XicIBQFsii1Cpj2E/irtDENRSPgJjFSGlSoGXxQKHulRgRXYHokQ1L8
	 qzDitlh8g/EEA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hdFCh4dtpz6v3h;
	Sun,  6 Sep 2026 17:55:28 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 06 Sep 2026 15:55:30 +0000
Subject: [PATCH 2/5] rust: serdev: Replace `active` mutex with receive
 pause
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-rust_serdev_probe_refactor-v1-2-69cdae0074ec@posteo.de>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
To: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, Markus Probst <markus.probst@posteo.de>, 
 Sashiko Bot <sashiko-bot@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6499;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=xmTFRFw7V/HU3JXIe69biF6uXSYP9tKIxk/FBu1sWo0=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnYzqmas2+Lg+oqHbSUW0zD7px/TGT5hvRpANM
 zGexL3WQhuJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCap2M6hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Ileg//dOrkcD6wllXJnVtCsKWLO6xbGHv9tq6
 zRNa4+WZP9GI9bPEoiAF37X2fP/4F7vOHjLt+hJTe8XHvlMI8vq1AGHS72HmTFMNYcI4Tnw648Q
 kJ5ywnBWCLePtvrQrY6CGQ629k9HSl55jtAIXfvLE4A65cBfBfdu0KnU542TKasxRWAyzD0sNY8
 CqIsCpJoVSxFcfnaXuFVqn1yWP3+XEUcRVj9IJ4ZK4tqzJJWMRn/GJcQMg+BTOoRA6RVxOaEurQ
 jWR8e+8i7rmFulKnn0q/gndK0vRFp/uiKRqnFDGaASRqQ3S0eYcbAHbI1MqxETeku7UH/hdLdeL
 FmE0oLEs5R7bPyp/jlWKm5qgxjMcAuYVAjt2/zzjrwP3sdXwSUhEen6jgWtlQUZmqRkilSBxOfl
 Th2jCtd3ffn/YApEkMBlYUfMXztAbnQCn8fMQlHyR7meYIPt1Fm8FCiEV5FFK5m0IfiL55xji2P
 RbXb7yj0DsEyX6KTKZDc89zmUQJ2eee11YS/tHi/zjuuiFFr2ItSfj5w3tyjU9+sC44IQTKHnAD
 DBzF7xeLBGrnH+3W8mlZxVANx2W02rsr9aukwX/UkF0SpmtjH4dmRVbXw2lKN6XRCGtchXsRInj
 ayKCOTsoILiL/mAxXzdU+hKI7W/raHrX/8BKK0sx/qkBHzDVsZ4o=
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
null pointer.

Removing the need for `receive_buf_callback` to lock the `active` mutex
fixes these.

Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@smtp.kernel.org/
Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@smtp.kernel.org/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/serdev.rs | 60 ++++++++++++---------------------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..c16d6593a8d2 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -13,13 +13,9 @@
         to_result,
         VTABLE_DEFAULT_ERROR, //
     },
-    new_mutex,
     of,
     prelude::*,
-    sync::{
-        aref::AlwaysRefCounted,
-        Mutex, //
-    },
+    sync::aref::AlwaysRefCounted,
     time::Jiffies,
     types::{
         Opaque,
@@ -103,40 +99,11 @@ pub struct PrivateData<'bound, T: Driver> {
     #[pin]
     driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
     open: UnsafeCell<bool>,
-    /// Whether `receive_buf_callback` is allowed to call `Driver::receive`.
-    ///
-    /// If locked, the receive_buf_callback will be blocked on data reception.
-    /// This is the case while the driver is being probed or while [`PrivateData`] is being dropped.
-    /// This is necessary, because we need to open the serdev device before the driver has been
-    /// probed in order to allow it to be configured, which allows `receive_buf_callback` to be
-    /// called. Thus we need to block data until probe completes and the driver data becomes
-    /// initialized.
-    ///
-    /// If unlocked and true, the receive_buf_callback will forward the data to
-    /// `Driver::receive`. This is the normal state of operation.
-    ///
-    /// If unlocked and false, the receive_buf_callback will throw away the data.
-    /// This is only the case, if the serdev device is open and
-    /// - the driver returned an error in probe
-    /// or
-    /// - the driver data already has been dropped, because it was unbound.
-    #[pin]
-    active: Mutex<bool>,
 }
 
 #[pinned_drop]
 impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
     fn drop(self: Pin<&mut Self>) {
-        let mut active = self.active.lock();
-        if *active {
-            // SAFETY:
-            // - We have exclusive access to `self.driver`.
-            // - `self.driver` is guaranteed to be initialized.
-            unsafe { (*self.driver.get()).assume_init_drop() };
-            *active = false;
-        }
-        drop(active);
-
         // SAFETY: We have exclusive access to `self.open`.
         if unsafe { *self.open.get() } {
             // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointer to a valid
@@ -170,7 +137,6 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
                 sdev: &**sdev,
                 driver: MaybeUninit::<T::Data<'_>>::zeroed().into(),
                 open: false.into(),
-                active <- new_mutex!(false),
             }))?;
             // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
             let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
@@ -178,11 +144,12 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
                 // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
                 drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
             });
-            let mut active = private_data.active.lock();
-
             // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
             unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(), Self::OPS) };
 
+            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+            unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
+
             // SAFETY: The serial device bus only ever calls the probe callback with a valid pointer
             // to a `serdev_device`.
             to_result(unsafe { bindings::serdev_device_open(sdev.as_raw()) })?;
@@ -199,12 +166,12 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             // - `private_data.driver` is pinned.
             let result = unsafe { pin_init::raw_try_init(driver.as_mut_ptr(), data) };
 
-            *active = result.is_ok();
-
-            drop(active);
-
             result.map(|()| {
                 private_data.dismiss();
+
+                // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+                unsafe { bindings::serdev_device_resume_rx(sdev.as_raw()) };
+
                 0
             })
         })
@@ -231,6 +198,12 @@ extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
         let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
 
         T::unbind(sdev, data_pinned);
+
+        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer to `serdev_device`.
+        unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
+
+        // SAFETY: We already established that `data` is guaranteed to be initialized.
+        unsafe { data.assume_init_drop() };
     }
 
     extern "C" fn receive_buf_callback(
@@ -248,11 +221,6 @@ extern "C" fn receive_buf_callback(
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
         let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
-        let active = private_data.active.lock();
-
-        if !*active {
-            return length;
-        }
 
         // SAFETY: No one has exclusive access to `private_data.driver`.
         let data = unsafe { &*private_data.driver.get() };

-- 
2.55.0

