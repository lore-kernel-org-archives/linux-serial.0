Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794663673;
	b=DslhOTpEszOw3gTtxJYSAlO/UB8lQEWGFCEBgng3yYEoDAF6IcVedx3dK4zBzKoN8pXV
	 ii3k5mUniMFqzhniUCuktxL8ZCXDFYF4ZU5jO8LsXq6s44FQ1tQXWBJieAP8sBs1tV2ok
	 JjZkfQSaPtdg9H8PQHIGc/YazGx6WMb+EC7HPkolB9x3NmxyMNwlVX4Z7K8/Sr6BAwh/3
	 7rWgp/xpRJbOLlO3NlOfQ+fmuA+Tx5tLvq/9tOREakISoCfHnhUQ2/9Y4nnZhMnKxFmPi
	 ewuQjcNy9ExvQVJzn5HZJe/nH0/x3xmIYrIuOPR8EWhXOnBmfpkPrEG9LZeEZDFWTlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663673;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IWGxRSF6TsGu8YkPR66UCDbiThQFkRdGV1nPrINMwrA=;
	b=S46g7VhRIzhca+iGBPbbf7DrwwsF1HOW1dYz025RLeIuxkfgis9sDtkQsSQGe6rcolZ6
	 zHA83uRRDBUBVyKJ0JHX0GRdhUpBmJWfWMaorwXvLVB24Bo9fF8HOc5WmgEMkUPgimMzN
	 PHb3pJB+BWrfg+ZdXIx96EiKsWhoA/dSw0SRiDxObrrl95kZqmbCIrnt8rhseZ4pKphPk
	 fw6ZXFjbbDl0y+/ZDa351yMkId1Kp4eKfqGSh4XEn50GSueGpGAj/7LiNAytKkZZMN95q
	 1nN140pDXAH1GG+G5mzG06JulzanpzaKoQIbrcUyTV1V7CxafrvMozgL9MXUXMG8sug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajJ+G1zN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7B606A33A;
	Sat, 14 Nov 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajJ+G1zN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794663673;
	b=KH5JABIsNlax5UO3tnGXHazh9DInZkNWNrQDGJH6pTgtHiJDPfAcyfqaHFxblURpr43r
	 ItTFp1QHSx0ewQ5B6/ESJwdh+QJiHB5RYE/2iR+pvnebB6pRHAGUgoiYYNZ2ZS6ldihe9
	 YtL5uDfRED5ODyERFD5sYZ2IwxUwN8f6hhObby2rbrE8irhZqnnHE0dEgJNif9L08vhoQ
	 oOP5gH4X9+rmuMXTFOLIYsB+fcm8bNrm4ZyleyGCQgu4slxjA6IgkWkGK78F4XvWy6+Zd
	 UgQyuriL4Lgce2KJB3LNZM4SEbx7Uws4rasn/+xNgIfRdSkNataYeqpoY71OnUaLPDw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794663673;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IWGxRSF6TsGu8YkPR66UCDbiThQFkRdGV1nPrINMwrA=;
	b=vwzYLtoU5dRpU7Jmj9PG5QI31X7YEesRTMwPqwQhxiyqlMAKP56EbvtrAFI/mgXDgSfA
	 LRVhmZzI0o3VM99V3SOv9N/kOIHMJOQsBYYAnDY6FD+XCFngei3NaK6hA5Xl/JYJXiR4i
	 EyVk1cRFINMiy07jIalueAG2L2TkTFkk94ZAvmJmN6YOO+M+F7kl5+W9Psx1zUPqCvFxg
	 yajiCIt+qO8FmAVjFIONTBrgUjuvXLXx7kLHqn6lLxKVREZ5/bopMq/c29Tt1iMkrLTmc
	 MgGfLpzBKXVLsFrwlXz//YYbfP6LYNWTGrOQqEcURRZe6OmIugzBnAVehZ2n4Boumtg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7843E1F00923;
	Sat, 14 Nov 2026 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663673;
	bh=IWGxRSF6TsGu8YkPR66UCDbiThQFkRdGV1nPrINMwrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ajJ+G1zNOQ9JOcMJWEyaQS0jWTCZ7oE8mGoaUjk8fiPi4St1nnCTZc2tIpuy8Be35
	 iMPUohuUvKnfMSWzQEahIlu4MEf3a3cEHa2SjxI7Cakab7nVrA9OHhoT1KGBSziS0p
	 Qk9+v8Nu+Z1kYJbSsXm1H/9gcCcNtz6JRJcK68F/gu3Y1dYnx3FoUGAVv6doDBjTDb
	 N1TOPKyHKEu/ykGKggo1xgWfH/cBe6SSNrUvwHC5V16ZckS5fLEFJqJXIcJNo2kjFp
	 ws0IZ1mOO/1RTPzPWeXcf7TbT92YXwMFGeffa9A8azq80xueiKz+xascF7MMs46XON
	 WHqip/iPulCrg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C7ED549DDE;
	Sat, 14 Nov 2026 13:41:09 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 16:41:14 +0300
Subject: [PATCH v7 09/10] ARM: multi_v7_defconfig: Enable Cortina Systems
 CS75xx support
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
Message-Id: <20261114-b4-cs75xx-v7-9-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
In-Reply-To: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794663665; l=1073;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=6lUn6eCTFyPOKvxFHES2Y+JrDHysCcc0CgLi4Om4C1M=;
 b=WBNIIKSFpVneYKcwfcglEV0A/Rf8+cmJduQMaUerSyIeq35GSZRQx4G1KklPZmgZyfttA/Ano
 48+Lr0Q5hRCDkolEdDjFisLEO1ltXPwr60YW7Cplv2VzOvLqrRI3m3e
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Enable the Cortina Systems CS75xx platform and its UART driver with
console support, as used on the Securifi Almond+ router.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 069d5a49f..23f144359 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -45,6 +45,7 @@ CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_MACH_BERLIN_BG2Q=y
 CONFIG_ARCH_DIGICOLOR=y
 CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_CORTINA_ACCESS=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
@@ -396,6 +397,8 @@ CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
 CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
+CONFIG_SERIAL_CORTINA=y
+CONFIG_SERIAL_CORTINA_CONSOLE=y
 CONFIG_SERIAL_ST_ASC=y
 CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_SERIAL_STM32=y

-- 
2.53.0


