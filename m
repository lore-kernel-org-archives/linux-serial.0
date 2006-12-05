From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/9] pcmcia: IDs for Elan serial PCMCIA devcies
Date: Mon, 4 Dec 2006 21:06:46 -0500
Message-ID: <20061205020646.GC2624@dominikbrodowski.de>
References: <20061205015942.GA2624@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:48250 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937543AbWLENT6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Dec 2006 08:19:58 -0500
Content-Disposition: inline
In-Reply-To: <20061205015942.GA2624@dominikbrodowski.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: tony.olech@elandigitalsystems.com, linux-serial@vger.kernel.org, alsa-devel@alsa-project.org

From: Tony Olech <tony.olech@elandigitalsystems.com>
Date: Wed, 29 Nov 2006 08:54:51 +0000
Subject: [PATCH] pcmcia: IDs for Elan serial PCMCIA devcies

Add IDs for Elan serial PCMCIA devices. In addition, move the
pdaudio_cf driver from matching based on manf_id and card_id to
the more specific prod_id1 and prod_id2 to avoid false
positives.

Signed-off-by: Tony Olech <tony.olech@elandigitalsystems.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/parport/parport_cs.c       |    1 +
 drivers/serial/serial_cs.c         |   24 ++++++++++++++++++++++++
 sound/pcmcia/pdaudiocf/pdaudiocf.c |    3 ++-
 3 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index b953d59..fb80fed 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -263,6 +263,7 @@ void parport_cs_release(struct pcmcia_de
 
 static struct pcmcia_device_id parport_ids[] = {
 	PCMCIA_DEVICE_FUNC_ID(3),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial+Parallel Port: SP230",0x3beb8cf2,0xdb9e58bc),
 	PCMCIA_DEVICE_MANF_CARD(0x0137, 0x0003),
 	PCMCIA_DEVICE_NULL
 };
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 00f9ffd..783b0c5 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -925,6 +925,30 @@ static struct pcmcia_device_id serial_id
 	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0", 0x96913a85, 0x8fbe92ae, 0x0877b627, "COMpad2.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID2("RS-COM 2P", 0xad20b156, "RS-COM-2P.cis"),
 	PCMCIA_DEVICE_CIS_MANF_CARD(0x0013, 0x0000, "GLOBETROTTER.cis"),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL100  1.00.",0x19ca78af,0xf964f42b),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL100",0x19ca78af,0x71d98e83),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL232  1.00.",0x19ca78af,0x69fb7490),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL232",0x19ca78af,0xb6bc0235),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CARD: CF232",0x63f2e0bd,0xb9e175d3),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CARD: CF232-5",0x63f2e0bd,0xfce33442),
+	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232",0x3beb8cf2,0x171e7190),
+	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232-5",0x3beb8cf2,0x20da4262),
+	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF428",0x3beb8cf2,0xea5dd57d),
+	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF500",0x3beb8cf2,0xd77255fa),
+	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: IC232",0x3beb8cf2,0x6a709903),
+	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: SL232",0x3beb8cf2,0x18430676),
+	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: XL232",0x3beb8cf2,0x6f933767),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial+Parallel Port: SP230",0x3beb8cf2,0xdb9e58bc),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
+	PCMCIA_MFC_DEVICE_PROD_ID12(2,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
+	PCMCIA_MFC_DEVICE_PROD_ID12(3,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
 	/* too generic */
 	/* PCMCIA_MFC_DEVICE_MANF_CARD(0, 0x0160, 0x0002), */
 	/* PCMCIA_MFC_DEVICE_MANF_CARD(1, 0x0160, 0x0002), */
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index fd3590f..a31d80c 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -299,7 +299,8 @@ static int pdacf_resume(struct pcmcia_de
  * Module entry points
  */
 static struct pcmcia_device_id snd_pdacf_ids[] = {
-	PCMCIA_DEVICE_MANF_CARD(0x015d, 0x4c45),
+	/* this is too general PCMCIA_DEVICE_MANF_CARD(0x015d, 0x4c45), */
+	PCMCIA_DEVICE_PROD_ID12("Core Sound","PDAudio-CF",0x396d19d2,0x71717b49),
 	PCMCIA_DEVICE_NULL
 };
 MODULE_DEVICE_TABLE(pcmcia, snd_pdacf_ids);
-- 
1.4.4

