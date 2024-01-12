Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2218C25
	for <linux-serial@vger.kernel.org>; Fri, 12 Jan 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efRdDqm8"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbb4806f67so4850459b6e.3
        for <linux-serial@vger.kernel.org>; Fri, 12 Jan 2024 15:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705100649; x=1705705449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7qtz6QdtoP8S0o7HHWZE03iwDGuSX/EUMpLPmn8nUU=;
        b=efRdDqm8ITgMXTBV/AA0+gowby9kmqDhSlr1LU5GuNXarsSYI5sy6rCFk/zupLTH0w
         SiG5xxSgWMcDs4lEnjorhskTc0nkX9omH5gTiACB/I5cSkM2AOG7TGbXXS6BWNP0/XbR
         D8r54Oz8HAkPANifzlNG8NT3OWy2KHBYI1uvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705100649; x=1705705449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7qtz6QdtoP8S0o7HHWZE03iwDGuSX/EUMpLPmn8nUU=;
        b=goK1H9YJvDq1B3EdQTmoJBzHGfZhbbSgxlMIr6IQQJJGWvEUzNHR9a/+jrk4yyI03v
         DoNLVK1FAEVBtPr0NDLO6Ux5U7yEGZqwcDddE3Yl+huePzcpaqxI5dSv/MycTB7tajAb
         Kj0aUiaCC7YYPv41D50drHsb+iaoaqoAgfdC3FJv7BQOQ3IaFqTOhOcHFuQv9uWgkan4
         iFWSL3miTcoHyqR8JDt5y0B9dGL8Mar7o4XfCDvyrNk9pAwucGs1PYfsB6Y3/ubGW4iL
         dj8QaHqfufulGnExHxjl8XhrU7ekcSpzSrlxQU2ovh9BoFcmuiqijLoqUORm+onG8HI0
         ZFKw==
X-Gm-Message-State: AOJu0Yy9uCX8F5NULxZhZho0oVB2pB7UEdDNRx+7ZMv6yqfueba3M5PV
	il9w6hFqQJsyWS9EU5gq+Ho6Xq3YIgii
X-Google-Smtp-Source: AGHT+IEjZrhsp27LYHk0t8+/pkaBORsXAC1es0/wqI168axSz0VmgPaj73/RXKG9OcZI7hRPFyq8Kw==
X-Received: by 2002:a05:6808:221a:b0:3bc:2a41:953 with SMTP id bd26-20020a056808221a00b003bc2a410953mr2203254oib.83.1705100649177;
        Fri, 12 Jan 2024 15:04:09 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3e64:3a29:441b:e07e])
        by smtp.gmail.com with ESMTPSA id fd41-20020a056a002ea900b006d49ed3eff2sm3678612pfb.75.2024.01.12.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:04:08 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: geni-se: Add M_TX_FIFO_NOT_EMPTY bit definition
Date: Fri, 12 Jan 2024 15:03:07 -0800
Message-ID: <20240112150307.1.I7dc0993c1e758a1efedd651e7e1670deb1b430fb@changeid>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the docs I have, bit 21 of the status register is
asserted when the FIFO is _not_ empty. Add the definition.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/soc/qcom/geni-se.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 29e06905bc1f..0f038a1a0330 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -178,6 +178,7 @@ struct geni_se {
 #define M_GP_IRQ_3_EN			BIT(12)
 #define M_GP_IRQ_4_EN			BIT(13)
 #define M_GP_IRQ_5_EN			BIT(14)
+#define M_TX_FIFO_NOT_EMPTY_EN		BIT(21)
 #define M_IO_DATA_DEASSERT_EN		BIT(22)
 #define M_IO_DATA_ASSERT_EN		BIT(23)
 #define M_RX_FIFO_RD_ERR_EN		BIT(24)
-- 
2.43.0.275.g3460e3d667-goog

