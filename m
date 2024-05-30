Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBC1862A2
	for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109188; cv=none; b=pTvOYnvf6Cy92D9Vf5D2eXFDddBfR2qBC31Mies8MQWVNoRbCvFyaPDIZztX+e13ExVpmn3dp9Kp98/V+qOCJwxjfw1qNaCcDOE1jF0c3YI4DI4hNcRz9GRyzkg9Gqs/JBUG2BzUkWTsSmt2KTjT397HhZqPDAa2gLKvhk/l2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109188; c=relaxed/simple;
	bh=OHNRIjCt/AbOcKb2xouTeXmLM+pYeA2+sCM+PeZUBHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg2CxCpDbVK5AftiA60bCAREVZGlecN+dTNC69rMqJwuxfbxfCEloFf+0r78YVEptC3tajEJCYM8cPKuzE/mg5zPa/CcxAP7+O8IJaklpCbS3PFU2Svb9mjYownhhDugZ2XA8HusGuwgErUBnPBMyHm2NEBUZZ8YF8BKf86VHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kb3Lrb30; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kb3Lrb30"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f4a5344ec7so10870355ad.1
        for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717109186; x=1717713986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNGi3BaacIMJpkAV5tddhgVoLNe/JGSac2Iso/bclHo=;
        b=kb3Lrb30Bzxzp4hqWqNBdk2HVDHGurJUy1K2epaQtYVdH3NSQLgbkcZ4rUmblVRjdp
         wQChU1otXpzX/uRYQ4yYrshdLOI2d6/Il9Gkdbge3kmVAHYtqwwWNcWaR3xTUSzmnSa8
         +u7X/etJRzqyqVl1iWIJbm1ShV2NtofjvS0pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717109186; x=1717713986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNGi3BaacIMJpkAV5tddhgVoLNe/JGSac2Iso/bclHo=;
        b=cMw3q9ZvF45n86a07RGyKSGwByT2Z91LL1hB8IzhoV3sAIzgNR/uiTG8OIbfPPDc6h
         YsCO2/Zt3LcSYqncb/fE/yVkyPoCTbax1A27kpZ6sEQR9jRdDbNBJWNu4gVhHCSVKu7R
         MpGkxVByCAtaN7OYToSgH6iIzrly7gjmsk4BQDi0SL5QGNtK+8iAKg/0S3AUuk1cVgf7
         uDOWuc23qUWiMb+bmWCONnRjruqdbwkbycBz/YlrDBIQpYIKQDOydgwNYDWfwZtj/79T
         fNVinmSOjSosw25yfnjEujHXWxXXxSFyd2s2RH6cUcjJivcg+iau/Emdz0OjscvwR2eL
         0lSA==
X-Forwarded-Encrypted: i=1; AJvYcCUNP+ggPXZGE9sfHV4Z9QqmHy3ltVbz77ZCiNt3YNua53ni54LQukk3FYlW0xPz5NXXEttKj/WgJHRTOzCMLzNn9T7kCMF/LZ7NrMuH
X-Gm-Message-State: AOJu0YyazR7TS7Z4Ijsn4Q3eVZ5m8xwiiVhHnElvqcCUWs/CYsJmg03x
	StLf0whE0YV+u1kCh09Ls+BgGSvFZJ516xC+qpNNDr8g4X/4AxtvksJBcMqn/g==
X-Google-Smtp-Source: AGHT+IGPRBGVd/Uds8lu/CwCOmUT5FA6Rwai1ahagYPAZWNotAwpSu3qyKimjG2+vC0ln3VA0ZBt+w==
X-Received: by 2002:a17:902:c401:b0:1f0:8cbf:c1b5 with SMTP id d9443c01a7336-1f6359c9c78mr3578145ad.16.1717109185878;
        Thu, 30 May 2024 15:46:25 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:564b:72b6:4827:cf6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632410b20sm2955795ad.273.2024.05.30.15.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:46:24 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/7] serial: qcom-geni: Fix arg types for qcom_geni_serial_poll_bit()
Date: Thu, 30 May 2024 15:45:55 -0700
Message-ID: <20240530154553.v2.3.I24a0de52dd7336908df180fa6b698e001f3aff82@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240530224603.730042-1-dianders@chromium.org>
References: <20240530224603.730042-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "offset" passed in should be unsigned since it's always a positive
offset from our memory mapped IO.

The "field" should be u32 since we're anding it with a 32-bit value
read from the device.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 32e025705f99..71258eefa654 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -266,7 +266,7 @@ static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
 }
 
 static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
-				int offset, int field, bool set)
+				      unsigned int offset, u32 field, bool set)
 {
 	u32 reg;
 	struct qcom_geni_serial_port *port;
-- 
2.45.1.288.g0e0cd299f1-goog

