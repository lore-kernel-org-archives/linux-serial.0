From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 71/75] drivers/char/cyclades.c: cy_pci_probe: fix error path
Date: Fri, 02 Jan 2009 13:50:07 +0000
Message-ID: <20090102135005.13472.64200.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37692 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755837AbZABNtw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:49:52 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>

We forgot to release resources in one case.

Addresses http://bugzilla.kernel.org/show_bug.cgi?id=12137

Reported-by: Florian Lohoff <flo@rfc822.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/cyclades.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/char/cyclades.c b/drivers/char/cyclades.c
index 5e5b1dc..6a59f72 100644
--- a/drivers/char/cyclades.c
+++ b/drivers/char/cyclades.c
@@ -5010,7 +5010,7 @@ static int __devinit cy_pci_probe(struct pci_dev *pdev,
 		if (nchan == 0) {
 			dev_err(&pdev->dev, "Cyclom-Y PCI host card with no "
 					"Serial-Modules\n");
-			return -EIO;
+			goto err_unmap;
 		}
 	} else if (device_id == PCI_DEVICE_ID_CYCLOM_Z_Hi) {
 		struct RUNTIME_9060 __iomem *ctl_addr;

