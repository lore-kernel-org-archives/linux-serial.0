Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811552EAF1
	for <linux-serial@vger.kernel.org>; Fri, 22 Dec 2023 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="pfP/Kkr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1703282644;
	bh=TaVYOqK9WKswt2YAgnv7g7i7ZYk05GKPJJpoNKcvZH4=;
	h=From:To:CC:Subject:Date:From;
	b=pfP/Kkr4rIs5dRfFBBq7qKHhOEst0iz23ZXZp55ElzWW6gyyVxuXBuzm6krDkDvFn
	 McMVPrDgA6fweZX2BYzU/Xb4CXqlcXEWwKRoaVtikSUyJqtu9C33DgR3kJVZmQtDVg
	 yS2biakJFKYyX/Nayr/lE0dvjzExzo3HR9qk6TJDn72s8a4vM1vxUukQZW5jfKmTTN
	 qLaZj3Oy4HdDZYvf+ZW/3sA/ueBGx3OasUnVQfxl9rUjmRNsVZomfL0Y/bMdQBu7qd
	 ZW0lPTuyTr1YFrBXc3xLlWoXUSuTXMkqc5TVr8r5zK+Rp2ZylNUfd0/AVbIC3mSOSi
	 bA56QIhRbucJw==
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
Subject: [PATCH] serial: imx: Correct clock error message in function probe()
Date: Fri, 22 Dec 2023 23:02:16 +0100
Message-ID: <20231222220216.2188-1-cniedermaier@dh-electronics.com>
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

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
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

