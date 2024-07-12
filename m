Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033F172791
	for <linux-serial@vger.kernel.org>; Fri, 12 Jul 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795882; cv=none; b=HjKzaSB9m/Z+cUyyL9bS9B/mdnrx/4azu0BEbVZlsCzVHMTZtquA9UffUNnyB9ap5peRLE09GD5BzFh/ITA6XQwOB/BxwZc5a4MiZyVUcW1hgj5zkDYxTkEN8bSB/I2c8/3yXhUYbUkU/1P6GAKfyx/8qRPUUAX8MZNUHjHURgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795882; c=relaxed/simple;
	bh=3B+bA/gVxf10QMJ/1auXkxH6EyxsVK0514t6LhufUHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r25GC/xtsc8AsUvMzz8+Rr8zgMhfObqOLceGh7R8gPO17vLfigLVpicxrk7K9HVZzgTkyXXEMBjVnRVskWtjlc39OBPTLEGc6hAn2fAFcNeuODcrA10PTIzrqHbrAareN16f8JGNM2o51bJ4nPIuFcwDniXzWFoPXWzWMqrXNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ftIL/2/j; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftIL/2/j"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so5627041a12.0
        for <linux-serial@vger.kernel.org>; Fri, 12 Jul 2024 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720795879; x=1721400679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+NL4PjPlsV5Aezh+PbdIHqVYv1xGaptU+I8RFe1E6M=;
        b=ftIL/2/jHHOXS83aV5XnpsKlHIu3oqQDVVvbGY2qStoN9b7P+4RKMo2txgtm9GYXSO
         1am2CL4SBA59Ao9C/TQ7BaaF1Rpz2QQm1LamX0Aiw/Ym5Ntdh/2VEb7eUMCSCe+BF8J7
         MUBF60elOuVY29vXQh/0FXe0S6R+PJw9CwJsgzCbaQ58sgIqAZPDP4oiyTFkqeAVTa6i
         8tO/RgObe1vL7dU5esW0CMm/BBQIMQCUQXsCUsSMmUfnVa34HEopLu88ynz3XiLc5OCu
         wLY9ZAE4CT+XFSHd9mHOZ+S0rWKaQuSLcpGyt2RkaCdZHdv4oImHxoTYowS9jXTiqAtk
         7x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795879; x=1721400679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+NL4PjPlsV5Aezh+PbdIHqVYv1xGaptU+I8RFe1E6M=;
        b=NZtutS/YJLcQ6qKGzRJQqOplUS2DA/ODBEOjvdeYJPSADKZSvg0xE25MQVOuyloEWw
         59tqNdpRUw5O/xVjyPuInIkxeF07gxUFBIpwL2MEyRiIlRDYIz0ihlj4ux6zzOfTYC0I
         9yh3pr+vDKvOewSSqlfv3K0ehbXpL5viwrrFBmc5mA3v5y5sUIzyn0Yo2n6hKq56qoO1
         AQvibcP8WNRzg23bqrrtU4Q6Tv/8qZJVrPoDbT0MpRTL+qL8042kuGPn9FcYwIPqeUvk
         q+Ie+HmKd74vJNihWTqdhb55Jd1Joj7uvukaMV1YM0VIhRL0bLhUn+4OdM6JCsDBhZ7q
         dogw==
X-Forwarded-Encrypted: i=1; AJvYcCXSQrWhZpraF3sSyP6rFLHIcJlIpCqVUIrforbmt1puKOiKFxUtVJFiJoOca9wH9rBXQ95L0a5aKzC17gljIapGDUIJbzXkdiygFDwa
X-Gm-Message-State: AOJu0YyLYMOGIAatypJ2V1P5/pOoKQeFZKC4lTQKT3G2vA2553yHDxS9
	jnuSr2u0/nrGED5/rVPKOhmt4uk3sQe2ovc5JJ+bmO6Oqt6Z723jT9ZgTB/c6bw=
X-Google-Smtp-Source: AGHT+IEWh0eo40136UlPMO1KRG9lFC2+P8kNpSziH/HRtDbgli04Dg1wOiVe7M+EJjGD2P/C9zRVvQ==
X-Received: by 2002:a17:907:9490:b0:a6f:996f:23ea with SMTP id a640c23a62f3a-a799d339b09mr217420666b.15.1720795878808;
        Fri, 12 Jul 2024 07:51:18 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff213sm351406266b.107.2024.07.12.07.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:51:18 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 12 Jul 2024 15:51:18 +0100
Subject: [PATCH v4 2/2] dt-bindings: serial: samsung: fix maxItems for
 gs101
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240712-gs101-uart-binding-v4-2-24e9f8d4bdcb@linaro.org>
References: <20240712-gs101-uart-binding-v4-0-24e9f8d4bdcb@linaro.org>
In-Reply-To: <20240712-gs101-uart-binding-v4-0-24e9f8d4bdcb@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

While gs101 needs exactly two clocks for the UART, the schema doesn't
currently limit the maximum number to this and instead the default of
five from this schema is applied.

Update the schema accordingly.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v4:
* drop description from clocks:, it was Linux-specific and a we'll
  implement something that makes it obsolete anyway
* no need to duplicate clock-names anymore
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index cfa1c0de946f..37ffa953b064 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -167,6 +167,12 @@ allOf:
       properties:
         reg-io-width: false
 
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
 unevaluatedProperties: false
 
 examples:

-- 
2.45.2.993.g49e7a77208-goog

