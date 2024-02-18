Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075F11CAF
	for <linux-serial@vger.kernel.org>; Sun, 18 Feb 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246498; cv=none; b=uHcEQlO6/WoB+H2Cl5Nc8x1Dpn7RGNi7Mhx+qzA79wXsX6Ys/esutMtfGmioiW/Nb4RsG2pnUKJSrnHq0GY6lGf0YeDx6LojVokM3KeZoTezBrC297/fxsJJSxsyLF1VeLdscGpNnTLXR6lvSxV1cgywicCaPp44oIQ3zQfyXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246498; c=relaxed/simple;
	bh=AVWHhRh1rZMkwA2URNmnJI+jdTqne4a/YOWi4eegs0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwq0J8NrYpkL6FpzGJdn/wHaVQRLE0cD4W5FC4in7RqIcEv2xYBmoIB5zZZ+cAXGpRTHmebS45Chsv4Fn+bt3yBkhupMbdC5ciGP1KItQJ3+1WWr2mpp9EdN51n+eoOvvHKg8ahvXEvAeqi9ZivVjecXnql2NjUQwycRNi8hVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwY-0005Ao-VP; Sun, 18 Feb 2024 09:54:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-001PwC-OB; Sun, 18 Feb 2024 09:54:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-007555-28;
	Sun, 18 Feb 2024 09:54:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	kernel@pengutronix.de,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] serial: pmac_zilog: Convert to platform remove callback returning void
Date: Sun, 18 Feb 2024 09:53:56 +0100
Message-ID:  <90b9a65ad8800b4d047aa5219959008a01588a94.1708246007.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AVWHhRh1rZMkwA2URNmnJI+jdTqne4a/YOWi4eegs0Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0cWwLcYXBrfNVxZWHwBLLAgaMjPlcc9FbBHMN FeMh2AuxwaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdHFsAAKCRCPgPtYfRL+ TiUPB/9Jpv/UmaIvvyPpPatx8W987RaRSLcnwRLbsHWzG7ocK0kmC3UBgBpSt7lmw5KKbap44mp Y3ejiJws7Ocsc7SG+bR4/ADcRi5rbjw+wukP3Z+tKIjSlP5efGAFWUB/zI9hlBgMj4XjEUhah8N qICU+H1GjixDKtKN7GaPAIFfCqL8/ovjphBQae/e/scGXU/CldycRQGJyK+LFkZSoo3N1enWDvS teZp9corAPhXnL5g3Qk1jfMYb5f8prHvBG8EWO9eob29oiIHsN0MYW8Kh4BEfbQM3s+T5uHQ6sC 3X3La7Q00KbwtTt+x2izcNxFicLl/Mpmb3sFmVa35U0rFYjG
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

Note that pmz_detach() is only called once pmz_attach() was successfully
called. In that case platform_set_drvdata() was called and so
platform_get_drvdata() won't return NULL. This allows to drop the
respective check and so get rid of the only error path in pmz_detach().

After that the driver can be trivially converted from always returning
zero in the remove callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/pmac_zilog.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index c8bf08c19c64..05b5b3b456ac 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1717,18 +1717,13 @@ static int __init pmz_attach(struct platform_device *pdev)
 	return uart_add_one_port(&pmz_uart_reg, &uap->port);
 }
 
-static int __exit pmz_detach(struct platform_device *pdev)
+static void __exit pmz_detach(struct platform_device *pdev)
 {
 	struct uart_pmac_port *uap = platform_get_drvdata(pdev);
 
-	if (!uap)
-		return -ENODEV;
-
 	uart_remove_one_port(&pmz_uart_reg, &uap->port);
 
 	uap->port.dev = NULL;
-
-	return 0;
 }
 
 #endif /* !CONFIG_PPC_PMAC */
@@ -1797,7 +1792,7 @@ static struct macio_driver pmz_driver = {
 #else
 
 static struct platform_driver pmz_driver = {
-	.remove		= __exit_p(pmz_detach),
+	.remove_new	= __exit_p(pmz_detach),
 	.driver		= {
 		.name		= "scc",
 	},
-- 
2.43.0

