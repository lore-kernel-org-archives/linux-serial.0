Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1845BFE
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600787; cv=none; b=gJBHY+AIYvToGiUICfmPhWXvuCnMcGCo7iIK3ziXV8gdv2k1z5WRhds6NmxBlg8u9n0mSOVbBriCE1Ih/1mYbw0dzStoUphR3QQYm1SCOwEntBEHPuaFrtWBpo5wZ0Pn8iFbF431nIes7aSqkw3U4qMa+1RriXed0z5Y1Q+mExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600787; c=relaxed/simple;
	bh=XgZGvDn4NtjjSfZg1L1mXFCQiDJ7Dx45zNhge3Cb1Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iYntFAW34CH8WYrU4ZQNcq6HejgGKE0c7UCR7dDQ8rfQYdGWpWQbO3CnU5g1krhkqcWfdA4JVyzDKOep7gyIoXgXe0uWTo7Wabwa3kLrPoiKErsC0PuZW1AnEeCoLvZgqWoHGZ3T4fDNUUlOWpamISt/40EQDJzUh2Y5XCYUKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rd76s-0001Xo-Mj; Thu, 22 Feb 2024 12:19:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rd76r-002Dh7-QY; Thu, 22 Feb 2024 12:19:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rd76r-009NXn-2N;
	Thu, 22 Feb 2024 12:19:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_dw: Emit an error message if getting the baudclk failed
Date: Thu, 22 Feb 2024 12:19:23 +0100
Message-ID: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XgZGvDn4NtjjSfZg1L1mXFCQiDJ7Dx45zNhge3Cb1Zw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1y27Yp1EJ/GdYCYOiHqiY1ITC69nlRdF2xnC4 TXMvyOIR0OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdctuwAKCRCPgPtYfRL+ ThJOCACoFHUk5qzT/tWW6lsv36mOhwreId/DykR5Bt5z/AhmUnKzXS2TDGoKaSwrDWkvhCHW2fp 28FJ9r/+rGmy2wpmlE+VWe8DhV6dWR5t6mwql6CE+jHGFSL+syeNCux/cxu3Kxu5DiZ+h/V+xqI OuROrGueoDNUIslLAv7vGnALlXUO/rLpW0qz2SitAQd2LOlqB+0PXE0ibL01Tb/3TUwN6arlVfi fFHxs3pU1tN3K6IgNP99KuRGwFql94F7CxVuBC1IK48yJGqYuZKOHDABINGL1BinIVXgKXhHY1r +NO8Wnxw1AhELFUQ8SAD59vq9uGx2V4vadhaDGP1euvGe1aq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

Instead of silently giving up, at least tell what the problem is.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 2d1f350a4bea..94aa3dddb71e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -597,7 +597,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (data->clk == NULL)
 		data->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(data->clk))
-		return PTR_ERR(data->clk);
+		return dev_err_probe(dev, PTR_ERR(data->clk),
+				     "failed to get baudclk\n");
 
 	INIT_WORK(&data->clk_work, dw8250_clk_work_cb);
 	data->clk_notifier.notifier_call = dw8250_clk_notifier_cb;
-- 
2.43.0

