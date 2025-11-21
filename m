Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60782F3600
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751072; cv=none; b=rm9hc1zWWGnB/nasKOTcnbHHjbMuwQCTj+UWxMxoPnklukndUD+H6AfKKq3KsSr9h9t9WXJcg+1wEcXWa/JjZF10Ac5QfIZvok4ozWQus4UoveCL0SKBjaQALpG/2vhnhpF8dcGwifVNRP/4OZt+JJub4Gk/g30ImeU4lz7c/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751072; c=relaxed/simple;
	bh=NKFHmcfiCk2EwIkTHkKYjnx6rN1uKn1am+sBKF+oi8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dzz6XDy4KgDTMqjd9/46YO8nHZI+CG5w5z2tAY1DAigDlF8nmsUaQfqgheVGpOJJgjXx/JHRvVPfcbaLbsegoOiTmo0LsUD5KxCC2VaS4OeS1XWF74Rf6UUt7TPwTPJzz6MNKRJmHV6eSNt3O4StSDTPSW4S40w+RmPXz4XPvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gnToBzky; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gnToBzky"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1481249f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 10:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751069; x=1764355869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFSdbuEHlkMgMI9LKgp25jd/vaPmbZhF8IKFWk4+qQQ=;
        b=gnToBzkyuSErRs5sXo3yPsyaP6GkPTMAlDlDR3BKdtIRiSlrx0F+4yroi7MSEMS08C
         J9xfVwc6cXq2gePZRdz3OZJas8v9elkzFlbWF+QbCrZfQCvuRWJngkwrfAgFGMXwUsDY
         lSRMl5lyg55fXG2Vpu2J07WLl1CbrrVsqAMbhW480aTqkNTEUNEsolybH3HtGTpYoJDq
         9BjNX/9Nt9egBNryHUdm0BXG4AEtg82DXnDEbT9+TwumglkSj80DMpdaS7lvkwTCdp8U
         N/UPTo14yoavNB9SFBDH6lHwDVVW+dqtjrm3cVyvH4yVSSKddhn0eqlAb/y/3MGCLQe7
         pv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751069; x=1764355869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFSdbuEHlkMgMI9LKgp25jd/vaPmbZhF8IKFWk4+qQQ=;
        b=EEbe+J6GcDOzhJaBoVbuZPUL0N3VDPXq/WeGNteubT/njW3XANK4o71bpD3d4lUFn/
         dzUx+k88xhnBZD/q89OoTROvc7f4/4hskUQBJokAT4IlUaC+2FqLgn3ktG9DN5dVOl1u
         iYVGyIPzINccyi65UvFngaX14XOWZri7RX5CZPmcpNnlMd8QpRHgzzaJFbnPYYfZXhfc
         bCMMu87sPvFxbk8l+04JH2SHgP0n7quofpIviUklN7D3hqwxUzGbi0HRNLgoLhlA3Qd6
         kvvTmnefjMjSv/GtD0by61wdfmqe9FoTc6hYOv7EHHzDxS/37MI9Nz7JQ5L2IP4Z1I7G
         o55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtxh7gIG32Qdx4q58PpbQiSs58xrqY8PXzlgg8pldGj9n29yE5gzVbFkfrGPy9Ry/357zGRQ7mZn5n+MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkbL0kOoSGTzpg+aYmWSQOItWfEa0m57Q2LH+bgkTmKm4uNn1e
	INAeHIySLfZocW71mcvxUu5oF97+y6i+8sVjGh1BQozwkbaflH5RxpoL4PkR+StZTDI=
X-Gm-Gg: ASbGnctM4q4mO4bMr808YT+LVVHyS0HvbICH2zHzE54WmDFcXjPsVq+Jb2cHB81Su6w
	wYxjlnorsIS8Jdy9mLy7ZNJgsOBeP/GBpzp9THiPqr++ljqK9YUUXo/ofiaJTku2aosMIuml0Lf
	xlgNNf+sjGQxBn2PEVAq//yeM4q4NRhzJ9kn12FBqjAWONONHL300rzW04uVs9nWlYnBY1FXEsW
	o5W41xI+GYmiJh6Hv9HjJz1E9Hfa45aeefoU76LEtPZ22vMS770JAZhktLVym78ORyp8d1LFWTp
	xi6Kt7Ugb0HTk6a+yxxqeywtdeytnYYhu40ZccNjv1WrG/Y0GWf7feOJYaaRg+XiET5oADsQ5k5
	xQCOTnIbB+0xwsixaH+lFBWPIp/6c1pQ74V9j1f3cyABrnly6oCMsH8PFz54tJRrofRVSKkFxqI
	l653Q6gg9afM4JrN6H3tflPeq6FAkNwHewUrY=
X-Google-Smtp-Source: AGHT+IE3ueb1gfvZpdP1O8B6KsMhh0NreYclj90YAJqPRO3t3jMYj6PAYTHfKHARsU3VdjyGtVHkhA==
X-Received: by 2002:a05:6000:601:b0:42b:4219:269 with SMTP id ffacd0b85a97d-42cc1d0cf4amr3499114f8f.41.1763751068837;
        Fri, 21 Nov 2025 10:51:08 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:51:08 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 21 Nov 2025 15:50:35 -0300
Subject: [PATCH v2 3/4] printk: Use console_is_usable on console_unblank
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-printk-cleanup-part2-v2-3-57b8b78647f4@suse.com>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
In-Reply-To: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=1461;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=NKFHmcfiCk2EwIkTHkKYjnx6rN1uKn1am+sBKF+oi8Q=;
 b=t+kTGkkizl6U6aR6PW2Gu87Sum27bEEzl8ibey1pJbKk6zu1jVjEcA/kU+oc6YLo7Px6+PkCp
 QGPAFvKM1ClA+rzBQGG0BnUK0kRud59IVkxx67TxhQX137mqpi913XJ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The macro for_each_console_srcu iterates over all registered consoles. It's
implied that all registered consoles have CON_ENABLED flag set, making
the check for the flag unnecessary. Call console_is_usable function to
fully verify if the given console is usable before calling the ->unblank
callback.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/printk.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cb79d1d2e6e5..fed98a18e830 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3374,12 +3374,10 @@ void console_unblank(void)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		short flags = console_srcu_read_flags(c);
-
-		if (flags & CON_SUSPENDED)
+		if (!console_is_usable(c, console_srcu_read_flags(c), true))
 			continue;
 
-		if ((flags & CON_ENABLED) && c->unblank) {
+		if (c->unblank) {
 			found_unblank = true;
 			break;
 		}
@@ -3416,12 +3414,10 @@ void console_unblank(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		short flags = console_srcu_read_flags(c);
-
-		if (flags & CON_SUSPENDED)
+		if (!console_is_usable(c, console_srcu_read_flags(c), true))
 			continue;
 
-		if ((flags & CON_ENABLED) && c->unblank)
+		if (c->unblank)
 			c->unblank();
 	}
 	console_srcu_read_unlock(cookie);

-- 
2.51.1

