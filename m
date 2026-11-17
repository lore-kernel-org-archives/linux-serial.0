Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925315;
	b=2QynnIgYIMg9o80wG5mEyEe2/E1yxv65wJsNRcp2xmpBF6ag0GSW3ld3A6KaXmUUpeHe
	 uzdSn4Aqj0sV00E1M6/lpBzmfo3iMpof+SI0N3pMFQyE4KteG5NWC7j/wVLUrJZ3uR9L3
	 U1K03v1v0wfD78zGY3JfqIwzWMAUHHI4ggA0NS+C0evb5rbVksYOROcdEf0l/g2PXVrnD
	 GYDFTQDeTdzF0jOSKxI9m906d2988nndi16R+SZ4da6W4Xahui5cI+vc+cYtG3jma/rS5
	 BCNXvZEAUt0L36i/ItagY8j3lkIDcA+q5JR4GjatBwvCI/dWzUCqShY1609KtfzbmvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LwurQFNbXh7iPvGiwBmdrhIGI4UzTbfkuF1+uo8VDJ8=;
	b=VsQALBwE1Ig9fAzVRbCiOhSbP76vP3qyIo0w69+IWck/LeTX4UnqADPtAbyiVlMXkB3e
	 agCbWxUpXj+B9NuJfTI52sylTJnaoaJ1Yhguxrf4KZeEf/YDSuwOguZKwFYmgLJpV7PjS
	 K+jaZ+UqHqe1Hmyvp89WU/5A4xwNZaAdIyTF7aLCaZkqzyvkkFebHcXzKyvb5tRdfJG2D
	 7D21MVpCoR4JY7o736UXW6eE04xkszklVSrYvVxpPjp5NPkHAAL4Bi3SQAgZ+wD/uKUpL
	 5ztDw3W3ND3krgGPizTbo8lXrr8RVQFajjwQp3AkvLpN+q2pV6Nj3QE06oNyYXo4doQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HYxgAvlt;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB4606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 14:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0EB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HYxgAvlt
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso10491324a12.0
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 06:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925313; x=1795530113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LwurQFNbXh7iPvGiwBmdrhIGI4UzTbfkuF1+uo8VDJ8=;
        b=HYxgAvltjlfhfqJpx9q7Jzw+9n6sTMFBXoqMI1l49I/u3QjUQ/FdBJlmkoEb8grnHi
         /fTWg6cFafyMosqUjBCh693zSsQBXitFqfT6WmmboEMnufuX8AXI0PaBs2MAOwJx5KCE
         rbA65xE4jdObOYmXO7YgLLwcRqUjq4FJJiSU1fnPDCtRk6BsLTS/b14j8ZRzG/xJLBc3
         Xg6Inre/FC3ejOaGb+nKJ+SU18+9KV1to1cosG4NpKR1jiGGjPAVCmRBLI85uoqZxrdR
         ZjEScSb2S9C+mCzTwqWY3C+tiUBtrOzByOJXn9KrSSQ0mSy8mjTHw0HG0feCQIacqJ3+
         RDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925313; x=1795530113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LwurQFNbXh7iPvGiwBmdrhIGI4UzTbfkuF1+uo8VDJ8=;
        b=EteS3VnKN6AA93z93LPgleA36W7jiQPTNwjJ3wS/JCs059rJ1cMMG3EMKqxJPaBCI6
         rAFAb4Z5ijYzLGwSBNpYUt2Psh5JrG+TA0G8/RCGWlU6JdCM6c9egLKY81bDa55ksMds
         uwP/zKeOLbnqiFeKWorgp+kd6cERGHswptOzLkHjo/eKLBzF3kIMmN8CiQFkFP6qL4hq
         WOta8uj2eAD2FfiaqOx0kysGRgYS72+MOVabDkd6K9GAUtRS4/CwjWEjG0RxQbojG3sI
         Hv04Tg0QF1wyhXq3mh1PHOAgb6nIbp1RKPFIi7IN4LB9yOBT6oD4atOZuQ5kTk2JxiLU
         ZL1w==
X-Gm-Message-State: APuU4Z+JAoJsiAt7VKe3EVsAmuBsRBo0814aNr6jyEvIKBR/YrFpP2rB
	IOfaQqyHuFER6Pm9sHlcj9JYjg5rd2eg1/TN9x3jSf21/0eCFqk5IWc7
