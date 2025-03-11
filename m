Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B81EB198;
	Tue, 11 Mar 2025 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663911; cv=none; b=CI/0CHuo6OlLFzojRW973o9UycetULPsOfKBJU5G8pOndNSNH/LTz7FfVe35qslmH31cGfC3sWlZIIH7rAV4zyI755HgCB/KXtQ5kJ44zjQPI+LU2pEeuOt8/NCXJIdUBxG4nvKOQBucpJc9K6+PtH4pGzdxtf55r+n+gTjQZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663911; c=relaxed/simple;
	bh=Nxd57m3NJdibA2oX+FRYFHVGk89RBSkaja9sGdB3cBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZw24XpYmffE4YuriGbBTSx+Ii+RYK/lmC8bQDrAdV+5iKLmUOhKp7jG5RqlzL0sW+sD4KidepqvsitsYfNyKXJS8GH9mBEU3MoED4uPv/xhzQDioYv2VGn0jWSELQuqNdF/uFDwqD8qMXeFuBF2Nyq3NBtK3khCRHZq69oLGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw8vmyXH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw8vmyXH"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c54f67db99so137750585a.1;
        Mon, 10 Mar 2025 20:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741663908; x=1742268708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oSwziDsvKFTJXuiRqL1YfUkGA94TmfsRfg9TxsllkI=;
        b=Xw8vmyXH29pMarbEsKji0obUWnCW7G5fYfACCiGuvV+FD5LthRTNY8m/n8GRfyatjQ
         gKqdApAUCRkhhQhp4wmcTqQPAID32xzN1kr0pMiM8EiPKXc0ZnD8LJM3IgxRspERH5/y
         P5T8web+ynJBXMRCWkRnZS6HjY/mNvBhRTc9jSdDUHj52zCJiEUseKO6jNjMpQn2mktY
         NI5u+7xF1oFmikXIG3V4jBHR+Df8hQB34DcmUbnoW0nmakyTvMnHZ+iwoNpKzpJGqM5I
         jOuYDR+E2iLEDR70cLaKsdHUrzC4MzqNHli3r+r2ED7N92iXA4teMZPUB9ZpWJVjUn30
         WZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741663908; x=1742268708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oSwziDsvKFTJXuiRqL1YfUkGA94TmfsRfg9TxsllkI=;
        b=VCZC4ejHL32EboM9r3vwcILXHxx/uV2M+tKwE285oGq5J5N3GziDqGBBm/gyFzu57S
         gPIeMC9AwMlHi/yIxRMwrF8YIxO7z+rEw72/AOX9BdzbmZ3pW5vrKQv3jxLaXXxFf594
         LLk7edWUDFccVghGX8f+VZJ1IdIFWGtQL02oHaVoJgSlL3jdm3UfVovMkCkpCeYmQeQY
         6HLwN308tFv6TUSqZJ8VcPNtDbVZGBXA+dkf+u8yIxt7KKGaqnxczsgF7IMiB+F/2+J0
         dX5cYzEtYJUIDxM3NU0fak/9OJeOGU6uTYULzFpF/l51/RsTmMR+mZGESsObe/M6ugBm
         0xIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWf+9/enr3NjvOwc1bCd+m+XRUuHSTHYaWBKUkenHlVAx7Mo9ZCV4vOPkszZlP3YBsKWIa+XEb3HSf8Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUH6Iu245u7z5JUwOoEC5z/Cn0eqcTQEnvBPiqtYWeHIdCGD+
	61b9hhiW30e1YKrBJMDVYfsJ0DN0HH3imfiv1E7UxFXlIIXGsF0gTuWd9ACa
X-Gm-Gg: ASbGncuMFVlZKLzxTklSzkj76cgbGO2Xqvooyev4qk/SHmxhIQa+BgMCHnvfkhqcgtz
	1WQ2KMJRBWkJ8pfh7OhK7z566o6E6Ub7ExwmcFQLI0mgTKSRFFSqJiCWFLhJc9rqeRIaSE8s4RG
	u3PbZ/3P5/VZT4851LEsWHfX72Jymu/7up53yjn7TadR84uWXHgbHA5vsaTI1/b5/Q1gqSYq7MZ
	yxRI3ZQyCborBrp85geNXOlDT2/XK8IFNvfxHt+BZ/z8u3BIaQJsz3L9VlxsRflaxL42/t4abC6
	hf+99sHgYRnTEQIgGlnU49YsEWVb3C6K9Xopfo961YWUzZWjsMxdGKSUJC6QA6Oh/oBpcRTIFki
	kRr8C02Q=
X-Google-Smtp-Source: AGHT+IFFcOoLxYbcFoq2EKXWhDHAIqJd9bXV7vm6uNhfgjef7g8cAwQoCjN0z6xXPQSPleRrcAuGig==
X-Received: by 2002:a05:620a:688b:b0:7c5:3da4:5bcb with SMTP id af79cd13be357-7c55eecfd37mr344036885a.10.1741663908257;
        Mon, 10 Mar 2025 20:31:48 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:aa39:bd07:6207:ac0d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54c204e36sm342772385a.40.2025.03.10.20.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 20:31:47 -0700 (PDT)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v8 2/4] ttynull: Add an option to allow ttynull to be used as a console device
Date: Mon, 10 Mar 2025 23:31:31 -0400
Message-ID: <20250311033133.1859963-3-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250311033133.1859963-1-adamsimonelli@gmail.com>
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

The new config option, CONFIG_NULL_TTY_DEFAULT_CONSOLE will allow
ttynull to be initialized by console_initcall() and selected as a
possible console device.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/Kconfig   | 15 ++++++++++++++-
 drivers/tty/ttynull.c | 13 +++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..edf557c73586 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -383,7 +383,20 @@ config NULL_TTY
 	  available or desired.
 
 	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
+	  TTY, boot the kernel with console=ttynull, or enable
+	  NULL_TTY_DEFAULT_CONSOLE.
+
+	  If unsure, say N.
+
+config NULL_TTY_DEFAULT_CONSOLE
+	bool "Support for console on ttynull"
+	depends on NULL_TTY=y && !VT_CONSOLE
+	help
+	  Say Y here if you want the NULL TTY to be used as a /dev/console
+	  device.
+
+	  This is similar to VT_CONSOLE, but without the dependency on VT.
+	  It uses the ttynull driver as the system console.
 
 	  If unsure, say N.
 
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index d8b51edde628..67aad3e6f538 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -96,6 +96,19 @@ static int __init ttynull_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
+static int __init ttynull_register(void)
+{
+	if (console_set_on_cmdline)
+		return 0;
+
+	add_preferred_console("ttynull", 0, NULL);
+
+	return 0;
+}
+console_initcall(ttynull_register);
+#endif
+
 static void __exit ttynull_exit(void)
 {
 	unregister_console(&ttynull_console);
-- 
2.45.2

