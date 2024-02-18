Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0A18623
	for <linux-serial@vger.kernel.org>; Sun, 18 Feb 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246489; cv=none; b=c/Ld6kTl5vVCONOSNUfMJX+HgQ8IA3AP8LTUhujozRXYMlnoyiz9UgEHERR5S34idFTyqq5yh7nHACzharyn3EhMUpSu8bBn3eVHHQ6P+Xkp8w3LD5qb327aglPJ0ilMSuWK84N3zhE5+n+ORrSH1E/Ih5D+ZT2NtFCgKSYVrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246489; c=relaxed/simple;
	bh=DSdg7CPBE2YGQLE5GzZb2mAtS6eg4EX1BkeG+YI2Pz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/On/bIDgm4NolWUgSAwqcNLYUJY8Fi7ai9B2DOYKaKRzojmDn6vPasVXqCYy6YDy4enEFngres4c0kNIOa9idW6J/nT4lLJBLA0SEGj8LeLC6Pw0U43RAyP801559JzCPDBjBT9hD0FDHkCsKS87dAjl/NFJPQL+DDSaulhD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-0005AK-OM; Sun, 18 Feb 2024 09:54:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-001Pw6-7Y; Sun, 18 Feb 2024 09:54:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-00754x-0V;
	Sun, 18 Feb 2024 09:54:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: kernel@pengutronix.de,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/3] tty: amiserial: Convert to platform remove callback returning void
Date: Sun, 18 Feb 2024 09:53:54 +0100
Message-ID:  <f2ad92c97086c42dab23cdb165d9f978bbf3d3b5.1708246007.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708246007.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708246007.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=DSdg7CPBE2YGQLE5GzZb2mAtS6eg4EX1BkeG+YI2Pz4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0cWplzWkhDF5WXPy3oEbWjt2wQtxdVF8u+IVA U2z8caiFtWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdHFqQAKCRCPgPtYfRL+ Tk4kCAC4iBM7y97nb73UTriHKIu2TIkwgGCXST5sMmC/YXqtWC0S+vK7ddR2IyolB9rCNKEXfYj 2ujq29LndlM561GkIjVsBtcW9749jLROpm/VZgvWR4CTWeVqnO7P2K9wgkEuWRpmFCK11w7hRNK GWuDvjbMOmn5V/8InAReSxfuIFEG46NqjZ7QXo2JMGrliBvWSbdETl/828ePLb5puCFffjJyO5E H0AZW24QK/YDl63SdbEWEXa9+AIxpfi1J/13FOy/U8Ll9OP6PkZyLLAhzAdeL8QPKMEGLOsF42J vza3Ry1pr88QXaPw13FrMHSFVH/ZnNfJpZMbTBsr5NWDn8gL
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/amiserial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 7716ce0d35bc..e27360652d9b 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1566,7 +1566,7 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __exit amiga_serial_remove(struct platform_device *pdev)
+static void __exit amiga_serial_remove(struct platform_device *pdev)
 {
 	struct serial_state *state = platform_get_drvdata(pdev);
 
@@ -1576,12 +1576,10 @@ static int __exit amiga_serial_remove(struct platform_device *pdev)
 
 	free_irq(IRQ_AMIGA_TBE, state);
 	free_irq(IRQ_AMIGA_RBF, state);
-
-	return 0;
 }
 
 static struct platform_driver amiga_serial_driver = {
-	.remove = __exit_p(amiga_serial_remove),
+	.remove_new = __exit_p(amiga_serial_remove),
 	.driver   = {
 		.name	= "amiga-serial",
 	},
-- 
2.43.0

