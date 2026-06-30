Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FF3E9C26;
	Tue, 30 Jun 2026 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813255; cv=none; b=jkX2qQf/VhdKc4SUizTkSIS9SpMCloFqdopULZrqRiLB6k0DwMNxFM4etNLz9cXwdd6IiZx6d05Gb+JeqA7bjFiAJJAdni2rGcxmkTU6htHYpJBaecDp3rBLmmyw2BMYHAubNAB+UW5jJqvZfm1H/tvGx9Q5M0y0LhXDrX1HNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813255; c=relaxed/simple;
	bh=5jlG1ZBa8egfg82qCqwH7qx85kPlT7tbf37Jay+e2W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhyWpeRXq7q02+vMW3aVRAv0oykm+H+6JDfAB0vtlrapNbyVqY7qQ7MHr9p3R4yE1Q6NZ8BQ9WEUQI9n0ASXHjXn8nPRonvH02lJaUUy4gHA3G3p8UL1KVB4Ri+HE/3NFU1K/rVXaNzjBJt2BbY9jkTeo9V/L5AzyDzGEcwwa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaW0UbMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaW0UbMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CBD1F000E9;
	Tue, 30 Jun 2026 09:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813254;
	bh=YfIYXFpeOLT8zVHUHzuYoeYdkWWHFupYpwpzBCCce9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BaW0UbMH5ejYzIoTXvdKCCac/cJXwivlxwD2WF50m0UODbxHm2Ugi7mndIwi6kQUX
	 je+g1gYxh+zn8I6Mb4ko47+W0T2uMqflja/KQXhZHxA49+U+GrqTub62av836hjW0W
	 V8l+cveoTHJzG9nEACP7f9Syee2ZRR5UYDN1jaic1nlJvwcmsO69bA2ejzK2YU/7TJ
	 9XjQyJR27+HxfsnlNGqbo22Eu75g7N4u4TYQ2F/D5Mvu0j+B5lWgdw1c2nhaFGoeRv
	 FJQvlTLAY/YtISEExuTZgrf8qmy38oTuoTo8qPB44JGRGSfnjCMX/l44vljCPXdKQ9
	 g/NjNb+MaYiDQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 12:54:05 +0300
Subject: [PATCH v3 3/4] tty: serial: men_z135_uart: replace
 __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-tty-v3-3-a8476c66c582@kernel.org>
References: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
In-Reply-To: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
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
index 6fad57fee912..9138fa29d301 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -16,6 +16,7 @@
 #include <linux/tty_flip.h>
 #include <linux/bitops.h>
 #include <linux/mcb.h>
+#include <linux/slab.h>
 
 #define MEN_Z135_MAX_PORTS		12
 #define MEN_Z135_BASECLK		29491200
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

