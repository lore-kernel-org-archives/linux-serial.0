Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58E3783B5
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710138; cv=none; b=ERpFlQrTZ29a3otbQoFadYEqlZQ5tJ+W5VofQR3Fuy49HnJAsL1F+zJnvvab1R8q2vkiFfOANtGoBCuZ5Bc0jbVDoKZHhb0ACPDdhEdZ7ZWtlM6HejXTIcVaeZJUAqSQchCuCsJt7ikeP/CnIU9yNHnrQQ5kso0hWjpPAQa3GvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710138; c=relaxed/simple;
	bh=IUT9wQKJhYMYNpvwzp523KgdDxKg/ILAJMoXUNXABsg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m1kXf2wDuC46zkMeAOZh8H2KYnKV4AvsBhu1V5vkHquR1z8ryRpDFgpUISyvvQwiMb4laZa0/ttaLYq5MhDZ3t8gRoxz3bVIvCXD33IB2Z8QVomJ5ff8ZsjTCj3KxZunTi3i2L+v65M7IAM+vm5ekg3FyObKtYlnJWMnjkE2u/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=k6hQj54U; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="k6hQj54U"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C593F240028
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 17:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788710128;
	bh=jwpkQyFqnars/Ss4HKKXX19eAFdRFeFAU5evcC6HTRE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=k6hQj54Uf7TKfLuZu1KE1gJYHZCSNjvCVS0pDi4Yf/WOHfm9D6gdOiL1+OV4XAPNP
	 unQgNy5K30u7xHOhGyVVYHmu8cqKstsOnF+7Ub2buq7OXjLQDlAw/3yo31MM5qlhTV
	 xUP+scp4aQjI/YE1fGVBd3wFDDJ5SbT38diQCNAEyUpSTA2Q2ZDg6C6sbH/dXSc3kY
	 VpVYwY3aUbnzFyF7MXe+y79QPXoJPu9lkircVfa2Vz43TnosNEEeRqAtfuD+BHGAvg
	 NmFpMIQb+9itOyvmGGXhsmhy9KC6LhhTn6HyXRvVHWywg5oAQV7WV7QFZbCeYtkdy2
	 ek1yMzp87zK8Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hdFCb1PyYz6tsg;
	Sun,  6 Sep 2026 17:55:23 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH 0/5] rust: serdev: Refactor
Date: Sun, 06 Sep 2026 15:55:25 +0000
Message-Id: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NUQ6DIBBEr0L2uzSIWFOv0hgCuG1pouiCpInx7
 qW1ny8z82aDiOQxQsc2IMw++jAVqE4M3NNMD+R+KAxSyIu4iobTGpMuowGznilY1IR341IgLlB
 aoVTdKNNCEcwl8e+f/NYfHFf7Qpe+xn+DcFnLazpqYE1E7sI4+tSx3J5rTq6Cft8/wRXhYaoAA
 AA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=IUT9wQKJhYMYNpvwzp523KgdDxKg/ILAJMoXUNXABsg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnYzpM1kWcej/BXrRcE0gPTEJK6GoWxaNk0+O8
 lFpr00wIqSJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCap2M6RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KQfQ//QwfYYqEIif7p6eWR56NPMqWqqCOFwqV
 ufBUpN4JAkpIsBkP9ux37sRPtHcUxm8vXfDxwMKJezn0o0Uc5PCWE1CkO8OoFTnO2mPMeoVxgxu
 xGu7Qt+h9hBk5jwMcsLvI9rcQJ46U4nZ6o1sQL+9BZmRqLJA6pWLrP8lHVza+TwqGpbVY3XRSrX
 6t3ZvrYcNL6UUwmfa8Mcs7E7MG1MJ0HqaykPbUcpRAwK0UcfYDL5wBZNpqWvgDCDgXMitGke6gm
 cPfGOgeFC/B83PRTx+eGI4pvTKQn0jeoeKKCO3OL9ZEFa4f+wFqp0+aCup1akDcGfqjSqxbIApt
 ueNLOxcpjeRnX7VcsoewlPMFJgls2GDTOABKkKTPGYiyQemQJ5yDIdtykNZZDuAZl2vtYS6EGoq
 4F10NdQH0A/3E2lKeUgyn4TQnNqTBNTjbFn07Fu52aprzKZfI4KlrHGmjzWrbYcVAY5xC3T/tov
 lvr4h/lMEwGQsC4nRRzxJYwfoe9zee3QZ3M7A2sD7/5XQAVdfRCEztSVfaFuk87rNTqXsRB2jzg
 AFVmKZeN1WC6j35kpnqrPsaz9cArKS+KJRZbsz7ug2RA4sdYryi/3sQfEyAqWCjCWzsNvl+1T5H
 x2/qET3mKDGpu2/chhxA9sTpS27og9XGl7NpINo0jLYLweKi7r7A=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

The following has been changed:
- introduce a new C serdev API to fix race conditions and simplify rust
  code. Should also be useful on the C side.
- fix race conditions
- simplify rust code
- add rust function to provide mutable references to driver's private
  data
- provide mutable references in callbacks to avoid the need for a
  SpinLock in the greybus patch series [1]

[1]
https://lore.kernel.org/rust-for-linux/20260827-gb-uart-transport-v2-7-a03bb1f5fbd1@beagleboard.org/

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Markus Probst (5):
      tty: serdev: Export functions to pause receive_buf callback calls
      rust: serdev: Replace `active` mutex with receive pause
      rust: serdev: Simplify callbacks
      rust: Add `Device::drvdata_borrow_mut`
      rust: serdev: Pause receive callback before calling unbind

 drivers/tty/serdev/core.c           |  50 +++++++++-
 drivers/tty/serdev/serdev-ttyport.c |  32 ++++++
 include/linux/serdev.h              |   6 ++
 rust/kernel/device.rs               |  24 +++++
 rust/kernel/serdev.rs               | 189 +++++++++++++-----------------------
 samples/rust/rust_driver_serdev.rs  |   2 +-
 6 files changed, 180 insertions(+), 123 deletions(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260905-rust_serdev_probe_refactor-0e2b044354a7

