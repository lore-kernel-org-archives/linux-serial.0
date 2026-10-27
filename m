Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142346;
	b=Hae+CQYuSiaPC+03sUSSDN03d4SxOnG1Q5iXg1KWwAe5g6K3nyq8BytMEol4F58ZAkRz
	 hfHKA8/mzHb45gp8bwynjFFTd1vUjUQqlWiRi6TobUmQrRYzBcP86EQpoKpJbczEJ5S9d
	 ULp53aJ01YavzVDlCm3YMaMUxgE97smK000Z2dMy9x4UMqmwhdjghElHTRHaTXUCc3HRg
	 lv3x0bOHuV+qt63DiDOWMCl7GpfNG/d6PvDKpmnyVEjb3xNskplgtcZPfwO9vSGvU0fhC
	 lsw5hCGqM3i0cjcpXSGLL6Qc/skTKq00CnncZboBTRSOZH+ylqcf7gemD3aZATQxLkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=oUDm3Xp9Etw97Pip2kF/VAmErAZUiFyUqD481xySoOQ=;
	b=t+DY51EpuQ6eY0vwu/Qu/yEUmaycBti0VcFk9SWPKV2S9QGf1O01X9vwvMVvzVEDUxE4
	 yub3Qb0LWqg/oqUGeS/cKtAWXJ4C7ghYaTpJpo2D1bN4LI43vDOWr76EMzWZv96VIjhhr
	 72VQndpwf8gJ3GJ4lXH5kccm5B1QJ0cBOF/JcgWAob1JVBDItoSz08G4Hw1iDwCzEL6+c
	 Mp2ly1GoIDMjZzzhQXS0nI4DP2etfGJYeJAAiV1skSbomoYu5zwOrDBhpQ3fcNbRAGsnK
	 rChKwojBBdmdo/MCTVcMFAku7Gb2gTzo6BGKe/emWFcgg7XjM0lL2ncqqDH0eiCFjaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zOQXg17p;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F5606A32E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 165F5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zOQXg17p
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-84621d8c7aaso194655a34.2
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793142345; x=1793747145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUDm3Xp9Etw97Pip2kF/VAmErAZUiFyUqD481xySoOQ=;
        b=zOQXg17pd26tyfvfpbNs5AXAS4UhyOdKIZ+Y+ZF9psjBSHnacYTi2kXSOPJq1GxC9M
         TfXgHvwG7pQ8phSXSTU9p/xnkbDNTTi45MBmd9TeQDSOe5K+5GtqMk7i8gGnOW/g8nfw
         pLD2FsCVkWy/4+rN/t9m+M+nb+NDNxRvdOeh+Y6nJ5kOZdxhcdljftKF6qM8T/x3gaVn
         O5LdCzYeJbL6NzgJbbdqdEFmm99hHvHI0SPtq++bPRMZ4uKurdWX+jPVKp8wC0pCsjCf
         6qgjGHYneMMJk/RusWRjh8JV5MpxcbqpC6uZ81DgtvoFPCibFJTjeYDg0dBaVglMzgoJ
         KA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142345; x=1793747145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oUDm3Xp9Etw97Pip2kF/VAmErAZUiFyUqD481xySoOQ=;
        b=BWSCOtuPXcb2lj7W6/LVDioxGcootwpEWPVo2KVxjQeZMiAHTdc4/tJwNCf2wN4+Jn
         npzQGU2D3+QpMCRC5awU8ZSwc244YU5+rZoWbB/xaZWoj7rOFLzJUELIVlCGh7ZWNhdQ
         cgQL0HsjcmvzIY9T9MpFBmjfSDIjOnqALzlSb02mhlH+eW0/by/Ibfl60LATq6gRunRr
         hT2H/zI3a8nixeJKW2BCTZ5EZ0HgxA89rufxkYaK3IZGVEs7Wz0zG/uETvH6bUK0/hTU
         oQ+ptEu/5ATadySV1EXys+rZHT/j0sTmXafpXr+OKoGhOSXD4CQhVliaSXPez9HhMLZO
         GeCw==
X-Forwarded-Encrypted: i=1; AKwUvByakpfHUH75Vj4wTbCjOospZPPjAa3XosCmzCyi1CODL13C8YeTPAmpX9jD36JyclnIQYf8tmjSQzKCbvw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjgDJ0Si1Vl0sJAsRGZ5t5V544SvVvjLvOJZcwEE6eXvzWYrDs
	qw6FXw6LWlvJRk88lbVNIhYAzFXcn8AdDEw/0L94VeCdWcnqzrQOb779
