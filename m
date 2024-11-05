Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EA2A1CA;
	Tue,  5 Nov 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812827; cv=none; b=vDvp5TLK7lEudLIaozsk1nrmHiJTvTaLBc0tIcgedKu4EJF+frKZo5azJ6frZJ4QOKqbrq8AECh8kpKFHWVYDS42RvvuLY7reI72ySsNQal2UbT3KTJO7NHE3rI03ddiQLUf7d4e/cUu1IEX9odp15y1GOfDXIlbGxjnRMp3k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812827; c=relaxed/simple;
	bh=t4B7PF0GVND0Gy78sX+dlhk6AmSUO1xVVVrNeGvJcPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FtlKbZdzV24Mq5EIxBeh09ywWZsSmDAjIuGXY62lIMNwV0Hw2J+O1WMSsO/7jSlbZ8kR1PwUjHnsH53bUg9WZWTasg/xeb02iyEZeltDpLOeuHU9pFLz0lVuwqANVGzQWzfuR8GaBixam1IvOiCD+Nnztt/jE76k7osVw9EFLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H/sI/e3+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H/sI/e3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730812825; x=1762348825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t4B7PF0GVND0Gy78sX+dlhk6AmSUO1xVVVrNeGvJcPk=;
  b=H/sI/e3+zLnUBS4Z+sluwio6iKxJ7+WnUuAScfF61zCkwS4jdE5ET8ea
   bZzAEd2/GfhuOBKYKHtc5/Pp/og8+U6dhXJeEVIxWOUy45WU/uRkEvzI9
   Pu33IUEkBuHYndqN8XwKt0gulvt+vzjj7eR6f33vtgT04HlAXtdnOL4ri
   +7L51Z8eQnxgaekbqUuZHEIG07XE0VT7zsgrfcWrNzFdeq1werbaqi2ho
   NWzFWYRK24Vpr7Hf+qU/x8XBg5CGKeRUReZKomg8h6nwuSXWOdKwb+kMV
   j13bW+zHRewd26YzH3lPb7OgxD2CEyLeItI7ocDuuCvc0adM+SfqK0xYQ
   A==;
X-CSE-ConnectionGUID: 7UwmSSx7Sxu5wyqCow4vig==
X-CSE-MsgGUID: uSOrPrBvQjyXZyAaZGLjqg==
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="34411485"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2024 06:20:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Nov 2024 06:19:57 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 5 Nov 2024 06:19:55 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <richard.genoud@bootlin.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <hari.prasathge@microchip.com>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] tty: atmel_serial: Use devm_platform_ioremap_resource()
Date: Tue, 5 Nov 2024 15:19:46 +0200
Message-ID: <20241105131946.22449-1-mihai.sain@microchip.com>
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

base-commit: 2e1b3cc9d7f790145a80cb705b168f05dab65df2
-- 
2.47.0

