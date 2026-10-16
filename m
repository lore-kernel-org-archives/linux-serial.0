Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590185AA687
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173644; cv=none; b=FcVTdQdWwBbYCJuQGI1gjgi3IGKm7edl4uxHmyGwJ4WZQ5e3wY9KM/AAVRjtOdFOdc8jN8XblPHmAUoX1snkj49dRYL1ET5ssWvl0RAWoUu1eUiLeaIgLY1RBMcTC4LrUrCQyaOGQZa/YHQ/QgesZL4ddmZJIcrWxFSX/PEOA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173644; c=relaxed/simple;
	bh=dYFeupRHc6oAp60ttnCYyTs5k36ZN3vMESWL/sNF9fQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZRq+GJ87x5zMx+86Q3/9SZiLPBeZKLTEX+NZX1QWU0NqJo7CcHp8Zz7+/+uWWqzxhOz59fcQqiQ3uCBmHrq51pEAAUWBmKLmvCyP+0Nr+OI0vZUn4Jw+A0JPpQ8JDF+f6pN5ce9E64Z0sG6w7XQMoAdc1R07Ljr5k53/s6jdvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=IxdfpYMV; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="IxdfpYMV"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DAA96240105
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 20:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792173630;
	bh=11iMMZTrj20U+SrYN+njM4FRnL4bVsSJ+M4i4qpVEik=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=IxdfpYMVc1AYBzfeIguNW+OBCUja9b4B52fqHPnegJbtQ5oh3pvGZ9hAt1cLQSuM7
	 4Pny32qKPNKnTONKaq38aTCzqWSthkFpWJW1Awk8zzXl7HQDBA/Y5eSMR5F0U8Emjv
	 b5eKgvH/tLu7X3RGzdzF4LMWZ6gIqwIlAuAS0vYVMPcwmIQCzi9Y+eVaXmLIJMo5Oa
	 h4LOhThTWcniby9eNOd68fkgwi74Kgo8IUy7VX9zPcUSosggrD4bWN0m3vJFBXTiVV
	 9XQJKexc0aJjLQvMOoXF2ppuE/sqN5hF0NRELvNhluAnOyuXZIqeDn5YLNDOBLywTK
	 a+aG4gOjaaGEQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j5t5P2TDSz9rxL;
	Fri, 16 Oct 2026 20:00:25 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v4 0/4] rust: serdev: Refactor
Date: Fri, 16 Oct 2026 18:00:29 +0000
Message-Id: <20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTW7DIBAF4KtYrEs0/DdZ9R5RZBmYNFRKcAGjV
 pHvXuJkYXXh5dPMfPPuJGMKmMmhu5OENeQQby3It464y3D7RBp8y4QD17AHRdOUS9+OPNZ+TNF
 in/A8uBITBeQWpBRKDoY0YGyT8LPgx9Mz58l+oSsP8bWR8HtqX8tzjdghI3Xxeg3l0FWzEzQ5Q
 x7Xl5Dbk9+laWXL8quU3ipVGQWq984PCGAkuo8x5oJx53FhK19RHDYp3igp7LtSTPOz8v8psaL
 ENiUa5ZnVaAwTCmFNzfP8B6qr2fKYAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=dYFeupRHc6oAp60ttnCYyTs5k36ZN3vMESWL/sNF9fQ=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq0mY4KL7qcuPRQxFfHwouuzo5slwJhbPsGOlh0
 iyHEecxQSKJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCatJmOBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KBhBAAtqxpo51+XTizx5tw7XAyhjnV+8yhLO/
 +Zqe5J6SVlGq4/Ig45IJbKwAXDYhzli2Q4mp8hSVMSjVGPYclz8z6PA6+xoRsACFlCPe1wPeS2R
 UXH0a7CG0+SpGr+68050mkyBZ+kB290DVlzNFs53jif9sTcsP33DDuTvLojhWyzmsZA8qY+A5QO
 e/cwm4fxhJRB/dSvmFlqKyL9oJPHPCh9EJkF8skDwIOOU/S1uNWFDs/HvM0f004b/TJjDBtZJkP
 xNZgFtPMPDDLxW3HfJaUENchRwtLssT4HorFQ8CrpG85/rxydj8VgbQOakbolekH/ycddZmYBzl
 dkat37bcN2h6fdMvXa8Y8Xgy0sSXfpoECoaKKwxWIbi2VypsHmgKTSDm5AQJzvc5w6iUYXR0vpV
 rt0CH0xg0hZ9eEo23OnwUF4yu2gGSyHZAsrcBqNt0QNFFejXVwo13ZLjapR58SlARy1wiwo8lPK
 ml3CwhOlTuY4/z4j5FqpUQP/YuQ/AIRTm76P0n6huPC1cTm8B2y2QRqok8k6TJW42Ai3GSukAHf
 Fv7koOPWK9B4YQ5IB0P7cN5GIlMr/KLo3fE/4AlMSwOMtzINLwCgQnLYGf/QhHyZD7WTANClLdH
 HwnWLux3Qa6D5hcdZ5XvgvEPJwSchPuGsqfboc3NUMQTQOmDox34=
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
 drivers/tty/serdev/serdev-ttyport.c |  84 ++++++++++++++++--
 include/linux/serdev.h              |   8 +-
 rust/kernel/serdev.rs               | 167 ++++++++++++------------------------
 4 files changed, 188 insertions(+), 125 deletions(-)
---
base-commit: ec8bf8280261294a9b9b4520414b42704c7f9f6b
change-id: 20260905-rust_serdev_probe_refactor-0e2b044354a7

