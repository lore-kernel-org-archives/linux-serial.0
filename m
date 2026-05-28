Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E53B895F;
	Thu, 28 May 2026 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963875; cv=none; b=Xi7PPfD0sLgPJctrl96vD1q55VZRXiXzDb21W+T9HWPIxqcSZvDImU7+XmyBGwyb9OpSauUv/uKU/UQm8NWun8wdwU8SfDhNwlFovFGp1iBKAnsr4ri5nCv52cvdcjIW2E3FYLdZxB+NOtACYEi2VX/0qCBN7OBNfmTb1z7V4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963875; c=relaxed/simple;
	bh=TD9dqz1KlLDHtnCU5rXCGzTLbngGmrWaIOq73qhB628=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLM0fgqPB7XBj5KvMfJ9GtUg2go/gh9Qt23GFRi11BshbXxZnp7C0nIjrH+2B/FQNYMYDfzvQKHNieISivgDQsdXf+ujk1CxUOyRZizG51J8AEjxxO0e1Gp+ySS2GZ+e5Co755uvjodz0PbJVak8nF2F3gQd9gzRU8GUNtpdvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eceMgPWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eceMgPWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D41F00A3C;
	Thu, 28 May 2026 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963873;
	bh=kp8FNXKpfIDXxy/obg2faB0r2hMuUh4kHDljPd1Q9rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eceMgPWsU4Oc5vFuawnPCveJrzbCB+0tKN7hwo77PWnuwIDWdwAHQW15i8rQxXFLf
	 0VV0hnTQx1m89G8N+mk8PGg+SZLqD2YjumWnvoOp9SONohaxubtLyK+z7lpzpQEjEu
	 2pFPFqB0OD/Hx5i5elYXthvWtrxrwQUwuqx2WTInASpP/f6tUIN+tKrZzJ5ZHyoATu
	 U2dpfWJsEUof2EzHCLWebkPnvWLitxizyrxLvmdZ7Nf7dCpGhVHwzj4cTb/VWO46aq
	 rGRLfTyHvPjT2MPn8rJdnnxKy0k4YwMDEyz7Z94/wRAuy/U9CYeNlLfs2gkjQaKoJm
	 vVpMSdE4W92iw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 13:24:19 +0300
Subject: [PATCH 3/4] tty: serial: men_z135_uart: replace __get_free_page()
 with kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-tty-v1-3-9da9f7aec5f2@kernel.org>
References: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
In-Reply-To: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.15.2

men_z135_probe() allocates a receive staging buffer filled by the
CPU via memcpy_fromio() from the device MMIO region.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/serial/men_z135_uart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 6fad57fee912..9c32b01edc9e 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -17,6 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/mcb.h>
 
+#include <linux/slab.h>
 #define MEN_Z135_MAX_PORTS		12
 #define MEN_Z135_BASECLK		29491200
 #define MEN_Z135_FIFO_SIZE		1024
@@ -811,7 +812,7 @@ static int men_z135_probe(struct mcb_device *mdev,
 	if (!uart)
 		return -ENOMEM;
 
-	uart->rxbuf = (unsigned char *)__get_free_page(GFP_KERNEL);
+	uart->rxbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!uart->rxbuf)
 		return -ENOMEM;
 
@@ -841,7 +842,7 @@ static int men_z135_probe(struct mcb_device *mdev,
 	return 0;
 
 err:
-	free_page((unsigned long) uart->rxbuf);
+	kfree(uart->rxbuf);
 	dev_err(dev, "Failed to add UART: %d\n", err);
 
 	return err;
@@ -858,7 +859,7 @@ static void men_z135_remove(struct mcb_device *mdev)
 
 	line--;
 	uart_remove_one_port(&men_z135_driver, &uart->port);
-	free_page((unsigned long) uart->rxbuf);
+	kfree(uart->rxbuf);
 }
 
 static const struct mcb_device_id men_z135_ids[] = {

-- 
2.53.0

