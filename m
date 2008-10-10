From: Alan Cox <alan@redhat.com>
Subject: [PATCH 15/27] Char: sx, fix io unmapping
Date: Fri, 10 Oct 2008 11:49:54 +0100
Message-ID: <20081010104952.31597.35527.stgit@localhost.localdomain>
References: <20081010103447.31597.42992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47577 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759327AbYJJKt6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2008 06:49:58 -0400
In-Reply-To: <20081010103447.31597.42992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

From: Jiri Slaby <jirislaby@gmail.com>

board->base is increased for CF cards after mapping. Use board->base2
for unmapping the region, since it holds the original/correct address.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/sx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index c385206..5b8d7a1 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2504,7 +2504,7 @@ static void __devexit sx_remove_card(struct sx_board *board,
 		del_timer(&board->timer);
 		if (pdev) {
 #ifdef CONFIG_PCI
-			pci_iounmap(pdev, board->base);
+			pci_iounmap(pdev, board->base2);
 			pci_release_region(pdev, IS_CF_BOARD(board) ? 3 : 2);
 #endif
 		} else {
@@ -2703,7 +2703,7 @@ static int __devinit sx_pci_probe(struct pci_dev *pdev,
 
 	return 0;
 err_unmap:
-	pci_iounmap(pdev, board->base);
+	pci_iounmap(pdev, board->base2);
 err_reg:
 	pci_release_region(pdev, reg);
 err_flag:

