Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0699313E02F
	for <linux-serial@vger.kernel.org>; Fri, 29 Mar 2024 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749299; cv=none; b=E8j/w4sTrvrrKxHD+V6I96fD6rHtfz+UKRPkzq3Jh0RNOjxHRErdMul+DZWUjGsxfuGhVi1MxCxU2AEI6s7JTlxx3VNHWUZ/zAbY/qfW30cuzspyi6vn3anuLfwA0hHeerJK8VTmxcmHfCx/QSeo6npmvu3v7FSpwb+dWuQDIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749299; c=relaxed/simple;
	bh=WwLc102XeYwZwzW3cybR17GYB+ofAI/4n3gKjg8xR20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwnrrlPxQ233zRq1C7SpWhjvPWRorCqkK96FSVrRVFzJYZnjim7RX+LslVYTBIAE50V0j9ZNLPmdXMJoqezj2QilUPQEIVdrDPwBWVHB/uQravLthIx2jbug4JoAFj+zdYDGQZDYkke0e5wVp2X9GsNdIJR/R5AVvzdsr9y++Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqKBX-0004gT-MQ; Fri, 29 Mar 2024 22:54:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqKBX-009GMC-7h; Fri, 29 Mar 2024 22:54:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqKBX-00DTjy-0V;
	Fri, 29 Mar 2024 22:54:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] serial: ami: Mark driver struct with __refdata to prevent section mismatch
Date: Fri, 29 Mar 2024 22:54:40 +0100
Message-ID:  <043afcbc94ad90079301f3c7738136a7993a1748.1711748999.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <2e3783106bf6bd9a7bdeb12b706378fb16316471.1711748999.git.u.kleine-koenig@pengutronix.de>
References:  <2e3783106bf6bd9a7bdeb12b706378fb16316471.1711748999.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=WwLc102XeYwZwzW3cybR17GYB+ofAI/4n3gKjg8xR20=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBzijRkqhZMAgH/jj2wot8WnuuEcuR35OQTqoa HxETeaJ7A6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgc4owAKCRCPgPtYfRL+ TlFyB/99tEe8PsNy2x4XEaKBmh7YcfGF2CMkAxh+l+QXvElnsS1gY5Ju0CddcPcSMrEzjIM04rm BM2Ib1uGGulFhQcVeWQMpzn4HlYNv8vB43j6Mpc2YwJWsMbqz2wJ5my8WJ+zFw4zfZpcx+vS8hu RrX/Ws6X2vik2JysZCe+dFBXK2jA7vaKq/ikPxSWvxTcFMVrFrOQl/IOMv6vK/cfNkmO/0txRSw dea69sg07LSwdJ4dTuU4PPxnQ1vy4Ob5eSjmxXNU5CE2e8UTXjk4k8OUliNx0O1JYI2qPjfXAWO QZnMh407StR4/a20SnGViosDO1219AVbFJqeHRVvNFGs8Nux
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

As described in the added code comment, a reference to .exit.text is ok
for drivers registered via module_platform_driver_probe(). Make this
explicit to prevent the following section mismatch warning

	WARNING: modpost: drivers/tty/amiserial: section mismatch in reference: amiga_serial_driver+0x8 (section: .data) -> amiga_serial_remove (section: .exit.text)

that triggers on an allmodconfig W=1 build.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/amiserial.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index e27360652d9b..8c964da75f2d 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1578,7 +1578,13 @@ static void __exit amiga_serial_remove(struct platform_device *pdev)
 	free_irq(IRQ_AMIGA_RBF, state);
 }
 
-static struct platform_driver amiga_serial_driver = {
+/*
+ * amiga_serial_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver amiga_serial_driver __refdata = {
 	.remove_new = __exit_p(amiga_serial_remove),
 	.driver   = {
 		.name	= "amiga-serial",
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
-- 
2.43.0

