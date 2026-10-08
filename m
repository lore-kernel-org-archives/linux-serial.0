Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BF4D8DBE
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472157; cv=none; b=slietIeyvxTur0UB8dWaEraMFmcNhveDoHW2R/56Vp/6HT2sy1MlusOqsW/7K/5dPgZhKCoUYHs7g5MnZXeLMbAmSAIUlcLLSRU1IwjnV0cS4kDxS4ZnBWSGiyUM3551X3PWsXLnkaTuDbUaZyQE/KRzsilh90WN6MKu1i1TI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472157; c=relaxed/simple;
	bh=DPLfbxW/sJQ6FCIIrRNk7iZhGqXjqTVidcV7RQr+caU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/U4enHMpieluUlamFXCfeFSE90PZOgP8dAq3GxDA9OOA7W9aOQlZVQ5XwcNI6C2ldtHfqn1q8idHjd4EH1bM/kYG9XAsO8hMBgEW6CVGryGBv50d3HckYyaaVbXYzcR7wlgmETKwe6nleqSdHQn35DlmTD09asDy+S4hX0geyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A4jADuv1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A4jADuv1"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso2121450f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 08 Oct 2026 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791472149; x=1792076949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZoYyHruaQfuFkMonTZBefQ9+t/8NjKFEa6jTKsN47Y=;
        b=A4jADuv1BTzBj6ZuL5Oq/JsBxPA9CbF2m0JTLaRN4DCw60S8sya1SKkGq6yc++koqE
         diuZXylWwmqPqmxFpN9vn2yoGhd4vU1cmxPyQTxz4+qaXgmdK8LympscMne0HUXt6SIa
         EHIDPa9CCpVD0Gu9zyucJnBUjnNGknvGDvBav5JWjvi++oPDM+WQTIr2szntPgZw5HAd
         T5FNOVEOH6ijqLPUy5tBGrgkuFMNfVV4DOSfQJD2QFrLVfYMMtkOeMZU0DMiT6x30/mC
         R099PTGpKOl9SW91R3kJqsG8Y+sOSCQnvzWHt5KImVgF8L5WQN31o/YskNXnjhAyo5wQ
         EO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472149; x=1792076949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZoYyHruaQfuFkMonTZBefQ9+t/8NjKFEa6jTKsN47Y=;
        b=bJKX3BIpGbe8FwHQryAojBS5GC6UB/pJdjhfd28qSz9EnBRNYulfvz8OxDi7PuiQOX
         Jg7b1CQJb0JeN6b+6uADrbz+InYW3DbjE0mHnv8zqdhMsRvdNfowEM6/tD9+hdUMK/8A
         O0cwOucgzTFe4iZmL1HFJL9oM7dkNX1sIrsWb3DOdApvhJV7r85LMthEoJq6TxrTg89e
         gDdz9q/ktdoeFssu/cIh7e5/EmU2jTXyn6IqkFVAxs+spPGteH4bGGfDqO0CdcB6Hkkx
         YHqD+Y+MAEuYcBEhx+5EulWCAy/L42t0DA68N8C8YQOvyCxHRQph3oj/s/QYuvpi2F47
         SzrQ==
X-Forwarded-Encrypted: i=1; AKwUvByCb/JqPnIYUdqfx+MO2NI/U1X+ibVXk2N67yZn3t1ys6zfjtB0terNimxeKz3KCkSKXf/h/zJ/FkugaCU=@vger.kernel.org
X-Gm-Message-State: AFuF++mCdRXN9MIm6tzumzniRV25tcLPXFjmcsSA+P6/ExkwRYcOsjz3
	5zHgDOSo/Y0VNIwqLNfRFQC7VKZA2C1n22tCGO4kD0TLTAgQzhtRF3o3iH8ZbIFMHMc=
