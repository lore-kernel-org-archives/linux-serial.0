Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327F3446C7;
	Sun, 31 May 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210981; cv=none; b=BZzvZC811w0ZUmPFz8Ev4Wr5ScwMi3hEm13L3Dhhum/+2iOF3G0cz8K/I35pcC+XxwxhaB0ELyhm3o9mQ6LAHfsYPkTPbnc4grV0Kv7lgi7w9pK2Y/c7Zl/SAjcZezNOPgV/A4CAGVXMXgbncSMxb9rYv8R4GQoj555o/p445FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210981; c=relaxed/simple;
	bh=5jlG1ZBa8egfg82qCqwH7qx85kPlT7tbf37Jay+e2W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqXl+vpzjW8cumQJgcRpgNHXiQ2OWdso9z2+i/3SEC7aT4bHpKcLZwLsXcs3BVKj4tNemkWzpQ9XQ/rc6cSqqsKzTqCsEwjMifNfAs55Q9PC2LTPTZqcd2TJWc6Sc88VewmbxqbwrTMdrSeb/pCdqAkx//C+sdDTbh8Up9SxIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRX7w2WF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRX7w2WF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59181F00898;
	Sun, 31 May 2026 07:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210980;
	bh=YfIYXFpeOLT8zVHUHzuYoeYdkWWHFupYpwpzBCCce9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KRX7w2WFYviJBkkt8f7QmwdrnwqRcFeA2dtyjFi7ddPKVWmw5U7+XWKIbBHv+Tdlu
	 sD18MWXVqLVjB5/yVC63MoxCGoJLNnK6HL+CPkHGqRnPIxnemNxvUvQc/3neqINWX7
	 TlZQ1DBU9Jcl+u0N+Io58Wrs9Z1R1uhhJTEDSfomNtETyR/CwyXC6ARxQlCuB0/9ZP
	 26JT09xFNOJ5Z1DFg/Cr9GiAq/OjhNkhlDNp5wf3d/t5LdQ4KPmkFlVgcxc9l+0Fj3
	 F9lK89f17GFToCGX16ro0It07MJdu3BiPalcxzwyOVuE2wPhyFDGLYndC8Nzd2hEXj
	 5xvYdZubgeg8Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 10:02:49 +0300
Subject: [PATCH v2 3/4] tty: serial: men_z135_uart: replace
 __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-tty-v2-3-f7149947d4ef@kernel.org>
References: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
In-Reply-To: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
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

