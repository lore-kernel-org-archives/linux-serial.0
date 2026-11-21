Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795294938;
	b=dthIms8Ku4ySJyUqKgEYLRw83i5eqAm1KouEVTym4dwvqfpcOUCqaFOkCa0Z1+G2aNZx
	 YQU5R95KiMXP8iVzjRp5lwZOrnK12uBVbLYc745vbik2sq9a6SxxvGlWr0wvHQCsn7viN
	 UNyilaXimVMwacKU6elBUWKHoaKO8cxgXdAnMAtS/bC+80r4acpYI6WJbB/nFIQv4+lp2
	 GD/WuM1Pt0o6SxFySYQl8CPXYvdg4Z5lDXre18359VsxjIRbwa6O8KPDSnleasfGjuEye
	 vYkDTsStISX0ED0jtl8jU8Y/7TPg0YKHp1eF1xwj2J5wnL2hWnfYxWV3EufSwdFF7rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294938;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IWGxRSF6TsGu8YkPR66UCDbiThQFkRdGV1nPrINMwrA=;
	b=ZaD6VgLpMNlL3t6jsMzgRz+BgP828IN/bu0sCtBBslKwk3H/lJT0PVKatiWYl8Ty/fe+
	 Wa1qPKynnB9RNUJoRoNrYVytzdJ+9ylWrePktAtwUCqDyjyNsg2Ahajpdlr8UYrWD5Epp
	 oSnj8iMkXJEroM2bsAblwoU7Mmq+okMkVrteFGZuh5ywa6fwYatyimJM2+NrzCBJtMGCw
	 6aMBigqm2Cjwt1rUkHrkRnug6fPzquz9rm63ot4c8JtM+zlQgoURriDq5+pM/AUIITQFM
	 3k/cozIymDqK/8HKJ47oGQw9fOwuikEK6fx8aK41gBhzHR2SFLDmODcHpv/S1LQuucQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsEu17ZN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5B60A2602;
	Sat, 21 Nov 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsEu17ZN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795294938;
	b=VprGw6QhB5JqSrLUfbSe/h1SvD/PM7HlBBy81fv4vJ0N2ltkCVXwhAqJQaDJqPCRm4ZA
	 ynAZadxUVSk5prJXw47nWKAnDLvh/BQUeKc1ApdKeQnP37w3WoNAKm8ko8RUV2ADV44VM
	 eb4wqhEZ+KWsgt2oOVyyo9Q+KMvuL4a1/Dk9L5J7nfJdhzIjWeLUKCYZ9MHPh+ZiSocJP
	 Ln+/I271mdj1lJO+fb1OIBc2vqqz4dnzoI12XWKyw5u0ybuiwhlPRXsDI3EBLMm74tNRq
	 Hy5M1ChU0ZTo15PWS7imlTisMCJS/5N5tA4BPT/tzmR/9cpyu/HTL1oPTw8wKzoIHVQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795294938;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IWGxRSF6TsGu8YkPR66UCDbiThQFkRdGV1nPrINMwrA=;
	b=WI/XOvYXpzRQpehe3IAnTeCD1nM1jc80MQn1aHRe7aye8I2drT3uU9VnHh9SzQUCzscT
	 ZiyJfekV5vlvoI7WtO5ReAJXEvwWHoslyOsCiIk1D3Je5tHEJ8gjfdy1OkwKNzXJIxE8r
	 dQiL2bBZWDamSi9E5CEN+MCTvbTUs5oVwDk+zuyjP2Z3Tyk4lP4otnsMPvjl283EBy/bo
	 heWUv/XCbT5FHNIxMAVYTfps37guY/yUgjG/H5FcZVusT+BZxxFznWPz8kMVOnij5Dc/h
	 tGkmPxrXvFM5fvR+yA8DJcluVXoW/20P639QdMQYYWOX0k/ToMhjT3hTrxYhKmabzOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D8A971F000CF;
	Sat, 21 Nov 2026 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294938;
	bh=IWGxRSF6TsGu8YkPR66UCDbiThQFkRdGV1nPrINMwrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PsEu17ZNNWl1rYVYbXi8/ST1wi3lQKRD/1HHiQPXK0nvfPvqnXg6B/cBMIrvi81c+
	 XiHAjMPE3CBw32hUj+wHZQvTXztCBj23srIif6hx32iCqLj9boy86mOXOK1cC1NrY8
	 Zuyd0NGQD1c2IGB2R9LK5SmCntmrJTtKFDpCtgVkvYb9hD2hd7dyCeA6wTsiNQpY7r
	 My7wpqeiwenSNco7Acc5TQoR33ieWJ1m2VDSuu6odKo3is4BMRy0Ualhlq1Np/p7wJ
	 dPlRWloD3la3reEvGsdEJkE9KPhcB0fGO1hXHjDcM0IoutzYab5RieM7Ab1Geb3U8J
	 fm6w/s4Zn+9Vw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 219864BDC6;
	Sat, 21 Nov 2026 21:02:12 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:01:54 +0300
Subject: [PATCH v8 09/10] ARM: multi_v7_defconfig: Enable Cortina Systems
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
Message-Id: <20261122-b4-cs75xx-v8-9-5f971b0dc69c@gmail.com>
References: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795294929; l=1073;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=6lUn6eCTFyPOKvxFHES2Y+JrDHysCcc0CgLi4Om4C1M=;
 b=dHGcZw65wtGXywhP33vD+PBaz8Ux8WqqudPybVnZzIFCbAkl8uJchB7YsYy36N6iF9vicZIUD
 Hpk66EOryWlAh8f9B4fu9Ujat4tam3P6miYl8OrDfdFLYO9bTrAbjcU
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


