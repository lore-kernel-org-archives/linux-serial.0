From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 16/33] serial_cs: add Merlin U630 IDs
Date: Fri, 31 Mar 2006 22:13:54 +0200
Message-ID: <20060331201354.GE28037@dominikbrodowski.de>
References: <20060331195852.GB27888@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:27863 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932146AbWCaUfP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 31 Mar 2006 15:35:15 -0500
Content-Disposition: inline
In-Reply-To: <20060331195852.GB27888@dominikbrodowski.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk

From: Domen Puncer <domen.puncer@ultra.si>

Add Merlin U630 IDs.

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/serial/serial_cs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

1de9cedfbdff1d8adb662cd3afc5bda66e393351
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index c303336..2307d94 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -739,6 +739,7 @@ static struct pcmcia_device_id serial_id
 	PCMCIA_MFC_DEVICE_PROD_ID1(1, "Motorola MARQUIS", 0xf03e4e77),
 	PCMCIA_MFC_DEVICE_PROD_ID2(1, "FAX/Modem/Ethernet Combo Card ", 0x1ed59302),
 	PCMCIA_DEVICE_MANF_CARD(0x0089, 0x0301),
+	PCMCIA_DEVICE_MANF_CARD(0x00a4, 0x0276),
 	PCMCIA_DEVICE_MANF_CARD(0x0101, 0x0039),
 	PCMCIA_DEVICE_MANF_CARD(0x0104, 0x0006),
 	PCMCIA_DEVICE_MANF_CARD(0x0105, 0x410a),
@@ -757,6 +758,7 @@ static struct pcmcia_device_id serial_id
 	PCMCIA_DEVICE_PROD_ID14("MEGAHERTZ", "PCMCIA MODEM", 0xf510db04, 0xbd6c43ef),
 	PCMCIA_DEVICE_PROD_ID124("TOSHIBA", "T144PF", "PCMCIA MODEM", 0xb4585a1a, 0x7271409c, 0xbd6c43ef),
 	PCMCIA_DEVICE_PROD_ID123("FUJITSU", "FC14F ", "MBH10213", 0x6ee5a3d8, 0x30ead12b, 0xb00f05a0),
+	PCMCIA_DEVICE_PROD_ID123("Novatel Wireless", "Merlin UMTS Modem", "U630", 0x32607776, 0xd9e73b13, 0xe87332e),
 	PCMCIA_DEVICE_PROD_ID13("MEGAHERTZ", "V.34 PCMCIA MODEM", 0xf510db04, 0xbb2cce4a),
 	PCMCIA_DEVICE_PROD_ID12("Brain Boxes", "Bluetooth PC Card", 0xee138382, 0xd4ce9b02),
 	PCMCIA_DEVICE_PROD_ID12("CIRRUS LOGIC", "FAX MODEM", 0xe625f451, 0xcecd6dfa),
-- 
1.2.4

