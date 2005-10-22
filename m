From: "Chen, Justin" <justin.chen@hp.com>
Subject: [PATCH] new hp diva console port
Date: Fri, 21 Oct 2005 17:30:44 -0700
Message-ID: <C1BB5827EB7A364EA57B4E8C7C02ADAC054EB2F2@cacexc04.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751281AbVJVAc7@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch adds the new ID 0x132a and configure the new PCI Diva console
port.  This device support only 1 single console UART. Please apply.
Thanks,
 
Justin Chen

--- 8250_pci.c.orig     2005-10-18 15:56:50.148489501 -0700
+++ 8250_pci.c  2005-10-18 15:55:25.624076474 -0700
@@ -178,6 +178,7 @@ static int __devinit pci_hp_diva_init(st
                rc = 4;
                break;
        case PCI_DEVICE_ID_HP_DIVA_POWERBAR:
+       case PCI_DEVICE_ID_HP_DIVA_HURRICANE:
                rc = 1;
                break;
        }
--- pci_ids.h.orig      2005-10-18 16:02:56.864305321 -0700
+++ pci_ids.h   2005-10-18 16:03:54.002976496 -0700
@@ -710,6 +710,7 @@
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST  0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX      0x1290
 #define PCI_DEVICE_ID_HP_DIVA_RMP3     0x1301
+#define PCI_DEVICE_ID_HP_DIVA_HURRICANE 0x132a
 #define PCI_DEVICE_ID_HP_CISSA         0x3220
 #define PCI_DEVICE_ID_HP_CISSB         0x3230
 #define PCI_DEVICE_ID_HP_ZX2_IOC       0x4031
