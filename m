Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142348;
	b=nJ3dg+sc7ObWXveoVnE3Ll4sfcppQGagcO4Feuqj2p00HMfMNObO9dwgTDfqT38vVVYa
	 QknPd7qGkafI6V9KzZ2d+xKDWnRHi9xZ+dOft8rZDyvbc1pq0CHU2D2g+MaULZWoz16Vd
	 Vc/V3AZx3ULK5SgADd8+x0sFAs3rFQdgpr+J4wlYs6lBHk3vDUvcM7BNep3912rehJNR6
	 hMyJHun28hxmXi2CDPsT6cgWz0t3rmt74t6owlPvFIdP/r5Lat6/n+uwOt+WTVMlisJtY
	 N3U/Lr2TiiVUeX5vSBsTTpflJ6LcOjwaZkcj4Pp8CD7foF8oCmIey6ZSWyY0THfP2UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AhsVd9Fsi+UcY/XjunpIc7bQ1eO+aEtcrlfgyGAcjFk=;
	b=xSYekZ6v5zv6uXz8lMl7eNBnDSAPRLpU0Azwq2GJt9Ft+7ZAIrDLk4RUlVaZkeLomT7Z
	 Q554tJ1PPZyz5X/CpxtS88YoTwNIwRS6rnP+++9Mt36Zg7/Q7kUPqJJwnmullk+dLdchz
	 h/0XD0ovRMbLlaWYeTO8mmIMPxDs2sZ6IdiMnYkVKSzyxCOk9a38gxRV7tXb5W4DuXHsX
	 tpG63RriJuv3Hl0G5ZFOdMt569upxCzC7+Rs/u6PSotNLuUSSM56z+O3KycZc/K4/Auq4
	 uVm/BKDbEWNAKh0c8k+xczvs/QrCJQEUbTHmKROYcONYCPX7MD7enw1+j4w2yXpAo4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oy8Ns+OC;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C07606A325
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C07606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oy8Ns+OC
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-70059e4dab6so297539eaf.3
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793142347; x=1793747147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhsVd9Fsi+UcY/XjunpIc7bQ1eO+aEtcrlfgyGAcjFk=;
        b=Oy8Ns+OCuC8ms5bppmSME9oA5Rj8eAcfHuQdFl+6a68Uh/Yh4JezhkNOUtwi2fYGS0
         LQ4bfKrOfnWNOVfHrDj2JaL8Q1f9TRiCjKqOO3a+CGjr7AG8HXv/iRti4XirkbkOxAJd
         iKd9uTPNgd8ICiFtbWFFdOzMlbYlPfoN75I9YOMXl5jPLt84T+0uj1oA4sPIHYUYAkPO
         PKsdlY2vdCf5evctBKpLJaBChE7jzkDhv9Y8gRcDtFo7XRlu8niEL3QqbprUdCBoJUNf
         LvchEAOGktphaYcq9HiQYAvucYhV5bES3OfQWOQ5Ptbf1udgIalmmHqRPLFJw0rf11Gu
         AFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142347; x=1793747147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhsVd9Fsi+UcY/XjunpIc7bQ1eO+aEtcrlfgyGAcjFk=;
        b=x6GVOtHXMRyY8SrJn66PmWlbIDfOwOloKaoW70EmhZwbPxkxWWd61VeaCl/MYqOOYf
         BJ9P9UVPnXyNjsmXCcwtfJUR0AW/iORqoYEbrRplHSCxv1dVTJRpHCMiJDrzoFMfhXq7
         MQn5N2XsE0XinvrUhlEfah7GuWbt+EMtEUzRE5mcbMTBU22twX+HQKftrZldKYRKVY16
         WJ6fnbZ88IOuUhXGDli00QYbpvN3PXbnER7h7Dt5MuEREKp7UbIA6CWVWZwQysbxSqsP
         3r20whVzugksyBTv1TO/5BmN6YRq2VuaTAYaL4swHE8WVoVClyXId1eLxomVt+4mq54v
         5Y4w==
