Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742009;
	b=bf8bzx6HaYWhxXhEqeTLZhpyeYdZuSNhX0sgiLlSp+RzRQfNK1hMBEOe8Fsxwmbk361c
	 yeFjlf3roo2JzdFaTlHU2ECb1tSMZORAk44s+GXz4m2Kwa1f9FX0OjDTW2NwD8AgfPe3I
	 3suZxnHi5/YyRfUAKq5U2BYKCVHzA83n4LkV7cFfEyeUyqj/FRCzBz9ps3UuoXgh/NCnN
	 vxylrSlh2hXbcbeDulGtTKgEd9NdJslnWICK+rBpMQAxEG5EMUaDIJ7uEWcAMp5MsQt6O
	 zN8KfMj2k94vLVPLVs11MFLqDjiLap4+QnSoy7Y0JS6WxnfUiDo68VxQ8KeaikdWbrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
	b=C9MzHECqIg1J02HVcncJ5p9hYaKoawNx5Mmd+qJu5m8odyHpOMNsQSbgIBg6UKbmQbR9
	 twnEu7VrSl7xZGC/61mItx18dvFu0uzDkyrwJxkFmleYdKsv/5InSQ5nMTQomyLlN6om1
	 5SLVspKwQaoEMqJRrga5aTce30ygdrR4V7dZenB05LpZIyrA8/451BvWbHNzd3hxlLA2M
	 AMgLbCInL+2HfgT2lMt9NTSBw+9jcBTcQUsSjiP+83Phx6cwnXMH9oD+R9/FFAB/MbzdH
	 ObjGRJLKcoPfh3uMZl1gNNDIx9Hrippgw9sOveu1w7O+44IyE84lObE9obH50+3oThQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJIx0CSX;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712B606A328
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2712B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJIx0CSX
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-5058b105df7so30622b6e.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742008; x=1794346808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
        b=XJIx0CSX0t05km3oi72zgQp84PQKqw3zLZpOV8xPVOVcJnbKbUM4u2U9SKueHHOck8
         DqB+6Coi+bdr4bQN3i/lJzdONPZZh4Jzwk7IZLd31yQb0yBc3ai0qegUldHBqFvm9ORt
         JBb0Bk5BWeC6Gwpovb1vwzDSpTqPs62FmlUPET6tqTsAolJQBO8kT4IsUn5XxqCoRLdj
         ji7n36UdsxPL6xG/sGkUMjup+f9S14T6p/eYUDGt2a/xJywa1tmQ9DsGkbIo4nUtsYqg
         oP3+NIRN6u0d7K/A5r5BDcmhNXbqVNZfd1WZFL/QpSVdO7fMxNuIOz4PCDs321FtLNlP
         UAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742008; x=1794346808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQd2y5d3c9Xle1BZoXd9DRgnl2+Av/870a5uei8ZYeo=;
        b=w7WPEMrdyXy3DJEFXa8IDCjYuTl3sZ0F693khvxlTtYSifvSnYccdPWKNds9WOR/PV
         J54nVZXgLGGIdry4tcqRXxW6CAByylGP8rx/1AgoCPQzUkuiOivA/vbvn9fNt8va9qg0
         F1Otr8z1vW1GqzTO28XEd3AIQfsK2eBIKnjNjrF5s+ttfQmRJi57ZvtqxWhD0jRv2/tb
         ZOKOSK8GVLhHjvUF+LUheZNhyWgr87djO0eDDx9ejYkjsAwpnd1uhNfzQ8Fz6FZ5cnG6
         P3CrLD3FZtiSNA5KJmXZ+kvr77l42+hb6C6PlcYqIs8LRKzXSx+zNmlbeSpEmua3W6Yd
         r/3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzZptg+rDLT6ABj/3TqqXRO1ehbEbCS3WBigI7pTDAQVOEB++2b8AJ1ZdpIkI53nEWUGvUxGjNglV8VFuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XFzJps+5eXsOhKHr+i0NZr773I6kktkjhb0xAqdXV8ZUA1Dak
	vqpMKYKCrIe/jzY/FD0Vuzkubp4oL08hWnLXm8lF+hhvlahGdoWeEgbSphD9bXEW
X-Gm-Gg: AYBFou0ei7wH+1SHFdSYOcXS7dffUKMrxWZLrTuisqZ5dtW7B0IpDfS38p9bbH9o7xu
	zSBpKPBCFOW5tOgqboCEpagsZAwj2trlZ5vPHXqIKPPTvFBPe2wqGs8AZ6Gfh+2jry0zvSjBgGL
	bkoHiqcCxkefmFIf97ZXURr6trLp8UcCmGFbAUgYARU1lGM6YYkzgqiboWxbD3o6saVC5aEfLwG
	w02VFA5K5NSiplyMAz7hQyqbanCuqHjFZcU5//qjchAgZNOMlOGvIwaXj6Lwl7riRoABHN7Ob6j
	MBFfHOeNmQcID0xw1seQx9L7GIBMbKr3gSeKrI8/LxQWgfO8XCLETZjV+28u+O6FU8NCgItuySc
	XoGeIbGw2oHKZvzUWBwNDm0sHIWEAXjxYCaSWfPDJFTupZgrwqWXMVQ/FXjP4dVdTrH8VjeLzkj
	hEMOblF3Mq70pB1/7FB6fRDmjDMPvj7VhT+S/+Hn5KAMwC0TK0NNYLZEL39Lc76iHZqEiq55liV
	4kjZHh/wvpGGYadko77lZcK9Kq/n8Jjau1Me6AniL6BxgFv5WTrwX1gDNDPPQ3fcAvmvpx9SFmJ
	mdXxMVgJHBb+A9xW3zNw05G0JlVSGvSj+RXaMik6bpBe/62erlitVcQNdRyPTO2Pva2xa7KIv70
	Uonmlo6A9giQNbLzpNGfAy4XbxEOp8d6aSR35cMKeFIZ4zyA/NQUlrKk2mxeQ2956lsjdLJBFt7
	5Y18N1lgI4eK2nA7YgDsiYgXYxVjqEM6qiQMVrurD63tuApQ/2GqF6
X-Received: by 2002:a05:6808:4fce:b0:54c:7ce7:33ba with SMTP id 5614622812f47-5640dc9006emr9815263b6e.28.1793742008124;
        Tue, 03 Nov 2026 13:40:08 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:07 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:39:56 -0700
Subject: [PATCH v7 03/12] serial: 8250: share the RX trigger conversion
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-3-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
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

