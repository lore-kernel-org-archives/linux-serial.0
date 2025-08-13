Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CE29B8D3
	for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107278; cv=none; b=c3nKp3YzlWOIth1HXdCpWNLuCboR+Rw1xLX4dtMb/LY7wStxTr9Qq7kixfE9E17L/zOnrxIvZ+mqk3wKhNtoQdUitKM2mAILE5M+A6p1HlYaIkMe83Z0ydFFwfBzbLwzNCr6uGTWEA+RvqnqyfypB303ozu8VEMnSPN0gJyW4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107278; c=relaxed/simple;
	bh=QybKy29Ct2YiEDYuui7hJlz/0jLfGcDQxytYrS02m+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1baasKWdHc2PBYjZ7Hz1o0jA0t3HDdpxeosAHI+jwG5Xvftf+3ijBVD0GVAVd7ndrprJTp2oX+qmMVCySHv00WDcFnfNR5UViJ6SIjmwPPh/oYBJyRMA5usp1Dej4HDk4ULLpUzRFlXRYTfzQ6hrQ2MjxL2wroPxw20h3zFapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=YbS57CMR; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="YbS57CMR"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e8706491ecso8030085a.2
        for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107276; x=1755712076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aikCCzA4JV8uW58QUohJldBg0J+53SfENsyjedVm5m4=;
        b=YbS57CMR18b+LaQ/349rUeuLORIqWyYCBiNaUxmyPAe2kJmv74oEyzD7eUQ8gcpGlU
         nkKDAxdLMCURsZ2G10y4R2bSRHGUv1u+7j2x3bmKx13scTNjmEk9aH2KP8EL/UVOsPrF
         OMhUqGSpbctUVkMvHULzpLvLNnZZxw5KlSQTFga1y7V8d47iI+ZwjR2YoLqds5HBpv7/
         KH+9ggyq8YKwZn0yz8cH4yfSYw5KCLpQCiNdHkfnYVvxswBoXGKXkFDC3vb7/R1h6wct
         7nQJAi0Ll6O4pcBmcYv4oJbb7hn65hq2THBB0JUABzbX2XZ6bq0SsxoGGYsKJ2x6pTxe
         PKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107276; x=1755712076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aikCCzA4JV8uW58QUohJldBg0J+53SfENsyjedVm5m4=;
        b=f6HsYLqFogpRd5arBxss5prW/Qk9kziLniaZQHZ+oAm/YENkR2qmx4jqmgSaJDvx7H
         //mKtA+fJD/BJfhHnT3ErThkCE2KVDGGXu7f1mEMRB1vZBRVjHonphC0j6NzOYADxTRZ
         92iLkG3dbNfYPrLBzUUQ0dDp9WMorMdL1LTTyNrxnjGV7ic8lCJ9n4FzObzvdrwOenor
         3yJfODJgpONW7V2m9JtVlpICndnyX5W9xU8hWDZ+UL1o9sSWiKEVj/S0RCawnRjpfKBQ
         62OOpboj2yL3rpBYfK5Lhv4DUxFGmgP4Z5wM2AvgZfurC++LFA/iVdLxpjEl5YzmcjVz
         WKbg==
X-Forwarded-Encrypted: i=1; AJvYcCUKkabZsaMxefrhzoqkoEe7alapkoYGkd3qjBWOjRf29EYPFbflWtEbAeesISY5BtUY56ssc9TTo4mmb7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwOVMlYiOyNBGketdQAXcYn82OLjyuBt2sGdEG+zZVa5yvWfPU
	VSo+lYeCSsrNdc533eU4dcm0Kt35aUSgyP8CL2751dFpxq4MLDdw72bppC72TkM9W20=
X-Gm-Gg: ASbGncvHIJC8Jjnx1eMdou8wSAhTrMxRTYyULdnr+jyeS9lIHfUOGdB19OdUOaRutzY
	pvtoLeDmCBhyCZ8Bh05lkQJHHv7kktVHA816jTHWjluNjR1gVVSeSx4DHH2PpSgG6yoaq/vUXLI
	N7b0ZLiXyXWCLUiE5XdnzPRGyIXwPSE0C07jJh1VxP77+q2+efKQNYorYbxZqdG4DgDS58pxqlg
	7ismounOZZVDK8kLx6NJ5IUNrNeWJMdMXRlkArO7Cs/JQ3KrJsFOoRKNE4W0VdH1bL4WiN/IBze
	kPU3m6taVcfi/w8n0Og5zRjc0AThe91VC9g/x+HC+umbzZLPZO70rvXqj3vHVsnwJV5CEwWljHE
	cgmqAyp3exstNukedhF9D2YXXdSKpFL50BEz33m48QzqJZnJCSc/F
X-Google-Smtp-Source: AGHT+IEg3SSFyFBuMzj7VtB0BXbM4b6FpFJkYNn6QJWw/Ig9p6dazfZbmEC4UpkoJX3lIwDtCnuVhw==
X-Received: by 2002:a05:620a:201d:b0:7e8:6a84:e82e with SMTP id af79cd13be357-7e8705753c2mr21068085a.32.1755107276240;
        Wed, 13 Aug 2025 10:47:56 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:55 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 6/9] spi: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed, 13 Aug 2025 19:44:42 +0200
Message-ID: <20250813174720.540015-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813174720.540015-1-robert.marko@sartura.hr>
References: <20250813174720.540015-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel SPI, so make it selectable for ARCH_MICROCHIP to
avoid needing to update depends in future if other Microchip SoC-s use it
as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Use ARCH_MICROCHIP for depends as its now selected by both ARM and ARM64
Microchip SoC-s

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c564..320b23e92cbd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -154,7 +154,7 @@ config SPI_ASPEED_SMC
 
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	depends on OF
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
-- 
2.50.1

