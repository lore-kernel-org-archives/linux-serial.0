Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669899;
	b=3qkLEsiL4uwJvEO5dHvNHTxp1TbOHK0JvAJx0+V6uhURS9D+7WnPRlpCn0JnTBW5PQgW
	 3BSke6Z/AGBXts56srZa6yLioSxz/OkHhhJf5d966JKR/K3V4xQi1j7cq0UFF053Zk5NB
	 jRAGlHU0b+Cu97PtXZYMAmnkf6cvAzKZuY2CB7SN/ktg1pwGTTv5XhcgvsSROUWEyMAue
	 c+s6im72MXheuvjfhp9uv+b/dDXESi+Te4E/1b0R6yCUFiNhiOttUd/7deqwm08319uJA
	 Khh/9PxxghgkahVqT1IheS9AwVuzyga20TEdSSshr52mlkEPUNEYUFmx2ZPx7thQrZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669899;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=+X2jAtN5JD0TiYFiy9zcDB/KWSPk0xWw25WlEXIrNv0=;
	b=PXaOiRi5mPkiTGgTCqYzK24B3khKnwk2I7hI3autl5V7yiA5MX4fyLOeffpCd/5LHpgj
	 Rn4dJ8ZbhpGvloxo69yWa4knBwLT33SSf1ivxPCCNfroIjNw7MeT7m2TrmDjGdmWu7206
	 5VbR06Bb2U/0L03/0jUzVPjRffgqwe7SSA6UuiG5wUslFACS+9ss69OJ6v6+3Bhelk8XT
	 SZwRIABZLPLCyls9HQzW1IcMz/M9OZ6OQpUeF+1u2TQcFG06c8Ce8i+bgeXiu+wbbAQiE
	 DhcfhLDuc/d82ap+kyZ3+4k/tVHwJ9O39GkAkwFNBdsmKu2Jhhzi0UVV8W2dEm2J/hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=gHiUt3CM;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C3606A31E
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 11:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A9C3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=gHiUt3CM
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 44DEB240107
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 13:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792669891;
	bh=+X2jAtN5JD0TiYFiy9zcDB/KWSPk0xWw25WlEXIrNv0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=gHiUt3CMFBsq+fbvKDoq/F7R7Ig8xkxutL5DMOYSJlA1ztqdKEGkOS4xbEK4Q1frV
	 +KDTaqJ3Icg52eQ5w5zlJx45oqI4wiTDfnNhlFXBPOnjg1wOlTEdAOgEyPMRgNOpzB
	 9qPf7OW7rGrai1FX4ivgvAqO1XhohVxE9tv0OagLU1AcdhsTNAzxBQGj3UnLJHj0Zg
	 FQ7gjZZ9b3BVkY6Z+y1w0dKD4iONXk+6G7TB62BnBQqiv7Al6X2mpj0aFtaW5B3pif
	 43JLITFkJC4GsGkjX1lO8o+Gg9wmuNzNY8XcXa23YcR5JDnXFfaLSDHVNxTmG4kA+M
	 /58KEJAmirbDg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j9Pct4vkrz9rxB;
	Thu, 22 Oct 2026 13:51:26 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v5 0/4] rust: serdev: Refactor
Date: Thu, 22 Oct 2026 11:51:29 +0000
Message-Id: <20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PTWrDMBAF4KsYrasw+k+y6j1KMZY8aVRI5Eiya
 Am+e2UnFJOFlw/NfPN0Jwmjx0SOzZ1ELD75cK1BvTXEnbvrF1Lf10w4cA0HUDSOKbd1qcfSDjF
 YbCOeOpdDpIDcgpRCyc6QCgz1xf8s+MfnI6fRfqPLs/iciHgb69X8GCO2S0hduFx8PjbF7ASZN
 88+1QO/S8vClsFnIb1VqDAKVB9c3yGAkejeh5Ayhl2PC1v4iuKwSfFKSWH3SjHNT6p/pcSKEtu
 UqFTPrEZjmFAIr5T8pxiw7Q/KuZXeC44gpFFmTU3T9Advmi4o3wEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=7ObpUIH327mgNdM5WhvqB1q5odDtqg/wvGR/V0HThjY=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq2fi9hg1Uk+ukiaycZ+mNEhq+P6QnkgUQkKVOf
 3j1J27oYZGJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCatn4vRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KUIRAAjX6K94+B8i6sGFFts7ezWH4lUo7SR9z
 KpMThvXZ4qXrbv+67bMKz2TV3OJuh602hHRlQ3UGJhCjAAHQ7nkxIouBd2om8r4ydpOPtEg8Nr2
 r6lJPIDFpl76K9kEUkcd8WxNh/YZZi0nwEH0KXpeewpzT/WkVv8HzsZtrGyZYtjfdsiuBjGohWn
 eMLii55wZtQ9+lbEe71ENzohtHXTIprLU+TRrof6c0Eg5a1JvPkRz9SOWLDj1eEWFkcTg73mq++
 7DHr6NLsDUDvMFBGEmZw/gNKEQ1ocwMvcHr4n0p/rn/wfqjwQaj/2IFkxveC4DKY8p5ohRJ5qk1
 xUi9aBQZm5awA+E6qwxeWanjhGiPfzQbiTHNPbf3svcFTrPRiH7dFb8WLjeGEqnEVIBrjyL+iNm
 lKsgLGRsEwz0RXnmJw/7IpvXsnz28nRtfLp8oXCTUaQpuOx9vIsNMXkB2Er7d6e5jNEPN1P7unS
 If85+RH9ZaAnqri5GgpoeNMyItZ+3JLRHHlmsMA/fZv1CIeVj103vpMD+iFzP0PhKzT1z9Gv6tz
 VZsFzkZDb136ZPILWylq3yKkcBD4y5f02aDG0W+d1r4MjTQ/yhbLDyH4hS0zTOOb93X2xABStzE
 et70MmqHRFIyOCJKjk7615HmDcnt0skIRYqgdrvba9jCmNfTR/I4=
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

 drivers/tty/serdev/core.c           |  54 +++++++++++-
 drivers/tty/serdev/serdev-ttyport.c |  80 +++++++++++++++--
 include/linux/serdev.h              |   8 +-
 rust/kernel/serdev.rs               | 167 ++++++++++++------------------------
 4 files changed, 184 insertions(+), 125 deletions(-)
---
base-commit: 091b06388b117fefdcb63336ac09956a4914b961
change-id: 20260905-rust_serdev_probe_refactor-0e2b044354a7

