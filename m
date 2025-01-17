Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10E1F708B;
	Fri, 17 Jan 2025 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737088480; cv=none; b=kcM+M23x2Ge5Uz0FkEuoSqDdYwq1u3JtixwVDM4tyc9cc2Sc1/dWUoxkjbpNX7e25iOLuiE+KQSGcQ5JLuMJND7cDlglkIrS3H0KfxhdVij9G3SYoMHIeKFj63aI8uoFB7nbUhljYGrD8xXL6O7WWv+3CMo2LNay5o/CYWw+ElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737088480; c=relaxed/simple;
	bh=p92wUBohP0rjxCMCifmi2TRiFtQ90A03N8ibiDU/jqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqTcE9CBkfgpsEowIPGpF046SlIleygvtqI7OkdE0VzQO9oIUGUY4RUa0qMfYbWGYvonYoc8htoZ+2jEyz6y1AqZehi7XRMIWAUbxyhURJ5A5SQt9G8bm72OB013hWDUzCibZoaK0Vx6KpubgLEax0UURXyIc86aBnQDep6P+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmgyMWsu; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmgyMWsu"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6eeff1fdfso153324285a.2;
        Thu, 16 Jan 2025 20:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737088478; x=1737693278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8av9nwhiwC9Ctcrjb5/vd0V4uYlTMOzWIq5eTF3m+E=;
        b=ZmgyMWsuKv8S3Y08a5rM/ZYNshjnhgKrTJTxGXXuAAxbXzRNH0Y+q5Zx3qxPAq2nhp
         413a94s1GDkwokxM8E1l3yH7q/UpNhCKZNo16dOIUyh/51mbFnm3g9oM0VzsLlI7bRQa
         PwItvyg43LzMPdRIZ+IPv9RfVk23Q07al3g88OXbbNEHi2GwVzwZLdjwxQaNI+avTFiu
         g/ZypvHmrHPsrssD7doAgpLwH5BF3rPhGIdQdge3HFBR7awrcUFvmTOYTZeN6DXjeuKh
         V4QYYvqayPiCxbGBIg2aUDT+Zi4Qj59jJUNK5Yt6ifCI03aiiTEzyognQb1GoeYj5qyc
         jSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737088478; x=1737693278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8av9nwhiwC9Ctcrjb5/vd0V4uYlTMOzWIq5eTF3m+E=;
        b=gVKKPziR/icyqOe6LblfDqB1wSmRXCdxuIwnGNI+1FCvvRnyQhDwQwKRblhaGUApKi
         eH7AVSRUPWLdHkyr6q+dda+fYlpRvdGiDZM117wtGkG1Gzzp1ODe1xSgRMBnzV6iQ5by
         uDQy4kuhU5Nsl0KMBbZVH47UDXNvUoIuboxWIfcC7DSsmVKdkuwlKleSWVpfV41E2LUA
         czHvVJWxQMQuwvwZyBGAk0mLS1q5KqtnaHisrP+wOq4UAJAv7PXGUz7lRF8u4Hcfk8XY
         o9LIzzXhh7pUKdmtZV5AA22ks0wzO98J70xG3RZ7q/oNhpWkw7piSCFm7ecqf2vIJWEf
         havw==
X-Forwarded-Encrypted: i=1; AJvYcCU494orPe0bz+5CHOJisO+JV/+zFR41S91IsdhJ74cmoGKjWAYIJpI4R7E4bqt1wdYUbYGQvOpJCZRDlOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJl7hNQyI33iv0+WTXna4kv1RaljDxPtOUeHxkC32qVVraECTv
	apOeOUZflr7/+HvEC7F3xJbWVZk11/mCt9z+J8Jy49UgCxiYMZUMH3Zil31C
X-Gm-Gg: ASbGncvyQMZA59Yt8kCxXZ5mvAfEIfOJjF9ulepK2kQOsTaojL9gzDPA9BTW5q5aGjO
	LLKjfDhlH6cp8MzcD8V+4auzNvzrcmAKeapYwMVWOQylweolsdWGM4OPxJdM0gnrXsEHq17f7qD
	+/ys2NoG8pd/oCJ3h0s4FbW9A+g91v4HDnkNMItvFBJa/0HMXKzsCR+81YUCak97tHTaItNFlEg
	johOmS6GuoV6ujddoaMZm3QzpARFDQglX1tZaYG85B97uVCVkr66XiCpaSOZHrxXchDpR1EbUG3
	QjS1jN+34fk0qMZOLgi0bi8JPKvP06V4Ili90P6o4nMKFl50i1FGobl5kbE=
X-Google-Smtp-Source: AGHT+IH61eWLy6opExo3hGumQ0lc1M1GULFbAvPY5i+0S6LtcH0Qoz1IACjQMILGAq3eGMB39Ehq0g==
X-Received: by 2002:a05:620a:2485:b0:7b6:de8e:da27 with SMTP id af79cd13be357-7be6325fac8mr250746085a.44.1737088478022;
        Thu, 16 Jan 2025 20:34:38 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com (pool-96-238-19-91.prvdri.fios.verizon.net. [96.238.19.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10404a2dsm7514911cf.52.2025.01.16.20.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 20:34:36 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a console device
Date: Thu, 16 Jan 2025 23:34:26 -0500
Message-ID: <20250117043427.1512743-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117043427.1512743-1-adamsimonelli@gmail.com>
References: <20250117043427.1512743-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
initialized by console_initcall() and selected as a possible console
device.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/Kconfig   | 18 +++++++++++++++++-
 drivers/tty/ttynull.c | 16 +++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..afe4e7722d4c 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -383,7 +383,23 @@ config NULL_TTY
 	  available or desired.
 
 	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
+	  TTY, boot the kernel with console=ttynull, or enable
+	  CONFIG_NULL_TTY_CONSOLE.
+
+	  If unsure, say N.
+
+config NULL_TTY_CONSOLE
+        bool "Supports /dev/ttynull as a console automatically"
+        depends on NULL_TTY=y && !VT_CONSOLE
+	help
+	  Say Y here if you want the NULL TTY to be used as a /dev/console
+	  device.
+
+	  This is useful for userspace applications that expect a working
+	  console device, without changing the kernel boot options, such as a
+	  distribuition or environment that historically had CONFIG_VT_CONSOLE
+	  enabled, and have now disabled it, but still need /dev/console to be
+	  working for userspace applications.
 
 	  If unsure, say N.
 
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564..8ba629ae426b 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -57,6 +57,10 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
 static struct console ttynull_console = {
 	.name = "ttynull",
 	.device = ttynull_device,
+#ifdef CONFIG_NULL_TTY_CONSOLE
+	.index = -1,
+	.flags = CON_PRINTBUFFER,
+#endif
 };
 
 static int __init ttynull_init(void)
@@ -90,10 +94,20 @@ static int __init ttynull_init(void)
 	}
 
 	ttynull_driver = driver;
-	register_console(&ttynull_console);
+	if (!console_is_registered(&ttynull_console))
+		register_console(&ttynull_console);
+
+	return 0;
+}
 
+#ifdef CONFIG_NULL_TTY_CONSOLE
+static int __init ttynull_register(void)
+{
+	register_console(&ttynull_console);
 	return 0;
 }
+console_initcall(ttynull_register);
+#endif
 
 static void __exit ttynull_exit(void)
 {
-- 
2.45.2

