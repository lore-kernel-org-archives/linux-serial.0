Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24E3C485;
	Thu, 11 Jan 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ipp+iS5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NdWck
	1RJ+IpJ17Xmj/T0oaXOjIgE4k+Q5QrVpzm1sjU=; b=ipp+iS5x+Jd5CycElPk8B
	cPgKnjXFqM6ecIxOw0gHBHmfKUiHeKssY3DqQ9TUHe+yLQlRxXoTg9cHuHm6WISm
	KdOb2jQyqFMjnbUbFl+CA+JvBOw75uf9FuyIv5y2F1wR7+K/uPa1GBFxUcGNWK8p
	/opAMHHkfl6+oWNaQcqFrE=
Received: from localhost.localdomain (unknown [36.4.236.25])
	by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wDn94l3+Z9lkf90Aw--.43270S4;
	Thu, 11 Jan 2024 22:22:03 +0800 (CST)
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
Subject: [PATCH v9] serial: linflexuart: Remove redundant uart type assignment
Date: Thu, 11 Jan 2024 06:21:41 -0800
Message-Id: <20240111142141.126879-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn94l3+Z9lkf90Aw--.43270S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4rXF4xArWDGFWkAFW8WFg_yoWfurb_uF
	1DZ347uw10kFWayFsrJFyYkrySgFs5ZF48ZF10qa9aq3yDZ3yrXr97X39ruwsxG3yjvrZ7
	uanrWr1ayrsxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM0eHDUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBXhhhq2VOA58K1gAGsh

in linflex_config_port(). the member variable type will be
assigned again. see linflex_connfig_port().
V8:
    Capitalize the first letter of each word in the changelog for v7.
v7:
    The first word and use terminating stop at the end of the sentence.
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