X-Gm-Gg: AYBFou0lJPMIftxb1DiTP0xp8beDnkcFEw59e8Sc+KxYL/xaYgQcn2PGguj7Pz6XIQL
	h4qJAM1mkckNQQN7plFvF0ZvlkDZhqYZClozmMoH6NUtVs91q9UXebBQ4nW5qzdFq6XEUsOd9r7
	RdVJuJGwJU6plQNh0nQ6sU9EmouAQ9bMVCiqEjEEagtEkn/LpLgVe6TnYJGc/6QlSfz1Hn0xHLR
	P6WeQ+5Qo8bMBMTggAWDt6xbadJWhDNGzIA8vPyZQxE2EqcIGDM8n9XJPec9rSBgViuTR6en/8q
	35bH+RswzZF9CdMF/0Tc+wdFmq1tFWYbS0AxkN29A//YHRcKK+Cs8OzNhZkK8OPYEuNuRWRkrjr
	X2zkAuGuInr/q+cdYKU0YSqRXzWk/YnaFjUsJXeLsCIM1SSpPLWjO489FD/Tc0rZNRH4oifwGeq
	WpnqPReMLFtr4OggFKyhwCwNFFYnVHCvKM60ZWqDInuJV1Fl9tnUSq0gwKLWcfi/h4VS3M5KSPa
	ZAZGQuXnS6fI1kZ+ET6+NmaiDLMEMvHHHKZxiKplTMd9Vc6aOxCbQ3dHgwsi0uG343AkVOXRaZj
	6sobN2526ie8+qpUgHcGVSZgxn5Xx/TTz15dprjt3T2E0/svOprwPPzuHIjgZM/lKoKLnNJkeCN
	Nkb/Jdl3kMhuIrxlXYNpUeJiiHqd4oPCl8IpheWdw/jMiR/VipTkW3LoZR8ySM3qUAWtyQgn8r8
	yqtw==
X-Received: by 2002:a05:6830:4411:b0:829:9992:20f0 with SMTP id 46e09a7af769-85ac0fd0da4mr851500a34.28.1793142344897;
        Tue, 27 Oct 2026 16:05:44 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0741c9sm12093328a34.10.2026.10.27.16.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:05:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 17:05:29 -0600
Subject: [PATCH v4 1/5] serial: 8250_dw: select port setup through platform
 data
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-submit-h616-uart-fifo-v1-v4-1-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Select feature discovery and DMA attachment through a platform-data setup
callback. The generic callback probes the optional registers and attaches
DMA when a FIFO size is available. Integrations with a fixed configuration
can supply their own setup before the port is registered.

Replace skip_autocfg with the Octeon setup selection. On 64-bit builds,
Octeon continues to skip optional-register probing while retaining its DMA
setup; on 32-bit builds it retains the generic setup. Keep generic setup
for devices without matched platform data as well.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 44 +++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 9cbe076463e0..1351523f0c47 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -64,6 +64,7 @@ struct dw8250_platform_data {
 	u8 usr_reg;
 	u32 cpr_value;
 	unsigned int quirks;
+	void (*setup)(struct uart_port *p);
 };
 
 struct dw8250_data {
@@ -76,7 +77,6 @@ struct dw8250_data {
 	struct clk		*pclk;
 	struct reset_control	*rst;
 
-	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
 	unsigned int		in_idle:1;
 
@@ -596,7 +596,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->serial_out = dw8250_serial_outq;
 		p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 		p->type = PORT_OCTEON;
-		data->skip_autocfg = true;
 	}
 #endif
 
@@ -631,6 +630,33 @@ static void dw8250_shutdown(struct uart_port *port)
 	d->no_int_count = 0;
 }
 
+static void dw8250_setup_dma(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	/* DMA setup requires a FIFO. */
+	if (!p->fifosize)
+		return;
+
+	data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
+	data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
+	up->dma = &data->data.dma;
+}
+
+static void dw8250_setup(struct uart_port *p)
+{
+	dw8250_setup_port(p);
+	dw8250_setup_dma(p);
+}
+
+static void dw8250_octeon_setup(struct uart_port *p)
+{
+	if (!IS_ENABLED(CONFIG_64BIT))
+		dw8250_setup_port(p);
+	dw8250_setup_dma(p);
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -765,19 +791,14 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	dw8250_setup_dma_filter(p, data);
 
-	if (!data->skip_autocfg)
-		dw8250_setup_port(p);
+	if (data->pdata && data->pdata->setup)
+		data->pdata->setup(p);
+	else
+		dw8250_setup(p);
 
 	/* Use the BUSY-safe sequence for both integer and fractional divisors. */
 	p->set_divisor = dw8250_set_divisor;
 
-	/* If we have a valid fifosize, try hooking up DMA */
-	if (p->fifosize) {
-		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
-		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
-		up->dma = &data->data.dma;
-	}
-
 	data->data.uport = serial8250_register_8250_port(up);
 	if (IS_ERR(data->data.uport))
 		return PTR_ERR(data->data.uport);
@@ -860,6 +881,7 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
+	.setup = dw8250_octeon_setup,
 };
 
 static const struct dw8250_platform_data dw8250_armada_38x_data = {

-- 
2.53.0

