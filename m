Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888944;
	b=t1fqSXn6TGmGoV07G/444uqBjBSrk1lNTfZh3oLSgomcLjqhyHLU6YMRb4qYZvTj8AFF
	 L8U8h5BRFnUFv7qcNMIccj4bicRQ3THn+CcY0fWmJ2AGpMJbjX2xxescBEG/xbX8sMthq
	 XroXvQ2q+Pib6W5j3iA4xt6oCePbIh8IXJMgzxvOEi6L4gc/wgGNj7GK3aexQ2I9/ful9
	 DrhnYNIa+b2z2O43VzUQRhc+NTCmUh1itri/aZCR2wVUcIGYzZ67+D+iKeQX3zBcexNu8
	 /KqCF1AmP/zQUsLrdFS6SMN7xDyR7T1wJJx+X9nVtl4NF3H3XeAUFAVBZjCtK3+MICQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888944;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=SB060tm94ok1G3ZrAKChHc1CAPBDl1EJH81JADMrd2I=;
	b=CF65X+dwxo3eXLmN7mVfE1FG5F6xGcON6CH8r+O0ioZzqHdXCe5UfPQYUzlByt4OZMR9
	 /7zmpT4DjIe/xmxH+PJ1pvXHvsFTzYxD3d9YqqfkgwbKjvh/sQEnk8f523r8npFUJkxOy
	 nMnNVBVi6qC+5hz7ydKbi7Mmbb/Ux/OX1ZIM09hVY5CsXoGsaxXdDBQ5FdnuwJZB9faOK
	 O+C9h0G43t7Gtr0lHbolCwsfaBHl7DnWpUNDhn+siyL9fRF6uwtTUj7X3N/j1MfJqyMyb
	 KQFH/hLNbvelOK3Ck9Y32OKHjxcAh0IXLbR4lE0TM1V2Wxfm9j4mdRjJ0Ksj3mregkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXjKTJio;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E2606A332;
	Thu,  5 Nov 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXjKTJio
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793888944;
	b=xkBMd7s8yjCUyUiRj/tQmEl5Rn3yc/umB2DQZu+TGKBgp0FCBhr8Sb1wkI2qkvFu4Yys
	 rumZvaPDBPvjze0o2HfUB6wqSHlGHk9xVFw2r1q3ZOeJSN/minFTZkgNsHWudp03Eg4Ow
	 rAqkA9MGv9XWuihBv3pYbRvSxcHyn89BIkCU33o+rDGvVBCBveiKdME2W6pmiG9HsylLc
	 Cy4TeJcffSd+W1dVsxn6+GjrMuCmYsgYKHAxBsRaaTUYnUIqFr4Bwjzn5zGc48BbWG2TX
	 0lOIADd7TDUOZC3KWRHZumLChvW9w7dd7Ki0JXNlu4csiB6KO1m4pJtJWdpjX7HwdZg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793888944;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=SB060tm94ok1G3ZrAKChHc1CAPBDl1EJH81JADMrd2I=;
	b=Xl93jVLs+F3yt1b/oM3DoufmRvrFIxS4V5rUXcbwZhr7tWRiU0O9KAWWpEqyG2IEWXt3
	 zzCvtCf25y4FjW8XIalSNWotmQagdV0pXM6VTwsxJZvjX5krBArWVvJRb8teAKsAlXaKo
	 D833bCUoJfaF/sDFlsaOL+CHBJGkN4aAcob4lgIcxLmc2zcI8hPrK+cDAMVaFpdPUCZ9j
	 uDDJ/OQn7KOjcETWscBeIbCiobgZs1dt8ew1YmHFafLptKj8A88h1wJSZCFbiGo5DcLug
	 eECXIbog00/XdoIGO7rKiapOPlcEjJ5618KkfmrS2uGFbv3iFdVJAHX6wU1MNXUmyGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B01621F00919;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888944;
	bh=SB060tm94ok1G3ZrAKChHc1CAPBDl1EJH81JADMrd2I=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=QXjKTJiowPoq09eaNbrqnkXtMkwV6FoFRtLqimoJKlru0kwtSJknSwMGTn4juhh9w
	 poEBu9KanHg9Lv0DzDwAIc0r7rAtChWC6WEpsLmuK3mFNaYbrjLAbKSjX/BYkx/TNO
	 vgFZMs6y1tf7IKjRLq+7BalJfGSf9E46WbU/u1XQwwqC0zPs4aw7528eYkf/85FUKo
	 G70C3bvwyGmYy/fz/QaCoWlpE8I0O5FNaluWbRWAvPTAXnfBJ8jPrv65EjQPuCalLF
	 oE+D74iySop2o3WNnDNVWAkYiV2ttuUukA1CN7rSyVJkmhxOcpdwYTExZTyiSwdLDD
	 wOV6VTQhDL7Mg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 12F16472B5;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Subject: [PATCH v2 0/6] arm64: Initial support for MediaTek MT8163 SoC
