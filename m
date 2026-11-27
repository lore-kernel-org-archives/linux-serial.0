Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807532;
	b=dxTvlMPHjKQwHOXOH6M/SFUT532YVI7yFs2Xvvi+79Ocf3KMpyLw6cOfNPI41wRyI2j+
	 2awTx4MKQyIYYYkjndmK2ZYx+TBGGSwCA1qOtuRhy9FmqvWnC4VAHYbGLacbjhTJ+N0vm
	 gH0+MP8AjBvhrLTmj/Rn+pDll7qKCMWrWz0tGEXcfRjh7cPuASV6yafp5lLAW7WXmjOxx
	 6buKHJZhttCt5p3a8JVMlqawH4TkjDwBbilIL1Yv/aH6/V8V+rmAzvtE47L/1BdUYUGKA
	 cVIntzFex3DxXtYcE2M7Ya28BCzFHNz686QCDnyhLAYEsU7sAbQoQfS2IRw2NvHapVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XH9gWDCllqbYGijR6SSDBIRKOHxF1ZqXOL/NGtJepT4=;
	b=eZ1JvZhJgsOl+LLmq+CZlR0Z5bNuMmIo0t7BYPeMELQmMkvtZJYsKjng8smU3dJfIhz/
	 C96LnGYjjOue6RuUk6SwXgidVOI23ktL+7XRBb9LXplU6jCBmYPEneawotyUtAmfagNOh
	 zWQTH0WvFxCNJjy1AZNo3PMv5IveYPO9J2PlWDkg5X4cNZJCphQm3kbvjY1alNSRJeqv/
	 84HVX2QwDZnLkfzBsk6zQIQPlgwc602haEf40u4tUX6Y4sVnDSxzEO9GHjOGflcS+kWeB
	 kq49psSrm0W+cnLw6Y0XdUHQIPmQilfCXzPcAz0Q6dKmghavU42LfdV4MocU+g32/4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YoIp2GKa;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F8D606A31E
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 19:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F8D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YoIp2GKa
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso60740495e9.1
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 11:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795807530; x=1796412330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XH9gWDCllqbYGijR6SSDBIRKOHxF1ZqXOL/NGtJepT4=;
        b=YoIp2GKag6vT0RbvcoMlBXsaks6YHFOD51TKgUrM+oo/SaqC+YCCzETly+dkP2nGe/
         PEtMN1Jb0zCwUHpM2mnjtD7Nt1Pqyxif3FJDeX+jUV++aTeWhw+rH6pplUhFTCYsdANl
         BwWb/Oh0IMq36IvrF5U5p4/F7eA7PavSpxOw+QA02G35wuKt0SsSkLAOlCytFAEQGWLc
         jcG5bCyw/H3s1L18B4Y5qGroKwbccou4UcvWvoKmrjBYeBt85hvlTZd14FzJcMpy/sp7
         Gqh8mR3ULT+ku3VY1Bu9/Dy2QdwzjJlN7zc6hsjKgihrac1uXlTgo3yO3vDUbOcGnaTV
         Bg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795807530; x=1796412330;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XH9gWDCllqbYGijR6SSDBIRKOHxF1ZqXOL/NGtJepT4=;
        b=xfQ6n/iDa18p5LSajn5iAB4mUtLFCQxsLnto3KHSH1I3w9JBdnCJFFQmuaoEwmndoJ
         9lDNbQLJAyY4TM+iM33qYhCwOvUGhLO32P3ltNah0FsXiMwubyC2xK2jl1Uv0ViLxUAs
         ZFNilUAFKwVQLyNwi6E3DRN4i2Sv2QkaATWEDV0WliuEirOmG+SMhfO60lJErcFBJKoX
         PFgsdPtIhJKlpBhOikL/KY49R4qBOT2L8XMZqyHNX8+KXGuL73TstcP7LDzs4DM4ragz
         M5HhxrFdhPo81xlp6gB8jp/PQA8Or4t99ofBlp1eqT+KS78CoxhyOw3UW73hT+P88vLC
         NZeg==
X-Gm-Message-State: APuU4Z9ufCWrbCfTZFA1JVJG7ZoaSzbUTjhWpp9Kxh5qV79pq1QVZkZ+
	tB7UFka0sQgKS5/qkcdHBDF6mWVfjDIhWbqQcRhv3KHGRjPbxcIwXGIv+vbNzSMb52s=
