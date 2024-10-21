Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3921CF291;
	Mon, 21 Oct 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493048; cv=none; b=HUO7qzUs4dTG5peAOH1rQjLiH7ZjWa1yHHhovs26CbAKdkmd0d6MEZnUNU62qcbumLsGDeOPedwMZHAnDoJz7G9BDKmtnQg+KkC411B7GRkLkT9Qsvh2vC+54zlNWfOzXXQcy1FljcJ7US0IuZGXWYwwBR5supU1UK4beqc2r0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493048; c=relaxed/simple;
	bh=yjd+fqelGYJuRa6KsIo04zhW9f3/9LxbbAlWVSzv/cg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t0DZhwou0JXBjX7UqISaSFV6QsOlBnAW1YzYcA0PUpxUrKO/og62QpAP7ovFfpZTjQnAC2aE1+F853oYavs1SC9r2+Jq1Wp/dg4qm1fSABqI6PCuT7nnvmAkdvbSdAV2QLCVEWe4D1Wwqw9YLTImRDSeDSnHniLOGcPwa7ZihrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e9hoF5ZH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e9hoF5ZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729493046; x=1761029046;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yjd+fqelGYJuRa6KsIo04zhW9f3/9LxbbAlWVSzv/cg=;
  b=e9hoF5ZHNWg7yTITEt8vIVS3mzVZooKtb/B6lUDDpdwxqiQ208E7IvIP
   xFHbNqDGuDvl9CyYoIPc/LvF6Mz1OsOwZC2K927YNGgrFWAZoMF8tksYg
   wMw+KA6p7RCb/c05v5KUL28P4S5OHq6sX8zCaOiIKi6qXVil4K4hqo84o
   rfreJCm59+Q9I5eW+bU3t2oou/CYR8iLNu/S08K82ILet9fJSH9FLd2PB
   FlKmyRPbUWeD+pPnPniekqFSIAt+hXG1k5UkJ0UcMoJarblwAfTmOXcGI
   Nfysuj0UqwxQ+Apr8XlBfyIVHYmMQKX+guJLMYwG8JqH5GvEmlVTk84Qd
   A==;
X-CSE-ConnectionGUID: prXNASNtSEGI7fl1Bae9BQ==
X-CSE-MsgGUID: VYjXu8agQeOmUhYFhm1Ywg==
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="33047165"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2024 23:43:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 20 Oct 2024 23:43:54 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 20 Oct 2024 23:43:52 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <richard.genoud@bootlin.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [RFC PATCH] tty: atmel_serial: Use devm_platform_ioremap_resource()
Date: Mon, 21 Oct 2024 09:43:21 +0300
Message-ID: <20241021064321.3440-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Simplify the request port function by using a single call
to devm_platform_ioremap_resource().

This will also enhance the printing from /proc/iomem:

cat /proc/iomem | grep flexcom ; cat /proc/iomem | grep serial

f0004000-f00041ff : f0004000.flexcom flexcom@f0004000
f8020000-f80201ff : f8020000.flexcom flexcom@f8020000
f0004200-f00043ff : f0004200.serial serial@200
f8020200-f80203ff : f8020200.serial serial@200
fffff200-fffff3ff : fffff200.serial serial@fffff200

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 09b246c9e389..e1107f14ec98 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2419,17 +2419,11 @@ static void atmel_release_port(struct uart_port *port)
 static int atmel_request_port(struct uart_port *port)
 {
 	struct platform_device *mpdev = to_platform_device(port->dev->parent);
-	int size = resource_size(mpdev->resource);
-
-	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
-		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
-		port->membase = ioremap(port->mapbase, size);
-		if (port->membase == NULL) {
-			release_mem_region(port->mapbase, size);
-			return -ENOMEM;
-		}
+		port->membase = devm_platform_ioremap_resource(mpdev, 0);
+		if (IS_ERR(port->membase))
+			return PTR_ERR(port->membase);
 	}
 
 	return 0;

base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
-- 
2.47.0

