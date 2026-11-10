Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280398;
	b=YVvV2h/DRP2YswTopTC8cN8cb+D6uS+yO4ctuHbPGhh5LN7NkvMquw6kudebtNwzJfvB
	 wytWRRq7IAbKLM6NOPmKjhCD6FFGJ7P8Xp0V2xR+UOBMFJDEnxSgmEawEzUkAc2y/Atuj
	 AgSLwDeSD6RbSc71TixjH/DrVRoK21KNt9g5vv7N8tta4Gy34J0ZQ8H8unB2gtN/pSa22
	 xUFAjvK9psF7C1NnXwCPrmNBQmgdbBByicCrehn5p5MJ2ebtXUifyPdwoTsLCWvy75+jJ
	 BGhMpSKTvoILXdD73aGkU/T4wUdHhp3iNo3FLNAnEy6fCprihRF6kMiQwNOVPK0Gwzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
	b=xAT09/Qy1IvY0okpbvkB90wv5D/XCTFdjaRDrJmTTuAvXCSy56bukaZXcYzCazZpfq39
	 buc9TVKF5m+sX1RiPhxffg5YD817+WY8F++WlYKKPbFCkhaV95DqJOI/ScUQeLS4JYxPB
	 A4u7R27ijo8P8d4+peksRmP6MuA76FnveNk/SVrnibtXDzLR3t6sE++2M6KG1kOf3Io1O
	 Yoh4kYeVjVCQkQuu6Xv/vBfhARjRaP+r6JHheoKFcU8hA8KYpszmoBII/eqT8cQ+dn9/q
	 UNN6/fln0gRYj0/gO/l4wiSCAn9JiaLA7yDa8o/P30aHxvEVs8+m7kxD1YnFWRjxjYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9AqkMxM;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5960A262F
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D5960A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9AqkMxM
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-53c156ba662so797823b6e.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280397; x=1794885197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
        b=A9AqkMxMK4FPNMW90MZCORCwopA+gopgfmc15klZek3jqQcsXSA2GSwT9kWjmd24eB
         zH25ro0kMNjEWSxesGBg7DobhiU5rTmSOApVldcJNoevOvyAmqhGDXaOjT3wStNPPAQv
         aDlYE+OjKIfMD/TX8CRogMA/dw4BrOogYWwzOU8kB61EzPbLaJNsyupGgYBDklYg5qNX
         F/4Y2MvV79eEk06J2Rm34zhduSKv5Bwff1oXrJhIaJfXF1TXIP+a1d1yAY0NhniVpsdM
         os94y5U8iGreDqoVOUZ8y3+FhygJGv9zalpEXtrd9vwohQkQtGJ3YRBUVw+qAkXKixSH
         gcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280397; x=1794885197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
        b=Os6JBXgwDr1WpulUc0rRmoZOTvDWZZktOgW2dCt9I3k+k9nQC+/6D2ezkV6C6oZE0M
         RkMsnb/MBSQy8168GEu6lAhTsWRWuaXAzjaF0kJFD6b4f7CqdRL35HOlBgzYUXnd2OXd
         rJNcOzDdcq/9rxSsqJeL1mK2+6mokPZwtZlZQQOUf0y27P8qAXBlaywH9pieDqtn/w1G
         jWmn9hehloxg2/K4UTSrV5QPHnKYuFl013Jk9/83O5QteoIJckBK1EXtf88+JPRgnhfX
         30tLzjkzVNJtlKtXqscJQqsY83yWl21ZW9kngXWtTqRAowHK/lNxpvFsduyywlj2pRPK
         YxvQ==
X-Forwarded-Encrypted: i=1; AL+hErGLfXVGechpvoM4rCifws3zciRRF5QLlD8jQdjZcKMCH85bJ8tfo0H6Ow9XskLfdYsAl0894I+hgTw6eXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6MRo838u+++oSlhuMVUWQ7O1sUmTUKr6cvOf6UN/BusuV/CAd
	XUIjVhZkQZpGCMGLjw9ph9yjjcLque7+/IKywjUxBODnQ2l0WunThsrx
