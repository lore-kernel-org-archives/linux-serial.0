Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25960149C4A;
	Mon, 17 Feb 2025 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765286; cv=none; b=i/CQW+hKFTPRjCZbXYK4iPGhpIbH1yJChElOe05rNeukmpSLhRe7kSnBbqp7CSEWHEc1VnjJIxssuAGR/nYjNbd3K63sK8IG/Kqw49V2t6qlCAOphHUMrILsCSpU2+KIn9y6PzdJ6YnDqL9A5ZepEI4e7JWmMSkTiIKXAW/hyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765286; c=relaxed/simple;
	bh=p92wUBohP0rjxCMCifmi2TRiFtQ90A03N8ibiDU/jqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0R58fpcTOSLe1It2oERwmXEw6/k8bt6iglVcdPx9Knbv/UL7x+zOk0kF9G7h84eXmlkz6DIIazby4mO+IZKTRVkaJv7ofK35xmG8KnMUlhFV6rStX7AnVoCC5FFEHN8io4+rzhuPNPHbTho6HKvKIYgrKjflnMVvr7vVzZOReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EprOw7TT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EprOw7TT"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c07838973eso368797585a.2;
        Sun, 16 Feb 2025 20:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739765283; x=1740370083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8av9nwhiwC9Ctcrjb5/vd0V4uYlTMOzWIq5eTF3m+E=;
        b=EprOw7TTGpWt/G1ZP7lqq0q+80Ai+fq3MCPpFmxf+CnJfDxxmD2gLMtH6QJ2z/ZV0y
         gM3V0AIGTIxuNTkBL3hVrNyLs5Oy3dSwEWAD91hHY/ZNs0mAHVdaspH6/c71g4jp3f9Q
         dayy88lk85KqLUR0UjagjQkryGbyB62GLGgrkWoH3Bw6nwVYBWElzkh0yK2dC5SYV+Y5
         gCOAqOV2V9uvayRynxelVyQVHUDq7k4Xw7v2tEtu0rGGT8At1xnVdz362wNk7lyXyXOJ
         vWVMOZ0JDYYTdByvOK+FD63ES0c2EHhM4lR5bHZvkJDl0VQ3DW4eU95b5B0/H3dfZU/9
         sNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739765283; x=1740370083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8av9nwhiwC9Ctcrjb5/vd0V4uYlTMOzWIq5eTF3m+E=;
        b=Pjw5pDcw7NaZ6qhnydAk4LSeIn8dZrOENem6XdPDxTpK0rOCUMDnnMM9EZ9n0Ni8yz
         dhtvs+hnowuw4CJEksGnMSzk+8nFTAT3hzFE8KBiuYR+l2gQHNuA1+ztJm8mvvaVbmB5
         pvsYOfV+j7Mm1wdBHUr/twySvhs7qX57g37ChgCbDUlX5q30uzlPKBcA26yD5TC9dbat
         Ildn7U6P62DUOFWLyg+2zM0Ykf5CrR9kprzFLkgi2lnsMlb55kHat7oGI002gOCWS7H2
         c8whawRnpgJhrzmhOVpBh6BgIALZ9cO00mYqBKUpiFXwv95qN58ABmodtPM+HcRYXOAq
         8Ejw==
X-Forwarded-Encrypted: i=1; AJvYcCW2sC8AKpdIvklVSU/dxX/aHzY5a5NKKttoSqlj2rG6pZ2S5acMkuPyfwe+eUrbD3z+pefE7qbPKGGVqok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmBoe81M6Mq3N8Z1oPjiTmPnLwIJJ/YgFNNihw8c5RXFpIRpQ
	WOm0Ed8Ggx/CcdpEXW91vcyrjbZ0Gyc4FCPWP9rPd1DKmOIN2Rldh/bU9sPl
X-Gm-Gg: ASbGncvZ9rzheVBae/dLcaLz8eiX/MSIcjdgIfUDaAMnCU0pVs6sAybrHZxt6HHuPex
	2ZQpNoV/RMSd/b64SXXCp5fC281mwjo7gZHjwb2gk6JvIWFwsBF3rRRSvu5s9a2WNe+2FykkNm3
	n8+Pl79iNDiVg7yj3y7nKPXg78rST9Hh66Kmk8o9VrbJckPfRynpWH6L7pD33bjxZvBfxGHYEbY
	Le3YeyW4SMaZwoUrY+BrV7k3Nj+EWbCqOTQRKHJXUM3jOKVtyYrZPueuoM7K70pYjgFJpoivnd4
	nekvOo9wpuHBB6RaY8VcuqpkOohIMudt9IZMJK3Cs+nU51s0Lj6pcQ==
X-Google-Smtp-Source: AGHT+IFAsXl0OfOCSP2dbhY8QTCTsaa0TAm1mqOzqVRf/w7erDav/9UfChlvA0lzdcKw8vyH1OVnPQ==
X-Received: by 2002:a05:620a:29c6:b0:7c0:78ad:ef4c with SMTP id af79cd13be357-7c08a9e7388mr1073720985a.34.1739765283336;
        Sun, 16 Feb 2025 20:08:03 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:3bda:f60d:1567:d3d0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c861537sm488465085a.67.2025.02.16.20.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 20:08:02 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v2 1/2] ttynull: Add an option to allow ttynull to be used as a console device
Date: Sun, 16 Feb 2025 23:07:47 -0500
Message-ID: <20250217040748.2017975-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217040748.2017975-1-adamsimonelli@gmail.com>
References: <20250217040748.2017975-1-adamsimonelli@gmail.com>
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

