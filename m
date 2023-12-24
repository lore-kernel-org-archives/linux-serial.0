Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938017C1
	for <linux-serial@vger.kernel.org>; Sun, 24 Dec 2023 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="R6VfIM4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1703410442;
	bh=kcBqw6AovDSUWhP3RKm3CcmC3+Imyp5KfdTj22Ed0pE=;
	h=From:To:CC:Subject:Date:From;
	b=R6VfIM4Lx6sVOUUUBON2UwY4W1rBjcppbMl+TQtBWVHveTMDSyqRJmi+vkIQAXRgF
	 wv6ufLtmYIJhokaoYxY3LUVxv/OdUmc7HMm83pS4iQK0ajUHFEhMhMarMxySJ/WMsz
	 C+qHF1IZ80zW7zXFbDu3KTf5bmJWASV92+kjakY4BbUVuaFiC92cq3L/breNRvHHpG
	 Z2+ciBSbS1IlhaLLPuAYkAKgXBrWOjTSejjPvxSS2/lywEcNrQJX+X2gZljwzP1E9W
	 UmI4nFE/G9RBNsvlCSc92Zw4EFoPV1JzSw35lufn3syLi/KiTrC9RQtsj/RBa5DiEC
	 +nwtxWQgTnxfw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Marek Vasut
	<marex@denx.de>, Fabio Estevam <festevam@denx.de>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, Sergey Organov <sorganov@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Rob
 Herring" <robh@kernel.org>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Tom Rix <trix@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>
Subject: [PATCH V2] serial: imx: Correct clock error message in function probe()
Date: Sun, 24 Dec 2023 10:32:09 +0100
Message-ID: <20231224093209.2612-1-cniedermaier@dh-electronics.com>
X-klartext: yes
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Correct the clock error message by changing the clock name.

Fixes: 1e512d45332b ("serial: imx: add error messages when .probe fails")
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Sergey Organov <sorganov@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Add Fixes tag
    - Add Reviewed-by tag
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7e952bb7bb8..55105a4b1af8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2327,7 +2327,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	/* For register access, we only need to enable the ipg clock. */
 	ret = clk_prepare_enable(sport->clk_ipg);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable per clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
 		return ret;
 	}
 
-- 
2.11.0

