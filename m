Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA914562BC;
	Wed, 30 Sep 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751604; cv=none; b=oDubZiI+YRta533osac8nZUZ6lIqEt3cLOkn/RSMPafWx1Fyqn2S3g76oDZTyWIvtK/L674s8qWfQgM0hFFxy7Q94NLCVtVaDe4aP/7nUqeVJLEBlk0Bzhi/agFZsS0+x6LKvSYT/thsV6Ta9HzLyNQA5JbkXLloQLgzVcwZ2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751604; c=relaxed/simple;
	bh=IkGSa5rdPtfm7+Eor6wSsLY0d9gc97tQ7PjbdN3pmv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7fhz1Cix+OZF5hyH5Y33gQI3Ou9qpPNNLkkbCBvd5h0Vy3w1alP7zrj+4UN0OX+1sW4P/JUT07y+hSynA7L0dD0kU7DvUEHmJcTHW0uGTJwMai8GIlVeVEJTSHjxVuB6CgHvHLU/DkZsyAIUisesRj1ysaWvIDm9HNXFZT3YmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgdM69Uu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgdM69Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B4FC4AF18;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790751603;
	bh=IkGSa5rdPtfm7+Eor6wSsLY0d9gc97tQ7PjbdN3pmv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fgdM69UusqGrSa+uYDcKpmhdXjVsIyTXptbdaGPdzbLFtWBZc6JB9JfL5lXR524X1
	 HAjpXnB4XP380MbgfYgjaAIFYGEg5ujkcWWv/VL3svelfmStwzczwBMC067NE+KpLX
	 qRMMeNuIemV3NQwcMN10UD74BPeabXtNXw1l7Y4JuO2bpq0TVUH7ux7CovP1m13sai
	 RPVEB4uAik/5dysz02zWhC4YUiZWlG6mKFrVcXp4qImwflqpUUkZuHPQOG+bbAXbTu
	 enSn2bW5IvLMoH3oUWaO1cCebR9vcXZM6jlQrDlRLhRjQp62mDdFEwJ3NSzfhbH9bo
	 hycpSG+Xb5uvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CAECA5FB1;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 10:00:08 +0300
Subject: [PATCH RFC 09/10] ARM: multi_v7_defconfig: Enable Cortina Systems
 CS75xx support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-b4-cs75xx-v1-9-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
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
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790751600; l=1033;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=syozw3CaM60zgc9fFnbuWBy8gDnN800qtMNSIdUmoDQ=;
 b=3GO6NWC/BkA+4i65OmXgIYUc5OQB+vEPWuA4knwm/IuRwwxV/2Wglqt7FTS5aiZXfjE7FcbYz
 I5otckmMcscDCOb0QZ+y88D7Jfks28AMu2QRd84qw+8XbMxHvv/jWZw
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Enable the Cortina Systems CS75xx platform and its UART driver with
console support, as used on the Securifi Almond+ router.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 069d5a49f01..5f0b10b1f18 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -43,6 +43,7 @@ CONFIG_ARCH_BERLIN=y
 CONFIG_MACH_BERLIN_BG2=y
 CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_MACH_BERLIN_BG2Q=y
+CONFIG_ARCH_CORTINA_CS75XX=y
 CONFIG_ARCH_DIGICOLOR=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_HIGHBANK=y
@@ -396,6 +397,8 @@ CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
 CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
+CONFIG_SERIAL_CS75XX=y
+CONFIG_SERIAL_CS75XX_CONSOLE=y
 CONFIG_SERIAL_ST_ASC=y
 CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_SERIAL_STM32=y

-- 
2.53.0


