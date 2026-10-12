Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37248FF9A;
	Mon, 12 Oct 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818380; cv=none; b=PdeUP6W+vtyCFfLr4gtOBSztX/NrluyQ0re6PfeqIS/udrAPpHiZY7zJ0biK5zDVUx43jbPL+qwVf5fWqeV5vR6/Otk0Azc6ZPX94natoAQQvQ3a1KfTLmiVSBC5Zuo73wtDc26hWzXDJjF5bJEEQbrpueP2GVgkhFyy+0tKlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818380; c=relaxed/simple;
	bh=OWylyIefKFPUmHKX93Ks0I5PsUBqwAK54eM+KhIrKeE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=NjaB2OM0asDa6f97paAAINKQQbtjfZOfbPjDA+uuP3LlXStIo5dFd3+4t9yNDrcluQP87xM5IcCAfu0cDADA3x202VpdKGaJfIWWqk3xO4Xzxl+Iw0VuXXak0Psv88qymD5sYbLNBO89aV9ozbWT5hWp38YokkDeRx9ZAjJcC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=veF5P943; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="veF5P943"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791818373; bh=5fgfkf1VJtkzY+vpSfke4wLKD2w9rs5+vYerqyHRQeo=;
	h=From:To:Cc:Subject:Date;
	b=veF5P943Ctwerb2fj5Tkb4d3c78c4gB7zhNHQvLO0tqEmlflPANw35j5aCG0jLhDh
	 h25QxUEXCLd7cKWdyQtVawwsaNdRrYGkbG5MWp4RaA5RE1d014i15Q5Cur6/ClpeCn
	 GYVegP+/U4vVOHuz8oZ6FgrwSIDBr0+Yc6CDqu0o=
Received: from localhost.localdomain ([14.116.239.37])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 4DF99A53; Mon, 12 Oct 2026 23:19:31 +0800
X-QQ-mid: xmsmtpt1791818371tp425s1w5
Message-ID: <tencent_323D31BEC6A1CD2A843E2E48242C774ECE09@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLsLTkWQTkJW4GtCG8e4/sWtKYGel8myIFXIcZ/e59lzta51p0WT
	 B/q/deeiNpOL2CpiqEUmcKQON+vQB9FLOKvKwfmQ9hwjYvyah9MArTzqz29g598rB8VTTLQDQhyJ
	 QM+R7FUVtYEqeEwaVXOKnBNK+UbUHkyMKqWxrxmdWiTHfe4B4Ujv9G5RjTYC2dA7KijtpkoPN0ox
	 aZiC/ePtiu8XbupK9axI0LVShr+loO49MInYJEsrGUEvbg78vX8jCmu34EYYzFHp4KaHfqaR/TY4
	 MnI9g0SoGp1iCP7E9NAzChkh9NN8hAn4Qgef7PYV9zDTI6UhyAdYqWCCdTV6MhzfqgJ7gkxtTwtg
	 8eELPaXDiX2QYa9lYj8CsaYMBm/izuU5609uvvwHTu3zyMsh8jDT7S/rokwujzjzXxhorT4tlZFF
	 aIZ9TS081Q5kKG18LkrDpTG0ha8LZ9/OwpM6m9BclbXMm071eF82MLY8zqJzCY197iYALxd96sm6
	 EPS/WcLx086Uyz03C27rZ2oQ82AHmInugFCwZlIqUXzoVvFGzzfCI4v6hmFfCNAqJik/3hL46nV+
	 dS/93KMfzD1vQoa9FZ5/Ij3eycmflzvjFNc3ctY0S84M7WHcz0C0h8sGNafAhFEWeHfjp5BX/w7K
	 CZ+2CVW36DHwSXbrSnGHPOQmDjZZf+nmFp2YPqtqbq8ZmgvbAc4fVJFDLhXsRywZi2UKRFjKFR2k
	 iVmf1P/sVcpWNXNGNRjfhGsz7OhqHY7Z/4jGLqymL9za0FlsrQJoJtBO+Q/P4dGguAsgyxiXtp8O
	 wo+1TtZyyVsK7ppcqaR4y6VSUZdmiOL635eMjtWbyxtquguS6ruRdT4S3gZofnwYfOJ8F1E5Tcd+
	 XGlgDILegUFWZNg+A1+U72+8u2BLvQKYQ0psI6wvvDG8V0JMAp8SSIfwdaoOkc4XXfXXnqaLHUHy
	 OOp1I3RpGLG1fYIWm05tj84Lf9pxLOnO7+9L5Bnsu/8sxv9mEAT1+BrW5Cg7qUdp7nRfslRwPcZP
	 JgRn2tPpT7mWu09tStEfd0dcVcy4XIqlaI3BQexEgzH5v/h5dR
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: shatyuka@qq.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shatyuka <shatyuka@qq.com>
Subject: [PATCH] tty: hvc: dcc: Detect JTAG connection only on CPU core 0
Date: Mon, 12 Oct 2026 23:17:33 +0800
X-OQ-MSGID: <20261012151733.53461-1-shatyuka@qq.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shatyuka <shatyuka@qq.com>

On SMP, migration can occur inside hvc_dcc_check() during
device_initcall, so the CPU writing the probe character and the CPU
reading the TXfull status may not be the same, which can hang the
system.

Commit 4419da5d5d4b1788568b ("tty: hvc: dcc: Bind driver to CPU core0
for reads and writes") cached the DCC availability detected on core 0
during console_initcall. However, this is not sufficient: if DCC is
not detected as available and another CPU later calls
hvc_dcc_check(), the check is not actually performed on core 0.

Multiple checks are unnecessary: nobody is going to plug/unplug JTAG
during kernel boot and expect it to work. Cache the return value of
hvc_dcc_check() from device_initcall and reuse the cached value during
console_initcall. This avoids complex SMP-related code and ensures the
result is always from core 0.

Signed-off-by: Shatyuka <shatyuka@qq.com>
---
 drivers/tty/hvc/hvc_dcc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index dfc5c9c38f07..fc8dcbce9b5b 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -29,6 +29,9 @@ static DEFINE_SPINLOCK(dcc_lock);
 static DEFINE_KFIFO(inbuf, u8, DCC_INBUF_SIZE);
 static DEFINE_KFIFO(outbuf, u8, DCC_OUTBUF_SIZE);
 
+/* Cached result of hvc_dcc_check() */
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

