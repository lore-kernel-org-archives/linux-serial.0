From: Thomas Wright <TWright@tmcdesign.com>
Subject: [PATCH] serial: Add support for Advantech PCM-3614I/PCM-3618I
 serial expansion cards
Date: Mon, 19 May 2014 20:30:51 +0000
Message-ID: <AA40FFC7EE521F4AB21A1671B51B7A510E7E7E56@hqsvrex.tmcdesigncorp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from alpha.tmcdesign.com ([70.90.209.226]:56228 "EHLO
	mailsecurity.tmcdesigncorp.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750923AbaESUqF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 May 2014 16:46:05 -0400
Received: from mailsecurity.tmcdesigncorp.local (127.0.0.1) id hf9moq0171so for <linux-serial@vger.kernel.org>; Mon, 19 May 2014 14:30:53 -0600 (envelope-from <TWright@tmcdesign.com>)
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

From: Thomee Wright <TWright@TMCDesign.com>

Add support for Advantech PCM-3614I/PCM-3618I serial expansion cards
Signed-off-by: Thomee Wright <TWright@TMCDesign.com>
---
Advantech makes a variety of serial port expansion cards, including the PCM-3614 and PCM-3618 (http://www.advantech.com/products/1-2JKLU5/PCM-3618/mod_5DF8DE5A-6B49-4429-BB2F-CB35FE1D168D.aspx). They have a driver available which was forked from the kernel driver ages ago and has not been maintained in quite some time, available at http://support.advantech.com.tw/Support/DownloadSRDetail_New.aspx?SR_ID=1-1W8FZ5&Doc_Source=Download Their driver added several features to aid in communications at higher baud rates, but at normal serial port speeds, the standard 8250_pci driver functions just fine. This patch adds the necessary PCI IDs to recognize this card.

>From bug 75681 (https://bugzilla.kernel.org/show_bug.cgi?id=75681)

--- linux-3.13.0/drivers/tty/serial/8250/8250_pci.c.orig        2014-05-07 10:46:44.034975484 -0700
+++ linux-3.13.0/drivers/tty/serial/8250/8250_pci.c     2014-05-07 10:46:52.346975113 -0700
@@ -1732,6 +1732,8 @@ pci_wch_ch353_setup(struct serial_privat
 #define PCI_VENDOR_ID_ADVANTECH                0x13fe
 #define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620        0x3620
+#define PCI_DEVICE_ID_ADVANTECH_PCI3618 0x3618
+#define PCI_DEVICE_ID_ADVANTECH_PCIf618 0xf618
 #define PCI_DEVICE_ID_TITAN_200I       0x8028
 #define PCI_DEVICE_ID_TITAN_400I       0x8048
 #define PCI_DEVICE_ID_TITAN_800I       0x8088
@@ -3855,6 +3857,13 @@ static struct pci_device_id serial_pci_t
        {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
                PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
                pbn_b2_8_921600 },
+       /* Advantech also use 0x3618 and 0xf618 */
+       {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3618,
+               PCI_DEVICE_ID_ADVANTECH_PCI3618, PCI_ANY_ID, 0, 0,
+               pbn_b0_4_921600 },
+       {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCIf618,
+               PCI_DEVICE_ID_ADVANTECH_PCI3618, PCI_ANY_ID, 0, 0,
+               pbn_b0_4_921600 },
        {       PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
                PCI_SUBVENDOR_ID_CONNECT_TECH,
                PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