X-Gm-Gg: AYBFou05zfnNULbGxaDkqGd4n4u1qL8Doqta70vE+VicYgUnVAPjan1FQUs/A32oLxL
	xrJyfxrAN5MOEpW5AxLRfSkFTAb4pVwqlNXM89VKThrie/bBWy1MliE26WQjrEDXN/mnmVDTc5m
	QVXDVCie/QFmUf1GtJsBTvTJg77hPMTK6LfsXm7GnFMsvgTvRQIOCKofsxwXSbaAkT9TmUrkuRV
	72NUhIi5pazRhq/HLXa+PWbtWjirPBqIJWyiAzWpLf3WP5ekYgSNP2Zhu/MVQZaD9QxJMNOvadG
	tGEoDJi1db8Wtme8MOuGJmIRqKWTOFVkbj9kphQXekylHHc0Hk5vfbAloxdalP4AhzJwydeNu7M
	AkQVk3FnwU8cwvaUuKE5dk5X7nzpBTdgWa/Kw0MLoASPAAzw4nP/nBnDjnFgN08zfHUEgK7Appz
	Dou1B59uKcpF6Kfe1Jk5pgD/7ARC/X9Tci8t9iBptgtpwsNILXSVcSUo7NMNp4wX9M+BzzvjT/m
	mD4ucp/SZJQ3f0niOBztjAWywp9N8LuHefZEFhNl3IbcaT2TAq45kjBHwv7CkTje3M8N+2veGzL
	cV6dfE8mIiTWxIKmiVwOSCmY+Oc372uFFhrFuyjKcloUrsE63ettgiZLPwnNYQhqW/GJOCMVPNN
	Ud08pHzWQrH2leioiJ2JeN4hCgs/tWxDRrObaUodsLwVME/QlzS+VhuyMWs07xWMXnPxQO9n6Nc
	vld814Nf/+i4y9WJWvAH6JURhzRtWhLIC7bBbWXz/VJ4HhJ7uADzry
X-Received: by 2002:a05:6808:1787:b0:564:347c:5a7c with SMTP id 5614622812f47-5683cd801f3mr1322272b6e.59.1794280396724;
        Mon, 09 Nov 2026 19:13:16 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:12:53 -0700
Subject: [PATCH v9 04/11] serial: 8250: share the RX trigger conversion
 helper
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-4-3f03961dae8a@gmail.com>
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

Drivers can supply receive-trigger thresholds through the RX trigger
callbacks without adding a legacy port type to uart_config[]. Extract the
threshold search into serial8250_bytes_to_fcr() so those drivers can use
the same conversion as the generic 8250 implementation.

Keep the implementation in 8250_port.c and share it within 8250_base.
Include the unsupported-table check and preserve the existing nearest-lower
selection and highest-encoding fallback.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 939b7d4209f1..8729619160ea 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -73,6 +73,8 @@ struct serial8250_config {
 	unsigned int	flags;
 };
 
+int serial8250_bytes_to_fcr(const u16 *rxtrig_bytes, u16 bytes);
+
 enum uart_port_type {
 	/* Internal 8250 only */
 	UART_PORT_AIROHA		= 124,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 452851815ffc..73bc9e7ab703 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3015,16 +3015,15 @@ static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
 	return bytes ? bytes : -EOPNOTSUPP;
 }
 
-static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
+int serial8250_bytes_to_fcr(const u16 *rxtrig_bytes, u16 bytes)
 {
-	const struct serial8250_config *conf_type = &uart_config[up->port.type];
 	int i;
 
-	if (!conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
+	if (!rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
 		return -EOPNOTSUPP;
 
 	for (i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
-		if (bytes < conf_type->rxtrig_bytes[i])
+		if (bytes < rxtrig_bytes[i])
 			/* Use the nearest lower value */
 			return (--i) << UART_FCR_R_TRIG_SHIFT;
 	}
@@ -3032,6 +3031,13 @@ static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
 	return UART_FCR_R_TRIG_11;
 }
 
+static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
+{
+	const struct serial8250_config *conf_type = &uart_config[up->port.type];
+
+	return serial8250_bytes_to_fcr(conf_type->rxtrig_bytes, bytes);
+}
+
 static int do_get_rxtrig(struct tty_port *port)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);

-- 
2.53.0

