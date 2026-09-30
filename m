Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB64521200
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789551; cv=none; b=Dd4F5DvTWF29fI1CBaUVd/zHm6Oj7oX2l7B/k93J+Lc+NumboBv464fn0/oUVTgcS48O+sRE0Hhfd6d84p+ISPshp6lu2bjcibcNKCU07ABCsWMt5+0xdQl0ELloP0DEXS6BCbKDbqS21Q57RMO1kP1uuM1gjUUSQndW4WWjWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789551; c=relaxed/simple;
	bh=ocxkrVXBALWT/Mvum2xc+qBbFN29pgyyDjWxXSVPDLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V8ttnWh3FywtvzuT+vPRqfaEh8YVFPtUCB1KXTwgvhfIacvMAQwHsjNv5fEdFIU5SF6aD7qs/pdTSJsK3dZdG7hLnFxFMMT24QsY7HI9yOh4pskoquUuM5IGDUczgxKvUL2MQG5rLZf6VFVlkC/xQh+ydtyLjCzrlg1zbPryGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=csBAb2Z2; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="csBAb2Z2"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CFA19240107
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 19:32:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790789546;
	bh=3005sGFVDNO/bvbLNOBBEpqWdrYQtVPFlOxulGAOHEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=csBAb2Z29iNxLcJxNXeekOtcMS37I280b38JTzjHWCNaiduJfyy9siOVC0w5Zrp0Q
	 mhVEgtGGcSIChbRrUs7/XnUb7eaw0KJwn9wwfVvw0exmBgHqrp5W2a6jtVZyeoCMQQ
	 O6zkrgeoMNivVnvKvX4rELz9UvV9CuD5tODUpU1hnrQfuo2CiNalpPApAL//Tv73jA
	 GMmmFeh6U0nN6189WTf9buu3aClPX5/YwTMF2+2C80Y7jpdxa6zXsTtsMrKR9kok44
	 unHfngMjRKkAs4o2aSZMlcfbP61VvGp0bCp62fw1o2uph6B4P71aQkAIq9c9MwP6CQ
	 cGMRvDN3tE3sA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hw2DQ12dLz9rxM;
	Wed, 30 Sep 2026 19:32:21 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v3 0/4] rust: serdev: Refactor
Date: Wed, 30 Sep 2026 17:32:25 +0000
Message-Id: <20260930-rust_serdev_probe_refactor-v3-0-d1b6e77135e0@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OTQ6CMBSEr0K6tuRRWlBX3sMY0p+n1kSLbWk0h
 LtbwIUrl5OZ+WZGEtBbDGRfjMRjssG6Rxb1piD6Kh8XpNZkTRiwBnYgqB9C7HLJYOp67xR2Hs9
 SR+cpIFPAeS24bEkG9NmxrwV+PK06DOqGOs7Eb8Ljc8ircY0RJQNS7e53G/dFasuaei3I3L7ak
 Efey9NULeHvqebfqVRRoM1OG4kALUd96F2I6EqDCzaxHxSDvyiWUbxWWyGqhp2F+UVN0/QB/WT
 Uzk0BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=ocxkrVXBALWT/Mvum2xc+qBbFN29pgyyDjWxXSVPDLE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqvUelZ+KvdynNzUumA0rA3Q2C0KtOTMXd6hQLV
 n7aoBoVh5SJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCar1HpRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JxqQ/+I1uK7ZVlFfc8QShrpchTKSwadrPt0cn
 xXLqDhzxFT7nILlQWpvzCPJfGr1+IRACTC4BqpSuQ5+rRukK0fN87ib4qvfk47pKH6/63zXNWZP
 pdGf9xrjlHqMbk9zeLM/ubykphN+jVkEy8i2oFZHlzG4El3eUBCZUwH3xZ0CGzwGCwAIvzO4tQB
 BHt9NDlC3OWSYhSx2kFYH9tHxRiirNiIeq8oqpZuI9RVHl9syIhwRxAUGGOVtsdUn/X33Glk3KQ
 1N7qv9J3oH7Mx7FVAyiQqzsF+gR6h/YMGnMWsRlyAtC84oFalA1mefd9DCRzRFctC1f7PsVgiBa
 w6K+SvEmpB5ncDsDr8zVakmqMkFrZzwWamPhEE0RGIcRLTx/2rO09NYwy4uYYBjx1HOpYbiXLr7
 5Hmnwb2GzfllyagUK34kIe2q2jYuAZOttdMGo7Sf1dVNsTEv+vLftSjgrCwO6x4xQIDfoR0W5GE
 6bQVjw3r8ZjBqvAZhF5Gj57vnaIYUmSKZoRrjyR7IlY6Thw+0T7/SKqFotygADsP6hgr7f8ii+O
 /3dUCIh1Yk1snn5g9ZIpsOq8qwFd/py/nYg1Pw6J/QqdNlgLc8hhym1iWnYBXNwqbylhb7Cnh+5
 XNXPz2bHSQLBa1C86QKuDkYxylClaJAVEKzZ55s+g0sWm/sg0vR0=
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
 drivers/tty/serdev/serdev-ttyport.c |  68 +++++++++++++--
 include/linux/serdev.h              |   8 +-
 rust/kernel/serdev.rs               | 167 ++++++++++++------------------------
 4 files changed, 173 insertions(+), 124 deletions(-)
---
base-commit: 5a956dde5526a634dca7ccad27c051ebcc306089
change-id: 20260905-rust_serdev_probe_refactor-0e2b044354a7

