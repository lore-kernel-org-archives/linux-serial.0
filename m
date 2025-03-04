Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B91F30BE;
	Tue,  4 Mar 2025 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060506; cv=none; b=fqC+o+gTc5ZzhsSUGrvtZrJXfjl11wkSr3zDgbakb605P8LtSAnuXmBt0yPCUglZ3GzEQyTyZZ0/UfNB+VWuiMLZE95KDYNTc7XMOS3VrTzicVcil9OLw42uzceRO2uhG2IfJMY/+FJvDT5XkwleoSiIsY1YV/+MlUWCaJjRZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060506; c=relaxed/simple;
	bh=lERtH19jid+LO+y/8+3N2dc3zBqsli+R2bMI9zoxhww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbhiKYDmkOHV9Q04FCoBQ+Chy0bsvKf5hGn5Q7msdX8CaT9nXjTNxJU0uUNnTbypbysmME1U15qNLFWfflQIA6Z3kNOD6bn2epMeRg0ffD14z39EO3pI2oHyhZkr62zFpzqk3QKpjW8zQR2mA2hp4fSn7+O+fCLzqSBNWa9raus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHEOnNnM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHEOnNnM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471fabc5bf5so24127811cf.3;
        Mon, 03 Mar 2025 19:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741060503; x=1741665303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie5BUWJem9d+IyUYFdQ1/YspxsAeO3qZHjwNy/H0VKQ=;
        b=SHEOnNnM9irNPLNM9UUo66MomCQudMQx9WfapHqyoypc2SJOiNJRf0EeIvB9WzSC5L
         yKejtI9Sdri3lmo552XPt/Y1aa5cThAiKXrakQpH1ROK6Rf/pkeKqTt0O5d+e4agyUYt
         mCSJp9jH6EnWq3EnA8dTz/5YglRdRBXsJNOicwY3+/oW/ZzoHhbeRR344AI4Va+CTqpR
         wqrEEf+ps8jLfCKMKf+YqG3AXmihuwgC12goRYy2VspDkYPrlTc/5eUx2DPse9JCq0HZ
         7/g8T1Ls6NVfDvUZFbpXuRMz9FPHSiiaof2l47nK2K9Mjf+eDnQhpKnJP2HWsTd+ir61
         JJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060503; x=1741665303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie5BUWJem9d+IyUYFdQ1/YspxsAeO3qZHjwNy/H0VKQ=;
        b=UPcDDxDYei6eNSIWwB8g98GI+cVCnkAnCAdmGl892r1tRDncfJpkCBU/QIBZTvqEm6
         qhKzm/F2ied98cqxEn+uXIlAeO7rIM+4x2b5inOyD7SPZrnkL5hNYFSMTrHZa3V4oyR3
         ru0zyFXt5jOvYJ2NnApL74HVXWEsYnEy6oabxAFcYo/mudTPakpA59LzLzS/+hBAqMMC
         HCbUMlnv2KjqYlQOH9nAWYCmkKqvw8uE6bqJqekZ5CaTuvOnspvM1W7U08BLaVMgVZW8
         d35s7q41inxBwaA0uSiC0N8QddJsNoxbcWrHhEAQKM40CuTeRwjMlnUAwpOIqbQL4K68
         KjYg==
X-Forwarded-Encrypted: i=1; AJvYcCVVpCfpZJfcL0OykXipDOFIBJt6O9LHMUMVP1YFXsl9zo5jVSOSMIA/vzRYW5vKKDPRTIsnIy3KV1ffius=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/qaygyG8FmnYsT19OCo7wBy5WXSEXZ2x1dkw5fv56ax3NPhc
	oFfoYRohNyeyoCD5E6+dMFq4Z29rRuiIzk/5RXpdUO6j0lJUts2Yh1LZL6T9
X-Gm-Gg: ASbGnctgBFKPTiR/rcUwWYglYiN5Hwn1/2wSpZ7wc9FajY4SC694wv3yuYLkbGwF0b1
	8Ryh/emte78fSUZr0ZYWGU5FmxauQCpER1QQac3nXBiIned0cl/4R+8202q6YlNdBBjOdzjxzA2
	VUzT+oRU9PwCl/MPTjFzgo+ZUa3ehw53v3aDIYT7mTnqwAsdLSRr1kvUr8D/Gpyfs2WzXBLtB3q
	SfM4TJy/4C8Uspq8+vco86zj2pwtEfWddrJa1vGlz45THrBJ+IwK9CXUCVBh1xeXkHYXc/+nqA2
	sclkDyCneMnobCeQid1Yz/CjD1tUcHAmPmZNBfCNT1RYNIwzcSdkiNCsjwHVDh7kZZHjKGX6VUp
	gxnU6ROE=
X-Google-Smtp-Source: AGHT+IGzkCf+odoTMbwNVMmYnlLG+yxs/PQOgVnpMSX3DQlX4FrPEXs3vPJw08soCZANFkrZtRx3sw==
X-Received: by 2002:a05:622a:20a:b0:471:8d66:cd68 with SMTP id d75a77b69052e-474bc0554ddmr207463321cf.3.1741060503308;
        Mon, 03 Mar 2025 19:55:03 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:745f:1ed4:1113:4077])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a1f2csm67567041cf.13.2025.03.03.19.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 19:55:02 -0800 (PST)
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
Subject: [PATCH v6 2/3] ttynull: Add an option to allow ttynull to be used as a console device
Date: Mon,  3 Mar 2025 22:54:46 -0500
Message-ID: <20250304035447.3138221-3-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304035447.3138221-1-adamsimonelli@gmail.com>
References: <20250304035447.3138221-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

The new config option, CONFIG_NULL_TTY_DEFAULT_ CONSOLE will allow
ttynull to be initialized by console_initcall() and selected as a
possible console device.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/Kconfig   | 15 ++++++++++++++-
 drivers/tty/ttynull.c | 11 +++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..868aec2ccbb3 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -383,7 +383,20 @@ config NULL_TTY
 	  available or desired.
 
 	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
+	  TTY, boot the kernel with console=ttynull, or enable
+	  CONFIG_NULL_TTY_DEFAULT_CONSOLE.
+
+	  If unsure, say N.
+
+config NULL_TTY_DEFAULT_CONSOLE
+        bool "Support for console on ttynull"
+        depends on NULL_TTY=y && !VT_CONSOLE
+	help
+	  Say Y here if you want the NULL TTY to be used as a /dev/console
+	  device.
+
+	  This is similar to CONFIG_VT_CONSOLE, but without the dependency on
+	  CONFIG_VT. It uses the ttynull driver as the system console.
 
 	  If unsure, say N.
 
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index d8b51edde628..cb1e363b726d 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -96,6 +96,17 @@ static int __init ttynull_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
+static int __init ttynull_register(void)
+{
+	if (!console_set_on_cmdline)
+		add_preferred_console("ttynull", 0, NULL);;
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

