Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFA79F5;
	Sun, 23 Feb 2025 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740287702; cv=none; b=RdlexDj4KTO8dLFBpXTS//iPBRzHxIAyp50IkudNA+gLT+YgQYxEH5BU+ID0OzARHj3u+94KPkSurHdGv3/Qc3mwR2QEIAwAfJaFjPqbnftnZ8P8PGBB4eeIryyqMp/W2pHXxd6nLdsJxLXoTvbQZtDwPj2Wbzn8WOGRoQ2Q9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740287702; c=relaxed/simple;
	bh=mQrSem63eAwDgMpxp7wwl6JnlMigX+QUakiidqHVY9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CClzjUSHNMZf/ck++uoZrU705NDmsDA6twGBlw2cTExJGL9ZEC+btezN/4iq5W4T3NeJRpo7T65uyCkSCUKUDlgHKtMoDCzZVrTlZzJTb79SOF2q7hkik1FWN5vCJjxRLBE7bRZBqQfhXKVu2Z1gqBuu+wIykqoCMoS14ZKsyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUyjlacN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUyjlacN"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so27724966d6.1;
        Sat, 22 Feb 2025 21:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740287699; x=1740892499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8MZETuC7V5G05JHalHsVh6dmDPdjiPVSG77k65pQVg=;
        b=UUyjlacNCL/LNPlVE8GmPjKaf2itomgYH85xxSs8DK7vSxDzRtMlcpW8ZcJmH+IarI
         PWapPWS77vMdy2rZs4PwxGQbvcSdw8PY5ecSj7nV5OO/MqMa4XAB4956mPTGa8uNcdbG
         t2v40CZlwe8xOdppl9aT1n1jSeZ0M9sDnC597U2Lgzej5pRmE/J75f3G1hpXkpK4fvfP
         Y/7TUpNhwpDpPAiUiDXVn1zW4KuTMO3hwb2Qgq/VypoO4TnZjIAzQy8CZX5JeqgpKCCR
         oq5jCJiybtSUgz/C0n7mxtcwdiwB13fz1p5sMZW1xmUbCZY/bn5sKuqAVsyKM6yrkEJT
         gX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740287699; x=1740892499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8MZETuC7V5G05JHalHsVh6dmDPdjiPVSG77k65pQVg=;
        b=Xu9x/OtXEgEgLXQouzuaFsbBkC4zbehE79NoWnjvK98c8CnWOHeD9JSSdGM5uYslae
         /O09MsBFKLuss0sRzTM9VNmj7JaOLAI21OhpslR+17jBLECZYRKboewXrC0pGOUqv9Hz
         FddTYpRVF8cJJJ+21eHXG4J7EUwNs+qnMgw/Eg/xNP82KnK5NreFjrn/g8oloLCuoO0+
         t5nAWc1pZ9GkNebYw6QddHw1TAG5lcw7DUfV5xzDuK6/1NrayTfXUqLWPxlNDxXWEWQY
         rdmHOLa2gocIQE4IGgPYLMfn6JXLUgZMZpn7H1daonrpgNeJQUGIpItCG55uNE5glk9v
         V2VA==
X-Forwarded-Encrypted: i=1; AJvYcCWZPvAo12Dl2XLOVPr8lish6a18m1AMy3yUGgE+HbMiMG/8iUxBdZ4KqK9dZB2VqTTMNE1miNdDPJrI6Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0q5Qu6Ay3OrBOtJQsVkfjWfSQt1hGNBizpQbAWojkTOZ96rUe
	YLGRXhZN3krHdiNswBLQ2I6rRsyAmSaza+hofmmNn+t2Kd3Cn23N0wwC9fra
X-Gm-Gg: ASbGncsY13B9wJFPxpRhD3aqhuX3KzX8lg8WLADTJginVVHt2VpLZR09SSXNRuBCpe2
	eG3CNnsvyZ7qPSJqhxcckpojFqnEyk77k0AoF5N0hvD3pMItoCgiS3x83YYu/595hRt+R7JJLiy
	DFafAf7n56MQl68KDGCzATWdbk9PSYqhC+kLWqA5b6fnX5cxxsWY7tAcxoMb7StbDh4/y0RtcE5
	K9qse9wC19civa2TgZxpCKvbk88XYSCkGNX7TLyXG/l9/2SqKTNXiksBdT+7WiT9mgncXy1rwBg
	Vx+FaskC3edJoBNeFAZIYK22aFs7KVtHhY6lV22WzmYl4Vj9jfdbyyf92nugmBol
X-Google-Smtp-Source: AGHT+IHeahpYDytqy/DPcuytFkI/T1WKxX9wxgxXb4BkGkFR7JGc27fEWirlyTXQ3Fr9BbjeTrxMJQ==
X-Received: by 2002:a05:6214:c4d:b0:6e4:42bb:5edc with SMTP id 6a1803df08f44-6e6ae7c9a0cmr104470956d6.8.1740287699002;
        Sat, 22 Feb 2025 21:14:59 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:104d:377c:5733:f5b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784e99sm118544836d6.28.2025.02.22.21.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 21:14:57 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v3 1/2] ttynull: Add an option to allow ttynull to be used as a console device
Date: Sun, 23 Feb 2025 00:14:40 -0500
Message-ID: <20250223051441.1861603-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250223051441.1861603-1-adamsimonelli@gmail.com>
References: <20250223051441.1861603-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

The new config option, CONFIG_NULL_TTY_CONSOLE will allow ttynull to be
initialized by console_initcall() and selected as a possible console
device.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/Kconfig   | 15 ++++++++++++++-
 drivers/tty/ttynull.c | 20 +++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..b4afae8b0e74 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -383,7 +383,20 @@ config NULL_TTY
 	  available or desired.
 
 	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
+	  TTY, boot the kernel with console=ttynull, or enable
+	  CONFIG_NULL_TTY_CONSOLE.
+
+	  If unsure, say N.
+
+config NULL_TTY_CONSOLE
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
index 6b2f7208b564..ec3dd3fd41c0 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -57,6 +57,13 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
 static struct console ttynull_console = {
 	.name = "ttynull",
 	.device = ttynull_device,
+
+	/*
+	 * Match the index and flags from other boot consoles when CONFIG_NULL_TTY_CONSOLE is
+	 * enabled, otherwise, use the default values for the index and flags.
+	*/
+	.index = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? -1 : 0,
+	.flags = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? CON_PRINTBUFFER : 0,
 };
 
 static int __init ttynull_init(void)
@@ -90,11 +97,22 @@ static int __init ttynull_init(void)
 	}
 
 	ttynull_driver = driver;
-	register_console(&ttynull_console);
+	if (!console_is_registered(&ttynull_console))
+		register_console(&ttynull_console);
 
 	return 0;
 }
 
+#ifdef CONFIG_NULL_TTY_CONSOLE
+static int __init ttynull_register(void)
+{
+	if (!console_is_registered(&ttynull_console))
+		register_console(&ttynull_console);
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

