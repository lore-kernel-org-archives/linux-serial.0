Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000815;
	b=sSTQAbQiseUGmPFflh93AkM9VpFSavxy5F4vZRz7vDYcMnMx2qnEcfGV22OoUHYsrZ28
	 ldCWV4bmTSvCK5YcCFIKPGZMpVrTlDey8S9qmMt43pMG5gOPeYk2PCJpubUB/EOKM3Ao1
	 jYeaiTN89fH8jZhKfC06nDmUFm11nMjt+oSBe1nDhYp0qbZhVxTHps0sz6W7prOiTw/Os
	 q3ijB2TzqPFz4kZ083JQZciiG/F76PItSrTUZLvxXl/ybnblNeUoRhghCmKxVskKtQ3Fz
	 PMMCXPw5Dh/UKJQwskfeWIAuU4RSNxTJAQ/ddgJO/zRi/Jt45ZQaqzDpBNV9cqPl9WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MaW4IJWC0g/bCa4F071QFM2op8BvQwVDTC8JsoSAq5M=;
	b=wmTZqHJw4xxXyN7cG0ZsIu8dLEZEig+x5eksXGGiy9K59hlA2TXDVdrORxiocEM/jYaO
	 oVoIAPW5K02d7rFcyKq04pVEa1osDXmgA0v21Zf+HuUZMyVXyIp1g+PldVOXsZLUNhcgd
	 r2RKMnyITzwNOyPbdyH6KXwuWNbqYj5yMIqEHpL0X7yXnzgxptn6hCuDhCtuumHHjcA6d
	 9oyJVM688AhMJFE/+8CbIMSNnxooOTjpv9B4vCtUoDwfaJbKaUfbi5nU8rpW4iAnXxd+w
	 tMjRQem/2B2aLc2SePGocPVdFqLPvqwttIhUr/sw7aTyEOuiKtbFIgDETgEP1rFsaMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="K8aIDWO/";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE61606A31B
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 07:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BE61606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K8aIDWO/
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d05d51553so17898155e9.2
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793000813; x=1793605613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MaW4IJWC0g/bCa4F071QFM2op8BvQwVDTC8JsoSAq5M=;
        b=K8aIDWO/9vobgoNaHDeHs63GRCjcODxwXky3Nq02Xikwnau67QyVp7FZu3ERHcUegf
         Zgw8RxfKLX5hxLGOs6LlAxk+EQ0m+jVeuWmiNk/B2GVZrxxP9VySjUeC4zD9PQmkzEJ+
         RfOjhl5k4Uq1OhQj9slRU9uYOw0AnTcoV/HTftyzGhqRcTH1VWEWbgOTGmCu25TeWgwA
         Xl8KQb+vSZO/oLuiCWtKlwbhYD8VCxfgBZjv0khwG3VY5v3sHlKyQI079BKCLUsBP5oh
         FpR4PABafjb8LA4OVLfRbss+Y2pEyKhx8WsGjp78M7ISpZAeNfmcQ/pkz+78HKsewBd4
         i4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793000813; x=1793605613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MaW4IJWC0g/bCa4F071QFM2op8BvQwVDTC8JsoSAq5M=;
        b=MXGXBpce7VrWp3Eeplblm3b9pL5F8Zkg/OQtkT52slW87BcvK3eiQey1XBvQbbMERm
         mb0c4MIAgf5Kb69xcYtNXYjlu+lmKnnKhVuHOhsTpbq7Tz+xEkTYaNL6LyMXc0+jLKqa
         9WUzNncivMfxxz4lyLu6+R3LWIkP4w6jWk3sLme4+cmoJlLss5RGh5kS7DOv9kaKnCPA
         vVpigKf+JyurImd3L9lmA717oG9rRC6nH51mo0uy4CbKr6rT0iHZqBcpyYo591nq24+b
         EfSVq6QTQcvXLQZdW+PPJ/0u3krP5FJW4CVprcaFTB6MktqaH5xqoPJ29LJE1fMfAuS7
         u/iw==
X-Gm-Message-State: AFq9FYLHNZ/d95l4nDd3PIDZIyJR4b2OZ0JGI2+UrX/2EgT8wG8iDB8y
	I7U/idbgp687BhM7BnIrzYTl5KHStW/hCnUDhiadp5s57Q0AVeR0hGtQ
X-Gm-Gg: AYBFou3cYkCG7+oW2bANyP64j61Owj8MdXk/VWRaQAbCizu+naxOcOn4LIzqck5746V
	2guI4V4X/JG8Fi3RiuCmgrxW/nzTBHuKEbEpGAqoUx66A1v12/Kq4vsRT1BP2pHGvv/TfswTm45
	aSBZtSAkXpsQu9r76igU3zc7K5dWiaNv1ToMoHXm7+zf/kf+a7VFqR0hxLLA+zZID3vo/tlI6ft
	3vE7ClMNMrJjFe61idKwIi8dHSPPW+0YtRNcRvOQhEzwF9rktE91scM2yfUfzEwijq1YQQRP95E
	LGTGC1kc5jwXC0iW7ZS6QEhVcNwtNXqV5SSKOCYkX22vSZAyYppaEZs1WYqSidZqgXiFNyrXKD9
	mT/ePPuXCRAEzg0R7u5+jtZUlHZGFBDN2r5B6Ij7oMoZ2GNy28s8m3e625yWKcCe6qybFNV3azO
	8YMaZ/vuRZT+vie1dhntK0Ib+qQcYtDP15rKY0PyXwbLtgqWMFb9zjPsDYh0VPJPfm9qQnGfOiD
	3ngXmlfejElw/mXiELph8O+6JTiBdE9yZmDPFM4qHInwXbUO/JAYMrUK2h5h87u5oCTMw==
X-Received: by 2002:a05:600c:3493:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4a35ac9d0e8mr108207515e9.11.1793000813031;
        Mon, 26 Oct 2026 00:46:53 -0700 (PDT)
Received: from fedora.jkuat.ac.ke ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a59d238sm162898215e9.14.2026.10.26.00.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:46:52 -0700 (PDT)
From: Bramwel Barack <bramwelbarack89@gmail.com>
To: pali@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bramwel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH] tty: serial: mvebu-uart: use device_get_match_data()
Date: Mon, 26 Oct 2026 10:46:44 +0300
Message-ID: <20261026074644.17464-1-bramwelbarack89@gmail.com>
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

Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>
---
 drivers/tty/serial/mvebu-uart.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 33ea496c93b2..adc2cf7ee65d 100644
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
@@ -866,8 +864,6 @@ static int uart_num_counter;
 
 static int mvebu_uart_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match = of_match_device(mvebu_uart_of_match,
-							   &pdev->dev);
 	struct uart_port *port;
 	struct mvebu_uart *mvuart;
 	struct resource *reg;
@@ -919,7 +915,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Get controller data depending on the compatible string */
-	mvuart->data = (struct mvebu_uart_driver_data *)match->data;
+	mvuart->data = (struct mvebu_uart_driver_data *)device_get_match_data(&pdev->dev);
 	mvuart->port = port;
 
 	port->private_data = mvuart;
-- 
2.56.0

