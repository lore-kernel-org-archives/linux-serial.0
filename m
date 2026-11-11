Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424782;
	b=UciqOK2VH+eSOhkjcww9g8JmqFMuPu4RXee/34yfrGgTyW8SCnllofkYDNWNmcLsDW0q
	 RlEf7Sdk2sevh34xuIvbyuvXoNyj5+8GfwfTjuT4usYcAj7WldSmyfNybg0e8paO6rxXF
	 HJaEtrn31CNYzb14PmvYIEruznwpHTOmhSeGUgrOURWQ7eOW2Tg5Ncp+rVw3IQYW6O20J
	 aEVjHTiyZ7t8qBfbTmKvrR7JO+zeN0RP8OOwfP1/Qd2esfStJJ7Q3FMj9YjnLUID9S1sr
	 bWsbPSIimL2O1Nv5jp06o3Dw2PVfgH02YNdp5b0ykRSr21lPP0LaEUXdqEW8SjZCtXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=BKsZ7Ow4qZ7mZiSdzQqgyLRR7L+0QBeMR+7OXlVyKXI=;
	b=jFeHVvhyfB9Oy902+h7llbXDIl2rgmDAsSH3XTn1GrU+ilahx4nXuPaem1/7LFFBqUfG
	 76X/mXEAjoxP9zkjq98vrcO2rFxfd9nmiwtj4Z1K9CDEOH61RuM67cx1WlQCoffpy6E4S
	 2E1AS3deJLrWB6jChiNqB4apqUc/2RDgLMACIeuFaqLuaYc2I3X9ViMzKZtBYwU4fOYvo
	 m4mUfjf6hhJEiFEKIIFxsIJ5xAxAnpTRCR1BxW9x9tzwJXitnnkxuXN2lvNx2/5g4yhD4
	 jCiA4UGnCtJiVQHtX5xr9rN+Exfku8AgFxRwCrn+OoP+s/3CKTVl3usOTgtVQekVisg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="H/qWxOzG";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CC606A8B5
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 19:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 623CC606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H/qWxOzG
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a210470b49so29204885e9.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794424781; x=1795029581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BKsZ7Ow4qZ7mZiSdzQqgyLRR7L+0QBeMR+7OXlVyKXI=;
        b=H/qWxOzG/yVcusr+sjNl58T4rcRNO67PXAXNjzqP7McyYDSblzOQlaT8awtldpi1+b
         Tdznbs5r66A6hVauNAl8Q2hcHllmRe4DwWsRkGWwGUfJM6fl2YUMgT5H7ThsI10ELCZ4
         /SaRwHhFOOJppjQnDQzUqCg0kgSlHctHmhYtaOdU4RbmRFNHRM5lIdAWWCnASSwITz0W
         pLjxkAg8VUUBSUu1F92JCD014tR/jcsqJ/Gha5jL6w2SnA2SqTxQeyHUksCcaYylxjOV
         9WQ+6IX48AVwHi9u6+SlJqSLwheTbkrKcxclSbWBdP+YzcDKAIrvpAPpZrwVf+UIZnwL
         9/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794424781; x=1795029581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKsZ7Ow4qZ7mZiSdzQqgyLRR7L+0QBeMR+7OXlVyKXI=;
        b=n0artkuzUBZj/XjWUDn/JAHxnrLXRP7+6iVWu6FoVbU4t/V77D6OtLptipQf9NZdsJ
         CywDDtAidfI3a94Sax9OMeKgsMZGAXQCNxntEjXCr/MBV7L/cx+aVbJV6aBkbhScxzMw
         nYfzg13SJ/9ebIjFB6+3jD2QryfaCGOcgdOtF6PcCl635IS3QmvjGRgIp0cqGvCRSCKk
         TYd9Q6Y6HDGqXuzy/wUPhzBqSa0uUXvl8ZlugDzhMpg6zMXpLpRyWkp+UDMs09PFpcWn
         Y890kBoJH4GtlD8M6ZqWWliosHZGD2HSBhCzIQQHWrVkTZeQ1OhVue4n8afpLe8Zommj
         wgCA==
X-Forwarded-Encrypted: i=1; AL+hErG5I02Ko8t9clacAMRz1AMBIZONz0TgoSSrCXKEq2XBIj0AaSzeGP3IZ0M5mkvRFwgsEeCsX5yhyfqh/vI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EbIkeS0BINJx2GJi93TNmT6rIVxM7QAoaBQoGox7oFcjSblrs
	vAk76rEf1ttq54qb9mHaNl2LXbkJwoKQnyy2GqFHLZOqAFBjKukzvxyb
