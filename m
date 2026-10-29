Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254481;
	b=vTgfrdMuPiJgUg7VR97Iijw0IjU48HHWHGQD/4+lBBVgljxKJSGadw7AWwGQaN875/I8
	 n/H00W1bzl1BQMhHuxAXoJZ7RQnMCaC1xT1yS3zxwiTgg1c/p1GCz0roEMfZ4XvhdedGm
	 ksr7DnA+wSmuwYScyaUOn0gRU3RzWIqtGwEs/exITbKkCQC3TrFosY0QIcrWQke5bRrGD
	 cltL0V+NK0Sij6AKhFyaB6GAtmf4LPsPY8wqsFypG4ExQPgmsjIwUlimD0HNf6moveH6K
	 2FSjmXFTkNUNf335ZiHVs8fvZamhSLIzsxXNl+gp/rkJLhUttU+kwNGIHWYKYEWOADA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ivEqINlh7ZkJrAoGIP7Qk/ck2w+8V1ulipYhp9Ae/DE=;
	b=BH8SiUFJaLUX8kA3jbGE8e9Mgxvg1zQushyTSg6SnngxXXY1F3el52VWFygt0sHurYQi
	 hiojwQdjyMJTtbcT8HveAprSRIOOtGx4OnkkU9e3uYC9f/eSDQnas2GI9OH8v5O1MgxbS
	 mGusNurqW5HfNDn1s+r9ZTGz8ZeOHxRV6c8QfXuTf6m6kzixqIDVHftZhDY55bo7hmxRc
	 MpTfwuchgKQAfIuUtI7lpvp9l4anvYyOT03QkYXfRR66lDO3S2r00GQb5fOR0EXoSWdC4
	 GivBcfFacBpVFKwXq+BH0Lo9ZYvAOZJA7RNkBXCBPZ2qnhpmAe5SfPM6UqN42J7TjbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwY+C7Rw;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06038606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 06:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06038606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwY+C7Rw
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so12675665e9.3
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793254479; x=1793859279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivEqINlh7ZkJrAoGIP7Qk/ck2w+8V1ulipYhp9Ae/DE=;
        b=LwY+C7RwjoAzSYAQqJJgoj7sJsD3GVBFQOiYIFCE69SQJxXZDaHHi37eO1pT6YYceZ
         vZxTMok1DXPfg10dfo33wGjKI7pivZrg89y17+t08DgkvDVShpi05v4gkmKk14fkA9oJ
         oeQIB/1RHXZP979uSUjNX6IPjavD33d/9VzVW5Yh4jh7gOvyJw1qkcVlj7ABAl74DCJJ
         kNoeyfQdp+3kieiHvy6oYTJYbhkW/XLJYATNI40WiHmm5fc3pVAgsy1wwBSIS2COhmk/
         aC77OBQ0ZARdYK+gR8n/QBScxxVuRDZViItMPooS9pdl4YQYsxWp+7DuINUVGmFUrsIK
         67cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254479; x=1793859279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivEqINlh7ZkJrAoGIP7Qk/ck2w+8V1ulipYhp9Ae/DE=;
        b=q47dt92NbgkTMXhGtjTJ04UJz8CSs/rZGyT4o/7UL6lax9mkI+oRJL2RJQ+X7SmzLA
         w7fpj6lJWUe6Eia9KxmGNbZEBG3/Rm0/Tjk/AI1bcCrlccCkt9g4zWoEYuaIR50Bs4Th
         QWpB9gu49OVac9u6I4caNYRHacipxEJbI4YhAhhXG+FDsAKhQgGKhOXyjs2WCb3Azb7M
         XrFi8g8EbqFdEJru2hQn41qAu+bRH/mLH9q61v7yTDpUQNxPCUiWEOLhKe8zPUPxxtIb
         5YZekhIMt0dfES7S28vFwWIE7cSfRAYkzH/PYqqgdLaboMFlQesKqUtX6NeO0Duie9jJ
         n6pQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN2SNSi3ZJ3o2cFmpoRjin6GjumsgRe4Z9PzrM9ktZfuVSYwooNBVnN6itM/x5llqobjjaq+HqYGAf/0w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIk3R7aUt7+2bdDZw+VwEKBpbObCWjHEGERrByz0CiGllhN0OF1
	wX2HnJENEZxhNJx1YVnfJrKm3TgvX0AqXyqvnjiL8+Cd3b3CXHH1NPlh
