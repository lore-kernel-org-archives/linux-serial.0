Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A13B198;
	Thu, 11 Jan 2024 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dqSBd+ty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XGWcN
	p2I/ujeacYSKUECw91AKfIpyCL2r7w3wnpKdeU=; b=dqSBd+tyVLvCJXw3k6q+1
	i+vi3E7cM2gwwGZYlWK858NpXXOfFwSaCpg1kanmobzPnlQRYCHMjjc/S+w4HXhP
	8W9BhozmhIBiDvRXH4B0eQOJYZE9Xo0y2+LXke5zh7uVinRAAWBH5VPDR/iYfFfm
	KC2Aps5DmCGAlgaXpv69f8=
Received: from localhost.localdomain (unknown [36.4.236.25])
	by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDHr_R0959layVQBA--.35417S4;
	Thu, 11 Jan 2024 22:13:37 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	u.kleine-koenig@pengutronix.de,
	frank.li@vivo.com,
	tglx@linutronix.de,
	zhang_shurong@foxmail.com,
	robh@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH v8] serial: linflexuart: Remove redundant uart type assignment
Date: Thu, 11 Jan 2024 06:13:07 -0800
Message-Id: <20240111141307.123458-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr_R0959layVQBA--.35417S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4rXF4xArWDWryUZw48Xrb_yoWfGrX_uF
	1DZ347uw10kFWayFnrJFyYkrySgrs5ZF48ZF10q39aq3yDZ3yrXr9rX39rW39rG3yUXr9r
	GwsrWr1ayrsrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBXhhhq2VOA58K1gADsk

in linflex_config_port(). the member variable type will be
assigned again. see linflex_connfig_port().

v7:
    the first word and use terminating stop at the end of the sentence.
v6:
    Use full sentences in the commit message.
v5:
    Add a change log.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 3bdaf1ddc309..c5a04a168c15 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
 		return ret;
 
 	sport->dev = &pdev->dev;
-	sport->type = PORT_LINFLEXUART;
 	sport->iotype = UPIO_MEM;
 	sport->irq = ret;
 	sport->ops = &linflex_pops;
-- 
2.25.1

