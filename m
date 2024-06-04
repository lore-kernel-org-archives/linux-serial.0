Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8B14883E
	for <linux-serial@vger.kernel.org>; Tue,  4 Jun 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516911; cv=none; b=I9SOBpTk18fKqK2JryCdSPLEHUhTZBr8rHdoxDe99QJz452fnlG2rTZzUAj/Z8MGRMWZ+AMk3xw5fwx6Niit39pyzOPKCZrFbNvOmcVdLDWoPdrSfx2MNsmMxCPNhXRwA2s9rFWn90YvCMAYmzl+3vGdKFoVXngyGH45D7J6Jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516911; c=relaxed/simple;
	bh=2XiXCEZWGzGuogpB7UrNVjSqiElFtO0aCEYdeEc0X1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGNJxV3ju7SDt5vZdrpoYhKFkVyv0vO9fV4i1bRDmgSWKAF4HNZtFI2ZyXO+8MZiKqgMTRQkCkJ3rHw1wT+E0/c8Oh8XzriiynSn749AcjT6aVcvDzCHz8H426AF0km7dnC8ZJsWYE7IBQWNgztbUAxF7bwHAz/OMgHJn555PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KNDNcKUT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KNDNcKUT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f62fae8c3cso42443915ad.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516909; x=1718121709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+b1f17eVJb80Zj1W53g2Cg6ZxrWFmpqnvW69q4l7Uo=;
        b=KNDNcKUT0lvSNVCsy6BrWeidvN+LQJ3AGkk3v27IMzZ9UCqL4Fu8sI/OvXgGPHdK+1
         ba5dyIL/nKVn6ARWYX34RvAHpKcWSEDIomcncWepEvZPOycejY21cXB9cyoiRtfxCgEP
         c3dlHNObLyCz5XHEL8tW5VLqhZdmV6wfKAKR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516909; x=1718121709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+b1f17eVJb80Zj1W53g2Cg6ZxrWFmpqnvW69q4l7Uo=;
        b=axksaRBQbxo91tKjNE6GfBXs65elnaqkGLllqO60O0gwd6gu4PzfSdBOsSXDKRC+2I
         JcF6ZL6sAVHBRLuOmTI3TDYw6W9dtoqZjv1iLlJDaDMCnia/7bC30ywFS18BfeiFYEuy
         KgrTMXQPLotNTrympxKL3sLlRrQ31MbGCJ+v5h/Lf8b1S+Biqc+TP86t7bjyzRQfh73A
         Y7EKk+JuWGHR7wNr/s/kOLz/EaLMplndizawXnkQ2UbkcE/08CadzkP6O3KSH8tlHAiK
         4ng8YNMB2ricdKLzs4ENak6tnk/ebaR12aPcQqCSBkuRyWEYqMD2v14eyQlZsIPiSkK3
         DgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq2CZXVjHeRS7QDva645gb6FaEph6FiCiyFM/MvTuyUDqHtIuU+/kpxLqurZI1OASl677ENceHRhBAlB2LfRoaxqHAu5CiMcgs653K
X-Gm-Message-State: AOJu0YzcYabMyp01L4tou15JMFbs7PFXvX4ZhOtP9vajeIuoKSMA8F1O
	K88mt9+Diw+Zy+rYQYCGygPIu5xs4GPJv+fuQsC4NZAjL/yZePNnFB8ULdmMgg==
X-Google-Smtp-Source: AGHT+IGiBs6CoEcjZoTZjvUybhOhGJoQkUpTWYueMh4xEVk/MVLaHWzkiQ429PcJ6uh2d03TU8ZR5g==
X-Received: by 2002:a17:902:e152:b0:1f4:9138:8178 with SMTP id d9443c01a7336-1f63709e30amr92494075ad.49.1717516908948;
        Tue, 04 Jun 2024 09:01:48 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:47 -0700 (PDT)
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 3/7] serial: qcom-geni: Fix arg types for qcom_geni_serial_poll_bit()
Date: Tue,  4 Jun 2024 09:00:29 -0700
Message-ID: <20240604090028.v3.3.I24a0de52dd7336908df180fa6b698e001f3aff82@changeid>
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

The "offset" passed in should be unsigned since it's always a positive
offset from our memory mapped IO.

The "field" should be u32 since we're anding it with a 32-bit value
read from the device.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a48a15c2555e..e5effc2f5878 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -265,7 +265,7 @@ static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
 }
 
 static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
-				int offset, int field, bool set)
+				      unsigned int offset, u32 field, bool set)
 {
 	u32 reg;
 	unsigned long timeout_us;
-- 
2.45.1.288.g0e0cd299f1-goog

