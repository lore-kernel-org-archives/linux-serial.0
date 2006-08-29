From: Helge Deller <deller@gmx.de>
Subject: [PATCH] constify some serial structs
Date: Tue, 29 Aug 2006 21:57:29 +0200
Message-ID: <200608292157.29355.deller@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pwJ9ECGeyeil/1t"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:51121 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751347AbWH2T5d (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 15:57:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk

--Boundary-00=_pwJ9ECGeyeil/1t
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

- some const- ification and usage of ARRAY_SIZE() in serial drivers

Signed-off-by: Helge Deller <deller@gmx.de>


--Boundary-00=_pwJ9ECGeyeil/1t
Content-Type: text/plain;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index cd1979d..851e483 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -458,11 +458,11 @@ static int pci_siig_setup(struct serial_
  * growing *huge*, we use this function to collapse some 70 entries
  * in the PCI table into one, for sanity's and compactness's sake.
  */
-static unsigned short timedia_single_port[] = {
+static const unsigned short timedia_single_port[] = {
 	0x4025, 0x4027, 0x4028, 0x5025, 0x5027, 0
 };
 
-static unsigned short timedia_dual_port[] = {
+static const unsigned short timedia_dual_port[] = {
 	0x0002, 0x4036, 0x4037, 0x4038, 0x4078, 0x4079, 0x4085,
 	0x4088, 0x4089, 0x5037, 0x5078, 0x5079, 0x5085, 0x6079, 
 	0x7079, 0x8079, 0x8137, 0x8138, 0x8237, 0x8238, 0x9079, 
@@ -470,35 +470,34 @@ static unsigned short timedia_dual_port[
 	0xD079, 0
 };
 
-static unsigned short timedia_quad_port[] = {
+static const unsigned short timedia_quad_port[] = {
 	0x4055, 0x4056, 0x4095, 0x4096, 0x5056, 0x8156, 0x8157, 
 	0x8256, 0x8257, 0x9056, 0x9156, 0x9157, 0x9158, 0x9159, 
 	0x9256, 0x9257, 0xA056, 0xA157, 0xA158, 0xA159, 0xB056,
 	0xB157, 0
 };
 
-static unsigned short timedia_eight_port[] = {
+static const unsigned short timedia_eight_port[] = {
 	0x4065, 0x4066, 0x5065, 0x5066, 0x8166, 0x9066, 0x9166, 
 	0x9167, 0x9168, 0xA066, 0xA167, 0xA168, 0
 };
 
 static const struct timedia_struct {
 	int num;
-	unsigned short *ids;
+	const unsigned short *ids;
 } timedia_data[] = {
 	{ 1, timedia_single_port },
 	{ 2, timedia_dual_port },
 	{ 4, timedia_quad_port },
-	{ 8, timedia_eight_port },
-	{ 0, NULL }
+	{ 8, timedia_eight_port }
 };
 
 static int pci_timedia_init(struct pci_dev *dev)
 {
-	unsigned short *ids;
+	const unsigned short *ids;
 	int i, j;
 
-	for (i = 0; timedia_data[i].num; i++) {
+	for (i = 0; i < ARRAY_SIZE(timedia_data); i++) {
 		ids = timedia_data[i].ids;
 		for (j = 0; ids[j]; j++)
 			if (dev->subsystem_device == ids[j])
diff --git a/drivers/serial/mcfserial.c b/drivers/serial/mcfserial.c
index 832abd3..df2154c 100644
--- a/drivers/serial/mcfserial.c
+++ b/drivers/serial/mcfserial.c
@@ -118,17 +118,16 @@ static struct mcf_serial mcfrs_table[] =
 };
 
 
-#define	NR_PORTS	(sizeof(mcfrs_table) / sizeof(struct mcf_serial))
+#define	NR_PORTS		ARRAY_SIZE(mcfrs_table)
 
 /*
  * This is used to figure out the divisor speeds and the timeouts.
  */
-static int mcfrs_baud_table[] = {
+static const int mcfrs_baud_table[] = {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
 	9600, 19200, 38400, 57600, 115200, 230400, 460800, 0
 };
-#define MCFRS_BAUD_TABLE_SIZE \
-			(sizeof(mcfrs_baud_table)/sizeof(mcfrs_baud_table[0]))
+#define MCFRS_BAUD_TABLE_SIZE	ARRAY_SIZE(mcfrs_baud_table)
 
 
 #ifdef CONFIG_MAGIC_SYSRQ

--Boundary-00=_pwJ9ECGeyeil/1t--
