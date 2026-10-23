Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790373;
	b=tZ/EWQnhGsGgZh/69MCQ4zItpeZCNbOyqqX7KuJPdxwiq5lyY2NUzyIi4YdWrTqk4s9v
	 w7+Eb1hOLW/h1W9xVQlZ8rWAuhpuc/164mvo7kxPgCx562WIOpR3mdFoHHzpNZKkUnWo5
	 vEJzu2GfI3RwLeqwMUkU4bECfVZ6aAKy2GCX+Jan0lxReuhkjTatadq/MVdK7HjTlpBRs
	 t9EKBQ/YOkgtZrGVZGaPfV35WBlzpvUqkhYTyulG+hbMGcK98UOrw12dgwmEWBu1d4Xmz
	 j6Un4u04FQfiX938zEGw6IFB0Dz8RrHbmxClev+etutJxrzqbX4vi+WrtZOfL4xjPzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=me6u6Bbs0ItISJiR06k4tVQKPfQkaZ0ZoYAv0UWBdnk=;
	b=kfvHQedqikCO0vp5y4/Pvxob8C0gPjIXVRen717IrwC1VobswT+JpYWb3pLEPiXFxbvw
	 Qt4p32v71suh1EnCRnwdwMSRX7BT43DopnCCmfCRd9Zrwd2juwKTJVbttShVuEoW+ybgn
	 dysULo46+R7ZWmxwQajXrbUb0/6YeQ5Qa+ZILLrMF4dKUOjPRiE1FWfNa0rQ2gZkZdAsq
	 f771/YEUrWwYZeho10uFNIhYgjgr+wf26LfJo7KGuxWYco0nxo8dGcMrJ5AyGCcnWzYEQ
	 ROWsZdJm+8fPLomzz5EGXFtsv/kOgRMWDYrfZrKhBg6brWY4M8u5SD5t8sFf4cuDSbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JfKrrTH0;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67C606A32D
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 21:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F67C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JfKrrTH0
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-81ba09a5d23so1375825a34.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790372; x=1793395172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=me6u6Bbs0ItISJiR06k4tVQKPfQkaZ0ZoYAv0UWBdnk=;
        b=JfKrrTH0n5VQuIi/rhoK5UA64PDmOuJ1t4AR1OqcbZgn82yEjF2i53eXW5O2dbwj3O
         AVDI6Vah41EXndWY4AaJt+oolwlQsxyNoMQ+znMO4xL5Kx9JTldEnlJPzGNlQTAZgdjI
         /lURYPjs6TQ5h7BPNYECPsbZFs8U6uL8opBLchJqnXZ8cEVE/9pA2cD4ppTc8eeY4pJP
         mNKeY4OPIfnWwQgf51PCkhWof+t3WOSoPUC/uJWJPuIvXfevEKTQ3frkxKUPLYLTq1sL
         mMvKQEDFruV/nDBDL+fbkFs6KPZ7s9FJGs3/92vc6GvgjNbzP6CYKdd0J+CM6YGixexP
         yeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790372; x=1793395172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=me6u6Bbs0ItISJiR06k4tVQKPfQkaZ0ZoYAv0UWBdnk=;
        b=dhmpRAxg7gO+qQF/9zOFUHuX+k45WYJOoqSHC2nW2IDB37GN3Yx+qzl2EhH8Vpq5rM
         jBr4wBEIFHcQISotSO7CWPm3EdZew1H/B4IKpixliRw8x+SjRYrZ2rSa+aHuXVfBnLED
         wBoBu+pkTww08stWjcE8DeoCD3YGRy+TpfElz4NTeK8S3rl6cy6fDUTi00bU7vPlL/j8
         EQw7z5KbMtmUlYVWUZ6nglnGhHTJsIb4j9OQg8kGtnG5Ws5FzwChT6gosD3FcxH6DWJ7
         UoX6GlThf6z84lgOxs6NqDgh2VbTNQyZ4Yh5wlN3UkmT/+HB1+IiiZ6jQFQdKvfA7nki
         5GUw==
X-Forwarded-Encrypted: i=1; AKwUvBwA+zIcuc2EwOpbQjUz3YFufCH2z12co0IwZspUiD9bRcOEEk7xZfNRr6BUfNt/H/Vg7MlAeKCT6wgk6qY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXJVvUNleA5nbuvFS2+ZpYIUt3zSWSTAUPPfaRuBFbSkACkuXW
	ju+BKe6NAf+/6kgsfXe788QznfcGGsNlj+dtwCB6t+ovG8Tr9FVwZ/Cy
X-Gm-Gg: AYBFou2NkvZzj/qR/4QcBNndmLUQJRGEO6Ehu07S4nwy5UOk4P8XyNUZWy4ZF7wuKPp
	F5fDkBkBTt38N1KGxeW0iy+XDEqFNnEbQT2z5fGPiRKQOh3A4JmLCZtdykQbzjENAGSuyRKV2pH
	gJMCQydu0HVWHQuk/thm673KVYQX6VaK1lKxjkmnJyMnFAVn65tzrK4v8p71SRVAwuRIo3ZwQvM
	tormD4/FRFV23qmG5PBX20bOGSwAxZhF2g8C8MHxjF+0x0onLzqqJCEF2gL/RXqcjHGCDTU0tGc
	8y84ymwpn8wyRZ0aTsu/KSxM4DZVDLNaXB4th5N0CU+Kej8+R9YfV/aXs+VDaZcfzOFpmOgTKGc
	f9Spvax7ObKgSpFHePXLnmd8s8rmIF6e4+xaIBPa9cjSzm3cW0TJzU2n7ozAHmpV0Vg08uwKy9D
	1E3owgkdd/BiuQvmGuV3+40w0VaSBoLz04lRYLkRXIKhTHZkWAqyLKsin5dpOPwGGlU2jE7ACiK
	xOYvREZoUg5x6KmFXCG38C1VoHUearKxx/iUtx4Yn4IAWkkFMk+ybVIkuwHeRnezf2jLLhdvyS+
	ISZqfeJ2HN1YY7LTKLVpJLkUwZAXwHPoNNTlcMGA0fJzVo1jJ6NvO1P5SnK52tsZ2u2KJDeHcNr
	pDajqvubzwFw0Y3YY/+zzYe4nkmZAMic3SZD69JwenBD4c9IcJUw9CsqCfHgqZ9fdRrCOBJUy1x
	J8JQ==
X-Received: by 2002:a05:6830:640e:b0:81b:ac5b:ea17 with SMTP id 46e09a7af769-850fedbbf50mr560464a34.16.1792790372497;
        Fri, 23 Oct 2026 14:19:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d8esm565721a34.1.2026.10.23.14.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:19:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 15:19:27 -0600
Subject: [PATCH v2 1/3] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
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
Message-Id: <20261023-submit-h616-uart-fifo-v1-v2-1-af0593504635@gmail.com>
References: <20261023-submit-h616-uart-fifo-v1-v2-0-af0593504635@gmail.com>
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v2-0-af0593504635@gmail.com>
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

The Allwinner H616 UART has 256-byte FIFOs but does not implement the
DesignWare component parameter register used to discover their size.

Add a compatible to identify this integration and its fixed FIFO
configuration. Retain snps,dw-apb-uart as a fallback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index e2ca126d58ba..fc1289073241 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -60,6 +60,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - allwinner,sun50i-h616-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

