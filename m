Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4841862BF
	for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109190; cv=none; b=NYTtq0tcBkx1Pyj9YCrjmzIjBIomuC/Hi4KyNootTyhPbInKc0AuhHJ3K6rqtfQWMpIZc/0VbYoAZRsIsQYWZ4N/4xg2eggXaLV36dooGPc0urZwb/YraaRNNObpNm0RB53OWhKMzI3hWPyc5s4I4O9jHwg5Z/T3myJd554kg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109190; c=relaxed/simple;
	bh=cQNJ3XMzHwi5FaJGdzzeq5t/gSbidgfxwp2JxpD4I2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxC+iT6qVk1mCmb1O3TJ9TtuSaMQEartCZ17TJP08IHy3KzpnhvZfe4zy1z2Xpq7CMghDB9ZslluyXhTXQueOadZmdaKZpVIslbDc2QDgZ2KALIateUXKxeHWs60ZAWcmgSUdVgzRV9+oBIhn5mtKjQEaR7rIC9BmfcnBNfEH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iFIMusMJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iFIMusMJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4a0050b9aso3378915ad.2
        for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717109188; x=1717713988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGiOTL7ihlI5Yhs010iFkTmajDvoSp2W9SJUSNub5/M=;
        b=iFIMusMJDubVZ/kcABU8xhG0Ad/x5rACFtKQ+tQNrW/26dZpeEaREYmht8dyfH9lqB
         0KNmgDAB37VbA3//YyU6RRbR65eLMbpg8JUhIiDNlCstF4u6OZzbQbgpZBEI1PBhFOFH
         EzDgx4PAFmxHB7W98te9SXmXLB3sgX2hz+aLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717109188; x=1717713988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGiOTL7ihlI5Yhs010iFkTmajDvoSp2W9SJUSNub5/M=;
        b=OGiAWue8Hoiir+x+yyN3sET8F4Jujm1I15ZabebxZjwtWV6cFTrEPOGoKGPNe9PMHS
         AONrjejjFGVU7cditGwL9jHGaL9BS044SZbJBQRxMQHscJTexH1Cf26A9B1Vq2yuUpf+
         Uib+kaUBtxqiRolLeOPdcNz8RJkK3zhErVYbQJPE9Tfn5nn1vPzIfzgY+T6CsI0x1nNh
         xr2SrczMh9ojnHN40xnSrXmS7/jV739SApEUGGgqBtQEvv/KNMTYHz5PtfrQs7/l8dR8
         JogQZYNBO4CLUBiDG9YHt8QRN+Jgo8ZLLIJLh30Kak+gAqhcXHFewbwDjUsaNIDOdvxg
         MhoA==
X-Forwarded-Encrypted: i=1; AJvYcCWuvZy5yyZUzOggNRJn69Mz8HHYBfy1jSoVHUjK72dlxRfaftivacGfyFAxIlxL+kWisOqpEi0S0qUFBOEcFLA537I5blJDFqrvQrwg
X-Gm-Message-State: AOJu0YzdqhqfHPsb7pT9kTuvhtlfG2tCF62gPG2dwcVk9WBiNoHaisUb
	3iPOw6JA280t91QYknosCZzl7uxhYDXO7KeYvfO8mLwdh8jTdNDa0RyL5t0Vew==
X-Google-Smtp-Source: AGHT+IGuNQy9vE7scNu6gP4OcjlhzBXrYXmV0BA270Yt9wNFVO3IPAIRHxMOBYrMyEWGHmskZxQBhg==
X-Received: by 2002:a17:903:32c2:b0:1f3:b55:e247 with SMTP id d9443c01a7336-1f6370a783bmr1589435ad.55.1717109188230;
        Thu, 30 May 2024 15:46:28 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:564b:72b6:4827:cf6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632410b20sm2955795ad.273.2024.05.30.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:46:27 -0700 (PDT)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v2 4/7] serial: qcom-geni: Introduce qcom_geni_serial_poll_bitfield()
Date: Thu, 30 May 2024 15:45:56 -0700
Message-ID: <20240530154553.v2.4.Ic6411eab8d9d37acc451705f583fb535cd6dadb2@changeid>
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

With a small modification the qcom_geni_serial_poll_bit() function
could be used to poll more than just a single bit. Let's generalize
it. We'll make the qcom_geni_serial_poll_bit() into just a wrapper of
the general function.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
The new function isn't used yet (except by the wrapper) but will be
used in a future change.

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 71258eefa654..539a6ac85511 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -265,8 +265,8 @@ static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
 	return readl(uport->membase + SE_GENI_STATUS) & S_GENI_CMD_ACTIVE;
 }
 
-static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
-				      unsigned int offset, u32 field, bool set)
+static bool qcom_geni_serial_poll_bitfield(struct uart_port *uport,
+					   unsigned int offset, u32 field, u32 val)
 {
 	u32 reg;
 	struct qcom_geni_serial_port *port;
@@ -321,7 +321,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {
 		reg = readl(uport->membase + offset);
-		if ((bool)(reg & field) == set)
+		if ((reg & field) == val)
 			return true;
 		udelay(10);
 		timeout_us -= 10;
@@ -329,6 +329,12 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	return false;
 }
 
+static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
+				      unsigned int offset, u32 field, bool set)
+{
+	return qcom_geni_serial_poll_bitfield(uport, offset, field, set ? field : 0);
+}
+
 static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 {
 	u32 m_cmd;
-- 
2.45.1.288.g0e0cd299f1-goog

