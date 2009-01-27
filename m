From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/4] Move jsm_remove_one to .devexit.text
Date: Tue, 27 Jan 2009 11:51:06 +0000
Message-ID: <20090127115051.6236.480.stgit@localhost.localdomain>
References: <20090127114820.6236.67019.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37025 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753179AbZA0Lur (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jan 2009 06:50:47 -0500
In-Reply-To: <20090127114820.6236.67019.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

The function jsm_remove_one is used only wrapped by __devexit_p so defi=
ne
it using __devexit.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Alan Cox <number6@the-village.bc.nu>
---

 drivers/serial/jsm/jsm_driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/serial/jsm/jsm_driver.c b/drivers/serial/jsm/jsm_d=
river.c
index 338cf8a..92187e2 100644
--- a/drivers/serial/jsm/jsm_driver.c
+++ b/drivers/serial/jsm/jsm_driver.c
@@ -180,7 +180,7 @@ static int jsm_probe_one(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
 	return rc;
 }
=20
-static void jsm_remove_one(struct pci_dev *pdev)
+static void __devexit jsm_remove_one(struct pci_dev *pdev)
 {
 	struct jsm_board *brd =3D pci_get_drvdata(pdev);
 	int i =3D 0;

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
