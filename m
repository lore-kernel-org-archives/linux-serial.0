From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 3/15] pcmcia: another ID for serial_cs.c
Date: Fri, 30 Jun 2006 21:53:58 +0200
Message-ID: <20060630195358.GD9095@dominikbrodowski.de>
References: <20060630195107.GA9095@dominikbrodowski.de> <20060630195217.GB9095@dominikbrodowski.de> <20060630195255.GC9095@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:36027 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932119AbWF3UMm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 30 Jun 2006 16:12:42 -0400
Content-Disposition: inline
In-Reply-To: <20060630195255.GC9095@dominikbrodowski.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk


From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Wed, 26 Apr 2006 19:57:32 +0200
Subject: [PATCH] pcmcia: another ID for serial_cs.c

Add an ID for "GlobeTrotter" cards which need a CIS override

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/serial/serial_cs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 2c70773..cbf260b 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -786,6 +786,7 @@ static struct pcmcia_device_id serial_id
 	PCMCIA_DEVICE_CIS_PROD_ID12("ADVANTECH", "COMpad-32/85B-4", 0x96913a85, 0xcec8f102, "COMpad4.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0", 0x96913a85, 0x8fbe92ae, 0x0877b627, "COMpad2.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID2("RS-COM 2P", 0xad20b156, "RS-COM-2P.cis"),
+	PCMCIA_DEVICE_CIS_MANF_CARD(0x0013, 0x0000, "GLOBETROTTER.cis"),
 	/* too generic */
 	/* PCMCIA_MFC_DEVICE_MANF_CARD(0, 0x0160, 0x0002), */
 	/* PCMCIA_MFC_DEVICE_MANF_CARD(1, 0x0160, 0x0002), */
-- 
1.4.0

