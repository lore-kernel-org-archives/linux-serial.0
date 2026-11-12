Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504617;
	b=l02eDYKVgq4LfSaCbzYwAvd/yViYA+AwBNjWTZPNw9QVhNSXcdShdo9lCh87vg3vi56V
	 hrbUUKVDy3PkE45PWAa4cqmmAks+iTBFuZn3PAtnocOw5O/wJHjCsljDCH+k7HzY+kx6Z
	 9+BVW97Ywar/wWfNnVQk557ivqS/YI9REMAsdQ1muN+MauKs2tBEHcYrlWVqhI2tY5gzY
	 rxyPb3/+NNbd7C48crCkuoUjwGIhWt2p1+JuVhGaC9zStRSzur+W6Eo+wy81YC61OdCIS
	 Haln55Z8W1y6GXlAYZYSwzFP88JdK422nqh5ZEWLSvNJW0rETGNq3vH0Ii5BYvjLLQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504617;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=6wFp5qFLHUM2+68nb6g0NSA+0TAXpbuD8jgV4OUdK5M=;
	b=qPUmliWp+u34SxFISmewymNtQWm+FYPuL/uFsKqU/PaKE7c6YQQ8zxc/Ck6YK9PRpKBp
	 z32f0poIHtX0q3PIlqpUzb3TpyN0oPnN5P2MNrZLcTmIhiqWBn+JD0GTCJ42TWxKcfIYC
	 016NRJgKOM9d71bWAYo83g6n6nKgTGemSLPB8x3yYlzFzuZE3+SU0t8YkfBzqjd+/ssF9
	 3XZJW3SHJV8fxgvBrzSobg4Zbra3VtNlda+iA1jWyi6LvI4SEUEkuqNENGAaFgdyjTlC/
	 IbOcvgo/GpAbkHiS9T6UsRg43eLMW6c/iMR7gc4hwSTbQCRzGLOK6uJlpb0rdFHXcCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=mFl1xDE1;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E7606A32D
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 17:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED0E7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=mFl1xDE1
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3E7DA240101
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 18:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794504608;
	bh=6wFp5qFLHUM2+68nb6g0NSA+0TAXpbuD8jgV4OUdK5M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=mFl1xDE1M+gwgS87AwiPXlCha3uvFRVugKXM7a0Hbx2kAahtNW0LHxJM/FSEh2HA+
	 rllU405tE5N6Uc2273uNuHO0a1c1lbP1EOrWC6xr7fgQ+9NM4v1/1Rw0Oy07956a/3
	 2BlLHJL/tDirFZDXEp95mTEKfvoLDkjQBLiJo4Nz3MtsiaAWQgTp296ke6endf9hwY
	 JL4wNHjs0QwV+02V+1/tp2lY3AjwAvkSwi3439n5YpRxBk5yjbjGoQDVXD0U+Q+WXa
	 8AbS8ZTNOhiVitk2nHNLn7lV6Ajb7g1K1jIv3XZkHJYE70o5TFJGPjeL2xMyqv/b7y
	 3CSKhFcTv118A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQS7v05Hdz9rxG;
	Thu, 12 Nov 2026 18:30:02 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v6 0/4] rust: serdev: Refactor
Date: Thu, 12 Nov 2026 17:30:06 +0000
Message-Id: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PTW7DIBAF4KtYrEsEw5+TVe9RVRaGSUOlBAdsq
 1Xkuxc7UWV54eUTM988HiRjCpjJqXqQhGPIId5K0G8VcRd7+0IafMkEGGh2ZIqmIfdNWfI4Nl2
 KLTYJz9b1MVGG0DIphZLWkAJ05SX8LPjH5zPnof1G18/iayLhfShX++cYaW1G6uL1GvpTNZqDp
 MkBmbcvIZcjv0vTkS/Dr1J6r9TIKaP66LxFxoxE997F3GM8eFzYEVYUsF0KCiVFWyvFNZyV31J
 iRYl9ShTK81ajMVwoZFtK/lOc8f0PyrmVrgUgE9Ios6XUigLYpVShLBhfa7CSK7umpmn6A4YKL
 UwuAgAA
