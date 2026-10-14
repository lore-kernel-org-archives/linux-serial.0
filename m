Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04753358E;
	Wed, 14 Oct 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988660; cv=none; b=WSPgEKlTh1wbs/4j5GNQ7u0xk7qghVU+lfVfL/HtjJUypXFtw3oWz65EvBcMXAgRJkGwxHbx1o9/Flzg3rLVg6wSqshNXOlhXEX98edhOssnDexWh7cD4ECWYclRDIjWfPKyxtkF+RtSDTFzpJ1K7D9WQsrAflWh9mfopmoRARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988660; c=relaxed/simple;
	bh=kLS9D5pS6vg2DzjEh048QLadb0JhjvSULgSeUGfO/aU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=PnYUK7vZOxmFkm6re/ApQULjivGLh9plsnCFBfMihrWEp0RmQTVsan1MZ4QoY3BRCbS9o5h5DEKF0oneLHYJoLQUU5uSfHncCsPsfOuibZpar9ywSfcue48fHI0DrgrvOiVoEk0Hm5L9dwKi1E9Fd3fV6zKdxO2hNQ5ADs1aCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MTe43cf3; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MTe43cf3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791988653; bh=6lR8x2xT9YiBmQ/SDlWdM+7xXOzupMUVJ7jbltkwUAE=;
	h=From:To:Cc:Subject:Date;
	b=MTe43cf3YMdHKBBvz6uHJPPO1SjzEmt6Lqg5l1JzzUV9vmVrveB5CcO3wobkFLwCw
	 75nl2hbcEoLKuLYELNk9o4FvZmEQo110on9czdlN+SzgtXhe0LiFOXFYWbVVD8wCAZ
	 QSY3Q+L1NLUayRshF/Q8QLlh3YobWSHhIVhcpu1g=
Received: from localhost.localdomain ([14.22.11.162])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 95F192AC; Wed, 14 Oct 2026 22:37:31 +0800
X-QQ-mid: xmsmtpt1791988651t8x4708f6
Message-ID: <tencent_77968AD30F111278CBAE934BCFD0AF00E807@qq.com>
X-QQ-XMAILINFO: Mi9y8J8807RS5jpJ99MgNVdl2oyl3GaLLLBH3E3O74+2Gjai+LszAWD+yNkQNb
	 Mumxbytqjvb/dus8n16fYU46SL07OY3coXZLzhrb+mXYZLn6teOD7Ar9aJCJCWePbEzNc4gt1BDK
	 cF9z3iI17DThj+cJ2Hh+9Tp4Q69JeGcGFSepdU+XgknShkQHvdSXaPqgXsg1MWuHDjT8uCvF+KJp
	 pDRrOe3DfWoMeYtgcIBX6MwPxReRqK14m3EWOggkY+8yo9jTVzFqsQ1oXFHYCUWNml1uAUdTVfP/
	 I8jp+AU6R0Xp5sdtZ3Y8Qh+BAixH0DfWMhHMlflI5t4RuKf0qCIOs98E/o5OGZVDwpEyPkV0XGtQ
	 JpUBRHkQprubiXe5oUGMymssr7KEgDb7g6jhnTeDjcQV7Yxm79XGmyV2z3ztbrRN01YfnA4eYxeP
	 zdw7QYOiV3AOh1OrXV5qRvbqwY8hDRzDukQiEP2Eoz0ZTD2d8s9F9MOLrt++0pTByQSgdfduaEE2
	 l/FO+pyIU+lu2+Wsh9rHNQSyyrwCt3pkBIqQd0x5LmA03xos0JDM6t0VIR0M0fEEXLaWygxdsCTU
	 VB/TM4Jshj8ZSP9PdDKlEoLBq6zf8fXkmq8gPsyaIz3E0kUtcF8VL5Z88fXX8OJO9guo6UYrjZnL
	 5q61R4n4KREjM01eqlDd2UUyd+16wJ2DX9hHWu3jMgn4ndbrgL8b5LRbhNXoZKdW27EWidhyrxHO
	 hY9aUi+hMSRdJp4WmtUQUTcotVqqB1892q5Jv+rUPOl3hDbOr4lZwEKagsaPeVzkQUIwI498hQdY
	 NM4al4UvXpYzW6O4wKBJJTLMmrhMPQ5fY54Hd3U7SI2bZypvUT+bqCp5uULDyTZDopaKrDJw0EGe
	 xI0DOUuJFp4PEHYgA7gWfP3OSjJMTM7YHJnd9Zhd6HO/r307FEaN42NmebHOYaLc40XQRaM1AwA9
	 6tjbWF1WWQN3CZk77CNH5Pk6uHQ6hAGVv9zuGGrwq4ORcq+J/8og4bl3oj66PmTJz4+ncFcG5jVV
	 HZWaQX2jM4QmaJnDijUugmgGyh1W/dz35bdc9d0Y2jvQEBTQeo
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: shatyuka@qq.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiannan Du <shatyuka@qq.com>
Subject: [PATCH v3] tty: hvc: dcc: Detect JTAG connection only on CPU core 0
Date: Wed, 14 Oct 2026 22:37:23 +0800
X-OQ-MSGID: <20261014143723.2595216-1-shatyuka@qq.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiannan Du <shatyuka@qq.com>

