Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B61862D
	for <linux-serial@vger.kernel.org>; Sun, 18 Feb 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246488; cv=none; b=rRWH9YEqQrBqrVcYyOolcpH4jfTai6nB7V2wX5iTyBc0ITyfnFqm9f9VymGVrFjF4ZVA25vTbydg2oz6M2/XOa4K4w/ihi4uU1Jz8L+aEjNfg+iaNfI4y4PFjBWHXiPbht72oSmMn5y/PrP0MH5cAEVh9mOJcRZL0+IirjGGmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246488; c=relaxed/simple;
	bh=5C4y4sSEcEhm0HTwMJKbGUwmMVDxuBCI+udRg9SR99Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=subDVwaKMH2yGsvV0wb5fkuSOBcxz+IsunBRfZ24GV8AcR9POGOadu5ZxNzPi89Nx63R7fLsJydylSIOnXxsFUCh3rVv2nIQeButUgWrSO256/N9Xp9G2kLSKrdn614QxOLdwDavrfzyvOGO5QC5yae5EpVvB4g2jUiaSK9nvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-0005AM-T1; Sun, 18 Feb 2024 09:54:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-001Pw9-G4; Sun, 18 Feb 2024 09:54:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-007551-1L;
	Sun, 18 Feb 2024 09:54:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: kernel@pengutronix.de,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/3] tty: goldfish: Convert to platform remove callback returning void
Date: Sun, 18 Feb 2024 09:53:55 +0100
Message-ID:  <60d0657daf8f4f9e2e3e282941ba542f08dc7f96.1708246007.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5C4y4sSEcEhm0HTwMJKbGUwmMVDxuBCI+udRg9SR99Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0cWqYk20BIvK/Ge14PeX6tjFi7hJp/5fcdE1n 35Q6rebiwmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdHFqgAKCRCPgPtYfRL+ TuzzCAChzfNSX0yyipG/UaJUwNKSUYhIb8hjFziPtDpE49Qcw87jO3v4ndZANQz/qc8VGE/Iweq Yvf4VXOghDED3KGCTr2PkSD2vAqwoJMEVxJjFSTyo+Tl0K74eHqbBSWRhWPKkV2PjXvC2Pgn5aP ql0T/3xf23bqXk3h5g6kkZ0OpifvYxWx64jF4VNmFIOj9jehCNvtEoAQCfB4wGnBYAhsiQPD8aZ p5pqWPyTQSEDY9hUp2aXZ7p55bPknQSJWEYmyzjHQCbplka4Vz7eKOwxazPjmvmWj6Txvvo+U1e 5yTBzdiQyiAa8QMP6YTGeOyr/+BnRLTPxHG2TJLAhS6WtD3u
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
 drivers/tty/goldfish.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index d27979eabfdf..34421ec06a69 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -408,7 +408,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int goldfish_tty_remove(struct platform_device *pdev)
+static void goldfish_tty_remove(struct platform_device *pdev)
 {
 	struct goldfish_tty *qtty = platform_get_drvdata(pdev);
 
@@ -424,7 +424,6 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 	if (goldfish_tty_current_line_count == 0)
 		goldfish_tty_delete_driver();
 	mutex_unlock(&goldfish_tty_lock);
-	return 0;
 }
 
 #ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
@@ -462,7 +461,7 @@ MODULE_DEVICE_TABLE(of, goldfish_tty_of_match);
 
 static struct platform_driver goldfish_tty_platform_driver = {
 	.probe = goldfish_tty_probe,
-	.remove = goldfish_tty_remove,
+	.remove_new = goldfish_tty_remove,
 	.driver = {
 		.name = "goldfish_tty",
 		.of_match_table = goldfish_tty_of_match,
-- 
2.43.0