X-Change-ID: 20260905-rust_serdev_probe_refactor-0e2b044354a7
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=vw1vKdaf1SB4/j8bNrbbMO84LBnBSbEoKu2zaxTSlNg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9feZUyrSQR5mzDJNNiVXo+VAPyNQF7Z/BufBl
 2sTWgu5oSeJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavX3mRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9I/QxAAkmJz1os+EYkD/Qh2zyZj1yEhhEi5rmd
 RkU1dy9LWdqN7VYuwG55vudAzn8LglEqgNrHcozwBsgIZfjbmN8sWdGUZCtDyIWzAmsbNyE9olh
 i+Q8rhUUyfHT1+f0Cmh99RTUYorQl1SuRdDnwiaiUJwuf6iy6EvHk29Yic08zjKPJtj9cYLwS7e
 ZufT2mQ3ESZpdQYZnxY9lierCMF8ErajIakBBX8SahSM38CQqyUR4u96XWPQEpXAJ20FqMAtDMx
 1kfptONw38dWF7kYNqHcXLHhZSFL1ssuQx7Tkdr8Zp5uLtkvRrCZ0ZwttmDzfHYjeWJaL2n9/Si
 lNQYxWEbtoY5w5K9lQxgKzk3d/uQiZziKaOTeRAaCp+t5KRsXMZdFbTFrdz1wTmUoWHbbc37ZvI
 Mxq2bNO3ZSPR3sl7OFGF8++fPGdHOHv7Cp7xlnSAWJ5xvCZNP5XpkRuwbzth0Vh1ZQz8MTlp6kG
 8HzpZl8ukSxeqWJ5Fgg1CGlwKgJ58T9CP0LYnpWjLZzuEPUbt7k+aMWDSMfEI6lRV1huD5C3wub
 K7iauQ2viSH6FiPYyYfWcqUxgNDWKrkPG2nBqPogmsNy6eVKtB0Xv4DSAirjy0WMRzTL+Dk3a/U
 p7N4ls1mSVfX0sIsBcLIZHJved5RE7lxry+rXdAbyWKgE+OhThDQ=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

The following has been changed:
- introduce mutex to C serdev tty port controller
- introduce a new C serdev API to fix race conditions and simplify rust
  code. Should also be useful on the C side.
- fix race conditions
- simplify rust code

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v6:
- fix issues reported by Sashiko:
  - fix compile error on 3. patch
- rebase onto v7.4-rc2
- use dev_WARN instead of WARN_ON (WARN intentionally kept)
- Link to v5: https://patch.msgid.link/20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de

Changes in v5:
- fix issues reported by Sashiko:
  - fix access to serport->tty outside of locked mutex
- only lock receive_lock in ttyport_open for set_bit
- Link to v4: https://patch.msgid.link/20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de

Changes in v4:
- fix issues reported by Sashiko:
  - add receive_lock to prevent deadlocks
- Link to v3: https://patch.msgid.link/20260930-rust_serdev_probe_refactor-v3-0-d1b6e77135e0@posteo.de

Changes in v3:
- add mutex
- Link to v2: https://patch.msgid.link/20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de

Changes in v2:
- fix missing memory barriers in serdev apis
- use `tty_buffer_restart_work` instead of `tty_flip_buffer_push`
- use `tty_buffer_flush_work` instead of exclusively locking the mutex
- add `#[inline]` to `PrivateData::driver_data`
- remove patches for mutable references
- Link to v1: https://patch.msgid.link/20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de

---
Markus Probst (4):
      tty: serdev: Add mutex lock
      tty: serdev: Export functions to pause receive_buf callback calls
      rust: serdev: Replace `active` mutex with receive pause
      rust: serdev: Simplify callbacks

 drivers/tty/serdev/core.c           |  56 +++++++++++-
 drivers/tty/serdev/serdev-ttyport.c |  80 +++++++++++++++--
 include/linux/serdev.h              |   8 +-
 rust/kernel/serdev.rs               | 167 ++++++++++++------------------------
 4 files changed, 186 insertions(+), 125 deletions(-)
---
base-commit: fd9230005e85472b81c1c7c16afe93dd878996b1
change-id: 20260905-rust_serdev_probe_refactor-0e2b044354a7

