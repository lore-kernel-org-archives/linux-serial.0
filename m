Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911952;
	b=mjz9qloNj3Qi29o1HTUTW9hlBWFM3XMzK6Fnh+HPQZjkzmHCway5GXqw13uoM9UUSZwY
	 PA2teDSJyjjQZVih2Ac6skcvVTBg5vgOMxKZzYUIZ1NccqvBx0S0k1PhL8ExIUsS4a364
	 srsabYTebe4irUuwV5PZeJZMy2adhdF6G6//3ELag6KW5uPXIAhKtmVbjv4YpSWrU0EXB
	 tIw8khmx7BS2yUC593vsoGnHAvQKS72RDs5UjSg4aSJmzkx0nQH7fBmN2uwDAgGKr/lhB
	 onis08KEwgF4JnCFAQYNDMSDIKDozQwEM84t2xoxoyuvnlXDJLD93q+BFrlgikEDfLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
	b=1OfKcUqNZS7HLyD9k20YZ7IEBhreEV7UFmLYMbKapw63Sbbct/1NfORMzSiFtNyN9QJl
	 H0rT2kwskGpWm+fiFtDkv3fzR4r03qiPvVtU57KlcOblLGebxiyRVmAzGgQa8GQ2lJPl4
	 dZGWJU/v6YEUeTmLggaBGzJps9zK5ooQK0ej8rZFljhASTQZUP7NkX+n4VvFsVTzhMTig
	 y5A12QNfh1yoRKxSytdaueSxHLXNgFwsW5/ugycM6VGdAn2AFFKNh8GsJnjFsNHERCP/m
	 yP75I04F6SWOi4Ab37MNhcP2t/Aqf2Q0HxH1QOVtyV/SySkbkgExDrIhyEbDfBx3wLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oiI0U3KS;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EA606A331
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 20:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E95EA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oiI0U3KS
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8241a56cd70so1559415a34.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 12:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911951; x=1794516751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
        b=oiI0U3KSmCl5sRBZUwtFDePkiUrIoQmVmZ13H5QCiPiAm1OjSVuBtrsUOoyUH1NiDP
         2PDIPcsXMAbo3IUxDfzkeBPWvvtvxg2WWdUwYaUZcYHnL+sdVPpU0eeQCAM91SGw5vZa
         OXuT254k3dNSl6rVoJk0PuH4kTpkYA4TZ89sCV0cZVCCSMU3k/9vLxOAGaZtqKo0x2Rt
         c3DUorYK3VtrLLGzRDn9WADGXMDtWPCuqqhHvAZ3eYcyQdSSabbmag5XSDKaLWbvr9ja
         Waa+dfKp8Rfnexs6b9yjhsQLRgzLuKpCJIbY14v7HGPlZajDYdkGqKjXrEMjIC/2kvkP
         gnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911951; x=1794516751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
        b=JB5IwzE+zLyRibqsCi6ZrP88rNOMnZjdQOrwf1EQM8ms2AmnNE31Fy6DwNT/2fLJqg
         j+qpew4qbijHKxSFchQKoQHRoOJjpg84gYL6E1snKediRw3QOMsTPxk33edn4zymJHGh
         LSrKOFc/5AfXhmoyWwBhrKT2VJUa0qH1jtCU/rMB9zgkL3XnP57ldWve2Z6HQhD44kP6
         ve8FuPf2KuNxkbwbCo7QwJblggcCJsj4DAW3AxGBnROwHvt6APV/RetQgLFlkEY2OT7f
         uRh5HOt2WJ3w0TmeluhCCdpheg8Gx2XyYA56jwEEG4uoIrc2wI20zkfg9yXKR5FAq9fW
         Z5tg==
X-Forwarded-Encrypted: i=1; AKwUvBwFeNXiwcuswLl2cTfb+cO+UifvqH/oaH4RNR2+iIUavQM/AcRwRGzWnLxV2o6Yfpnd8MNt5qUiyeYd0ao=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TALeQMDSd1PjxJ8Fipcpu2/dZffwaeyEOl/F3jsyICyQDaAuy
	8OoLXU9Xrojlqmwvz3smvtf3abEzBxeAXcUzfQXYjwni8gIq8OrvVIeW
X-Gm-Gg: AYBFou0TeNNzRDe0CoZKyEia0DKxN3oTxPiK49IzU6NGB4y0FcBEaNue/s3HqVxhgQN
	vNIOtwIo761TDFnYU78TPxpQZXHXIiegy2iRA4rjm8EX3S7+K9WyPmUentu/NObj7VlOwv6zsm6
	/bXSaEDeQJPRPMocxFFuXD7k+J2iIFC5m17zW83/VAhdx2Xg5dRjgtUc5oC0vI9E5kDv0vSAcxu
	FzKH8O75a7ds2qiyZxEUuNt0BbBwkWPjaC/hIuGEbbjSzeztBBR8eF0DZjrGqvx33ksXwRGTDH7
	P+A67BJaNKAIAl1hqcz2GNho248XerUcOGVufh+lmpl5KnwRpbrTSjc/uO5UBAfZzOr5Ab5MOq2
	RzwNAH5oBNl4nEgNJNzFrJZR6kQ2tGbFGz8XJxA1rsuGeCh9ogeQqlzrIFQ+NeHj64/WmmYKDAM
	8eNEa4Qa93b09AGeGbu96RnlKWpZmTc8/1TU/mwfnoTpnNztCPPjJ3R7Jv47HM5jP2wumcvY/l/
	JzlOsfy2AqP0jVL9CcS5XD2Ou/NWHdLIGItHqXqVHvsuQgpH1cv/+qlBmJou0K1MOiundgwyMJi
	O/bZBS8FxVbeYztCyhmBIanFPQ6X+b3hS5cKkOKVm9Nu6LthRVR9rttUJ+Wj7mElJqOeSm9kaXE
	etDonZws2XZUgbOjDoQ3TiMHAiUClya8/ke/haqBRl+x6voFkfXhoIri66JAlizgpB6DV+kr45j
	xHsbCMfnlDxoyHdmJ+tTjTQmzlwHKUEGqZ+gnYaoJPu5keF+hOOXs=
X-Received: by 2002:a05:6830:4c03:b0:81d:54f9:d6a3 with SMTP id 46e09a7af769-85f1ce073bfmr525242a34.4.1793911950589;
        Thu, 05 Nov 2026 12:52:30 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb298fsm292276a34.6.2026.11.05.12.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:52:29 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 13:52:10 -0700
Subject: [PATCH v8 09/11] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
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
Message-Id: <20261105-submit-h616-uart-fifo-v1-v8-9-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
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
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The A523 UART integration has different FIFO depths across its controllers
and reports each controller's depth in the FIFO Clock Control register.
The receive thresholds follow the standard DesignWare FIFO-relative
mapping, while the optional-register layout differs from the generic
DesignWare integration.

Add a compatible for this integration, also used by A527 and T527, with
snps,dw-apb-uart as a fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index fc1289073241..ea6ce99178e3 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -61,6 +61,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun50i-h616-uart
+              - allwinner,sun55i-a523-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