X-Gm-Gg: AYBFou0sK4srXB2yR66rfqRelKG51qJoEQd0Ie/8oJ2SRjQkc/svrzYGe6Q6BvkVYfR
	Fdzap86lBHX/9FfADGG+Ab2OQ3ytzPTUi9HajgIWhIY4inL/N/kdBgRaTslhPa//MDgMi1txH3Q
	j5Q8RAqckkg56gyKLT1xS4NV6s4lY/6KLVEuysxa56YdaIgMdEiciWATPBJ5t34qHLrCis2pmSD
	TEF05i+6NDMQ6ytWMYMDD3D0rHntAiLGYHuoMyhAZXg2dHb6Dnn1Z5M7dG1a4VOh+MQB1H5jVyi
	H5NwloszdG1q3eYSFjRnoMjLPvnQ6mFtBmfj5BWV4hB/ui+cfxBwx8Q3MUGC2Oz2NJuZgPIe7D2
	Nn5RIP/prrB49VQI2NkABEiMDb5ejdxUoiQEt52PDEFBEsORmL897WAqwYcVzOBSshIgo1LgL6t
	6DavLESQREwGUUuOr73q1qIQVCBA4cMFpFw3dSTS7C1GqMQGGbznRNvHyg/3fJ0hMKKzZNeAtGm
	l0vhbRRV3ichbo2xxqiK+/g/Ho4M2ZmfFicJWTYvB6bE86VsoO4B5dEcqUXdQZzKi5b3PqcUM+l
	/8D39mEO0pxjOfAZOCZSmjF7gupXQW98jzFFusmURhKj9KjtAgcabEqcZgyGMv3ruvHpmRU8KjC
	VtNRBRpVs/pO2TL5JIYFkaG1NkiPq
X-Received: by 2002:a05:600c:19d0:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4ba093805dfmr58429255e9.9.1794424780677;
        Wed, 11 Nov 2026 11:19:40 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e267dcdsm9345305e9.11.2026.11.11.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:19:40 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 11 Nov 2026 23:19:19 +0400
Subject: [PATCH 4/4] serial: vt8500: Drop the port index bitmap
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
Message-Id: <20261111-vt8500-serial-cleanup-v1-4-b33594a25f87@gmail.com>
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
In-Reply-To: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847; i=alchark@gmail.com;
 h=from:subject:message-id; bh=1q06ztS4FMn7AIh6i5VhNy93j0jS97qWkyFFncuqV88=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR92b/f7K3N3q5VzOwunN4e8gIxtxYuj2svcCm64b33+
 ymjSReiOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqY5MZ/jud4Jl9QfUh47bkbIcTP6t4nztK2ixxXOFj0ne+trH8WRojw9HDwce
 SZ6190xAb/T8/mXluH8/Ri4JHtWMqIvLnRWYuYQAA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Stop reserving a line in the vt8500_ports_in_use bitmap before probe
acquires its resources: nothing ever clears the bit, so an early probe
failure strands the line, and a retry then fails with -EBUSY on an
aliased port or drifts to the next free index on an unaliased one.

Pick the line from the serial core state instead and let
uart_add_one_port() claim it, as the core already refuses a taken line
under its port mutex. Rely on that for concurrent probes too, so that a
racing probe fails cleanly with no driver state to roll back.

Keep the allocation policy as is: honour an in-range "serial" alias,
otherwise fall back to the first free line.

Fixes: 4001130df1a7 ("serial: vt8500: Add devicetree support for vt8500-serial")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-ca000721-4a5b-4d88-bdb8-7f1e438dc81e
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/vt8500_serial.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 7c7b4beb51fd..f9858f10b5db 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -90,7 +90,6 @@
 
 #define VT8500_RECOMMENDED_CLK		12000000
 #define VT8500_OVERSAMPLING_DIVISOR	13
-#define VT8500_MAX_PORTS	6
 
 struct vt8500_port {
 	struct uart_port	uart;
@@ -101,13 +100,6 @@ struct vt8500_port {
 	unsigned int		vt8500_uart_flags;
 };
 
-/*
- * we use this variable to keep track of which ports
- * have been allocated as we can't use pdev->id in
- * devicetree
- */
-static DECLARE_BITMAP(vt8500_ports_in_use, VT8500_MAX_PORTS);
-
 static inline void vt8500_write(struct uart_port *port, unsigned int val,
 			     unsigned int off)
 {
@@ -611,27 +603,14 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	if (np) {
-		port = of_alias_get_id(np, "serial");
-		if (port >= VT8500_MAX_PORTS)
-			port = -1;
-	} else {
-		port = -1;
-	}
-
-	if (port < 0) {
-		/* calculate the port id */
-		port = find_first_zero_bit(vt8500_ports_in_use,
-					   VT8500_MAX_PORTS);
-	}
-
-	if (port >= VT8500_MAX_PORTS)
-		return -ENODEV;
+	port = np ? of_alias_get_id(np, "serial") : -ENODEV;
+	if (port < 0 || port >= vt8500_uart_driver.nr) {
+		for (port = 0; port < vt8500_uart_driver.nr; port++)
+			if (!vt8500_uart_driver.state[port].uart_port)
+				break;
 
-	/* reserve the port id */
-	if (test_and_set_bit(port, vt8500_ports_in_use)) {
-		/* port already in use - shouldn't really happen */
-		return -EBUSY;
+		if (port == vt8500_uart_driver.nr)
+			return -ENODEV;
 	}
 
 	vt8500_port = devm_kzalloc_obj(&pdev->dev, struct vt8500_port);

-- 
2.56.0

