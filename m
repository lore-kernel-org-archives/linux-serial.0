Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280397;
	b=ibAoOZdWBxJvJoifu2KUbkjUXI59kmqm40fxUMl5NqBG5yWTggkJ+hNWIKd5UR0UgJdW
	 3MyIbqtb/VNhGBJf02Z7i9jh4RprTV/sFlhvJgDZ+bh95Rlc46+Qbm9Dd2pALauKONvTF
	 cSbhPFygaRNvA0gU0GC8Xa9tPHeyubd8Eh1J22YM0MVwFO/oqmbE/QHjROC/oK1H8B4tl
	 i0+YjzPMytEKGTQyzLSfe21YB9cMJSkGGcyCLFK39oXJHtYrUPYZ/QVlkpLrSZplWle3p
	 U1i3+OAjR4a1p0lOBa4DmG/scga9gBTb5i8cEFQqETLFrr6rGp3joO2Sd5u5ChKVNEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
	b=JjIVo3FX8tpkBsBqBEbU81y1ZF/FcjT2G8YEtBKVXRQR1zTJNdVaD86v3iF5WO1Um2Xd
	 sJxiEYhsvZShbvgy/adZl2m8zRWlC9s3sd/ZCq3dfD8iVnouYH4P9o8N3dHtFTxHNmuAZ
	 G9IvH7n1TWDQhtILGYYhnr2wD8FHIyp1j9azqUN8coDDkQUDXCa0hhV/VKjiizDXwSbbN
	 pm35w//9TQPus7QZxSo1UPDZ7Gq0JYQ3HYYCXvyiRBzMGEVZsWZlhKbfwGc9DIq4qfNhx
	 p6b7QNOqaLVkB/KjbP0BKE/amzeWqrNsIkBQpzplLvqzyq9dTiImTXO7297mQcv3aaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TS7KB5Ro;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289660A2621
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7289660A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TS7KB5Ro
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53dbe9b8d6eso1283553b6e.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280395; x=1794885195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
        b=TS7KB5Rocmq2cqLp4Prtr0rleuF6YNd1tUgIf+aulTXpKjuB2JVHvPoWOuh6PwH8i2
         mmT/yHxIToZnG0fOK+HCYlzOkFYrhVEMOV2IUM3t1OgHjEdS0ZoFfx/MHhPY3w1CVD9L
         +i2OAG/g4wWPvDakwcyvELwmiNfoeeSmYgS3PADTYpyXi5tachAttJ0qzEXSWCKxrVUx
         htTkZZFq1cSE+2GQpoYAZeBXwf1R1cv2hsufgkz05fFSSd3shjr0tkGyGwztHML71eky
         CDa9He1vkzMLXXGo4fp8kAEeuFuUorLtv2ygxOA6hJ8FqianjI93elExZ107nKfKtRRV
         XIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280395; x=1794885195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
        b=rzPCj/DNBLEWMj1FcIkNZB43Tt9oJddBleGP1VVyBjM3JBWadv71QQ7cDNwthGjYac
         4mstnyIsCzFQQ4ec3bzHRTpS/SM607G1e5fFrIGiSTabtvhKSlFDRvhpXaQ1FoWKvAlQ
         9HDilhpfidNEwWMyT8U1ba4sf6mq5TtfniBt7QUpnGTxlyUrlVQmUKZx9+WIl5BmXeh9
         fhu/QQxBiutA+vTRWaoOSwfoxG8DdiMTwSEntfm0kL3ujuUQ4O0BdqKFSZ9H0BtEbR0T
         7bTZHh/Iu7Kjw6iLvby+Zq+frPRKrJJ4nc8OeyopEqRTQLZ7cLkeaWP5LcFUPqwRGeHp
         HmNw==
X-Forwarded-Encrypted: i=1; AL+hErEo2W+Xxmpu1gM7atmoZpeJhCIQTOSbUCe+UtwOdPUZBo6RJY1uA/fcDjoDNLeirGu4zmaqm4lS4gNb5FQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uVut/BRSoT3fqo5MaExmHB+caGxs7qTXSX3om6vyhxpwXg29G
	4EsvX2kOff6r8oglcau8/dHCYU26P8ZOaWTqH2Y/cxk/ppC63eZUFYle