On SMP, migration can occur inside hvc_dcc_check() during device_initcall,
so the CPU writing the probe character and the CPU reading the TXfull
status may not be the same, which can hang the system.

Commit 4419da5d5d4b1788568b ("tty: hvc: dcc: Bind driver to CPU core0
for reads and writes") cached the DCC availability detected on core 0
during console_initcall. However, this is not sufficient: if core 0
does not detect DCC as available and another CPU later calls
hvc_dcc_check(), the check is not actually performed on core 0.

Since JTAG is not expected to be plugged or unplugged during kernel
boot, especially between console_initcall and device_initcall, checking
DCC availability multiple times is unnecessary. Cache the return value
from hvc_dcc_console_init and reuse it in hvc_dcc_init. This avoids
complex SMP-related code and ensures the result is always from core 0.

Signed-off-by: Jiannan Du <shatyuka@qq.com>
---
Changes in v3:
 - Fix the initcall order described in the commit message
 - Update the comment for dcc_core0_available
Changes in v2:
 - Use my real name in Signed-off-by
---
 drivers/tty/hvc/hvc_dcc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index dfc5c9c38f0..0223b26b5b2 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -29,6 +29,9 @@ static DEFINE_SPINLOCK(dcc_lock);
 static DEFINE_KFIFO(inbuf, u8, DCC_INBUF_SIZE);
 static DEFINE_KFIFO(outbuf, u8, DCC_OUTBUF_SIZE);
 
+/* Cached result of hvc_dcc_check() on core 0 */
+static bool dcc_core0_available;
+
 static void dcc_uart_console_putchar(struct uart_port *port, u8 ch)
 {
 	while (__dcc_getstatus() & DCC_STATUS_TX)
@@ -90,36 +93,18 @@ static ssize_t hvc_dcc_get_chars(uint32_t vt, u8 *buf, size_t count)
 }
 
 /*
- * Check if the DCC is enabled. If CONFIG_HVC_DCC_SERIALIZE_SMP is enabled,
- * then we assume then this function will be called first on core0. That way,
- * dcc_core0_available will be true only if it's available on core0.
+ * Check if the DCC is enabled. This function will be called once on core 0.
  */
 static bool hvc_dcc_check(void)
 {
 	unsigned long time = jiffies + (HZ / 10);
-	static bool dcc_core0_available;
-
-	/*
-	 * If we're not on core 0, but we previously confirmed that DCC is
-	 * active, then just return true.
-	 */
-	int cpu = get_cpu();
-
-	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP) && cpu && dcc_core0_available) {
-		put_cpu();
-		return true;
-	}
-
-	put_cpu();
 
 	/* Write a test character to check if it is handled */
 	__dcc_putchar('\n');
 
 	while (time_is_after_jiffies(time)) {
-		if (!(__dcc_getstatus() & DCC_STATUS_TX)) {
-			dcc_core0_available = true;
+		if (!(__dcc_getstatus() & DCC_STATUS_TX))
 			return true;
-		}
 	}
 
 	return false;
@@ -265,7 +250,8 @@ static int __init hvc_dcc_console_init(void)
 {
 	int ret;
 
-	if (!hvc_dcc_check())
+	dcc_core0_available = hvc_dcc_check();
+	if (!dcc_core0_available)
 		return -ENODEV;
 
 	/* Returns -1 if error */
@@ -279,7 +265,7 @@ static int __init hvc_dcc_init(void)
 {
 	struct hvc_struct *p;
 
-	if (!hvc_dcc_check())
+	if (!dcc_core0_available)
 		return -ENODEV;
 
 	if (IS_ENABLED(CONFIG_HVC_DCC_SERIALIZE_SMP)) {
-- 
2.36.1

