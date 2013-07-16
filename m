From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4/4] pci_ids.h: remove PCI_VENDOR_ID_ADDIDATA_OLD and
 PCI_DEVICE_ID_ADDIDATA_APCI7800
Date: Tue, 16 Jul 2013 16:14:41 +0100
Message-ID: <1373987681-18245-5-git-send-email-abbotti@mev.co.uk>
References: <1373987681-18245-1-git-send-email-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1373987681-18245-1-git-send-email-abbotti@mev.co.uk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Abbott <abbotti@mev.co.uk>
List-Id: linux-serial@vger.kernel.org

These two defines are no longer used.  They were only used by the PCI
serial driver "8250_pci" to support the original ADDI-DATA APCI-7800
card.  In that driver, PCI_VENDOR_ID_ADDIDATA_OLD has been replaced with
PCI_VENDOR_ID_AMCC which has the same value (0x10e8), and
PCI_DEVICE_ID_ADDIDATA_APCI7800 has been replaced with a local #define
PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 with the same value (0x818e).

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 include/linux/pci_ids.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9d99119..6dec3d6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2258,12 +2258,10 @@
 /*
  * ADDI-DATA GmbH communication cards <info@addi-data.com>
  */
-#define PCI_VENDOR_ID_ADDIDATA_OLD             0x10E8	/* actually AMCC */
 #define PCI_VENDOR_ID_ADDIDATA                 0x15B8
 #define PCI_DEVICE_ID_ADDIDATA_APCI7500        0x7000
 #define PCI_DEVICE_ID_ADDIDATA_APCI7420        0x7001
 #define PCI_DEVICE_ID_ADDIDATA_APCI7300        0x7002
-#define PCI_DEVICE_ID_ADDIDATA_APCI7800        0x818E
 #define PCI_DEVICE_ID_ADDIDATA_APCI7500_2      0x7009
 #define PCI_DEVICE_ID_ADDIDATA_APCI7420_2      0x700A
 #define PCI_DEVICE_ID_ADDIDATA_APCI7300_2      0x700B
-- 
1.8.2.1