X-Gm-Gg: AZFdTZddXkEtTzOcDy79867JD1gKPhaQEos4BicXRsf12c/fUt7rYL2X5vwhDatIKLS
	3tGX+3YCBmuC28zNFpeHwdznepUVJHMFHU8Za6UuvuNQy4LTXMzUHjWErvcjBwLy4tNLTi9RtyU
	tBx4Ce8ffzgqagKcmAoE/U98l7Gnr5W6Dfbv5iHlXw+6NAvfn7Hd0+omnnmLXQOyB9mQdlVUatC
	uOleEB61vsbogwDeA5S7ZRbGRn87b4rKB4RKEIXivKUuutjdGnsJM99zDFsu7XP8ctcQfdplYix
	SpGoO7tXPbF+bp4VxjEOicVlx7sPMKVEGhBsYk8xtlToJbczQtvcr++mg5zlME6ROtfXWejAJ4a
	lYDW5vYTZJaoozcCl1OPodWQ3GrgVASXAwXDU5A8k276VREmQ4Ik0aiviMSh9nqG+LJlEIbkMQA
	g0O242p1iwqXkaYHARzihjlHUsJcedxbNX1BIwEM9YcpKmd9z1oDh5Sa41faSS7acIV7jk3rP6+
	sw26lAfh2yk6itkkX6mJ0J2k+Nnuehl2tx7Th8BKiB5eBaiPeeZTWO4jAOLYumpCV3iNdRX9pF5
	vKW7JAqpaEUmLPIU2y+lH6MVr6+e6rdZAFfHY5QzbxiEiE/Zx8HwYF9Y7C/nLlyvoJO4UbOELaO
	u8KWm73HU
X-Received: by 2002:a05:600d:1c:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4bb9de0d5ffmr266662415e9.25.1795807530110;
        Fri, 27 Nov 2026 11:25:30 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm700412425e9.1.2026.11.27.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:25:29 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-riscv@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
Subject: [PATCH RFC 2/2] serial: esp32: Report active-low CTS correctly on ESP32-S3 and ESP32-P4
Date: Fri, 27 Nov 2026 19:25:11 +0000
Message-ID: <20261127192514.174468-2-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127192514.174468-1-vitorhg20080@gmail.com>
References: <20261125233020.1380594-11-vitorhg20080@gmail.com>
 <20261127192514.174468-1-vitorhg20080@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ESP32-S3 and ESP32-P4 UARTs permit transmission when CTS is low.
The driver currently reports the raw CTS level as TIOCM_CTS, so
TIOCMGET reports CTS asserted while transmission is blocked.

Record the CTS polarity per variant and report the logical CTS state.
Use the existing polarity for the original ESP32.

On the Waveshare ESP32-P4-Module-DEV-KIT, UART1 internal loopback
verified that TIOCMGET reports CTS deasserted while transmission is
blocked and asserted when transmission resumes.

ESP32-S3 hardware testing is pending.

AI assisted with driver development and the loopback test.
Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/tty/serial/esp32_uart.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 7d58a41..ab0f739 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -140,6 +140,7 @@ struct esp32_uart_variant {
 	const char *type;
 	bool has_clkconf;
 	bool needs_reg_update;
+	bool cts_active_low;
 };
 
 static const struct esp32_uart_variant esp32_variant = {
@@ -172,6 +173,7 @@ static const struct esp32_uart_variant esp32s3_variant = {
 	.rx_flow_thresh_mask = ESP32S3_UART_RX_FLOW_THRHD,
 	.type = "ESP32S3 UART",
 	.has_clkconf = true,
+	.cts_active_low = true,
 	.loopback_mask = UART_LOOPBACK,
 	.sw_rts_mask = UART_SW_RTS,
 	.sw_dtr_reg = UART_CONF0_REG,
@@ -191,6 +193,7 @@ static const struct esp32_uart_variant esp32p4_variant = {
 	.rx_flow_thresh_mask = ESP32P4_UART_RX_FLOW_THRHD,
 	.type = "ESP32-P4 UART",
 	.needs_reg_update = true,
+	.cts_active_low = true,
 	.loopback_mask = ESP32P4_UART_LOOPBACK,
 	.sw_rts_mask = ESP32P4_UART_SW_RTS,
 	.sw_dtr_reg = UART_CONF1_REG,
@@ -332,12 +335,14 @@ static void esp32_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static unsigned int esp32_uart_get_mctrl(struct uart_port *port)
 {
+	const struct esp32_uart_variant *variant = port_variant(port);
 	u32 status = esp32_uart_read(port, UART_STATUS_REG);
+	bool ctsn = status & UART_CTSN;
 	unsigned int ret = TIOCM_CAR;
 
 	if (status & UART_DSRN)
 		ret |= TIOCM_DSR;
-	if (status & UART_CTSN)
+	if (ctsn != variant->cts_active_low)
 		ret |= TIOCM_CTS;
 
 	return ret;
-- 
2.56.1

