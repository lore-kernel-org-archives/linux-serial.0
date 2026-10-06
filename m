Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3EF4A3D40;
	Tue,  6 Oct 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310662; cv=none; b=R2L5azAU7TQHghLm9/vOewyKssNZsAwREoSvNWpUU5hAgq8t4/E/c6HIiGuwkMoj2IcAhCLqC4PsWO57aSzZhPsRakdAS8sDRlLzB/sxtU0eIcayVE7eY2czZKg34P9T/Q8VrinfopnlOPw/h2qgGAEpm4hVx9t+V0yfo0aQ4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310662; c=relaxed/simple;
	bh=qg8FxjYYcR96g56eBLYXieOz+MrSTLvR4qvZUqFA5Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHezg7k34uU9BfM5sxtknK+YS1r9Hb0b0rV006TK+pM8w9KMQHxS7i0wvBBgGwAPpsC+LVTnMTSM1a2Z4ISwxjrW+q0OzcefQIZMbTfIzq8h+F/PvSE67eDQbN84r/AnO5/+xCVJguEnbdfgxzYiNJhljXnopiGkg8RTKtTdigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgqn6Jo0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgqn6Jo0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DC45C4AF61;
	Tue,  6 Oct 2026 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791310662;
	bh=qg8FxjYYcR96g56eBLYXieOz+MrSTLvR4qvZUqFA5Vg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hgqn6Jo08qHmQ7m/7wwApK6r3+nGVP/zTm2PSMXKQgwIFQDro7MahcRqyU8eBV6RZ
	 nSHTTmVRV0B/tS/aa8OeirldvGXBwXD2kjrrvtVJSB1RAmmsAE0IFnFFq4RLHo7wXS
	 5fSAUJdw7A7HVSWAHDbeh4hGs/gk+RZqFd33CD/MYS1sO3uqqQI7BYLMDcUTyxnJRx
	 OMmAXotst5rTWD+hJngI+juk9Wcj89MNTUzJyotQZgMZoJxhNLc8rl3BiNLy4/VebZ
	 /Ik1rqGZegAfzR83L4rJ7KDAS0RZ49mJCWr8+2+oF8PnMoogacBdn47WMaFkydLSpg
	 2uTR+Sta+EVZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA9CA5FFF;
	Tue,  6 Oct 2026 18:17:42 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 06 Oct 2026 21:17:47 +0300
Subject: [PATCH RFC v2 09/10] ARM: multi_v7_defconfig: Enable Cortina
 Systems CS75xx support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-cs75xx-v2-9-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
In-Reply-To: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791310660; l=1029;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zk+TsjqlPDPtaEBvj1Z/MrZdVTP1GT9DNQGUsLXW2+g=;
 b=dG4oBKubJXupPk08c0RFAbBrie9l1/vhkkmxPyNQ/NYNIyh+0JRuB6sr+niOC6BgwZRC5OWnr
 WHwbEJ3oSdDDLD3vyLoyir+5j+oVYZfl3Zdi4OFKTtsWV03V581krtl
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
index 069d5a49f01..23f14435998 100644
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


