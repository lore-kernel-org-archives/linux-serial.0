Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794906699;
	b=B4NYFWN6+QV9udrUvnWtLQGKtNOnxyPImb/nz74m9rKNQSM7AE2A6QwUOa7qpEZ9MDcS
	 hJkNp6yij1P/iY9nPhTPmGEQbu7KNVCkK0y1yxfj1Y6cjZB1vCxDykpw0CBM4eGjem5pl
	 BKdzMUBg8M2iz3edyeaEv9yhFKyY9+OEAUVTpYv34NUxwYpo4uwC2AVxq4nF1MJdkm/Jl
	 ZZ156XeMywJlqjh/Q/bIgW75cIBD5q4f2BML1e2KD3Bgn21ssIrZRR2WyEjhk0JnfWnkn
	 4KrqO7LY+qWRsfNT2zR3i3DYry0Z/sj6mCYNxwKELvLdQ5WfcY5Z1Up0NEC9bARhJPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906699;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=lytm7i4O0+WOrTTYwyW/3THQkYm2q9/u/GLtALBGpqE=;
	b=ygNJaUuqZTRAEaohnCi//P+LCA8T02wjkz9EvrSTkl8slqueIpt3WTwtNDmjXn9r1Bp4
	 S++jHDKtDnA10ka49q685JT43Lxn+Zhyv0VODajO/wqUgHq2W4JoKeGYQ/HNV5PV4VYym
	 J8BbDkUhZAp525JRfST+T1FN0in6Q38LfSSh0FJ/fD2Ur/xlj16SfSHGf7LQlUMmrCT13
	 m9ikGla0qQMlRWLragN/z4dEp9lffYttEPeaPiOxQBOshjRyqXsvhtpHoozPaoxy+4kuM
	 p/xUrgbikPwQDzVOy+pg//HYtAS55uZkGZkZxDXz5WSvVKjcmRXSfQqoqI9fuTlkdgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzTRMXna;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F77606A31C;
	Tue, 17 Nov 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzTRMXna
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794906698;
	b=kTSLcW/nqldSsfc+DMVPoo07mX2W9VZjAOP6jkCWXAVnhtqn9lC+MrJTNsDVRUPFubfW
	 Zi7Mns5E9WNPCxObRw6+J9crPIPmnK5DfXffd4SWJJHDKYYWYJ3+5Lr7H6G0XvdhSQYAm
	 1qjnm0hJHiQYvYzW3Fg97lGh9mRD+dnhbiSAzil7iUa4paRB3ndOi/lDjKY3DyAxTvURA
	 P9O5w12iENpVD62bG+r36GNmRn0WHkEZKIJr8zPtqNL2mmsLAuZdycDNgRYWxgRsONo8e
	 kziFJWWly7OlUuePbXhGJZ2sZqWqEgrp95FRXyvb0GEhySEQQNmzEkmXq8xhny5mt8w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794906698;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=lytm7i4O0+WOrTTYwyW/3THQkYm2q9/u/GLtALBGpqE=;
	b=n7mVbQh1wXII/jn1rHPOmEcOe7E2f9BB6wEkaj7HI/QLTEAlDF8Ea8m7v/JCU4NE6tEU
	 Q9rpuJS1hzOq2L9BSkTDrlgDDjEpSuZzlOroAQbWfu/e4Go7PTqV7BQZS8AAWJGnx55sl
	 WKKMJJLiMe93B1+0cr++RWieEBkcxFveQGkiv3oQXdm9i4B17Wluz7c823z88CoSCbLhn
	 0VZg8R3bJclxXh4WmFLxSP4U4ClVMD3Fya1n5qclS9pRPv4BNW6Gu1l/fy2UIdqLJWf2f
	 LmPQ3Dcfzni2MQt26u14i2QARYE1ctTos8vmvXItx9pZL/ecer0X6QP09g1GldURM6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BE7261F000C8;
	Tue, 17 Nov 2026 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906698;
	bh=lytm7i4O0+WOrTTYwyW/3THQkYm2q9/u/GLtALBGpqE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HzTRMXnaOv8wfcyLF7b/jQcFydd3BgTh/el0qzlDNdzktKJxdmyqxpGy1p7Tu0kR0
	 1XAO1VPlr2eRcobYxjHODkekE4gKh6iqY4Yewymt77PHvl2Ok3LVTCXSdeDZNt63Cb
	 jmuNICwwlehMelxNqwu7JvQ62c4U/qys0/eD/83w1D50c7IxC4CF7rm4F9GUAw0mVr
	 /HOYt4I/59khon5YBfesrpOtemYM3e2g2YI3ZDA2oxzVuUJU69M84B7RwV/SdWTAA0
	 aWdoJiCw2sUpqc9+dfvpPBfo5sKoo1RYC3PqqVVNA+gxkMAKfKK3oWMZ69fAOSbxZ5
	 3fm7NLOoPz/2Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 15FB64A76F;
	Tue, 17 Nov 2026 09:11:37 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Subject: [PATCH v2 0/5] arm64: dts: mediatek: Add MT6833 and the Xiaomi
 Redmi Note 13 5G