X-Gm-Gg: AYBFou2hDHswMAuZ3ZjrUn8EK9ot6SKZki9vnyidcSoEb+SxPNNaNz3wAc55qTZXgmD
	BEaqAY5hZMPMgBnpMnaJtvu3fQxpzPoRcuN4YnOPJ1GX6k22RaYVrZWpLsDBPUy5FfdDbioZrb0
	AdGr1Fzix5XNwi5Yr7V0LVu2BMxTiUC1pcd1v7nsqGcMJROlAl3gSF9vzIWJugFSWDuxN6ZQp7y
	P3ohY8IvGy3WM09vS/uf2eYXS0Yxd6s9w8KWwLqoO6jRBX9C8j/Vmzzl5SQU0U3+JZVbM/bciOG
	AYM/Nf0oFRoZfbIe1R2AKaZCmdoS72ZNacxPhNBWV6DsbOeV8M+4sswUu/tBryeZ5QdGq5CqJ97
	GBhLJoXMIPHM7JRVJpZav4kS9QzEcI+ivM4xLPXEOyGBEdWyNzo8Qh9lJ0JEFqkXORXbpulxj/m
	45f2u2pmA5qNMaArAIS6SmDjQEyKptTUvE/VFr5mejf/HUzZK4O+HOITlJkOU4BEZR5VHLFs6fl
	3gdi2xV6B5x3yLLGLvm/kYR+Obzde1n2zMWWRzb2sJdeo4wWPZPFLzMhyjv1LqXS8bPQxYQm6c+
	Dlun6mBjR+1OumVXY2NXlAmGOIE9t3je9p0c/RQWxQxiniau669cjWv8aZzJZbzrk/EK0zS0YCf
	GDfRXpeitjVatJ6WwJ8Dpt/icOpeTvN6CjAHTmLt2po6Iyj8YRL8gv40lTbluKJ4VC9FNgQ25Qq
	AqS3hHj8+PYCCnzNoaQjuw22jfhyNjUjasVFwm+O4w3ql/G6Zgfu4u
X-Received: by 2002:a05:6000:160e:b0:48e:888:36b4 with SMTP id ffacd0b85a97d-48e5d5c3867mr7911286f8f.9.1793254479252;
        Wed, 28 Oct 2026 23:14:39 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aead-eb01-e474-b637-02f8-0d63.310.pool.telefonica.de. [2a02:3100:aead:eb01:e474:b637:2f8:d63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm32614741f8f.25.2026.10.28.23.14.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 23:14:38 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Yi Yang <yiyang13@huawei.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 5.10.y] serial: tegra: Add missing clk_disable_unprepare() in tegra_uart_hw_init()
Date: Thu, 29 Oct 2026 07:14:27 +0100
Message-Id: <20261029061427.27973-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Yi Yang <yiyang13@huawei.com>

commit 38f28cfe9d08e3a47ef008798b275fef8118fc20 upstream.

Add the missing clk_disable_unprepare() before return from
tegra_uart_hw_init() in the error handling path.
When request_irq() fails in tegra_uart_startup(), 'tup->uart_clk'
has been enabled, fix it by adding clk_disable_unprepare().

Fixes: cc9ca4d95846 ("serial: tegra: Only print FIFO error message when an error occurs")
Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Link: https://lore.kernel.org/r/20221126020852.113378-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
This fix is already in 5.15.y and newer stable trees, and applies cleanly
to 5.10.y.

Tested on the 5.10.273 review queue (6aa0165f18f12) in arm64 Tegra210
QEMU across the FIFO timeout, baud-rate tolerance, and request_irq()
error paths. Without the fix, each failed open() leaks +1 on the UART
clock's clk_enable_count and clk_prepare_count. With the fix, both
counts return to 0.

 drivers/tty/serial/serial-tegra.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ccc6106a5a253..3b86272cdf390 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1060,6 +1060,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	if (tup->cdata->fifo_mode_enable_status) {
 		ret = tegra_uart_wait_fifo_mode_enabled(tup);
 		if (ret < 0) {
+			clk_disable_unprepare(tup->uart_clk);
 			dev_err(tup->uport.dev,
 				"Failed to enable FIFO mode: %d\n", ret);
 			return ret;
@@ -1081,6 +1082,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 */
 	ret = tegra_set_baudrate(tup, TEGRA_UART_DEFAULT_BAUD);
 	if (ret < 0) {
+		clk_disable_unprepare(tup->uart_clk);
 		dev_err(tup->uport.dev, "Failed to set baud rate\n");
 		return ret;
 	}
@@ -1240,10 +1242,13 @@ static int tegra_uart_startup(struct uart_port *u)
 				dev_name(u->dev), tup);
 	if (ret < 0) {
 		dev_err(u->dev, "Failed to register ISR for IRQ %d\n", u->irq);
-		goto fail_hw_init;
+		goto fail_request_irq;
 	}
 	return 0;
 
+fail_request_irq:
+	/* tup->uart_clk is already enabled in tegra_uart_hw_init */
+	clk_disable_unprepare(tup->uart_clk);
 fail_hw_init:
 	if (!tup->use_rx_pio)
 		tegra_uart_dma_channel_free(tup, true);
-- 
2.50.1