X-Forwarded-Encrypted: i=1; AKwUvBwjoHk7zk+SkUV0IXlh09vyNucxJVFuNOgKWOshqaT+4rDp3nQsHDVUaVINzAhYbjuyulvK8Gt1SPrTeyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYImbRmwDIhLMUXryEeP8uJ/ucufCdf/46QvPd4tgmGltEfiWtEy
	lgrEHHqSXrqVotCHw8EPwC4CFYwSpyHlpoFCOWT+L5mbP33TPETB581e
X-Gm-Gg: AYBFou3uVSIXHDVob3gFfjOtJyF77iE20Z9dLvyGWLE5HUPzod59XmvEGcqxnnTPXhK
	KvJnX+Nko0lW1zSQtShDdWFVLYmSHz98lQ4XY5lnzmD0l6TycUDJo812HrtoVd9oBYv+20sAQ3t
	pN1cxI2v+eUdZ1dhEVG9GD27Eay7ytttmH1GzBw56hxuHcZv2kJco8RYVzhvQyu4fwD59P0yhrH
	4sglbQ17QOsceIlAnCwGVJVYfYpFqYFrKT5MURlfmksV+YoUg9vQ4Pkh3CA7v0B0JlLweZkGwUV
	deiCi/S42ARJmitmjPizGsPCb2gEloI2dQDcTuqoAxOnfwKPeQqUGgPxCtKO9dy+kKIJ8if33XY
	HVVkxQSLj1Kb2JX9DsgvVFfKSLABUsSJmyHm5tB6LIVR64IYWlFQpOTHA7OM/1tdsT2PLm7VH+m
	n6itxLmotqRiZqM/jQrWQYP4XfhUleyrpok16T5dSjbgEfEPva1O45t38S9UxxQoJbZuJ96p1TL
	AUtVJQY4zZKNdrv0w3LxLAir/cf9hbBqouJ5QoPEmiEbBl4yRf8uS6iWxd45nUtF5OTLXX9aHma
	LAXJHqnGn6jHe4lAHVAgkltOad6miD29ckcNl5DnBNwDCS8+UXdtn/crEkj2dg5kLsuS490u5LC
	eRU/bKKLmLVIqOz/jBmFb10Pyhf/0Aj7SadC1FwB4M/JcQo6n3OQvV8Ice/SwOgfk5UBy+uLZ8C
	WFpQ==
X-Received: by 2002:a05:6820:3385:20b0:713:da3b:901d with SMTP id 006d021491bc7-713f21629bfmr243308eaf.79.1793142346826;
        Tue, 27 Oct 2026 16:05:46 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0741c9sm12093328a34.10.2026.10.27.16.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:05:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 17:05:30 -0600
Subject: [PATCH v4 2/5] serial: 8250: share the RX trigger conversion
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-submit-h616-uart-fifo-v1-v4-2-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Extract the receive-trigger threshold search into serial8250_bytes_to_fcr()
so drivers with per-port threshold tables can use the same conversion as
the generic 8250 implementation.

Include the unsupported-table check in the helper and preserve the existing
nearest-lower selection and highest-encoding fallback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      | 16 ++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 12 +-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..195ed58a2231 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/errno.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/dmaengine.h>
@@ -73,6 +74,21 @@ struct serial8250_config {
 	unsigned int	flags;
 };
 
+static inline int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes,
+					  unsigned char bytes)
+{
+	if (!rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
+		return -EOPNOTSUPP;
+
+	for (unsigned int i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
+		if (bytes < rxtrig_bytes[i])
+			/* Use the nearest lower value */
+			return (i - 1) << UART_FCR_R_TRIG_SHIFT;
+	}
+
+	return UART_FCR_R_TRIG_11;
+}
+
 enum uart_port_type {
 	/* Internal 8250 only */
 	UART_PORT_AIROHA		= 124,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..c332963dc2ed 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3018,18 +3018,8 @@ static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
 static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
-	int i;
 
-	if (!conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
-		return -EOPNOTSUPP;
-
-	for (i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
-		if (bytes < conf_type->rxtrig_bytes[i])
-			/* Use the nearest lower value */
-			return (--i) << UART_FCR_R_TRIG_SHIFT;
-	}
-
-	return UART_FCR_R_TRIG_11;
+	return serial8250_bytes_to_fcr(conf_type->rxtrig_bytes, bytes);
 }
 
 static int do_get_rxtrig(struct tty_port *port)

-- 
2.53.0

