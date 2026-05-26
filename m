Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202761DF27F
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804093; cv=none; b=tcpnJZAkyvhVVTZZOLrz1MWAZZIbdD9aednoXr2hZRqsM8sO01ahKv9KItVkEpg5vxY+fGISm7zqAK6ukr5npkYfUfwckFJN8v0zIzmtDh1M63e/6cxjyz9tIFpRR2miO6w6DNVFaAZ+3mKKKfmSbhTtVnCUoA9rlnvq5MlO8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804093; c=relaxed/simple;
	bh=0z2edL3R2p8KARdyZ1ceVn7mBtxSXzQGCr6CF1SB408=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQEmqrXDSVWmT7Cx9jmGPudo9Ru+lOmzlz99KPzIEUV1S8TPL6sHtSQLiziXMKhp8CjVTGbdvuZqVyzDs4SCwjUqdJr43vwb6JM4n/kkGhxwxTLRMYo25o35/ynIcNui1eo8hM3Xj0hHyRWlCmz/VIf6hZ6VaM/Aej2S8pbL68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=W6kftQzq; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="W6kftQzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779804081; x=1780408881; i=wahrenst@gmx.net;
	bh=TL9ueUimTb/6wHI0JcdVdwqDurL+JyY0kYhuiUornTo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W6kftQzqKxnXCeT7T2ot2dSPECC/+9U1tQUzkJ7S8A+paw9a12kX2+CEwt550SGE
	 wGORYfAjxv8wRmjCE657/lMWju1KWGEgjzq78yVycFtmsCofm/ecq+loepbKO61RH
	 a1SxJLwBktvjUpLiJsQe37l8ZbYeGV7qiw9PNMFCebvVtSs4nQ/kvTMLBMTHJSyaU
	 awr4Im3b/2ejUWoOFHdQxnWIqxv8TKjjR9A9YMW5ds3hg4J0DuiGlLY9jtPDkyGaU
	 u4sQI3AxpgWvE4YZIrUwbCQboxIeYvcTiSOeDIXTVGo51i+FKI6NPWgiDFcDyw1SH
	 fI1r3gm+AihoO3aTtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1wd7Xu1ftz-00HLAw; Tue, 26
 May 2026 16:01:21 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ingo Molnar <mingo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFT] tty: serial: fsl_lpuart: Add register dump
Date: Tue, 26 May 2026 16:01:13 +0200
Message-ID: <20260526140113.50372-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tuub8Cf4RoHtJU3wN0GMt2cm/+9jHo4o9sC+elcz/nx/fQW5SwC
 SAAE76oPtXsrV1+OjPrEBd/xzbWi7BVLPo/btmVLVCTDuFZiwS9vISNhTpxDmCRN27XL7fk
 GXN81BxpHX9Mu/quFKdDDKhJs9vzvuWm2aHNm//3KtexqVEpAPL9Yap6GbEXzGs9OovZ1qP
 /SGzp7Aa4w+kikXJ/UdJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TnL4sBCEhXI=;eODheuCJIw0KkcGlzOZecDNXti/
 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
 GU9Gs1tHfuzoRrPhtA=

Dumping the registers from userspace for debug purposes isn't trivial,
because runtime PM can gate the required clocks and any read access
to these registers would result in a lockup.

So implement a register dump via debugfs, which deals with the
runtime PM.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--

Hi, I only have access to a board (i.MX93) with 32 bit registers, so it
would be great if someone could test it for 8 bit registers.

Thanks

 drivers/tty/serial/fsl_lpuart.c | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpua=
rt.c
index 1bd7ec9c81ea..7e4b3e59414a 100644
=2D-- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -10,6 +10,7 @@
 #include <linux/circ_buf.h>
 #include <linux/clk.h>
 #include <linux/console.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -23,6 +24,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/seq_file.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
@@ -291,6 +293,8 @@ struct lpuart_port {
 	bool			is_cs7; /* Set to true when character size is 7 */
 					/* and the parity is enabled		*/
 	bool			dma_idle_int;
+
+	struct dentry		*debugfs_dir;
 };
