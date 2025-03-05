Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D11C6FE8;
	Wed,  5 Mar 2025 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149023; cv=none; b=aHbQls3jIK6r6VF2Bm6x7yryec3grGPAs17kHoAKt99048vcV6WaJh6BQSdliODlWNRHkCmCkvGI7sciTam7mVWVJX9XVz4jHt0/Xy7v2isndxyD0kOgqfZtpcmycsPoGpTatCURQxyEe8ZS28OrxLjwUenMAjpSEETdMAyYLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149023; c=relaxed/simple;
	bh=4OU5LuRAPgPJd1aa7qci6p7EFQ2s4059bejSPNDhMvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRuycRoVS2TPL2snzZxedZjkCsMgbFbHYds8BFSC72CG/WHFFPPSulEmeBEveatvXbCpjero0DzQ0iDVor5Bg/wIJ4JxyBe4djndVPTVk2RV87u/0OUFcx6ab9lD0qtixZlzNP/2jx1fUL6G1f7iLx9LgNSsSuZ0UPbSL1Gsm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7h8Nqvd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7h8Nqvd"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c081915cf3so830605885a.1;
        Tue, 04 Mar 2025 20:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741149021; x=1741753821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhFFJIc1/5ckE027gEnZNIXa3PHm3cFoR9UkUps3DRA=;
        b=c7h8Nqvd5aHtXWLHShyQ8EeUIZtOzH5LZTvYGIyLizyId1s1EdpIc05TuNd7egvhsS
         EFu+ncqT/QDsITmJB/RqAh9BrFEJIXNtGMHPgNkb2IAfMGLHOROpLYTQ4CyL57R+hcgr
         fxx/P2NRN6vbHJh9j4oqJtnfOYuoW0Dc/4E2bLCPZXptfwOwADr0kbAPH6HBF3S0aCnV
         ZF/+WrKA6hwGWdYGHzwP0sP0IJ1IbhICMHCppDQAf/4NUgyetU3bghV/IIpqp9IW4JW+
         ugxI/1I/xFa3RvtS4LN7UkQE5WQfQ9PsCxkexZz/oF3n+Aqyj1EKBMLTYPe4t2z6iC5k
         lhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741149021; x=1741753821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhFFJIc1/5ckE027gEnZNIXa3PHm3cFoR9UkUps3DRA=;
        b=Vr4KBB8RHDEdoIi+SyPJTdV1eENvLgmHpbscnPP0CYeYqs/OUsA25spiTxZLX8pg1a
         ksx4nL5VdG0eXqcG9EsTA/DfuPQpJ/KAOhmTE/mSr5azP6ZIrfllrivrLsNo6HRu9S5P
         G0Lol69QkUwNnDfRltJqgjQbLMoQOA4FFr012LEYUqL8zaMAbAb1UJKc3w98BFdXpO38
         LXrmqQK5VnVRG2DkeFMpDKjcvT22ZA7+uct329LYOT+kRZQ/dCzqupW0WShImMRZCitc
         GbdnK6VlM4bCxHm3z9GWYbAfbwAXjWOifbuajMaXRRoBuyIhJCCIQcjsdw8lV0lAv/3Z
         Y9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYoJzJy5USjITafKlC0jX5Af2PVH+p5kgzEJgYUjYxzfejfuskjgElMO0ifkMLYGl4MmjKD+eghF/T4lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKKq1h+nO2ADGwtrmUFpAXRP1zcLVj7X9ol8xYZW2Cgd+km1o
	24wE75LWcM5LA/c89qydQHV8UkdXTgugEq+B6CvLmmk0wBRjPuiQU1N1NhZ/
X-Gm-Gg: ASbGnct2oQMVQ7UlYK4kxm4arliKLiVKA1GW5os08u7bsP+5bOW/KuT8s//5r6dJp8m
	R47IUFF0gaCuIT1tikL0DagKNynZYtNpRtdapd7BOjwnbfFWUMBrt9cR0IuYetItvJKN+e7G2oD
	MRIw2LwcPtzmnpJCdBAJ3KhoZbFeM1G++CqZgmkM2EX9/7KDb/psu58ju1uy6kG8zqchmSRaRe5
	k7C9Wjezf67/K3n2Ray+9OCGTsTqWR0kL3jr/9yupEPw9KR2WdEXCsrkdNxIatkHeVc4S5D99fY
	CdEneRYaR11rSr54SQowPKsB8lCj5Y9jUXtIZtgz+5z4A6bXMRGc9oCsixrdpCPHzVhoJgOpneC
	Wx/ZJKFo=
X-Google-Smtp-Source: AGHT+IFnBhrPsbmYSJgkYVZzATggSZ/pMScHhMhbU/lifZR9B8ONrave/pUxII5tEfZtFN7Pu5DKBA==
X-Received: by 2002:a05:620a:6883:b0:7c3:d711:6ffb with SMTP id af79cd13be357-7c3d8eb11c7mr285994785a.41.1741149020906;
        Tue, 04 Mar 2025 20:30:20 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:a5b9:4b66:4113:9357])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8b4dsm834060785a.15.2025.03.04.20.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:30:20 -0800 (PST)
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
Subject: [PATCH v7 2/3] ttynull: Add an option to allow ttynull to be used as a console device
Date: Tue,  4 Mar 2025 23:29:29 -0500
Message-ID: <20250305042930.3453265-3-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305042930.3453265-1-adamsimonelli@gmail.com>
References: <20250305042930.3453265-1-adamsimonelli@gmail.com>
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
 drivers/tty/ttynull.c | 13 +++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..00ec1acb69ac 100644
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
+	bool "Support for console on ttynull"
+	depends on NULL_TTY=y && !VT_CONSOLE
+	help
+	  Say Y here if you want the NULL TTY to be used as a /dev/console
+	  device.
+
+	  This is similar to CONFIG_VT_CONSOLE, but without the dependency on
+	  CONFIG_VT. It uses the ttynull driver as the system console.
 
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

