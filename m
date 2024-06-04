Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18E149000
	for <linux-serial@vger.kernel.org>; Tue,  4 Jun 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516914; cv=none; b=ZcNldf8+fvNJ3z52WFt0wVg9f8WihkabUBZvhgS+hLZz9cqRui/JiVlXDbyiZyi/30WKkguh343putVW9vZBWHzK9HkU3wMflqgvLB6dIQT0hZoxKF7+Xy5fI2YExuD2dXXAQaTpmuTwehqQTAQm36h3de4Fz10tpSt4NelV9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516914; c=relaxed/simple;
	bh=bM+CwYviE8hbC61Ao8++7cm40ioyxFsXZdRy+wbbZqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5jqGvoQHFazoSCG+iYjflPF9SwwsN0AmgvcdaHaq/6BLzsjpF4tEfG976rAMlws8DyMOPFk4CmOuUI7IvNrIu/2t+61pEuj60phJW3NcQWABisW4q88JuPs3u8GAI/uzzRHYPZ/fXjPknUzHgA2hIvSsD9z716QyCJXt3lXczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zotcbhvs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zotcbhvs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f62fae8c1aso37437165ad.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2024 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516912; x=1718121712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz1mGlcK+k8OO+Zf/s5Aw5nRh+dYCllETeWsEDeJzE8=;
        b=ZotcbhvsEHfXUHRIqQo6fCbK2+uQXYRy4Ac045qckmy6ih8EOZU1XHXBol6nE0X6xu
         zomh2Lbw3QFF8Wq2b4fBc5tEGkp/MGVlkIaNuAEaGI4uCd2iHAmBDQhVx7RL//QxySwA
         RSZSxbVdU3f3CP3q6A3Mu3ESwDyC0VhIogVs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516912; x=1718121712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz1mGlcK+k8OO+Zf/s5Aw5nRh+dYCllETeWsEDeJzE8=;
        b=cG05uqhuR5PZZWf0QXDFhfkLXlDiulmCvN66XpAy1BQ+1pFytaVF7UK191P+gBrDVe
         1vvyj0Mmmxz2eg49wtKJEdIaC0QlVsAhj3vAfcCnBGdHvVdLIaLBabIB/zt5gMR8MSpY
         juMBUX720b8lhyjYAyufXN6u+U33MTXAq4cxPCKNSiWWPKkaVNWoo66wkwwT8JHyBeJX
         wNv+Yp+PhAj+twgN5OJDE48cFFYbX6pd1aTl4/+WnFOWGqhc+U3PGgmLmayl3B08BeM5
         3ffdmsxmcalwVTUAlBB2uZZ4CoFy5zDdhdTo42CgnBucbMGXPpeuGl/E/be4ltpEQ2f8
         J+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWgmXIMVPDPZCURDU1QwRAt0AIQFcNWXQuZef8YTx3BzPmgty7mMfAXPEYGro+iz2L8Ycx4D4RPEQZ/Tr9/1yC084Rm+7r1hVIMuEqi
X-Gm-Message-State: AOJu0Yw84Fgo7rNCwOLb0aQiWTGFchxy8DpcVa8aHSWY7atOXPBTF3SA
	oG1GkcbYrBCGqUZ33rgEVrIVKxlk+cCfsH4BgSE2iLTFcyAcZlbI0octr+K75w1tK14lu4fLywY
	=
X-Google-Smtp-Source: AGHT+IFjFsK7b5jeJuRmXNUJeTh0/w0Lyx/zDUdM1spc/2b7tXWGJLUB/NlaOIxAnXtZTLPBHn40MA==
X-Received: by 2002:a17:903:2448:b0:1f6:74e6:1ec1 with SMTP id d9443c01a7336-1f674e62022mr75670415ad.68.1717516912287;
        Tue, 04 Jun 2024 09:01:52 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:51 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v3 4/7] serial: qcom-geni: Introduce qcom_geni_serial_poll_bitfield()
Date: Tue,  4 Jun 2024 09:00:30 -0700
Message-ID: <20240604090028.v3.4.Ic6411eab8d9d37acc451705f583fb535cd6dadb2@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604160123.2029413-1-dianders@chromium.org>
References: <20240604160123.2029413-1-dianders@chromium.org>
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

(no changes since v2)

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e5effc2f5878..c4c54359d32d 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -264,8 +264,8 @@ static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
 	return readl(uport->membase + SE_GENI_STATUS) & S_GENI_CMD_ACTIVE;
 }
 
-static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
-				      unsigned int offset, u32 field, bool set)
+static bool qcom_geni_serial_poll_bitfield(struct uart_port *uport,
+					   unsigned int offset, u32 field, u32 val)
 {
 	u32 reg;
 	unsigned long timeout_us;
@@ -295,7 +295,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {
 		reg = readl(uport->membase + offset);
-		if ((bool)(reg & field) == set)
+		if ((reg & field) == val)
 			return true;
 		udelay(10);
 		timeout_us -= 10;
@@ -303,6 +303,12 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
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

