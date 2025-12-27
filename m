Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A8314D04
	for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837857; cv=none; b=tixwgIGfgSjjpg0aFLDW/3jaBvAYtaQ0sipQNGlUbrgrpI4uxqAAepLfXnE4JGP/htPtADsjF9qG1SMWCVG2qFdZaNWz6n7OZn06BEoFb42rbzH2zi21LuXENAK2l+QI2pb/dIknKLi3fXiQZA3+8gA0v+Pto9SgUsxjXOSX19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837857; c=relaxed/simple;
	bh=ZR0iR9pvZGcVZSHwNZDrCThadrViJMyV5/bfGtiN4gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaBo/wlpKRI8SfYccRWqmtt2mCdRaVavpBf2pxCdte9fODKMz8HKnJRVkb2S2Qg1M+lCac8Nv84krlQldOCQBo8qRFZXgm1hCsa4el+6vsWoVtgipYxGNGmZ422YrLpIGw35w9DbKoIXa+fjUD0y5dIa8XbDsn56AUzrc5wWXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d0hkAh+A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d0hkAh+A"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae77516so75654725e9.1
        for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837853; x=1767442653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvSE1c/4a8QCKCTV5gdf1mCLxf9YZVQyxdWd8z10SmE=;
        b=d0hkAh+APo89SF/oO/BATGo4UBjKStTkO6nvr+Kw3SITajoXYaVQ15NLvunGq+CgKm
         /f1RU381IpYScuBObwBAeOa14t5nYX+bmB3LMkOmJEnOz9lpx7R8KZLwrDSSwWCYUYdF
         5mRdpAypRmMTYXRAyQX5ZUAHYt96mgzso6yyFK9MX9+RzVeWtATQZGCi467A787ljwOo
         Rx6n68rbC7osZgiy2NJS2qABPEz+4BHDdQbaQsd6vbAE2gsJ117+6BSmAC5KkKBy70Kw
         e1a0tdAfHZNz9MAhwrpUMvRik9PS2l9RIU3aNlyFE4Nl4pCKIYgilb2C7b/ZBPc+Ym/+
         hx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837853; x=1767442653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GvSE1c/4a8QCKCTV5gdf1mCLxf9YZVQyxdWd8z10SmE=;
        b=LU+D8J1rW+g3CxU93SQwy7kvDCeCNsp5L8fyAln7qfYaAqPCJNdjgqzMdy/sxeEhzw
         sZ6vxd71vVm8oDRIa1NiXuLA/Ba9OdcC5Dt2H6ZClipOLt3z+/jOk58+3kGwgy8Ay7O2
         8fDcOeQFwse2HHcbprQSbt1DlZ6hjDopiSXzI58k5R7+Kg8EOYbyFAvkF12iN1fdgXkt
         MKPd3ey3UiZkDp483XqBt/g+tB1sUTAHCmDUQ5UQHMfQxuhYsnXKItbe0DSBlLiFnntN
         Tu/m3q/ABCb8KUuzCg/bjB1aeeMPmTloOeIZvLHpd6vsBr39efpuFvegpRn45hs+p3cV
         racw==
X-Forwarded-Encrypted: i=1; AJvYcCXGOhnqnONDGb8iSlGHNB+EyUBNEwnpDN2aZBETx8esz/cFGKEUij/9PnorGwbk/KpacSOLdNmMJA771e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvENKnKPTFPbqsDfkdk64+E3zjX9xUaxtipUi7Qero525zisxd
	v/aEaqwV8pw0ZiEane8umoUwagSxHc7KPHyxq1nkDe6fMsFLB1JCiLfGUnVHti0gtHg=
X-Gm-Gg: AY/fxX7c7W+9qY2jdXEehpvXx/Nvpql6aDP3XEzit8TBuj40RqHyCQhvyUM7fThaSmV
	qKSrt68k4isQUfW0+BgVj9YmdVdFHYUrw+QMJOhVv8i9BlR5HySw1334xglyBfjUua1PIAIVDpz
	zwRymwRAWMwE4LAbMlhvIkryjW6PB2En3Yg6XtkOlrriaiv6Tcxyn9rxdDtoXfj95EZvGACijKp
	2452Zga4ZMY4utZ/iLJUqYYZ9lT1VFXIfoih0ptihfstsBM88xgAPE1zwFZJz5WERd8oCx7aLnA
	eTL1+3h2juUF+DrrcvkZVQqxZFcrD7IissPeZlZq+Y4Qtno3Ut4yh1cIDl9Y8+ej5h86nsKG0uR
	BK7PoqW+4/OPgxSm2Ftxhr9gnltu8Sxf+++XbQXY8/wRDj3EtkWzW5zh5zcruyiSSaZn3aESeek
	GyPQ10OuouXYh94yHh6Ao=
X-Google-Smtp-Source: AGHT+IFc0PxKRmRSwma+5BK2z0BfbuhbWCK5ZAQiNCh/fQVQ/f+EcwX2yper4KDcLK2LLWDZAwXkgQ==
X-Received: by 2002:a05:600c:620c:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-47d3639489cmr187665015e9.17.1766837853435;
        Sat, 27 Dec 2025 04:17:33 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:32 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:12 -0300
Subject: [PATCH 05/19] printk: Add more context to suspend/resume functions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1815;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ZR0iR9pvZGcVZSHwNZDrCThadrViJMyV5/bfGtiN4gw=;
 b=tA7/rFTFgz8i0hdAJ53eXVaQiZ32fF9Si88T8AKGgxMwsJDyXHg4gS+HXEQzjoX95zhxiaqSG
 v/P+ZTpJjf2DQdqlDkpPXA8mgBEajKQf1Xila0zWamPBwICGf70zjAA
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The new comments clarifies from where the functions are supposed to be
called.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/printk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 173c14e08afe..85a8b6521d9e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2734,7 +2734,8 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
 /**
  * console_suspend_all - suspend the console subsystem
  *
- * This disables printk() while we go into suspend states
+ * This disables printk() while we go into suspend states. Called by the power
+ * management subsystem.
  */
 void console_suspend_all(void)
 {
@@ -2766,6 +2767,12 @@ void console_suspend_all(void)
 	synchronize_srcu(&console_srcu);
 }
 
+/**
+ * console_resume_all - resume the console subsystem
+ *
+ * This resumes printk() when the system is being restored. Called by the power
+ * management subsystem.
+ */
 void console_resume_all(void)
 {
 	struct console_flush_type ft;
@@ -3553,7 +3560,7 @@ struct tty_driver *console_device(int *index)
 /*
  * Prevent further output on the passed console device so that (for example)
  * serial drivers can suspend console output before suspending a port, and can
- * re-enable output afterwards.
+ * re-enable output afterwards. Called by console drivers.
  */
 void console_suspend(struct console *console)
 {
@@ -3572,6 +3579,7 @@ void console_suspend(struct console *console)
 }
 EXPORT_SYMBOL(console_suspend);
 
+/* Resumes printing on the passed console device. Called by console drivers. */
 void console_resume(struct console *console)
 {
 	struct console_flush_type ft;

-- 
2.52.0

