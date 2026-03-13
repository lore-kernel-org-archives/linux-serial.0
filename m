Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734F3DCD93
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425557; cv=none; b=SlQlI1hYF9Ihzy8MVeKhhBkEKtTxt+o/EVOJcc73Ws0G/AkHq3kyXteoIgWf1SbfJQLGEnx3p0VX6zsrZvHN8Pq6OIm9I36W+fJw/F06XtuT/UBo1h1kus+KgSfBSlvyP+2CgailqhNsILiK5zp7jn5wlfQok4W6cji/SvMe+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425557; c=relaxed/simple;
	bh=nhzCKHcpSQOEzqoUhprA9k7Hu+jE/8eApFY1eIPTW04=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bG5p8vOGc73t5uaptwN/iqyNPvIiS0gk4NC3EDEuk2AAH6rUwlVkOPpZR2GHR9OL+Oo6hcxlRYm5j3b2YaZpn5DAI8Q/1zJ9W4TeETDtjkv+LNDb4my3I1sQRzFSHcXnWD78OBoTSMx63J/HvgPlUszcYJcV7eRGbRIqHilk+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=oPres7mu; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="oPres7mu"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 78282240029
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 19:12:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1773425548; bh=oP1CwqkAzPip8KPnsHIuwNOs+ExBzvZniOq/Ft8GfNI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=oPres7muxfKgHkLoJKVK63A39hZGGygi5uuWSFBvf5SxSn3MPn8DLzcF0hfwxZvoZ
	 oq0WlI2jpTJ8N9qFvNzM+7Tgx6QVlFcEURamIkGIhCcwiaO+6nPuPN2f85b2YeNgnO
	 2KZ+m7muoxLXK6Fb3jpxIK4iQjV8bLuzXwUnOwFGt07Erdtpc8FLiYXq8aj3EyzgG9
	 ZPqOz4XIUeW2T9EqZl9ls23g3Zz+IjpUQT7b7X4CSZnmNW3Wawe+WqfVphkHrslEhq
	 0ClK0OyrCswmxYDtxVK8TcJZzCTczV8aBB0ygEXi2pncrcslxTyzmbdqKKiZiTpTqX
	 c88F5T0crqg4g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fXXdN4yr5z6txb;
	Fri, 13 Mar 2026 19:12:24 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v3 0/4] rust: add basic serial device bus abstractions
Date: Fri, 13 Mar 2026 18:12:27 +0000
Message-Id: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG9TtGkC/1XMSw6CMBSF4a2QO7amvX0BI/dhjBG4SieUtNhoC
 Hu3EE1keE7y/TNECo4i1MUMgZKLzg95yEMBbX8bHsRclzcgRy1QWBaecbpm1FFiRFqVgipe6ha
 yGAPd3WurnS959y5OPry3eBLr++0g33WSYJyRUkZpa6xBcRp9nMgfO4K1k/BnDZfc7C2utmpQN
 gob1PrfLsvyAVQlkmfiAAAA
