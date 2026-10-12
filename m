Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37093624AB
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785426; cv=none; b=BlzTDVMUiaykad5EfZXpJ/ww+Dhdvgf/2CRzsV6VnLHseFaL0bS6nAxqARBK8/vp9RURA9+gRvG/TRQfjiVXm+YWQL02Z7ngw9WnR5TG/izr35IHIuzlvcf5sH0mUaflXrRs2Xn4+KygadHi+bzBzswquZVlylo3psc+5n9G38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785426; c=relaxed/simple;
	bh=A3al1tmuV0A0Vdqcy9xJt/695r+kavRLV9q//wj6SQc=;
	h=From:To:Cc:Subject:Content-Type:MIME-Version:Date:Message-ID; b=pykzM63cfO9jGukTsVG07XF4rn5n7FSfEPochmwoQBKY7YEtZV+Rumqmdkn6eY44il75egw1PAQwzJKtgrTRwKpCA15mIA7795L4LsUggf29G0xXFrF9vrYdkTw8jAkcp7uelIGSr2MHsvXA1s2ajcTVupAsoUVUI1BIw5KDuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6WwLmoN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6WwLmoN"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1c9879395so372167a12.1
        for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791785424; x=1792390224; darn=vger.kernel.org;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VV0FhVrq0sGfMbGLK+HF2R3XMkBDiQek25otMQXj59Q=;
        b=I6WwLmoN9he7sPSZt2uGN5RHX45q2X4i10kKyCHzWDGZznGu8/DJ2oZ87u4ybLRKE9
         3YUHTKEV7CLVlTmw6Df3Og6VllyEwfFsJT/uX9hR/tNO0bdU/G2N5E89OPlv5RCnhjY5
         sbIENHtaZ8vhmcDgq/+RYpE8CyVmkc+T5paEss3XATIFUfJe8jls8LOPUBpuaeVjENyl
         69288WgL13zfnhh6THXQEUPjxIt5Q6tDYcDokhrQyVtFhP5oS2UAojAn7TDXQAiqM1Ue
         Nz2l2TVA4joAOb7WA4ChlyoxbEyquJ7ygpCO3uu6QUlg8Zh8nCxrbcqTh5NyWBagSPLz
         6ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791785424; x=1792390224;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VV0FhVrq0sGfMbGLK+HF2R3XMkBDiQek25otMQXj59Q=;
        b=kH7Dv68/MhUPV4drqC4G54IjA1gafIfNOYKMbJp9IoA5pljsJFrLAe9mhxKO52vSKV
         9HuMh0jsqkMg/hh9lI5kk28KfLwfibs+MJGFleUCQv3oE+DqkV2AfdUx2IvGZtBI2C9I
         0JQdWSmtvUw1bPkZGA5Nq592FYfcwGWYgQ3z7uY8/C66w8+RMfqVrFaPsTHE92g4oOu7
         BBvL/CKOcEkZY+WW8T39VPqDL/zYtVrvI+h+X2R2xlPuuP5OAhD+dw1Q1Lakby23iWYd
         iFoEai2nww3yJHR2WsLPZETZKOgO664YZzw/Q6fxa6NQqavIeuFAAujMH1mWfijMDfvS
         nXJg==
X-Forwarded-Encrypted: i=1; AKwUvByQ3guNROOLNZ65cLSc0dI0vpqe9J+zeDiXFQNKfpfD8OAHj9jYD0fQex+w8LeGlZUTofEdndB7mvbf5f0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIH8gomTNwuj7/7U+Lz5X+TEU9k8umbRRDXZep+RwxbedB7Jhwj
	R8W37Ul53x6iNRwuAOegOnvigOxVy57aIfySGuuaOeC4ey5jlO/Aa+BP
X-Gm-Gg: AYBFou2wo/jR/bD+KrRjNy83iGneSEreq3cglwYEwwDIaBntqwjxdZC43X1GXQfW4fS
	YXw2COe7rVjLv5QxBjIbawforQVbpLEamKXzY0HAOIPxJ6IutIgNaYF0UyK+0a4oEp072ep4CLk
	6tRQbxLcXne+Tlr0/KVfiSF2X3WV5/xS17giU+K580gnh30pz4wlTxIjpW0xzm/8QL5QPhLajHN
	6NTZyE8yu1JyDfcCJMEFm5oG9o/skFf0gOpES4018b2jNrpSZCpS/XDiKvhgN70eWY1ZeMfhYfu
	R9u10svaoht7oLSj9QEHArqp7MdN8KdoLtI1eK8GPDoWLW3+HHCdK3zdDD+Pla/rHQNfZEtErnd
	69g8VOLKO/+CezjQJEPDCvVw6ACXxyj5ITc5lCoL3acpgm3aKqSA08F0iMoFOGGvfN03GY7A2/m
	FO6qob6i0h65pTOyHpFXicj97VQ2uyqtMy5Hnj5imCust23G9/TEDDo2qIxCoPYPVfSopHM3fCG
	EExfcehBm5V4X/vfoUpOXRjUYFE/KBU5TkOxaaiX9MnXeXaur6rvtRJDZ3C8IBoPZJ8U1Lv1A==