X-Gm-Gg: AYBFou2iz/QfnKWE2psX4lrqt1LkFj6GPQoYHDVjinvi9M8h9FrN5VCe5idSzVVGrTE
	uD8b9tbvZMfzV1QxNxszFJR9/yxbwjTJ+ARJya8tUau27wnuhD2FIkk4O49no8Tu3+XXI9ZbClU
	rfWtcKpQlkZjtak5GiEkbnbvQoHh/pJpMLstu3aodOn4POZZvv0Eg2I+VEUXwAGC5CslXCPHpVn
	tqPm7/p70PDlJaXu9Y2eH7w/w4dKk45JWBJWPrJX8L/F0EHU/XPDoSVGy7REEZKtJu6G12560Vl
	5KSgSzmMvVcYq5fjNFVJC39QjbUAU5D2hKZw6apcY0TK1V2MOjhIAQRfSs70KvOD7IqPm61vxxf
	VN7ibDRN2uKMpGxemWkFBKULu4VHE0CxuMaxTiP4MLIyEtYFSWT7UmcNFjk/+Ng2m6nbuJB5ME8
	osTfnVRFqgFy6tEJEYRsFmLqnSTgPchTJklKLS8zNsdS23VdTwdBVx9ZwYWtVmHz5JqW8Wgaxp1
	4tF9knn4hn6bFlLQKEqQ9uZxMYM19GnOCDyOaquGS/u50IwzY6FIRAue4PXW5u8n7ar8YmVPc28
	n7uY7rhWLBBXYuwXK0X9QQPws5KAF4Bt/Tw7RBiNs2Bdl1WIp7/QA9idtO+tw95DgPS3mz9Sq8A
	BeCoJ1KSiLfGcxgbsDEWmp5Tp4iHvdYYTPrG/OOIrg4VQdMJQzCaSDzndi7JaTjK6VTTuUtqgGo
	M7p+AvtYzjuHtc09n30CzEY5HRUwYToKqhAnA5fX0yAHt4CDf4AzH2n7+KoaXoYYPm6YbIJLeEh
	w==
X-Received: by 2002:a05:6808:3089:b0:4fb:c2dd:c7a5 with SMTP id 5614622812f47-5688127ca80mr655733b6e.31.1794280395471;
        Mon, 09 Nov 2026 19:13:15 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:14 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:12:52 -0700
Subject: [PATCH v9 03/11] serial: 8250: widen RX trigger byte counts to 16
 bits
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
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-3-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

DesignWare UARTs can have 2048-byte FIFOs, with receive thresholds as
large as 2046 bytes. The byte-sized threshold tables, setter argument and
sysfs parser cannot represent these values.

Use u16 for the threshold tables and byte counts throughout the 8250
conversion and sysfs paths, including the uart_port callback interface.
Keep the FCR encoding byte-sized and preserve the existing threshold
selection. The Moxa setter continues to validate against its 128-byte
FIFO before writing the byte-sized trigger register.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h        |  2 +-
 drivers/tty/serial/8250/8250_mxpcie.c |  2 +-
 drivers/tty/serial/8250/8250_port.c   | 12 ++++++------
 include/linux/serial_core.h           |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..939b7d4209f1 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -69,7 +69,7 @@ struct serial8250_config {
 	unsigned short	fifo_size;
 	unsigned short	tx_loadsz;
 	unsigned char	fcr;
-	unsigned char	rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
+	u16		rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
 	unsigned int	flags;
 };
 
diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 4935a5d1c1a3..4f0b881b4f83 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -257,7 +257,7 @@ static int mxpcie8250_get_rxtrig(struct uart_port *port)
 	return serial_port_in(port, MOXA_PUART_RTL);
 }
 
-static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+static int mxpcie8250_set_rxtrig(struct uart_port *port, u16 bytes)
 {
 	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..452851815ffc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3008,14 +3008,14 @@ static int serial8250_request_port(struct uart_port *port)
 static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
-	unsigned char bytes;
+	u16 bytes;
 
 	bytes = conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(up->fcr)];
 
 	return bytes ? bytes : -EOPNOTSUPP;
 }
 
-static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
+static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
 	int i;
@@ -3073,7 +3073,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
 }
 
-static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
+static int do_set_rxtrig(struct tty_port *port, u16 bytes)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
@@ -3094,7 +3094,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	return 0;
 }
 
-static int do_serial8250_set_rxtrig(struct tty_port *port, unsigned char bytes)
+static int do_serial8250_set_rxtrig(struct tty_port *port, u16 bytes)
 {
 	int ret;
 
@@ -3111,13 +3111,13 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
-	unsigned char bytes;
+	u16 bytes;
 	int ret;
 
 	if (!count)
 		return -EINVAL;
 
-	ret = kstrtou8(buf, 10, &bytes);
+	ret = kstrtou16(buf, 10, &bytes);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752a..97301ef66af0 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -461,7 +461,7 @@ struct uart_port {
 					       unsigned int quot,
 					       unsigned int quot_frac);
 	int			(*get_rxtrig)(struct uart_port *port);
-	int			(*set_rxtrig)(struct uart_port *port, unsigned char bytes);
+	int			(*set_rxtrig)(struct uart_port *port, u16 bytes);
 	int			(*startup)(struct uart_port *port);
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);

-- 
2.53.0

