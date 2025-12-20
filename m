Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC82C21DF
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256676; cv=none; b=kwBsNsjZQ//RBa2vkTK+4pK08uMUM/QVDMb7EDHYWPLRY4BT2DnYBGUOr6DkmI/PFdgmO1O+YYZGmcSjo7Cw8BHBfWkFyBW13EwkXmGGnCEJBHlwO64Wl9XvnvRSX+3Nw75yrcWNSP63iWsMViqiOe0lYqHY15WNI6G/2gP0N1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256676; c=relaxed/simple;
	bh=pO7lViA3UDqU2ILirSuthRDId2PL04Tut6ezCFqQmfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PPV3K+PHEob4J9JAIJ5wiQcu7j9IMIvvbtttTpEsakS6IcnDFjUx31kqcYlFx9fPILdVL4q4aDy2qwHJVIqP+cCwQFDFV7bhcZX1VSH3AIBhmMqvbMJjgrkf137ekjv7kh/a3OoQDNEC5ry5fy689561/FNpZ78Ga3sco7FPylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=LRRXLr6f; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="LRRXLr6f"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 152EE240103
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 19:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766256245; bh=eZtWdwMAYdMMyN2pI2nGm0zkxekdGtYyqGRCJ+suVXM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=LRRXLr6f4oKXZ7zutGAb0kG9Ca66EpoKrBxb80wP8F7DYq1PNUpbgNUK4ax+LeNky
	 skizUQbgB1mvXmqQqXYra9/fE4RuABSElYX7K37QdV8WTEZVkiiCPxajDZOCMqD1nQ
	 28tLyK9cQx799XOMNElcqXwlVFHhMfOAhN6KGceun4FTRSpvMPaehpAksuX76lI2gw
	 /FjeIYBZjtlKE8hVzEta584V7Ehgsn2thMTKthzudJ60pD3G7VWH0NlR2cRL9JHAHT
	 hS+VNaL+vGJQnXYOXb+nfGjEfDFVG8hXyhJpGBy8uOVHeV2NvUu4XK1TLWfiFTmJDT
	 5/IwnyXHfPpWw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dYYGC06Kjz9rxD;
	Sat, 20 Dec 2025 19:44:02 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH RFC 0/4] rust: add basic serial device bus abstractions
Date: Sat, 20 Dec 2025 18:44:04 +0000
Message-Id: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOrsRmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Nz3aLS4pJ4oKaU1DLd1FRTEwvDVEsDC9NkJaCOgqLUtMwKsGnRSkF
 uzkqxtbUA6cC9x2IAAAA=
X-Change-ID: 20251217-rust_serdev-ee5481e9085c
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=pO7lViA3UDqU2ILirSuthRDId2PL04Tut6ezCFqQmfg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBpRu5yL92yCERDUu536klRA9vDxg2kaC5MPvdCs
 kn9rrIpdmWJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaUbuchsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9LeuhAAp1tHm7+b6X0xgPBtoQMokFinU3qyOnh
 QB29fS6WSTAl6fc+52uNbHARLIvmldOFvm+/0d6cjpbTTHURjZVMCvtyuSf66Wp0onQUQo0wO0M
 F9XA+BmwprjwyQhgN4FUrjUAgzwYZxXPTR5XxhryOGZ2Q5jwoPfNWC19arih0TFhEVBhaEvra+b
 Ees/jOt+4KVr9Xfq2nSKymZ0MSFutqx7JmAODAP2ze/mh0ZPBwQWp0QwprdNNlqNLTqo7AH+tLE
 tWy9oSITvCZfzTp7V372kHCZw4xKKNiG0qWKnI8N0OHArVyFQDa8EA+MY4IQHO2U0Sk1ELDfDDT
 s0fJXPCn1WmLg/Hhqu5ulGy8OWXjjrX2aBD4lmGrl7/Q0l5PGIKP5ZDGbhKi0AhKbULmLoi5Jg3
 FKbjg8hoYj6xlDGmdMyOuAwTsFpHnfhReK0D5UrfSt2M3ZCGZlXAOrk+cnJX4r7ZAesqdWIP4v3
 g2M1N7ZWkIPVHqOKw431asG+iRHP4ZtejUTe4JaA0nnq1Y/taMMvB6Wpr/JLEfWCevUpddoVEB7
 hvqLsYvtChRLHXEVGe2SmALPYBMLawHEiDezpgbqe7uB0EoLKwnInK49qQn/xu0awNl6Kq63vhz
 9EQmQT3cqjY2IYURFWoDNT29l4gwGOjzXpDABYMIPR92Cp+z3bos=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

This patch series adds the serdev device bus rust abstraction into the
kernel.

This abstraction will be used by a driver I am currently working on,
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
Kari Argillander (1):
      serdev: Export internal is_serdev_device() for drivers

Markus Probst (3):
      rust: add basic serial device bus abstractions
      samples: rust: add Rust serial device bus sample device driver
      rust: Add serdev rust abstractions to MAINTAINERS file

 MAINTAINERS                        |   3 +
 drivers/tty/serdev/core.c          |   3 +-
 include/linux/serdev.h             |   2 +
 rust/bindings/bindings_helper.h    |   1 +
 rust/helpers/helpers.c             |   1 +
 rust/helpers/serdev.c              |  22 +
 rust/kernel/lib.rs                 |   2 +
 rust/kernel/serdev.rs              | 815 +++++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig               |  10 +
 samples/rust/Makefile              |   1 +
 samples/rust/rust_driver_serdev.rs | 175 ++++++++
 11 files changed, 1034 insertions(+), 1 deletion(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251217-rust_serdev-ee5481e9085c