Date: Thu, 05 Nov 2026 14:28:45 +0000
Message-Id: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6CMBBFr0K6dgwttaAr72FYlDLIKLSkLURDu
 LuA8QAuX/Ly359ZQE8Y2CWZmceJAjm7gjgkzLTa3hGoXpmJVCie8gK075UEshRJdxDGYXA+QuM
 89FiTjviEPhZcZRCcAdSnopa5qXKt2bo5eGzotfdu5ZfDWD3QxC2yGS2F6Px7PzTxzfu1z3+2J
 w4pNEIqUYlayCy/Dt5FZ3tN3dG0rFyW5QMb3audAAEAAA==
X-Change-ID: 20261018-arm64-initial-support-for-mediatek-mt8163-soc-ea58d47cb7aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793888941; l=2514;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=xYWhJdUiyf1YSsJbWggMRSuD7a4P0ZPx+YpqCfYj/AY=;
 b=Dy4ilgGz6/7wDjsLtjtacc2scZ/XdEP0ABXqQCC9jkR0mpFWmP8b6bmM9RLffsp3svumiHFGf
 Ghhl5a20pe6AQ89y1ZmLn6kM/xtS8cAla+R/oWBuHNoLd9NrRLE9Scj
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

This series adds basic support for the MediaTek MT8163 SoC.

The MT8163 is a 64-bit SoC featuring four ARM Cortex-A53 cores,
typically found in entry-level tablets and smart displays, such as
the Amazon Echo and Fire HD devices.

The bindings and SoC dtsi added here, together with the already applied
watchdog support, are enough to boot the 2016 Amazon Echo Dot (biscuit)
to a shell over UART0.

This series requires custom TF-A, U-Boot and OP-TEE ports for MT8163.
The stock vendor firmware does not provide a usable PSCI implementation
(the vendor kernel brings up secondary CPUs with a custom "mt-boot"
enable-method instead), and these ports also define the reserved memory
layout used by the board dts:
 - TF-A: https://github.com/iara-linux/arm-trusted-firmware
 - U-Boot: https://github.com/iara-linux/u-boot
 - OP-TEE: https://github.com/iara-linux/optee_os

This is the first of several series. Support for the remaining
peripherals will follow, starting with the clock controllers, pinctrl
and power domains.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
Changes in v2:
- Dropped WDT patches as they have been applied [1].
- Picked up latest tags from v1.
- Link to v1: https://patch.msgid.link/20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch

[1] https://lore.kernel.org/all/589d0ab4-46cf-4b8d-b4b3-5519dbf030ea@roeck-us.net/

---
Ben Grisdale (6):
      dt-bindings: arm: mediatek: Add MT8163 Amazon Echo Dot (2016)
      dt-bindings: interrupt-controller: mediatek,mt6577-sysirq: Add MT8163
      dt-bindings: timer: mediatek,timer: Add MT8163
      dt-bindings: serial: mediatek,uart: Add MT8163
      arm64: dts: mediatek: Add basic support for MT8163 SoC
      arm64: dts: mediatek: Add Amazon Echo Dot (2016)

 .../devicetree/bindings/arm/mediatek.yaml          |   4 +
 .../mediatek,mt6577-sysirq.yaml                    |   1 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../devicetree/bindings/timer/mediatek,timer.yaml  |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 .../boot/dts/mediatek/mt8163-amazon-biscuit.dts    |  68 ++++++
 arch/arm64/boot/dts/mediatek/mt8163.dtsi           | 243 +++++++++++++++++++++
 7 files changed, 319 insertions(+)
---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261018-arm64-initial-support-for-mediatek-mt8163-soc-ea58d47cb7aa

Best regards,
--  
Ben Grisdale <bengris32@protonmail.ch>


