Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385274;
	b=nBcgPlZyoHtZoaocmAeumLDQxxizbjNFJQoyYDs9694EE3u7ZOjq9Flm3oBIbNlwiTEZ
	 7jHMCVa+Bl9Hw4p/BHtKZUsE9xKJ9bV215amWun6RfPsZGmiu0TksyCJXEfLCQSAxPO+U
	 s3eDUFUesFuZ2oEoK+wx1HhwBVmjl2ZK9RCCZCaj9sXpVBkXXXBu/C2SvTfQiX5IARUOI
	 H0erxCW6+mgEYWBTbV3IMV9cAvjILOv317DLGjQN2dIVtkY0pZmHaW0H2bbl5CcuIijH7
	 TEi0/nUP1z8RWR7kmlwEV3uL+Pv50EcSoTgn/7a31VLqVmXCgpm3QKrdNKFN87zo9tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6IcSNu4leey2R/HZQEBsUuZxK1oRfKLqiFJlrMLS854=;
	b=nAcvpyuvBlSE+8v6m7GUaalENqerOU1Z4MvwwMOelZzX+CYAbkoMTwNORgF7pkuNXeW2
	 e+yKveUHjULPoOrSZPzMJx/24dYlrKBHSMeYtvnuDhNas9aV3AQGm4zupbV7GuKYbCuZT
	 R3tUhqYuxlOKsBCCZm5DvOqTmjxq3nWh+m71/nxYOcz5mq/K+IjFnwKkVOOU56RyPrcD3
	 mEiBi6U6NP9VJB86n9BqzdgYRS99dTdYbBSSC7thMLZIWJxzAeqXgp0/ebtJ8EUrSNj2S
	 RhxjnprmdCE3xDwXJOSGcYsvE8es8Miys3QjqDk627esQQcqSprp7eY5LgMJWLYIl1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wVt2wqfq;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD03606A31C
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 18:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AD03606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wVt2wqfq
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso769556f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385272; x=1793990072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6IcSNu4leey2R/HZQEBsUuZxK1oRfKLqiFJlrMLS854=;
        b=wVt2wqfqlC2tFU7dgRYWofFhySsKi6XWL54tcVniMNHh3s9cRc+cLL+xY+pN4c1riV
         DtDEr4n10/djQH/E0jiT7qedo0HGaoWg+yhRjdcPGtfxg5FrvIeOc8TYo9dY4PrXDaeD
         GX3pwQePYwo3inQemkhgdDFwqHGWYH+honwFu8uTyIkg49qzZCX9G8EPPwzx85icgG9t
         IMK1u20OzfvT24CtYfDS16nKM2NU78JJko6nyAUwqTmytu0dzUY4DApV1/gx4Q3Ah0TG
         WqYQAiWCK3rWm0MlEH4FY8+ieySzYQ2t9e6+tYLsylsqhJB15b6abS2J9yihy//XEYpn
         PMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385272; x=1793990072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IcSNu4leey2R/HZQEBsUuZxK1oRfKLqiFJlrMLS854=;
        b=M6iAfScpZWuF6M/zccK41Fmke72Ph4iPzMbSW8cmypNOfqZsO0cKazd2B3MLUiVZrP
         S79hLjIvY79VC0+xuogBAocoPYCaqpLTijerzjbSIOAqYqfLftc+pf1GwkbNhsVsNMOA
         LgPB6ZLHK6ShlzbPWAFU22ZIXb+5ZYXduBdxVerbhP/U6blUpzRox0MV3GahvtR7cj/4
         5IiwoT4sD3Ld4KUxBLvDDlMlVHf6xzCAQm0xiL6b8sDH7tRqZ19QC/5vVi2khcQFSOex
         pK6OczxY8+JVDMi3Ot+AzY/7aWtRRkAIfCeGDE1eWquq0wnQV2FdZ7GNiNEbUjh3l8k2
         dzcA==
X-Forwarded-Encrypted: i=1; AKwUvBx8jMXrW1pD5PNSIL0WbPi92xEnSAUD6Pw5hmhYi4q/nmRiGOKAdSQ1tHF3HiPNyM0fKi0iG90XZztuuCs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbwSy/QmxNfeKUSsp4KZviqifjDPza/KoTqgtXIPqZAiBPBNzq
	NMFtWSv5yndy/SDyBnqZFNPWbnSRw0nF/8hemzcRvmBd8TZ936oKgBjM