Date: Tue, 17 Nov 2026 17:11:30 +0800
Message-Id: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/22NyQ6CMBRFf4W8tTUdZFz5H4ZFh4fUBEra0mgI/
 27BrcuTnHvuBgG9xQBdsYHHZIN1cwZ+KUCPcn4isSYzcMorxmhNplg1QhAlA5JStvVNtiWTxkB
 eLB4H+z5rj/7HYVUv1PFIHMZoQ3T+c94ldnj/y4kRSpSRnNFGYDuI+2oWetVugn7f9y/pvGost
 wAAAA==
X-Change-ID: 20261107-mt6833-base-5a974a951add
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org, 
 phone-devel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>, 
 Rui Cao <i@udp0.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794906695; l=2718;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=p9Enb7h3tqAIEZP5EV7jwzS6FFKHn1F3hp4gOfUaNOE=;
 b=ZCG2NI3TkmszzT9x9HfEXZZVr5GvPIJPaaajISgwPtZYD3yCMGNkO6s5hVZrIaB+zCgu+/JGB
 HZf58BvKYzuAbWLz/2SN/XpiYskc7FXfGEsG5kOfmZe/P+0hVmGQadg
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com

This series adds basic support for MediaTek's MT6833 (Dimensity 700) and
for the Xiaomi Redmi Note 13 5G (gold), which is built on it: the eight
cores with their caches and PMUs, PSCI, the architected timer, the GIC,
the watchdog and the first UART, and on the phone the framebuffer its
bootloader leaves lit and a ramoops region.

With it the phone boots to an initramfs on the framebuffer console, with
all eight cores online, both PMUs registered and the watchdog running;
UART0, which has no connector on gold, passes an internal loopback test.
The pin, clock and power domain controllers, the PMIC wrapper, UFS and
USB are to follow in later series.

Stock LK cannot boot a mainline DT directly, as its DT overlay step
expects vendor nodes. As on other MediaTek phones, this DT relies on
the bootloader (tested with kaeru, an open-source LK payload) to fill
in /memory and copy the firmware carveouts into /reserved-memory from
the FDT prepared by LK.

The watchdog gets a compatible of its own in v2, which the driver
matches in patch 3; the watchdog node in patch 5 needs that patch to
probe.

Signed-off-by: Rui Cao <i@udp0.com>
---
Changes in v2:
- Make mediatek,mt6833-wdt a compatible of its own instead of falling
  back to mediatek,mt6589-wdt, whose TOPRGU resets MT6833 doesn't share,
  and match it in mtk_wdt.c without reset data (Roman)
- dts: leave the memory size to the bootloader, and keep only ramoops
  and the framebuffer in reserved-memory (Roman)
- Collect Roman's Reviewed-by and Krzysztof's Acked-by tags on the arm
  and serial bindings
- Drop Krzysztof's Acked-by from the watchdog binding, which changed
- Link to v1: https://patch.msgid.link/20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com

---
Rui Cao (5):
      dt-bindings: arm: mediatek: Add MT6833 and the Xiaomi Redmi Note 13 5G
      dt-bindings: watchdog: mediatek,mtk-wdt: Add MT6833
      watchdog: mediatek: Add MT6833
      dt-bindings: serial: mediatek,uart: Add MT6833
      arm64: dts: mediatek: Add MT6833 and the Xiaomi Redmi Note 13 5G

 .../devicetree/bindings/arm/mediatek.yaml          |   4 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 .../arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts |  57 ++++
 arch/arm64/boot/dts/mediatek/mt6833.dtsi           | 341 +++++++++++++++++++++
 drivers/watchdog/mtk_wdt.c                         |   1 +
 7 files changed, 406 insertions(+)
---
base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
change-id: 20261107-mt6833-base-5a974a951add

Best regards,
--  
Rui Cao <i@udp0.com>


