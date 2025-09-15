Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383128506D;
	Mon, 15 Sep 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941626; cv=none; b=XCoTDfvonGuZ1/2AIhigOI3bO9VLlZ5lK7cCRwhwvj3Hv0lVs8gp6At6RzVTQXyPUuXJJPqRZ8j5DKWb05A5jKgE15ExYff4iaLZwRw4UBRmlRO0X8Jhyx8aaKwtZ96xapMB5plNaEuRBbByL2VT4y3P6rwGcJHH+tRwPdjouDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941626; c=relaxed/simple;
	bh=FiTIN3Lu7XEzDVaqOg3dFA61ZLD0/ywl+FoNcLu5GsA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4EonDX/IgvoV5+qVoqlcsesrCARqnZ8mWdGbrM4oMS3h/x8mzCidV9QIOlqDoC3XyUanYeIt7aJndfBripQZLVDZ+wqCdA/kR8tGgKAaTVweL2CkxUEleqPaDvtvZuEoHs6F4TxitEvOWZ2SInCXeisF+/vZjTKEgFSJF+9res=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uy8v2-000000005zY-3dY8;
	Mon, 15 Sep 2025 13:06:56 +0000
Date: Mon, 15 Sep 2025 14:06:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Changqi Hu <changqi.hu@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] tty: serial: 8250_mtk: manage baud clock in runtime
 PM ops
Message-ID: <4a199adc63de9159865a48b7ded2048d45712d91.1757941345.git.daniel@makrotopia.org>
References: <2de07b0a6d51d5d3bf3e55cd03cf75adfc91ee7d.1757941345.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de07b0a6d51d5d3bf3e55cd03cf75adfc91ee7d.1757941345.git.daniel@makrotopia.org>

The baud clock is gated on some MediaTek SoCs and can be managed by
runtime power management.

Disable and unprepare the baud clock when suspending the UART, prepare
and enable it again when resuming it.

Fixes: e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock management")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: add this patch as suggested by AngeloGioacchino Del Regno in
https://lore.kernel.org/all/8b1c1796-6de2-4526-9a29-d8649141b878@collabora.com/

 drivers/tty/serial/8250/8250_mtk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 9329ed1f759d..5875a7b9b4b1 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -435,6 +435,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 	while
 		(serial_in(up, MTK_UART_DEBUG0));
 
+	clk_disable_unprepare(data->uart_clk);
 	clk_disable_unprepare(data->bus_clk);
 
 	return 0;
@@ -445,6 +446,7 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
 	clk_prepare_enable(data->bus_clk);
+	clk_prepare_enable(data->uart_clk);
 
 	return 0;
 }
-- 
2.51.0