X-Gm-Gg: AYBFou2Ey3O7Pg6lRd3KBwcRosdJk7mDcUnZHBCzM30CAazff+Uf30AQwBPpXqTi4Mp
	pffdIP7WgshwIPPJiJ+slKE1dqqrTeO6gVM8AoQOEIR5/NX16412St66oe+LsTikq4cKPZfjFAU
	2YcmW1Z4JuNFyF2pIAgFx0yMxzX8s+oHiKAbmb4YpB5RE+Z3n54HzVheBylbEXeksYo8P4ZJsvg
	rEDmp8sY21AFdYqjvgaC3TQkmiJgVyOZuyYrahebQ+T8DTOqO6CMCIsUp+Ebi30moSGZ7f6NuZw
	YEI9hyV2urCD7nqUhjky7jMfeJu6IWbXIbL/jb6TfnjXyPuwnFsRvcI/WKe7MXG7gq43vSebVy9
	0a1bAIXQ0UScpKm2kvChqoWIIK6jHp+1yOEHGcowOnxFIzGSZk50c2d6taWA1AvoNFLHOfUS25I
	jTsdllwsa4mSiVf/I0OswHcqesdzBmSOOdRI+fw8bxUXv3YH44iyozpDD71yLFL/OPVL+tSuz4g
	I+DtOjZfWCKBR/eH/4QosPhn/allx7TLDjX7gB7ucjN3QerWK8bn2KrbR8PfYsZDbgw0U04Ocom
	NcHa1v4tx3mA7NDnRRXkfrTxjEJIU9aH3Q==
X-Received: by 2002:a05:6000:26c8:b0:48d:f14a:9183 with SMTP id ffacd0b85a97d-48e6e303b1dmr7587067f8f.15.1793385272117;
        Fri, 30 Oct 2026 11:34:32 -0700 (PDT)
Received: from fedora.net ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba24f6sm4388535f8f.51.2026.10.30.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:34:31 -0700 (PDT)
From: Bramwel Barack <bramwelbarack89@gmail.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: Bramwel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH v2] tty: serial: mvebu-uart: use device_get_match_data()
Date: Fri, 30 Oct 2026 21:33:30 +0300
Message-ID: <20261030183332.23834-1-bramwelbarack89@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Modernize the driver by replacing the legacy of_match_device() call
with the modern device_get_match_data() helper API. This cleans up
the boilerplate code by extracting the match driver data configuration
directly.

Consequently, drop the explicit inclusions of <linux/of_device.h> and
<linux/of_platform.h> as they are no longer required by the driver.
This allows us to also remove a now-redundant forward declaration and
 drop the problematic of_match_ptr() macro wrapper.

Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>
---

Changes in v2:
  - Dropped the redundant forward declaration of mvebu_uart_of_match.
  - Removed the of_match_ptr() macro wrapper from the platform driver structure
    to prevent build warnings when compiling with CONFIG_OF disabled.

 drivers/tty/serial/mvebu-uart.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 33ea496c93b2..1e980dd26465 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -18,9 +18,7 @@
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
@@ -859,15 +857,12 @@ static const struct dev_pm_ops mvebu_uart_pm_ops = {
 };
 #endif /* CONFIG_PM */
 
-static const struct of_device_id mvebu_uart_of_match[];
 
 /* Counter to keep track of each UART port id when not using CONFIG_OF */
 static int uart_num_counter;
 
 static int mvebu_uart_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match = of_match_device(mvebu_uart_of_match,
-							   &pdev->dev);
 	struct uart_port *port;
 	struct mvebu_uart *mvuart;
 	struct resource *reg;
@@ -919,7 +914,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Get controller data depending on the compatible string */
-	mvuart->data = (struct mvebu_uart_driver_data *)match->data;
+	mvuart->data = (struct mvebu_uart_driver_data *)device_get_match_data(&pdev->dev);
 	mvuart->port = port;
 
 	port->private_data = mvuart;
@@ -1016,7 +1011,7 @@ static struct platform_driver mvebu_uart_platform_driver = {
 	.probe	= mvebu_uart_probe,
 	.driver	= {
 		.name  = "mvebu-uart",
-		.of_match_table = of_match_ptr(mvebu_uart_of_match),
+		.of_match_table = mvebu_uart_of_match,
 		.suppress_bind_attrs = true,
 #if defined(CONFIG_PM)
 		.pm	= &mvebu_uart_pm_ops,
-- 
2.56.0

