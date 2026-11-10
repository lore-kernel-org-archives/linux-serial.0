Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308112;
	b=QRFtUARAAH/jOXsS1h5kg8qOECcWbqSHkO4qbOu1flTxU8/0IoFhFeWqvphzW2gpyNy6
	 Qr2A4dlN813TTplTtk6tLXXFTfyRfOViO8WTaA9vnsHUtf2zgMOOVre0B1iQld3RQApKo
	 oCFZeJLTYgSrw30VeFkPm7qHrCWgIm9F2giQY57I1oIQRovErRqqxW1t3tCHO5BD9a1gK
	 YsDG4SmY2ZnXGs/Sx/4IrF3jfPxwBUpgcyZ4UXBlb2F7oYhW5MaDK0/ajCgrgZW51CjfL
	 sULE7V4MwHYW4fHyeFVLaOt7NrcHJVni1dE7ye3LzfZAyzNyrORYB1Bd1qI0sU+VZTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308112;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8CAYLPtyBiwBBks9yHGzZqRhAeLVlB4+AgTjAjREjOQ=;
	b=SmkcXJAgokL2Y87BBdo0n1pXynTlayIolrfXA8pu0uL8y4mf+AusGoEXwDhDBQguo0fx
	 P643yBXDL06v5B6N0YitTXk3nIxIDRTO2af4egUp7Pd+unXCAVUBOMqL8EFw6YxJ4iL/F
	 tCg57Eowa3Mp/VpYUUUg3dp4UpL4+RlMiTeSD2n+bHEE4U0M4es2BONPA6kNvcWpCSJvm
	 wYxb3A+GIUmbWqCAv6tvlxXnpKnMkOE/T7AdWc/7EIou9XzXfI6ilR3PgA7LAI4jQyEwC
	 tNYS2DxstAyz7utfoCiUGa0NkS9Wtt4kHu/0B4t/YsKnnUZmhxEup8YgK5I0qGbubEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=V0olp08m;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D5606A339;
	Tue, 10 Nov 2026 10:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C35D5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=V0olp08m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=V0olp08mm3BuEGZznmcsEi46FhZk+EkoW9Vli9ndVUNzoNjo+Mzq0QcJuRIndf6z7u8eD5WqQl3og
	 E82luv3ZGLqm23VebZZqcVOLJqePSLm//QGwjC7fAu+w4mzZawbMm7/i2+2WTTHl08tRk1kog5u+D0
	 FjHb9ZPbcvXoJ3GU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af2f807e8a-0ac64;
	Tue, 10 Nov 2026 18:55:07 +0800 (CST)
X-RM-TRANSID:2ee26af2f807e8a-0ac64
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af2f803ead-b2d1c;
	Tue, 10 Nov 2026 18:55:07 +0800 (CST)
X-RM-TRANSID:2ee76af2f803ead-b2d1c
From: Gu Bin <gubin@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gu Bin <gubin@cmss.chinamobile.com>
Subject: [PATCH] tty: serial: imx: return error when clk_per fails in imx_uart_poll_init()
Date: Tue, 10 Nov 2026 18:54:55 +0800
Message-ID: <20261110105456.1563-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In imx_uart_poll_init(), when clk_prepare_enable(sport->clk_per) fails
the error branch only disables the previously enabled clk_ipg and then
falls through: the function keeps programming the UART (imx_uart_setup_ufcr
and the register writes below) with both clocks disabled and eventually
returns 0, reporting success for a port that never came up.

The sibling imx_uart_startup() handles the same situation by returning
the error after the rollback.

Return the error after rolling back clk_ipg, matching
imx_uart_startup().

Fixes: 6b8bdad96164 ("serial: imx: add imx_poll_init()")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0831bd5ee3dc..2a931361d17c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1954,8 +1954,10 @@ static int imx_uart_poll_init(struct uart_port *port)
 	if (retval)
 		return retval;
 	retval = clk_prepare_enable(sport->clk_per);
-	if (retval)
+	if (retval) {
 		clk_disable_unprepare(sport->clk_ipg);
+		return retval;
+	}
 
 	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
-- 
2.50.1.windows.1