=20
 struct lpuart_soc_data {
@@ -1031,6 +1035,7 @@ static void lpuart32_rxint(struct lpuart_port *sport=
)
 	}
=20
 out:
+
 	uart_unlock_and_check_sysrq(&sport->port);
=20
 	tty_flip_buffer_push(port);
@@ -2860,6 +2865,67 @@ static int lpuart_global_reset(struct lpuart_port *=
sport)
 	return 0;
 }
=20
+#ifdef CONFIG_DEBUG_FS
+
+#define dump_register_hex(_seq, _reg, _sport) \
+seq_printf((_seq), "%-12s: 0x%02x\n", #_reg, readb((_sport)->port.membase=
 + (_reg)))
+
+#define dump_register32_hex(_seq, _reg, _sport) \
+seq_printf((_seq), "%-12s: 0x%08x\n", #_reg, lpuart32_read(&(_sport)->por=
t, _reg))
+
+static int regs_show(struct seq_file *s, void *p)
+{
+	struct lpuart_port *sport =3D s->private;
+
+	pm_runtime_get_sync(sport->port.dev);
+
+	if (lpuart_is_32(sport)) {
+		dump_register32_hex(s, UARTBAUD, sport);
+		dump_register32_hex(s, UARTSTAT, sport);
+		dump_register32_hex(s, UARTCTRL, sport);
+		dump_register32_hex(s, UARTMATCH, sport);
+		dump_register32_hex(s, UARTMODIR, sport);
+		dump_register32_hex(s, UARTFIFO, sport);
+		dump_register32_hex(s, UARTWATER, sport);
+	} else {
+		dump_register_hex(s, UARTBDH, sport);
+		dump_register_hex(s, UARTBDL, sport);
+		dump_register_hex(s, UARTCR1, sport);
+		dump_register_hex(s, UARTCR2, sport);
+		dump_register_hex(s, UARTSR1, sport);
+		dump_register_hex(s, UARTCR3, sport);
+		dump_register_hex(s, UARTDR, sport);
+		dump_register_hex(s, UARTCR4, sport);
+		dump_register_hex(s, UARTCR5, sport);
+		dump_register_hex(s, UARTMODEM, sport);
+		dump_register_hex(s, UARTPFIFO, sport);
+		dump_register_hex(s, UARTCFIFO, sport);
+		dump_register_hex(s, UARTSFIFO, sport);
+		dump_register_hex(s, UARTTWFIFO, sport);
+		dump_register_hex(s, UARTTCFIFO, sport);
+		dump_register_hex(s, UARTRWFIFO, sport);
+	}
+
+	pm_runtime_mark_last_busy(sport->port.dev);
+	pm_runtime_put_autosuspend(sport->port.dev);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(regs);
+
+static void lpuart_init_debugfs(struct lpuart_port *sport)
+{
+	sport->debugfs_dir =3D debugfs_create_dir(dev_name(sport->port.dev),
+						NULL);
+
+	debugfs_create_file("regs", 0400, sport->debugfs_dir, sport, &regs_fops)=
;
+}
+
+#else
+static inline void lpuart_init_debugfs(struct lpuart_port *sport) {}
+#endif
+
 static int lpuart_probe(struct platform_device *pdev)
 {
 	const struct lpuart_soc_data *sdata =3D of_device_get_match_data(&pdev->=
dev);
@@ -2969,6 +3035,8 @@ static int lpuart_probe(struct platform_device *pdev=
)
 	if (ret)
 		goto failed_irq_request;
=20
+	lpuart_init_debugfs(sport);
+
 	return 0;
=20
 failed_irq_request:
@@ -2987,6 +3055,7 @@ static void lpuart_remove(struct platform_device *pd=
ev)
 {
 	struct lpuart_port *sport =3D platform_get_drvdata(pdev);
=20
+	debugfs_remove_recursive(sport->debugfs_dir);
 	uart_remove_one_port(&lpuart_reg, &sport->port);
=20
 	lpuart_disable_clks(sport);
=2D-=20
2.43.0

