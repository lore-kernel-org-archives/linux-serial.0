Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039F3783D5;
	Sat, 30 May 2026 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780181470; cv=none; b=kngX+m2EdbHhZZi8akSbhOUg0BaGx8dp+o6iW0TYISWkTa7tABV5kjNLfa9/8mS+/OwPN9/Z+Ev2vEr91PxjknyLU0wCG0T5sjvDW4znkJoMpI5C8prebZYRtzmsDCR32saDkXEceghGmQ7dK/2X+yMUmYO3ffsD5nxpMiwpuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780181470; c=relaxed/simple;
	bh=i6yyE0Dn4THGDheAsQuCbxaViLFW1ARK5q9G8YpPkPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDgYqpHLGeDQoXVww2DwXhkusuIdvYI66FEAnzVLxpeBnSOWRxa2xyjv7hzFcnTb3B6c0RJRujTqkkbFeMQs/pX6+v+0EL8lL4qCWHktamX2eIsjkV817GITYFu7qEQ+23FtNhJouVx7nyCZ7UTW5qV968Ybr03MU6zR8SAMeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFKmA6rA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFKmA6rA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B742DC2BCFA;
	Sat, 30 May 2026 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780181469;
	bh=i6yyE0Dn4THGDheAsQuCbxaViLFW1ARK5q9G8YpPkPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nFKmA6rAjR15/tRMR7MADMExTSuXoW/PA9Zt7Xmiz+9KW0Q6VV4kBw4HOzfNBfVc3
	 wumF+NlPm8aP29fp15Iy65Vym79Nn4n+KdhE0N+Pquduxi1Ihf/XR8ISI4JeWeYcuY
	 5jH13GAyIqLlGlINM3/nuJlEDCTMq5dQ+Kd4A1dxv+1Q4yx7+pGioJzGUBEdfuL3GV
	 baC77KGh4O/Z8aW0HpsXclgUjThNOVaN0TlFvzs4FFKJd45+8CJ0IxR4rV2QtvQBXh
	 qCbQm/jIwkztN42YHED8C9X5yi2KDI96oQp9/zMphVytDnu7DHWjzegIHkkl4Jh4HQ
	 +d7RK4TiwspMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C6ECD6E57;
	Sat, 30 May 2026 22:51:09 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Sun, 31 May 2026 00:51:04 +0200
Subject: [PATCH v11 3/3] MAINTAINERS: serdev: Add self for serdev
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-rust_serdev-v11-3-dee8e0d830f1@posteo.de>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
In-Reply-To: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=838;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=P+qqzzRwhI8B2ZhOfr+PVqRWtfVtS9KesBahL8YX4uk=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqG2nbZIg0nXhOycM/1qybSufuCsXWEmdoGQwRe
 cG7GjM6MOWJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCahtp2xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Jy6hAAiPX7RzBxIe3kQ7rF3al/RzJ7ngkNM28
 6zXck0BQMCPs8ApVlkbY/dqKBKelAdDIS5r96upET5eyQy9r8vuQQ3IfProVEJIkbrAoBB/mX+N
 DPL24f5PEBGFj1zu99egO+BKwOGaqv++BJKBpLci0U/nIaOe+zLBX//YodFKB5IeZ4kNekSMWed
 lGlOvGis5lpy10jZt0RdGxijScEt2HrEZiYzXvygwCni3gQBaMdebiUoIHhSLVfBPoiEKDkdRJw
 Usm9GSTDkg4uf5NJ8SWHc5bvGshbLcvwBe17UqXV4MC08uxgwHFPw0WkgpkOF68DSEFk8H40N63
 k7KOt7CrvCIAspifnCzyWz8bTp5ekTdrZxlcxoebQnnw+S2ne5jLTfT7IuxRVyrO3kGL5ToNla0
 qY2BoivjUoj1UG3ajU+klgwpGqn5kKutwgC1xufuX3FZMO7NYPbL0hBwCRkHXld6At/mK+7L1fj
 X8iWAriY+JwXr1+4wntj2CEbppcmCJ0oHoVLGtEDYbXEdo/3qCAOXoiGwoHwCMLsQGIkRBCzFjh
 kaHVX/gawwiTBqYN7Tr5cLGk4CZpvViq4sfHnnsle4kPSxKFLmQeJzT0gRozrOzbJ+9NFf6XtrM
 87s9s70UVl5vWUhK/gDW7iT2o8qK59s4SKm2Ek11qomPYj5Xgr60=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
Reply-To: markus.probst@posteo.de

From: Markus Probst <markus.probst@posteo.de>

Rob mentioned he needs to find someone else to maintain serdev.

Link: https://lore.kernel.org/rust-for-linux/20260430195858.GA1650658-robh@kernel.org/
Link: https://lore.kernel.org/rust-for-linux/da85ceb81f51079d4a8248a1ffde6a27d2ef24ad.camel@posteo.de/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa3f20f0cc4f..58db6aedf45a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24270,7 +24270,7 @@ F:	drivers/iio/chemical/sps30_i2c.c
 F:	drivers/iio/chemical/sps30_serial.c
 
 SERIAL DEVICE BUS
-M:	Rob Herring <robh@kernel.org>
+M:	Markus Probst <markus.probst@posteo.de>
 L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/serial.yaml

-- 
2.53.0


