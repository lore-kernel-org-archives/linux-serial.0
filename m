Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC34FD260;
	Tue, 13 Oct 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904091; cv=none; b=aJUmUF5wXGrgrj9puS0vo2PaS6glfd3IYluCnko5KwkyMr8WXeDSneCAfQAlR5St/hnCxIFmbtwUcyKmIdWctnf1b/nBlE5p0a94uUmGG9NQeAQ9yc1HrdWIB4rcQGh0O6/aaFY1FaYfpt61BpSDllFlYL5c1Rz2UMJb+yvdL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904091; c=relaxed/simple;
	bh=fjV6m6pm/f42cLr2GXmx0rbk7k+RVgbzNzPWFlgUX8E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Ww4kan+ZVP1sxa80l3CRC27JFPh9NpNcpgqO0YVAv+0VWxSOZ4bBak9DX70Ft50ANUviK45M6so1geYW5pKXY2K46gvInVyGE6Xi+JX1+4BCxzIQMDGckSHJteV8iZLHu8D6o/O6U3n2R3QlBARZ9JwJw+LBgkm7ZOOxwo6oqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aGwadCXO; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aGwadCXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791904083; bh=1dveUdj0X56769ICDxCgEKBf6OnKQ4M14FhSzBYxL2A=;
	h=From:To:Cc:Subject:Date;
	b=aGwadCXOyzCa5kAEGSfMGyMRMZLdFBpIH0px0PxUDaK2Kljj9HR8XVdM09MYb+c7C
	 0FSep5lcaWvQUb/ZexHfdN67B76ZXSj9kUHTSDeoXLZasO/vDWyWJ70MN7nBZlK8Jt
	 yCsMJ12Kx67c+fp4FPzYAQ9t408AefIy0GQxSwjk=
Received: from localhost.localdomain ([14.116.239.38])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 1B0B6EC5; Tue, 13 Oct 2026 23:06:48 +0800
X-QQ-mid: xmsmtpt1791904008twv7hqmnv
Message-ID: <tencent_A0A4CA13FA8B0F7ABF62EE438764D032F205@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6/1b2eleLQwS+qLqASgi6dRiJDZ2D+cUKVWlExYKxkaAHg7+ad5
	 BP1hDl0T2xE+XZMa3b6ydZDnHOBoYPgYzA3DgCzevAEsJH3/9QE99SyUiebRqZ8FL5ZwRmXX7e3w
	 VS4l2HEYdLagXBkNJWo3JfFa/DnPqbL+/7MhKlPi8I0lNdZMddsRpMnzkmFYpkzPzqPCXOR13YmK
	 FFznyEPRWf5fvB1sqKy34cN3D6t40JZByaKI+GnoDnW1iE1P7BJ97nr+H4SKJE0Kqw/F3QLVePAz
	 K6Raxka5rRNLLER4eSQiDKeF0A41Mtj4OQuILbiMi13ZdTfFCgPhwxnv9QnS4w0Ip7TEf8WMf2Zn
	 qEf1g49tiTjJabVw5sK0xPfMbhHqo9zeCGF3vHKDppTk9aotJmBnsQ0gepu560nBAIY/bGHt++y0
	 UijCsCrdnkdEDFGK5D440f0ewfXDfF3/WZ/bQY3e8oCMDVxUERM6OvlAjX9/zERnTUh58J2PhKMs
	 Riny9x36ENm7IIBV76i+Ezm3mL5zA2DUMXodBMyn1/UXXQte/SVQOqkrLg0Vx/r82lWwjqI1jMAL
	 J/WVvQkQ2bYSacw/TNhy7lxeWgrpgP50EVw1k7L/Sl6ZEnGfzW6+PDstxXvXbP+hMGIVAc23iInG
	 T+CdRBUzvj0rVaEqw0E1cbwaw5bdHmvo2Go1CyVZ8Ffw522bIQP0aXD1oL9LFXzT0YFmGlRG/CM4
	 7md+FYgm2l2IdjOZzZU0oSiqVtStrhEAlDeF/fwtlU8PX2IXgvRaENJCrKB4P+OXbRLx0DL5Q7Hl
	 ZMUvYqQj1u7zlNNmkUB+BpUd0U8wT8vqTMLwHouDIoJlaEDAalDYQLbYVdJh/SpLqTnZkOhXfZAE
	 kOFM2XdlXhvFVFallpKH+dYiHPdfIrjdxwFrZwjmlmlcSXNkXGWTkEdDOFIVpDxQG71d7RnWxnGE
	 9W2CA9qkfXEj1++TSqS8bFXsq/QLk7LxUOZuWTZtISMMbXulmSd6d1u42sOW+hWBaxiM1wSP0vhj
	 BmKF9wuBSUvbAdgB9QEId5Z+5JbWZRIEkpdBDv6xT2GUTRj/qfOKIhtKSneIDmHLQyK6s4h5qtv7
	 +eTkajm3mNybPNPxCIV18YzDN1QI+NyZ5Jp4VN
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: shatyuka@qq.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiannan Du <shatyuka@qq.com>
Subject: [PATCH v2] tty: hvc: dcc: Detect JTAG connection only on CPU core 0
Date: Tue, 13 Oct 2026 23:06:08 +0800
X-OQ-MSGID: <20261013150608.1378887-1-shatyuka@qq.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiannan Du <shatyuka@qq.com>

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

Signed-off-by: Jiannan Du <shatyuka@qq.com>
---
Changes in v2:
 - Use my real name in Signed-off-by
---
 drivers/tty/hvc/hvc_dcc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index dfc5c9c38f0..fc8dcbce9b5 100644
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

