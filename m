From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: [PATCH] Add support esd CPCI-ASIO4 4-port serial board
Date: Fri, 15 Dec 2006 09:37:57 +0100
Message-ID: <200612150937.57517.matthias.fuchs@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:50302 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbWLOIrH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Dec 2006 03:47:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by comm-neu.esd (Postfix) with ESMTP id A2CE2108048
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2006 09:38:00 +0100 (CET)
Received: from comm-neu.esd ([127.0.0.1])
 by localhost (comm [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 12141-01 for <linux-serial@vger.kernel.org>;
 Fri, 15 Dec 2006 09:38:00 +0100 (CET)
Received: from debby.esd (debby.esd [10.0.0.190])
	by comm-neu.esd (Postfix) with ESMTP id 2B430108046
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2006 09:38:00 +0100 (CET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

this patch adds support for esd's CPCI-ASIO4 4-port serial interface board.
The new PCI ids are added to include/linux/pci_ids.h. 

Matthias

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>

---
commit 5513f516c850f1e3422ca4316a255b09edbe214e
tree 7141cb8087cdf9da6601a95d4921db70262e7c3a
parent e1036502e5263851259d147771226161e5ccc85a
author Matthias Fuchs <matthias.fuchs@esd-electronics.com> Fri, 15 Dec 2006 
09:27:36 +0100
committer Matthias Fuchs <matthias.fuchs@esd-electronics.com> Fri, 15 Dec 2006 
09:27:36 +0100

 drivers/serial/8250_pci.c |   11 +++++++++++
 include/linux/pci_ids.h   |    3 +++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 4d0ff8f..3de8f14 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -936,6 +936,7 @@ enum pci_board_num_t {

        pbn_b2_1_115200,
        pbn_b2_2_115200,
+       pbn_b2_4_115200,
        pbn_b2_8_115200,

        pbn_b2_1_460800,
@@ -1249,6 +1250,12 @@ static struct pciserial_board pci_boards
                .base_baud      = 115200,
                .uart_offset    = 8,
        },
+       [pbn_b2_4_115200] = {
+               .flags          = FL_BASE2,
+               .num_ports      = 4,
+               .base_baud      = 115200,
+               .uart_offset    = 8,
+       },
        [pbn_b2_8_115200] = {
                .flags          = FL_BASE2,
                .num_ports      = 8,
@@ -1990,6 +1997,10 @@ static struct pci_device_id serial_pci_t
        {       PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_DUALMODEM,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0,
                pbn_panacom2 },
+       {       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+               PCI_VENDOR_ID_ESDGMBH,
+               PCI_DEVICE_ID_ESDGMBH_CPCIASIO4, 0, 0,
+               pbn_b2_4_115200 },
        {       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
                PCI_SUBVENDOR_ID_CHASE_PCIFAST,
                PCI_SUBDEVICE_ID_CHASE_PCIFAST4, 0, 0,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 51180db..4d170e0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -949,6 +949,7 @@
 #define PCI_DEVICE_ID_PLX_R753         0x1152
 #define PCI_DEVICE_ID_PLX_OLITEC       0x1187
 #define PCI_DEVICE_ID_PLX_PCI200SYN    0x3196
+#define PCI_DEVICE_ID_PLX_9030         0x9030
 #define PCI_DEVICE_ID_PLX_9050         0x9050
 #define PCI_DEVICE_ID_PLX_9080         0x9080
 #define PCI_DEVICE_ID_PLX_GTEK_SERIAL2 0xa001
@@ -1681,6 +1682,8 @@
 #define PCI_VENDOR_ID_ELECTRONICDESIGNGMBH 0x12f8
 #define PCI_DEVICE_ID_LML_33R10                0x8a02

+#define PCI_VENDOR_ID_ESDGMBH           0x12fe
+#define PCI_DEVICE_ID_ESDGMBH_CPCIASIO4        0x0111

 #define PCI_VENDOR_ID_SIIG             0x131f
 #define PCI_SUBVENDOR_ID_SIIG          0x131f

-- 
-----------------------------------------------------------------------
Dipl.-Ing. Matthias Fuchs             esd electronic system design gmbh
http://www.esd-electronics.com                    Vahrenwalder Str. 207
phone: +49-511-37298-0, fax: -68                30165 Hannover, Germany
-----------------------------------------------------------------------