X-Change-ID: 20251217-rust_serdev-ee5481e9085c
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2932;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=nhzCKHcpSQOEzqoUhprA9k7Hu+jE/8eApFY1eIPTW04=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBptFN6g+aGMPfixr0XlcGVBcwNy4Px4KRsaJTEd
 y5+CVZ53IeJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCabRTehsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9J54A//SNYv1EpOne/57kO88w2ksXoyXY7kXkV
 Cbcc0EWbCMlSTYBx5ykIKtal9EW5qNYyZlI2D4l4JePfwwDcMQd0a92N5w1AJScLHpmYVmATcjb
 zv6O4ICOe3+IeH4XCgOeeav2/QlvvrBUTdw1W4st49/AJlbfoh6trp5C+PjtsIxwGPVGc2iiOzM
 YuSq4Bz35DzWCaxLTcbkv638fz+Jho95OXKNDlu8IT7NFmnc/nTo2aBLkhPIq9WqZFxldwPe/Rb
 IdMA6Du9fTa0xqMcX6bXZWaiG5azCODp8T+EKv8np7gYqT0n556lKsKGy0GaVtjA2m73huEm6eU
 fncI10o2p8MGi1YlhRFV5pD52BXpzwi3Q/HfZwHi0ypKxeM82vDlqyZVWyXESPBycIzkC2Mql+Y
 YK5lQi7B/0AA8rJp+w2md0yIx+1GcxrmqrMbbvjksY0ccZMqClfZWobWPq0lgpsB1G5z1Ta4obd
 FcbMPk9pQzI5rcH4ucD9Hm+CPsEfLoDZxtWEsg9SJsNKbLvW9P77p5emtyPB8Pf7yb7eHin8guL
 j9C719KgHJD+MB6yC9HFKNrA7sA5kLH6PWej0Rm3ZPzkOApB9mEzzFqtzxOsdvHd/u3DG7kO7fK
 PP6cBdVc82/KjwcFIIuWWta9gLQiFN5HrTZw6yh7ZXEk7Mx7tsEQ=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

This patch series adds the serdev device bus rust abstraction into the
kernel.

This abstraction will be used by a driver,
which targets the MCU devices in Synology devices.

Kari Argillander also messaged me, stating that he wants to write a
watchdog driver with this abstraction (needing initial device data).

@Rob: Are you willing to maintain these rust abstractions yourself,
as you are the expert on this subsystem, otherwise I would take care of
it with a "SERIAL DEVICE BUS [RUST]" section in the MAINTAINERS file. In
the second case, I assume you are going to pick those patches as-is into
your tree, after they have been reviewed?

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v3:
- fix vertical import style
- add Kconfig entry for the rust abstraction
- fix documentation in include/linux/serdev.h
- rename private_data to rust_private_data
- fix `complete_all` <-> `wait_for_completion` typo
- move drvdata_borrow call after the completion
- Link to v2: https://lore.kernel.org/r/20260306-rust_serdev-v2-0-e9b23b42b255@posteo.de

Changes in v2:
- fix documentation in `serdev::Driver::write` and
  `serdev::Driver::write_all`
- remove use of `dev_info` in probe from the sample
- remove `properties_parse` from the sample
- add optional `baudrate` property to the sample
- remove 1. patch
- remove `TryFrom<&device::Device<Ctx>> for &serdev::Device<Ctx>`
  implementation
- fix import style
- add patch to return reference in `devres::register` to fix safety
  issue
- add patch to add private data to serdev_device, to fix
  `Device.drvdata()` from failing
- simplify abstraction by removing ability to receive the initial
  transmission. It may be added later in a separate patch series if
  needed.
- Link to v1: https://lore.kernel.org/r/20251220-rust_serdev-v1-0-e44645767621@posteo.de

---
Markus Probst (4):
      rust: devres: return reference in `devres::register`
      serdev: add rust private data to serdev_device
      rust: add basic serial device bus abstractions
      samples: rust: add Rust serial device bus sample device driver

 drivers/tty/serdev/Kconfig         |   7 +
 include/linux/serdev.h             |  15 +-
 rust/bindings/bindings_helper.h    |   1 +
 rust/helpers/helpers.c             |   1 +
 rust/helpers/serdev.c              |  22 ++
 rust/kernel/cpufreq.rs             |   3 +-
 rust/kernel/devres.rs              |  15 +-
 rust/kernel/drm/driver.rs          |   3 +-
 rust/kernel/lib.rs                 |   2 +
 rust/kernel/serdev.rs              | 536 +++++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig               |  11 +
 samples/rust/Makefile              |   1 +
 samples/rust/rust_driver_serdev.rs |  86 ++++++
 13 files changed, 693 insertions(+), 10 deletions(-)
---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20251217-rust_serdev-ee5481e9085c