X-Received: by 2002:a17:90b:4b85:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3ab3ab60609mr6810362a91.22.1791785424078;
        Sun, 11 Oct 2026 23:10:24 -0700 (PDT)
Received: from [127.0.1.1] ([121.165.170.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39238608sm15480827a91.17.2026.10.11.23.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:10:23 -0700 (PDT)
From: khaliforce <kforce@gmail.com>
To: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_dw: retain programmed timing for BUSY waits
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 06:10:20 -0000
Message-ID:
 <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>

Baud changes update frame_time before the programmed divisor changes.
A switch to a faster baud rate therefore shortens the DesignWare BUSY
wait.
The wait can expire while a frame at the old baud rate remains active.

Use the programmed frame duration for FIFO and BUSY waits.
Account for UART clock changes.

Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
Signed-off-by: khaliforce <kforce@gmail.com>
---
Compared the complete patch off/on on MangoPi MQ Pro UART0.
Kept other port patches, kernel options and DTB identical.
Tested BUSY changes from 9600, 1200 and 300 to 115200.
All 11 paired changes fail without the patch and pass with it.
Each trial returns 64 matching loopback bytes.

 drivers/tty/serial/8250/8250_dw.c    | 20 ++++++++++++++++++--
 drivers/tty/serial/8250/8250_dwlib.c |  4 ++++
 drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 51d026f20825..03be503bcef0 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -17,6 +17,8 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/lockdep.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -131,6 +133,9 @@ static int dw8250_idle_enter(struct uart_port *p)
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
 	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
 	struct uart_8250_port *up = up_to_u8250p(p);
+	unsigned int frame_time = d->data.frame_time ?: p->frame_time;
+	unsigned int saved_frame_time = p->frame_time;
+	u64 scaled_frame_time;
 	int retries;
 	u32 lsr;
 
@@ -139,6 +144,12 @@ static int dw8250_idle_enter(struct uart_port *p)
 	if (d->uart_16550_compatible)
 		return 0;
 
+	if (d->data.frame_time && d->data.frame_time_uartclk && p->uartclk) {
+		scaled_frame_time = (u64)frame_time * d->data.frame_time_uartclk;
+		scaled_frame_time = DIV_ROUND_UP_ULL(scaled_frame_time, p->uartclk);
+		frame_time = min_t(u64, scaled_frame_time, U32_MAX);
+	}
+
 	d->in_idle = 1;
 
 	/* Prevent triggering interrupt from RBR filling */
@@ -156,8 +167,10 @@ static int dw8250_idle_enter(struct uart_port *p)
 	 *
 	 * FIXME: frame_time delay is too long with very low baudrates.
 	 */
+	p->frame_time = frame_time;
 	serial8250_fifo_wait_for_lsr_thre(up, NULL, p->fifosize);
-	ndelay(p->frame_time);
+	p->frame_time = saved_frame_time;
+	ndelay(frame_time);
 
 	serial_port_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
 
@@ -167,7 +180,7 @@ static int dw8250_idle_enter(struct uart_port *p)
 		if (!(serial_port_in(p, usr_reg) & DW_UART_USR_BUSY))
 			break;
 		/* FIXME: frame_time delay is too long with very low baudrates. */
-		ndelay(p->frame_time);
+		ndelay(frame_time);
 	} while (--retries);
 
 	lsr = serial_lsr_in(up);
@@ -188,6 +201,7 @@ static int dw8250_idle_enter(struct uart_port *p)
 static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
+	struct dw8250_port_data *d = p->private_data;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	int ret;
 
@@ -200,6 +214,8 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 		goto idle_failed;
 
 	serial_dl_write(up, quot);
+	d->frame_time = p->frame_time;
+	d->frame_time_uartclk = p->uartclk;
 	serial_port_out(p, UART_LCR, up->lcr);
 
 idle_failed:
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 8859e66d2d71..d74ff203f904 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -39,8 +39,12 @@ static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
 static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 			       unsigned int quot, unsigned int quot_frac)
 {
+	struct dw8250_port_data *d = p->private_data;
+
 	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
 	serial8250_do_set_divisor(p, baud, quot);
+	d->frame_time = p->frame_time;
+	d->frame_time_uartclk = p->uartclk;
 }
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios,
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 1fe52332e774..5472c13ca92e 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -88,6 +88,10 @@ struct dw8250_port_data {
 	u32			cpr_value;
 	u8			dlf_size;
 
+	/* Timing for the programmed divisor. */
+	u32			frame_time;
+	u32			frame_time_uartclk;
+
 	/* RS485 variables */
 	bool			hw_rs485_support;
 };
-- 
2.53.0

