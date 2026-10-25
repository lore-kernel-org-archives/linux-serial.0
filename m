Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792893983;
	b=SzlDZhoSrVHlhqjOThgd9//YKhJx+YoB74s1YfAIs6KH4jK0SLuBIteUgorPpTad5Ekp
	 U28+U1xXathm/ARBCWJ3FSUIOElgPU4vM8MmnT8bkgXKrZyqe91sJ1N7Uz/COTdKZ9eNG
	 NE4gyOL2K4zRRpq97WXVviuvP2GM/JHBKaDXGEHoj+KF9cvg02v+IwZy2ehyqSddP5Bqn
	 RUcX5s9fpk6iC3PF6R5jFR/9uzAtuxySfDXDe0ao3VrPL2ev9UifGEb4p0QuNnbv8ZJ0f
	 YOgD17Tcg4RNtF0mWVY4AVcU5F4rzwQyHYkFcc5LkJd2+NnP5KDRfFDb6bbGSYJKBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792893983;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WVhn12b4N24AJ1WPG089D/lakUuR4+PyygMCKsFpCEs=;
	b=zPm2EYd8syHbwjxAS6Bu1tfBVwjl7z2jEr07YEV66slz4cd8fP08gqxNz1J75Pv0HMhc
	 brdkZD7qzJuQmtexYlaNCHNcFhBkmi1pyUVwS/5oew2J0/3e78QIyMKgbO+UgPXXmvH1f
	 aoYuH7Brl2ny+3Jk23iBxKVM7r4P0fEepoQXVjE+uiCwnVtbNyVcE3rYQ+xq5e5nJ/1FF
	 Fwmd3SkXLjXOJeg3jxBk0QwmOCn7ZkmlwvioDP7Q82r7luMXyIbGxXHPNnIHWEeB9xVbO
	 SYeIRIgP4yoxe2GQ3d6fQoNYNQsVxBQT3DpHqpHJixkFUTYhM3T44bPz+kyfhFdPC8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KW8g+Lek;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E1606A31A;
	Sun, 25 Oct 2026 02:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC9E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KW8g+Lek
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792893971; bh=WVhn12b4N24AJ1WPG089D/lakUuR4+PyygMCKsFpCEs=;
	h=From:To:Cc:Subject:Date;
	b=KW8g+Lek87w2ucpwLeA24efwcvXmcFQgFO6Kpdk3/PqaEMMg4PSruMs4y/EjpgcpO
	 mXDC0Iwk+b9FYeJvklkVEXJWEzmFxZXhQQcn+HawT5P+K+6E3cAAL6wWl1CtZSoWN9
	 Jz/pV4+pgrMyZZNyD15Dnk8gHKEE4Qys9vuU5PgI=
Received: from kernel-lab.tail5e91bb.ts.net ([39.144.194.158])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 189BFE07; Sun, 25 Oct 2026 10:06:09 +0800
X-QQ-mid: xmsmtpt1792893969tqaus357m
Message-ID: <tencent_23BFCCE74C508AD599E72011EAE5E409C006@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe+2vMzbfGV1q91RIeCxPLcIhE/Wse252dGGcyTcYgEF0yG0sURy
	 y1hAsy5rCpV/E/PPRKtYoz93ggjjpnDGReqyGoTt0+DJ1klgdXxbXWKyjRlYp/IjRxGGoMYx81l9
	 eSQ/Abkm8QV7iC4UW5y2JVHLMCJGKgaloYFOvbZvK6mMcM6SulSMA1TDgcdaoE474IQZjgi4ESc6
	 26NqwrSiqtT1RjYAlWLobm8YxnlZJpeJqHAaN7eiXBqr1Q7N0ITjp+Y05gD6hDJaLMyVYqxpdtKT
	 K0mVRDlCN5R6KQ4jJJ3w+EfYyishc7Y8iniXDHIKgj9JB1cpifSpazPDo2TyorATNPjcJcT9opUW
	 ltX8rvPEEiBPWq1b9t/D20tUBXRUSM+9o3cLQrIqgo0uyg8+s24JYWqHSuAQvXKceeBZ5BuhG50o
	 bcTn8fmlhPZWPsQvNJC+xxPcrKrbLGMcM82uT76aChswv2g+by91SoA2jM+Y3omAx4EogKsxdkjM
	 BgJQYExSh7ZJU2HCoe3J5uTM4CHOHuZAwEi0WZjF/taV1/v3rGlixMMaOumsXVeRiDO+fWgAqoA4
	 iQYDKc8We51ypwcPcaH14fEKqexqLWg3buAimnEq1CWrXnRUjK26SVFKY6yFpdvb1v0kbNFIyqCg
	 pBLKq7adAHxOcTH3aZ3CZEtidUGGLuQoVz8vLtFGL3/K/WLXe0YqyO4JJUPEGnjz1WBUCsk4hkMI
	 nUlUZvizlIlh9yzZns+eFJEr3mCtjdIte/VfVCJQy0HnuxvYJt7PMXSPqNd3mFidPujJuxxBE9PK
	 3dCV//md0TXzR8O7INETdmR4jHNhpkA9RJ5CpwHLpXtaf0sibgGTCMKMagZvz4ouXupseeXxBNyK
	 kCUsPW6vy6VEK0Dxf1duLrZBUZHcTKBGeYer1qqiSBX5JrjA149cVc7Q0FI5E8JWfHUeUZMMI3AU
	 +jrZMqHY+Eqzu8LiSyO1voOsO9n2PVglLxVOyVtlemkqVFvd7cpe8du7q3Xr8UUvb9oi+wrlNGpI
	 TNxfcDsNCP0gA1kBCnVfrM+1ultDBoKAxfLZorqw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Yingjie Wang <1075151112@qq.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: Disallow runtime changes to nr_uarts
Date: Sun, 25 Oct 2026 10:06:09 +0800
X-OQ-MSGID: <20261025020609.2177758-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_uarts is clamped to UART_NR while the initial 8250 ports are
initialized, but it is also used as the iteration bound by the remove
path. serial8250_get_port() assumes that the index is within the
serial8250_ports array.

Allowing nr_uarts to be changed through sysfs can therefore make the
remove path access beyond the end of serial8250_ports. The value also
describes the number of initialized or dynamically registered ports, so
changing it after setup is not safe even when the new value is within the
array limit.

Make the nr_uarts module parameter read-only through sysfs. Boot-time and
module-load parameter parsing remain supported and still go through the
existing clamp.

Tested on x86-64 with CONFIG_KASAN=y under QEMU:
- 8250.nr_uarts=5 is honored at boot.
- Writes to /sys/module/8250/parameters/nr_uarts are rejected.

Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 drivers/tty/serial/8250/8250_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 9d9dba4e0439a..2b07337407fd1 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -385,7 +385,7 @@ MODULE_DESCRIPTION("Generic 8250/16x50 serial platform driver");
 module_param_hw(share_irqs, bool, other, 0644);
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
 
-module_param(nr_uarts, uint, 0644);
+module_param(nr_uarts, uint, 0444);
 MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
 
 MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);

base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
-- 
2.43.0

