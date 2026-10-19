Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD342F7EE7;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370443; cv=none; b=ABS9Bo1gmhQVJfkyv4hXr7467mK5f6cIQq891zqYcHDF/O1s6kjPVLvs56zdMlXbiWHbmIzCMYxx4IRqO9SUSEFAsW4gpIdx+aEyMuMrCWYBV1m4ltWMKnWkEZwN3SDq7syb5B5CtBIcQT/AKBLZP2mYVab2EvY5mbpCv/6tbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370443; c=relaxed/simple;
	bh=Okf9cZqs2tuosAZqVM6N50l4ODVk87pJ02XFJIFdg1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i71TIOYE2Hk2vby0QUzzGEyODpdC60h+0OgH3Z9H56NgSKtBDhNm62fvvW+tvd+qoOZwXNPTartGSI7KNVp9th9oOItD1Fs+hEU33PR0F1Vb5xX+2X2DyY9xgC5HnVbs//VR0rIXx1PM5X3+Iz2DWd1kZYg1OIMf6iA5nlvRwes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/Nfzld2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/Nfzld2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C7ECC4AF14;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792370443;
	bh=Okf9cZqs2tuosAZqVM6N50l4ODVk87pJ02XFJIFdg1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r/Nfzld2+qEsmWbQyzk8NdmH0r752Fwkre3gsPIK4FBZvjzlq7Uib8a+lG6MAB3La
	 PHr9ciU9U9G/cLtgahLCHkkT1Ako0xdvrhZ3mi+fnLyWwQts/nN0RglsARc5c/lSOy
	 7dbjPBFb58SKtIaeEwZhVTg/NkilkUOdlvVkU8BQy35MF0s4vkAuL8t241SpzvVl/5
	 ItWb6yyTXi36iLk7xNSV1+/+mAwTJ6uySiTJE6N4tNDaQOpH9J84jXOJZOgej2AG2t
	 rQ2Eek0edwyMXO+DkjkMxXIp5wzgBbGoVgwQuBrU9BtNkPWDXfAbHx55NJ4gDZRFST
	 HDVQBg5vjyAEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69935CCF2D4;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Mon, 19 Oct 2026 01:40:02 +0100
Subject: [PATCH 6/8] watchdog: mediatek: Add support for MT8163 TOPRGU/WDT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-6-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792370441; l=1544;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=/XTNZ0sJc5waPCmXjLC0TBnLTxhdHSp17UVgQTVrcOk=;
 b=9D6DQ5YEYoCFOvrvWp1BbWcmknxj8b+1B1kqQkshIu/XlI0b7gwW+LxkowQ591ZAtqpzpaqJl
 4sxYm6Pi5RSBHAy8FNOmRMon9XRZGxzEgy00AXgppSlSwETOELBdjXj
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

From: Ben Grisdale <bengris32@protonmail.ch>

Add support for the Top Reset Generation Unit (TOPRGU) and watchdog
timer on the MediaTek MT8163 SoC, which provides 15 software resets.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 drivers/watchdog/mtk_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 1630ab65d593..0c6efa2e851d 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -70,6 +70,7 @@
 
 #define MT6589_TOPRGU_SW_RST_NUM	12
 #define MT7988_TOPRGU_SW_RST_NUM	24
+#define MT8163_TOPRGU_SW_RST_NUM	15
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static unsigned int timeout;
@@ -117,6 +118,10 @@ static const struct mtk_wdt_data mt7988_data = {
 	.has_swsysrst_en = true,
 };
 
+static const struct mtk_wdt_data mt8163_data = {
+	.toprgu_sw_rst_num = MT8163_TOPRGU_SW_RST_NUM,
+};
+
 static const struct mtk_wdt_data mt8183_data = {
 	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
 };
@@ -597,6 +602,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
+	{ .compatible = "mediatek,mt8163-wdt", .data = &mt8163_data },
 	{ .compatible = "mediatek,mt8167-wdt", .data = &mt8167_data },
 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
 	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },

-- 
2.56.0


