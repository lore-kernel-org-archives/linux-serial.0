Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B015B143
	for <linux-serial@vger.kernel.org>; Wed, 24 Apr 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963993; cv=none; b=a/x03DYiPx3UoBgxLHHKa5YQN5ebfveT6UFtXZ80d4NZTzE2lPpMeMCwDTEAltj2rmOhcmeRVdolGpV9fqzUKukA9VtnUm1VG1u+xCiux+252XdKVI7svFtoTh8oF4MvxucIEPY95X9yQ7JegkCy/hsSP7wn9neEAzj1+FEv5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963993; c=relaxed/simple;
	bh=lvGq478npegdfe7X33ro4L3C4YXKBVJlBkfyJxEJbXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekJwiLCh8xG62bE6npk+p8qrkQ4YsS5z/S3+BBiKxU9zvzGXufD7fh4C8o/9Y8FRUCN/m7QB4EPCLxPoMt84V604eTreYWEtJVtR3cqaatsy2SYsOiYZezF5AP1FlsMwairbvGO2NrTiT6ZPMrwcgmAOzOIj9kV2dH15dZA/Wyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=McPBIgIf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="McPBIgIf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed32341906so6568274b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 24 Apr 2024 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713963990; x=1714568790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWmvHblwyLfpV+rEC2PSqDTFbQMnE4MDRNUxWTIYKmE=;
        b=McPBIgIfkGSRkg6nVkKfnpiWJ72i3SZ6PIocpp0PgvijkzJ+L2JrlrVVGO8WWp9/Ko
         7HIZz0gNBSsAWkm3GzQy5UtULLMz2J4uEXvZVt8J7x1Pr0BnRsxRf9CqlRrxvzVU+H8X
         n43ZvyrPBXhvaigwVjMMFttxgWzH+bjK2wI+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963990; x=1714568790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWmvHblwyLfpV+rEC2PSqDTFbQMnE4MDRNUxWTIYKmE=;
        b=muMZmOJQ9xIdXi3P8SDOttvEB6v1df8VPj2mdM2gjOvmkZ3B+CgaWR45cgPPopeu38
         2KxIYyEPmnl1NkSJCv1R4yndiH+XjNCeW8FkgiYG7SfpTbeoWcg85XE+befQP06pJETW
         J8xlQIZXsUJ6qo8EEETlVbevOFuCVZm1BTgw0qyyH+5iH0VCMasT93YN4oQw6MCKnkKo
         UH5FPvWAbNmh6vADqPdAXHK16vuKtVvkEc0KyfkB3RdkRhNfkbu+u5lWI1kF9n1gItxg
         UfWnsCEZ5f9c8ZH9L53ZkxwuyI1ug14j7Q0G0Y+zyhNlvod8jOfhjo/c+fro0TnkteK2
         dg0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXXXUiXXCkA58MfB+4y2SAsgPmwm7v0krU/wV8xFNAB4eQzwCCe3vI1DovvgqQdItuL9uhbhTJiyVEtePi06mUCpR5m96GkgqtoeFI
X-Gm-Message-State: AOJu0YyJB+VioV1OFq5z97cAmg6cr3dZ+GCZvEvyrnzrlQHOuuIv+pCP
	jcjznYadA5DpnIaIHQIv8WNEQhLwPOI3vtvrH32Zvs/4CyPT4HWddZgho1jm6A==
X-Google-Smtp-Source: AGHT+IGxaNdfLyHIQirpTurMn+c1hdzjWlDQY5IRavD5VXu6cW703ROJBZd0shDax7VyQ2G08e/VqQ==
X-Received: by 2002:a05:6a20:c6cd:b0:1ad:7fd1:ee2e with SMTP id gw13-20020a056a20c6cd00b001ad7fd1ee2emr2131046pzb.13.1713963989985;
        Wed, 24 Apr 2024 06:06:29 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:836:835b:e0f2:a3a0])
        by smtp.gmail.com with ESMTPSA id y5-20020a637d05000000b005f3d2a9a91bsm9981158pgc.89.2024.04.24.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:06:29 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	Hilda Wu <hildawu@realtek.com>,
	Pin-yen Lin <treapking@chromium.org>,
	KidmanLee <kidman@realtek.com>,
	linux-mediatek@lists.infradead.org,
	Archie Pusaka <apusaka@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-serial@vger.kernel.org,
	Al Cooper <alcooperx@comcast.net>,
	linux-arm-kernel@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH v2] serial: 8520_mtk: Set RTS on shutdown for Rx in-band wakeup
Date: Wed, 24 Apr 2024 20:58:08 +0800
Message-ID: <20240424130619.2924456-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Rx in-band wakeup is enabled, set RTS to true in mtk8250_shutdown()
so the connected device can still send message and trigger IRQ when the
system is suspended.

Fixes: 18c9d4a3c249 ("serial: When UART is suspended, set RTS to false")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v2:
- Replase serial8250_set_mctrl() with serial8250_do_set_mctrl()

 drivers/tty/serial/8250/8250_mtk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c365a349421a..b9cca210e171 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -209,15 +209,19 @@ static int mtk8250_startup(struct uart_port *port)
 
 static void mtk8250_shutdown(struct uart_port *port)
 {
-#ifdef CONFIG_SERIAL_8250_DMA
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct mtk8250_data *data = port->private_data;
+	int irq = data->rx_wakeup_irq;
 
+#ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma)
 		data->rx_status = DMA_RX_SHUTDOWN;
 #endif
 
-	return serial8250_do_shutdown(port);
+	serial8250_do_shutdown(port);
+
+	if (irq >= 0)
+		serial8250_do_set_mctrl(&up->port, TIOCM_RTS);
 }
 
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
-- 
2.44.0.769.g3c40516874-goog