X-Gm-Gg: AYBFou14STfxbYcvkECTMcHt9QB/QQ5uYwesIcaN4xf+RUXS9NmyBJEn+d0Eyckmg7z
	qGNiyI3RD2v16PjR5SrvHrdUnZGHsm0m+9kDZC5JNPqTh4DhdI4EXyH+lvHOdhApyTxB0czv4J0
	Wt/7WFvIGkvJI+DjVxLDi45zwr7P2vtnbcMljJp3QHLc0KKu+6dAtvCPk1Di02hZwATwxfFdMVU
	iIga9ry7lTyY9fiH5Ux2Ut+jgk6+ppJKPHgaWYIWlmMOw1elUfGLPVuED+zJ2Sd2ZdN3SBIHsiT
	mm8xvMTW8+8RyPBFH1Uz4qnvdoghF+ju5rBUUkdQtUz5Y+4POtnAyEmMlQeoZ/4dsjzbUMtkxmF
	DLNgJsqncHN3WIyBmjfa7DlQAhSymAscxYuyKNVnkRutsFnIgQxmrehlR68wtsPU56xOdZd6mpF
	STL61UE7+RKJxRlaVvNedgU2pEJZheWrCwnqfDbvjkfx2GUvuwzBnIsz/+CY6RaxaiLz9aJgdSn
	z1K2C6RSnBxcgbXzcmzdKle6fwKHYnAEK6QXMBaKpK3AQwY1LOHgh28dNsiEQ5HB5oFa+P3nYkB
	jI1z2jJpaxmxmS0+42ksRrGDyrs=
X-Received: by 2002:a05:6402:1e96:b0:6b6:f5b0:88b3 with SMTP id 4fb4d7f45d1cf-6b7c0891000mr11477809a12.3.1794925313148;
        Tue, 17 Nov 2026 06:21:53 -0800 (PST)
Received: from fedora ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c24e7714sm5728827a12.28.2026.11.17.06.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:21:52 -0800 (PST)
From: Bramuel Barack <bramwelbarack89@gmail.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bramuel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH v2] serial: mvebu-uart: drop of_match_ptr for ID table
Date: Tue, 17 Nov 2026 17:21:15 +0300
Message-ID: <20261117142115.18402-1-bramwelbarack89@gmail.com>
X-Mailer: git-send-email 2.56.1
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

mvebu_uart_of_match[] is always compiled in and already referenced
directly in mvebu_uart_probe(). Wrapping it in of_match_ptr() in
mvebu_uart_platform_driver is redundant and prevents ACPI PRP0001
matching when CONFIG_OF is disabled.

Switch mvebu_uart_probe() from of_match_device() to
device_get_match_data() and check for NULL so both Device Tree and
ACPI PRP0001 bindings resolve match data safely. Also drop the
now-unused forward declaration and <linux/of_device.h> include.

Signed-off-by: Bramuel Barack <bramwelbarack89@gmail.com>
---
Changes in v2:
- Use device_get_match_data() with a NULL check in mvebu_uart_probe()
  to prevent a NULL pointer dereference on ACPI PRP0001 match.
- Drop unused forward declaration and <linux/of_device.h> include.

 drivers/tty/serial/mvebu-uart.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 33ea496c93b2..509690748ef7 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -18,10 +18,10 @@
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
@@ -154,7 +154,7 @@ struct mvebu_uart {
 	struct uart_port *port;
 	struct clk *clk;
 	int irq[UART_IRQ_COUNT];
-	struct mvebu_uart_driver_data *data;
+	const struct mvebu_uart_driver_data *data;
 #if defined(CONFIG_PM)
 	struct mvebu_uart_pm_regs pm_regs;
 #endif /* CONFIG_PM */
@@ -859,15 +859,12 @@ static const struct dev_pm_ops mvebu_uart_pm_ops = {
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
@@ -919,7 +916,10 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Get controller data depending on the compatible string */
-	mvuart->data = (struct mvebu_uart_driver_data *)match->data;
+	mvuart->data = device_get_match_data(&pdev->dev);
+	if (!mvuart->data)
+		return -ENODEV;
+
 	mvuart->port = port;
 
 	port->private_data = mvuart;
@@ -1016,7 +1016,7 @@ static struct platform_driver mvebu_uart_platform_driver = {
 	.probe	= mvebu_uart_probe,
 	.driver	= {
 		.name  = "mvebu-uart",
-		.of_match_table = of_match_ptr(mvebu_uart_of_match),
+		.of_match_table = mvebu_uart_of_match,
 		.suppress_bind_attrs = true,
 #if defined(CONFIG_PM)
 		.pm	= &mvebu_uart_pm_ops,
-- 
2.56.1