X-Gm-Gg: AYBFou1pyycZVEGx3BCxsf8qJwYuKnIhH8c57JP9meBiJMg1wBrk/Op3HD8o7bggU9/
	BBHygYDfyLMhopl//OfgJKdICAGsJH/tzmcK7nQz1+UXmwvRUPNZ2M3/gqazW/bugOFQdxUD6Xj
	n0PIEw1tHBlRq+hjJ27h9kM6X/Yb6CKiqjBz2hbabySpvsWwLBqGaTTcImeWX021ebHQo21ykJY
	1Iu7ei91b/ni7HS7ejC4YD9RSGAjHwHCCzpypg/143ov3kRaGobw6ELUVwpBR9b9eLmJrOYKQ07
	uDsEZnP5eS1wH8oZQGRqXm3PzDB8Ndere95nhOUVnN6uHvYARgd3w9WO7wU/hVubNb09TUJJFIi
	E292OgVkNpEUGgFPbk8IVkmO4qERLUOiy5DTaoMAxwvqg6xwjjwbUhQpEK8fvMq3sMVOxqmknCi
	P7x4Hj8RpHCIouaV+kgkX7v0bSKkPQUQ5vFE1Vs3lamOpACYF7w4mElwgw3U88b4nemEVwOmOdG
	xJTKEFlfr0=
X-Received: by 2002:a05:600c:3f12:b0:4a1:6811:8d with SMTP id 5b1f17b1804b1-4a180310ad3mr106022705e9.11.1791472148744;
        Thu, 08 Oct 2026 08:09:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843b5f28sm82116835e9.12.2026.10.08.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:09:08 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linux-serial@vger.kernel.org,
	oliver.sang@intel.com,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on reboot
Date: Thu,  8 Oct 2026 17:08:52 +0200
Message-ID: <20261008150852.8286-1-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NBCON consoles emit messages in a dedicated kthreads when the system
is working properly. printk() tries to flush them synchronously in
explicitly marked emergency context and in panic().

Another situation where printk() could not rely on kthreads are the various
reboot and halt code paths. They can be detected by the `system_state`
variable.

Let's default to NBCON_PRIO_EMERGENCY for the post-running states.
printk() will automatically try flushing the consoles synchronously.
Also do not rely on printk() and explicitly flush the consoles
after these states are set.

Note that suspend code paths have already been handled, see
console_suspend_all() and console_suspend().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202608061008.48a1e76e-lkp@intel.com/
Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Hi,

ah, this somehow fallen through cracks.
I am sending it as a proper patch finally.

I am sorry I have been somehow too busy before
the Plumbers conference.

Best Regards,
Petr
---
 kernel/printk/nbcon.c | 4 ++++
 kernel/reboot.c       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fb1b37741952..d8f8ec836eea 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1446,6 +1446,10 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	if (panic_on_this_cpu())
 		return NBCON_PRIO_PANIC;
 
+	/* Do not rely on kthreads when the system is going down. */
+	if (system_state > SYSTEM_RUNNING)
+		return NBCON_PRIO_EMERGENCY;
+
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
 	if (*cpu_emergency_nesting)
 		return NBCON_PRIO_EMERGENCY;
diff --git a/kernel/reboot.c b/kernel/reboot.c
index d177d89fcc33..776784a82499 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)	"reboot: " fmt
 
 #include <linux/atomic.h>
+#include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -94,6 +95,7 @@ void emergency_restart(void)
 {
 	kmsg_dump(KMSG_DUMP_EMERG);
 	system_state = SYSTEM_RESTART;
+	printk_trigger_flush();
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
@@ -102,6 +104,7 @@ void kernel_restart_prepare(char *cmd)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
+	printk_trigger_flush();
 	usermodehelper_disable();
 	device_shutdown();
 }
@@ -305,6 +308,7 @@ static void kernel_shutdown_prepare(enum system_states state)
 	blocking_notifier_call_chain(&reboot_notifier_list,
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
+	printk_trigger_flush();
 	usermodehelper_disable();
 	device_shutdown();
 }
-- 
2.55.0

