Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3433D8;
	Wed, 14 Aug 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634292; cv=none; b=d9Fit6KxBgmVr5CDCzgzQjJmCsrv1NZOFV3rg0nOFeukeaKF2YhRrz4qCo90SeJJ1wg6ED285LHjBEK6Kiip6Ch1MYzig+lv0KWlPkpaNbdBuYwaUaGv1dFvgHOkIlj/yux2vbTXSTUGIoXPqFZFKiF7geGpbBLbWhva33cZXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634292; c=relaxed/simple;
	bh=m+MoOHkGiXtBn4BvwUlztRdZKfut3VVfRtqAHgJ1Vs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUm5Vtb/V03p0TKn3l32dFCioeBuViZcQRJHckDm++KTXq0smTQwNt8cnbavys62Rg+5JgtUqpUrkCsMTusMyofPZ7/I4TR3OjfrRmTQuVEjBXdiV67SNzmyAUYiabji3Qc6rmJACbC7xt5h7VgIH8KG2VwKOP1UyDfuDQwaeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=gUGiy9+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhRGp5oa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gUGiy9+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhRGp5oa"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E7AA81151B58;
	Wed, 14 Aug 2024 07:18:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 07:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1723634288; x=1723720688; bh=QYG9wVPSdd8HXxuMVtrKu
	Sk+0giFp7L5zjG5fxfeEPU=; b=gUGiy9+GltyefK24RffzzGmhltjdZeIrlB63U
	2g9hVUz7yEUquwkcf8FokT3rFH5ZOmfV9J8hNtS3oI5cueRq5fPzi63FuJqKcSkA
	gmfaaFZBQhpsJbAmFti3yyGHNDOJ1ITzWBlTqISOmBAPl1boAJLvdx2pZ+/b/4SV
	qQObA4sLnKRYCW1QPu0wRNPykUrWzT1IZOBC70FcB+HzJjH/po36R3GW3UVye8c0
	kdo8t5hWeyroIA1l2NJixYS6cGY0guHhiW/DMVJtUW0ZXrbSl6Zy5GiQynM8h9If
	ATtVun9qZeq6QSbdN4x3NfNd85qRfy99TpiRz0BsdHlFYohxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723634288; x=1723720688; bh=QYG9wVPSdd8HXxuMVtrKuSk+0giF
	p7L5zjG5fxfeEPU=; b=YhRGp5oae+wnyFcFzWQYQ5tlB09g5Tb+qWDEzthniHQ8
	wVEfPLb9N+55aVduBOrnS7M1B7y+5bxYGrm306Gc8Yijl3o/kZRHCKksU3Odkk20
	vssKQIgG+jaYUqvK3g/Slun6v8cAuW/nihLcpO//S5SjdAvC3En6vq24jmffmYR3
	DQ7IfsZgxvJWlf0a7Gh8wpmvCr/zhAI4Geklz0NLmWJq2grfSXf15+rkX0j7MLTq
	da6/IYpmPViIxku2STxMXQOhjwEmUV0CrjYzv8T94YS+odnoVW3Ue5ChLZHPv+xc
	yEmurOowNvIjqkKceHx/B9tNNITwLY3iGKhkgfsokA==
X-ME-Sender: <xms:cJK8Zp2gzhYiidbXmPTa_KpBtl9U-NXmuEhnzYIvldszHcmzvb2XhQ>
    <xme:cJK8ZgGN-dh0AA9Vf-2WL8mc3-yTOMywOOuUuB7EeeuNH7gmWbRICCjrdlKNYFzHm
    t92MiLYSEwknsQ>
X-ME-Received: <xmr:cJK8Zp5HPGnwNu7AgR_j7-Zk0dYLp7ngkQVj-iQlWxZjK5sfIsWRFOmnU69eggNmJECTbc52A7ePvJbNIjLpXwV8LJomi0LSU5gAqzo0n3nt3-0r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepifhrihhffhhinhcumfhrohgrhhdqjfgrrhhtmhgrnhcuoehgrhhifhhfihhnse
    hkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefhgeffjeejhfeffeffhefhjedv
    ffdvgfffudfhgffhudelieefjeeludetvdelieenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhrihhffhhinheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhrihhffhhinheskhhrohgrhhdrtghomhdprhgtphhtthhopeht
    hhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkhh
    hilhhmrghnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cJK8Zm3ejUW4nNlpJ0OkypmJb-AGMNLYW1rpmQV9JVgkivbDUd_tLg>
    <xmx:cJK8ZsFm_eFxYKqr1380Wu-6gKUYBjGuPo8oyFXD07UJZkCARzs7fw>
    <xmx:cJK8Zn_CCHxMuXG-MY-vvf_jM5837Ah2UsSwm3MNcxIXh_WpVi4Drw>
    <xmx:cJK8Zpl7KpCxB6yiwd4WfUOIsCxoUsaDtD10g6S5RR6I1Nk4J-Hsfw>
    <xmx:cJK8Zn1ZVEHOlXC7oEInKzOKVotr49KFXC7n3fvmMjBFgnLQ5176-T4y>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 07:18:07 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: [PATCH] Revert "serial: 8250_omap: Set the console genpd always on if no console suspend"
Date: Wed, 14 Aug 2024 13:17:47 +0200
Message-ID: <20240814111747.82371-1-griffin@kroah.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 68e6939ea9ec3d6579eadeab16060339cdeaf940.

Kevin reported that this causes a crash during suspend on platforms that
dont use PM domains.

Link: https://lore.kernel.org/r/7ha5hgpchq.fsf@baylibre.com
Cc: Thomas Richard <thomas.richard@bootlin.com>
Reported-by: Kevin Hilman <khilman@kernel.org>
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/tty/serial/8250/8250_omap.c | 33 +++++------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 1af9aed99c65..afef1dd4ddf4 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -27,7 +27,6 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
-#include <linux/pm_domain.h>
 
 #include "8250.h"
 
@@ -119,12 +118,6 @@
 #define UART_OMAP_TO_L                 0x26
 #define UART_OMAP_TO_H                 0x27
 
-/*
- * Copy of the genpd flags for the console.
- * Only used if console suspend is disabled
- */
-static unsigned int genpd_flags_console;
-
 struct omap8250_priv {
 	void __iomem *membase;
 	int line;
@@ -1655,7 +1648,6 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err = 0;
 
 	serial8250_suspend_port(priv->line);
@@ -1666,19 +1658,8 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	if (uart_console(&up->port)) {
-		if (console_suspend_enabled)
-			err = pm_runtime_force_suspend(dev);
-		else {
-			/*
-			 * The pd shall not be powered-off (no console suspend).
-			 * Make copy of genpd flags before to set it always on.
-			 * The original value is restored during the resume.
-			 */
-			genpd_flags_console = genpd->flags;
-			genpd->flags |= GENPD_FLAG_ALWAYS_ON;
-		}
-	}
+	if (uart_console(&up->port) && console_suspend_enabled)
+		err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1688,16 +1669,12 @@ static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err;
 
 	if (uart_console(&up->port) && console_suspend_enabled) {
-		if (console_suspend_enabled) {
-			err = pm_runtime_force_resume(dev);
-			if (err)
-				return err;
-		} else
-			genpd->flags = genpd_flags_console;
+		err = pm_runtime_force_resume(dev);
+		if (err)
+			return err;
 	}
 
 	serial8250_resume_port(priv->line);
-- 
2.45.2

