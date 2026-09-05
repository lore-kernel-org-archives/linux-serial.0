Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BB3793B0
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615028; cv=none; b=R3AI8lWRQttfxVlTptdaHXhtS/rDxgXW24gmvELhfPfzWRlUulASz9KISOyoGHbiquGxcfJS4EMO3wt5ox7z4fswLk9or8oGXVMCx7A1wUwDA3oJKGsIN1dkrtmQIgBlsZNrlDZO1060FGKNvXAp8IAUkJ5OgrkEhCtmnWoRCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615028; c=relaxed/simple;
	bh=/sHkrXd6mCsWP9i59t2eUZxlmi8BLvtU4brDKGMSKfY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PXvSXtJuo8ybrrCPLmKJOTt1t6Ou9Gpf9SfKkJRurs+gDhNg9FofORgRLNP53tyQPD1mwtIondqw3V/gY4App/OJXZ1u2DbylIQEtnfv7aid4DYMLX4pJmS44rGQbi30OT/KSTuip5UTmtSzIzXFD/osKXC/xJpGpSGUt89FWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QXlrqFr9; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QXlrqFr9"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B04C5240107
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 15:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788615010;
	bh=ssXWVRsdIn5Z3wp/OqRzUmICHe0zBBdsbTkhBd3pUl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=QXlrqFr9HuBpRI0YW8i5KXt/L47Iu6HjJYlnWgchtqgQvIrGsPFXDvJvPsNmWuD7c
	 EHcxu+4JDl/MiWvGYD3Id+k5ii0FxBZ9U6eyenxouUV0QeTA1cmxUfmBbliK/VAMPw
	 gmlqMDFSrlOGybJNUjR1WaAZUYyZOLXCZDmHFaySLW+lcqrKzrEov7AzWedp27To+n
	 irLGmfDpWa9IhGfP6wWerssU2Fn5MJo0dzfmcAYl1uS9ZiwHkNNC3W0i1knBZ5WISB
	 +ahYi/OBcxiAFtDfl9hdRp5PY4bNy6pmX10sMtCv1mPHaVagDeb2xAqlWwuKdxGsQD
	 Y1AGQKca7SkaA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcZ2R4dQVz9rxK;
	Sat,  5 Sep 2026 15:30:07 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v2 0/2] rust: serdev: Mitigate race conditions
Date: Sat, 05 Sep 2026 13:30:09 +0000
Message-Id: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOyw6DIBBFf8XMuhjBR9VV/6MxBnCsNKlYQNLG+
 O/Fx67LM7n3zlnAolFooY4WMOiVVXoMwC4RyIGPDySqCwwsYUVSJRkxs3VtKHXo2159iMC07yt
 Z8hxLCK3JYDjvi/fmYDuLJ0q3zZwJg+85vHJHDAS3SKR+vZSrI3+NU2Ikha09KOu0+e56nu7h0
 yT/M/GUUMKQV0zQPOOFuE3aOtRxh9Cs6/oD9V4ZKewAAAA=
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 Markus Probst <markus.probst@posteo.de>, 
 Sashiko Bot <sashiko-bot@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=827;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=/sHkrXd6mCsWP9i59t2eUZxlmi8BLvtU4brDKGMSKfY=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnBle/rNQ43bFeWvmH7iHmkj/W27WBDdPA0qVU
 5P/X1L+LwiJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapwZXhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LuqRAAtqn3qkNC3+UTHyE8m0I9w6+MBP92p7q
 NdJU/6JRKnYMBVMK1k9hLbGan9EPhVs5QhugjRFIabfR/eD9zEOAbZnV4q2M/H5M3n9EBzOy45R
 Sekyzc4Ph+pOuyC8R+uePR1jJIxZJ8x3GMSQbovUWJ7l/SKdopO2CClJMXXbglGpNEXfUZc1jpI
 Mx1tIyIf0GGeDELhIfT9ErSF64ZsA3doMc9QllgiYhVskThQujUKsRoiE1MiCWZ5VWigWk4mNMl
 c8e2EjwPJs0WPa5i+gHSex1BBrhN5ldZEje41TEW30Ny5mMthnhPvrtkhx1b/mbiPq3UKIRs65H
 j71Zuni1qxVtFvpms0MeTZ7vAY7/C65IsndwyUAeRADZ40fGoPRSjRPzZ1LEY8pcCv4Ploa9/xf
 RzW9G0aLqUELAjRcY6ueI39XQObGi/1kMdy3LOCf0d1K2GNl5KkYqxC4pLcmnWumhL/qkWsDfiQ
 gVnfjL6WG+wildevUU1RUcm8GN0/7u1JLwlnEsxKgN9Sup4vgYY3MQcZx8lbg94+WwXy+1fEMdk
 QIbCQvpSpJopL2nNqerx1/KVqvEXhnFEZFwNhnx5nbHx7ypIJgVm439yah+l0UMrO2DXKMlqfFq
 iP64S7/M9P0xIXCR+r4bkao0jatrrlmfKn81qHUiiT5NAi/aac+E=
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

For details, see the commit messages.

I will submit a patch (for the next merge cycle) soon, which will
make the probe and unbind code less convoluted. This will make bugs like
these more unlikely.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v2:
- also fix race condition on unbind
- Link to v1: https://patch.msgid.link/20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de

---
Markus Probst (2):
      rust: serdev: Fix race condition on driver unbind
      rust: serdev: Fix race condition on driver probe

 rust/kernel/device.rs | 16 +++++++++-------
 rust/kernel/driver.rs |  2 +-
 rust/kernel/serdev.rs |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260904-rust_serdev_fix-be3ff9c8a5e8

