Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBD163;
	Sun, 14 Sep 2025 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757809640; cv=none; b=r9MCBqNubJYMlwaU3s8U8bnm/fjl6TTvW1V9i63vnetX1huNYf1XP1yU6PUxWQeN4O9mIM7YBuo1ZqfgMkE1Aa5D/HRN3RrCFP/I55se4kcF4k4YTeAzMF4JUeSn+HFh+pk6WqUff7FRdbRd4HPGpTg1jxjvZ/dqcY2cQYIb3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757809640; c=relaxed/simple;
	bh=XhAY2Nc3nA6iDpUI121blFa1UrnZBHRgmQH83AHqnJU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AzQOonlNNHWvLpITLKhWcv6NI+R+twO//NE2q6wtlCBbtsNsPSmli6QiWuBOcu622XkAqvw4avrXR2h+8ePilni/dpWxHZ3JT7kjX9BnmwXxWeszGdBR+mCf1u7/VdIFDXxnHiUkFw5/U/HSamk9r/NCbkrdskHf8yTOfuaaSkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uxa9C-0000000077z-2TM1;
	Sat, 13 Sep 2025 23:59:14 +0000
Date: Sun, 14 Sep 2025 00:59:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Changqi Hu <changqi.hu@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] tty: serial: 8250_mtk: enable baud clock
Message-ID: <5d6acd2273e3c98a5cbc685ad94eff19c6b6d044.1757807642.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some MediaTek SoCs got a gated UART baud clock, which currently gets
disabled as the clk subsystem believes it would be unused. This results in
the uart freezing right after "clk: Disabling unused clocks" on those
platforms.

To fix this request the "baud" clock as enabled to prevent disabling it
among with the unused clocks.
Runtime power management can probably also be restored to the state before
commit e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock
management"), but that isn't strictly needed to fix the regression
introduced by that commit.

Fixes: e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock management")
Suggested-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b44de2ed7413..9329ed1f759d 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -475,13 +475,13 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	int dmacnt;
 #endif
 
-	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
+	data->uart_clk = devm_clk_get_enabled(&pdev->dev, "baud");
 	if (IS_ERR(data->uart_clk)) {
 		/*
 		 * For compatibility with older device trees try unnamed
 		 * clk when no baud clk can be found.
 		 */
-		data->uart_clk = devm_clk_get(&pdev->dev, NULL);
+		data->uart_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 		if (IS_ERR(data->uart_clk)) {
 			dev_warn(&pdev->dev, "Can't get uart clock\n");
 			return PTR_ERR(data->uart_clk);
-- 
2.51.0
