Received: from mx-relay28-hz2.antispameurope.com (mx-relay28-hz2.antispameurope.com [94.100.136.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3E32E15A
	for <linux-serial@vger.kernel.org>; Fri, 19 Dec 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158152; cv=pass; b=dyP3L4jok1rKH66FWE9R9ZTI6vrpC1lST5r666fKgHeQDOPVscpR4dx7RTLW+d4CiMmV52pe7lDTt5AwsUy8dso/g3M/Yg9k6QOBc8zNZ4QMn/AJtklMVnez0IfXH6rPD2DkEW9Hr18lXjy3MWePnqcvXaqyVp32RXB/nJhmI/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158152; c=relaxed/simple;
	bh=gAV5OzuQXwWPCMJv316Z6wQuDjqrcDF85HWGHeKlv7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuETePBcWOARoXv9e9X2J9Vp0LcSv1METqVkenDgiytMIniQzBsNvss+FcJC2fGYMlVCCNhGGjumo2lPCWmZ+w4iOSpnqjFDN/B6DazoVhMfZ/j4lR9L6zonjP92pegoYu2/fq45+Q5OJabNfCX+qOTkL8OCa5fqaGETVwoxLDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YGN9xaEO; arc=pass smtp.client-ip=94.100.136.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YGN9xaEO"
ARC-Authentication-Results: i=1; mx-gate28-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=7z+cBDDiomQU7X5BwXP3yaiVOwHDXbtZONGbFihOuDQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1766158114;
 b=W7ucKpAUs5QMLRGCkISsoEtG4k6OBoq2tq13GpGhh3rt0UaHh15wBb1nHUF1rWeNf6zWvlO5
 vY3vMcRBBzSp8ejfd4e1LQF8c3tJHYahZCkbCBUgvLFyRh33Ee3bLFkB9R+Ozt0LJ7bXWj9PdHk
 AYvgdiKHG84TFdM7eLvxVOD2NH31eJEpGGgmEPO64V/WUK+9zrsLN1pIJs4rtOm5sHQr1ryWQYT
 ihun6qbM71iYNps37N+NuyRRB5I02A9TesuiNjqZKmINsL5heyN5On2SMejzYOBXnXjcRcN5YEs
 853dsMehCpdSPa1fMZZaVa07Ud5ZA91PzPWRb4eRy9FYQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1766158114;
 b=qu3ZAiv/zFXTCSU3BBnsZnRSTHOZvcPvxRICKi2Qe67LdrPAcnV3ft9DaSgItfISohuSlB45
 NkF6H6sBzZSzNg+GIyGI6dMGyZCxkjYWFADdWb/f7nWtV/w+AHOOG/cf4u2/cdNs76qOcm58i41
 gwwYKb0JHaffMKCmJybBcC+bWof+8hoH8mq8EMJM8IVrtFurP2Y5hfAZXxhi5tED7Dt22o1KQW7
 opHqnGRF8OEc2QYF5qfmaG4HEwSjyRbhBszsDx9KFXHCDOXL2NCAbhqVjXHaVbP+yf8Rl+8D5kz
 RZZ2Sw/g2HVwuHBBRRJO1uaxwA6nRm6Xq5couAY1TBAcQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay28-hz2.antispameurope.com;
 Fri, 19 Dec 2025 16:28:33 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id DE6E25A0CA0;
	Fri, 19 Dec 2025 16:28:19 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 1/1] serial: core: Fix serial device initialization
Date: Fri, 19 Dec 2025 16:28:12 +0100
Message-ID: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-serial@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay28-hz2.antispameurope.com with 4dXryr37zzz1QFJX
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:b6045aaf1d5356b3f007ca7799d8fc75
X-cloud-security:scantime:2.162
DKIM-Signature: a=rsa-sha256;
 bh=7z+cBDDiomQU7X5BwXP3yaiVOwHDXbtZONGbFihOuDQ=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1766158113; v=1;
 b=YGN9xaEOFWqGFwgvThuqNzklOAgKN5cT3OOGZEoXd/PURqU6040fOnAI9WTlK2N3Bf3tilFm
 A13jk0FrsdWXWc5pwxMEH8jyiVhNG0SJH7YNiAKu1lGcTgxGuw9pT6/CfR6l68dz8rlMaw2l/KQ
 ERP1IOSNljPEn1++65VETF8XNKLOZplmKnHZYZq0vsGOWSCr5swV7RJMRtiRwZtj/SxuzAgaZqJ
 JnlwiLcsVl8G3R2G6bZd2TY46BxITvl5CvLGf24E7e1psAXP1yO5BCjmYwrdBKxmdfZxnNW0n0o
 OvX6o7Za0PAuhpIFvX7UAujAc7mfb18qE0TEfaIxyOIKA==

During restoring sysfs fwnode information the information of_node_reused
was dropped. This was previously set by device_set_of_node_from_dev().
Add it back manually

Fixes: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
Suggested-by: Cosmin Tanislav <demonsingur@gmail.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/tty/serial/serial_base_bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 8e891984cdc0d..1e1ad28d83fcf 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -74,6 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
+	dev->of_node_reused = true;
 
 	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
 
-- 
2.43.0

