Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9F1BE874
	for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162750; cv=none; b=aj+ZkObKJKUD7OO/JI523GO0hPjujRc9HT3MN44n+9PselkAC0LCAnSxnAbaz17M6+j79Dhy2gB7rYZFDl+Wxh78cFYk3m67oeKcvcqwgpYuSamngfW3iDda/t/ohTOf7HPkSIwb3jJ0awoU3tky3In1A3qmLreCF8n1w9UZBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162750; c=relaxed/simple;
	bh=trPHxilhW2oQjHu87GszVwwwDkweNgsvTDl73YHBlYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0LEiOGHhJ8EhBPqnnmQeBmCMgiOHvoX1xlh9nMzy24Be0/koxgn1+zOzxVRDncDzfw34YOgkUVm9k+6acaq09SKt5PuPXXIh3kP8XLNw+eMAbagFujxqUQtjpd2PyvJGxZDP2qdegk0tF1+1nFq26hGORscGLP6UrTTnIBjLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i4b0atWb; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i4b0atWb"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a0220c2c6bso5546815ab.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2024 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726162747; x=1726767547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf/bniYlfRZYtTAiPueeb667UzLVb/sHpgqtAEqZ4pY=;
        b=i4b0atWb4UH/DYTK80I8JccIpQUzFG8s8vX71cSawAuw6p6hOXOZ7jQOrVIN6DITpv
         GqlUX5XYVMjXPIzu73kU9jsPQBxN3j80omSu5zLpcpDWQB7rEmjpwMR38oSIWVxl99Yt
         CbGlv+FrswpNvaTbjyWDQEWW3hA97nQVQ2tTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162747; x=1726767547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf/bniYlfRZYtTAiPueeb667UzLVb/sHpgqtAEqZ4pY=;
        b=RrOoUECJxUHNarh2bDrTcCBOJ5U1T8dcqP+cP9N0tOln4UmtDkBVmQtb0TO7D58AbT
         14Udv0Zd/RLrHHXCSEyqS+eZSM/zE9lgyjQggWEbRVvj/aU4Ul4ekNvTAsr/CMqTn/1L
         pVzRoFHdRikrwRjodumI3Gh8FSWNrE5ys5FLk4hTRmv9lx8kz7/UOa+VC0dZjLhMBnln
         KAnGZcblGwPrk6v1LW3VRS2BtuPSPN/qtKiYKTtCza22G0wJSFoY63/Mr5f/hHglwkit
         wBvfrHvDaDnsFXEF+A5ejNnLsU0UBA98Z317fWkpQXjlIFQMgmmtShoGajT5ypW8Dhpm
         tbvQ==
X-Gm-Message-State: AOJu0Yx8ksvfUWgG0QoFUt9keQlV5nu+7DUtcwW0P5m+yIMHgO2cSE6N
	4MdZW569BlZb19/ErqmK3tite4XGfNLdnm5pZEi5A8cAaXtifsSFIbZVbuW8lc8fiKq5RO5foHM
	=
X-Google-Smtp-Source: AGHT+IExDtgB/Ne9u3i8tSQpAY6TV0WOITGF0nQgTQhik+IHprM4Ev1fywxaGsBdNhJ6OdksXiIa1g==
X-Received: by 2002:a05:6e02:164f:b0:39b:330b:bb25 with SMTP id e9e14a558f8ab-3a0848f7e52mr36649725ab.12.1726162747309;
        Thu, 12 Sep 2024 10:39:07 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-226.arvdco.broadband.dynamic.tds.net. [24.56.189.226])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a05900e618sm32570135ab.55.2024.09.12.10.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:39:06 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: linux-serial@vger.kernel.org
Cc: pmladek@suse.com,
	rafael.j.wysocki@intel.com,
	ribalda@chromium.org,
	Raul E Rangel <rrangel@chromium.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Documentation: kernel-parameters: Add uartclk to console=uart
Date: Thu, 12 Sep 2024 11:36:19 -0600
Message-ID: <20240912113616.1.Ic8770cb6e660110359b245808105e5310d3fa528@changeid>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240912173901.3969597-1-rrangel@chromium.org>
References: <20240912173901.3969597-1-rrangel@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The console=uartXXXXX parameter is just an alias for earlycon=uartXXXX.
This means it also accepts the uartclk parameter.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>

---

 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bc1036e73bc0b4..cd3d44db60457d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -788,20 +788,16 @@
 			Documentation/networking/netconsole.rst for an
 			alternative.
 
-		uart[8250],io,<addr>[,options]
-		uart[8250],mmio,<addr>[,options]
-		uart[8250],mmio16,<addr>[,options]
-		uart[8250],mmio32,<addr>[,options]
+		uart[8250],io,<addr>[,options[,uartclk]]
+		uart[8250],mmio,<addr>[,options[,uartclk]]
+		uart[8250],mmio16,<addr>[,options[,uartclk]]
+		uart[8250],mmio32,<addr>[,options[,uartclk]]
 		uart[8250],0x<addr>[,options]
 			Start an early, polled-mode console on the 8250/16550
 			UART at the specified I/O port or MMIO address,
 			switching to the matching ttyS device later.
-			MMIO inter-register address stride is either 8-bit
-			(mmio), 16-bit (mmio16), or 32-bit (mmio32).
-			If none of [io|mmio|mmio16|mmio32], <addr> is assumed
-			to be equivalent to 'mmio'. 'options' are specified in
-			the same format described for ttyS above; if unspecified,
-			the h/w is not re-initialized.
+
+			See the documentation for earlycon=uart
 
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
-- 
2.46.0.662.g92d0881bb0-goog

