Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55551EE0A
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906139; cv=none; b=olZFcnvPUTtcvXiD7vPfgd1b3qwHXAK6rZo5/MRVn/oN/w+hytPomsIB7fxnuBrpbfYF6tdZxeqdEsjRq7NeJucfY3eY7v+YjqlSGbPbT4C55OMfFTJdyNFM3OHz+5Dhufo6XJt2PY6hyq9SrAccGYVmSsQ640s9mfRtzzjZ6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906139; c=relaxed/simple;
	bh=PLKNnY0shbYu+toZqyW6ELKsVMoYRKE9gJsmG7TyZxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKKNtjOZu+zEyV2k5UjJU+HeD93vcqZrL4WmbADqfZ1AB+7IJlCwD7UvV57llitT7au0XN5VDoDuaI7Le5gpSMWKSLuPx+MSrZuObarZdWLcum/Lmy7zYF9yfsweuMZgTT3XQQPZ8zPBLLH9bIRaPK1IIglR6hZWWFf3F5NL788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UtX6ODW/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UtX6ODW/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso269315e9.1
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791906136; x=1792510936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0o562vnHxAoJu9TkgWw6HND2WtwAaL2hGXNC5e9IZzI=;
        b=UtX6ODW/RT+YAfDnZhvOd18v7hXHoR4aRcJIv7KjkW8D/vx0NPpdn+Wc/XYX0vYBQW
         b3/824T/hj+2nT6vr2ivk4fMsltkYr5qIh7BrHxIRPNxDI3i/7/gGNqobVXeXVskyGbC
         68fLUGMuSwypYPPxuiwdyIxS9L6GQTttR6AJFYgtrKQMBgGxqo6xIWGdM+IqP4ZnnUan
         PgaNOcBgtuDlt21PbmfMl9at2DC6A1vs1CvTZNIVgjWGwMjnN1cxDAYBe7wnzNA6IEh7
         7f0jQe+kYS+iirZtNCLh2sSjHhMBRy4KasAMBKP6aQ8gmZtAryzUat1Bv9/oQBPzex1D
         BrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906136; x=1792510936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0o562vnHxAoJu9TkgWw6HND2WtwAaL2hGXNC5e9IZzI=;
        b=MmJiOWbXizUBHrNsnXGsOf9juWz5X9vyXGDNAxXzfX5owJvQWR0GGbAA4m99xuJSJu
         MbdXI4YsGiYZg7Vg81Pyy6gN5fDKL1ZDT2u43tFMEUphBWMaPbDNGy7oraro+pxg9wwQ
         gR/+bJJZvtMydHojyf3zEF+UQGSmxIwviieTQGBQhn5klzUWgoPrzrorUChsF3EOrQJQ
         aQNv+ChfQ0jPcUakYempMDPM/y4sjYM4uhmSzOif7T4xCNSecpI2TzCWbArKssUE8ZHn
         BOnwhNkjiozhlQtaS5x8ptrWXNO9PE3Dred3eTjlAhcnYdBGazU8LE2swIqhwNoFtYuK
         jSFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQRCBWt8nh3tOmVC44emnIl2ETs66QhuOsr25sMqZwzkm8HNCI3eJ6Wr+yzzKC+QhvZq/BPXOC6hYKrhg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSg6dter8C2nBwMkp+fenNnbYH0uaOSbLPs/3VwpeofMrHAWH6
	sjB94Ze4AElP7jtjPE21V3U5eTgy6+u7U7Ie19ioTxY+YZeNfAymz/9ihBYxn/w2C0k=
X-Gm-Gg: AYBFou15JdNt2iVas6hHg3oIM1SZ9cF1cyvD4rCmypX0c/7xeD7Oh91EKIUG9zkbbB8
	Am2CsSBawBgyrYUWr3UWgG3jZylV6JFFRC8g6Vaqpm00QNOLkzegIppLi7/7zNX0+WL2WXwTm0Y
	8fg49Tdys5W+MsdEVzE/18E/7HOvYwlF2ddIsTCfsfs8eEWasr04i5D85Tf0lzO/vbGe5to/7ig
	Ro7G56FDdp2PRu5fm2qMyQfEH2uj1w2KHiutBBi7c6DAk29R2ptpbJ+6ByJjaiaSqJK7aEZBRF5
	Y/HO2B2/W2cHfGcLXsWL/rCvJjboxcFnVvz21Sgd9LrYJwrU0vWZGBHSO1nW9G3llzLPaEBLcoM
	9hLyJi/3POk1WtctFLMpoT5CT2c/XU4unKuZAR1ZgUwy5UJA9mkiXbPI03S5KqQl5zqR01NFD4y
	BCFgBY0vI+88TFERjCv7BJw/qfamJcoRpj0Q6LOz6pRR6dHyddaDiy+DSxD301RLQqGReoWONm6
	anc55z7VCk=
X-Received: by 2002:a05:600c:4e89:b0:4a0:22d5:908c with SMTP id 5b1f17b1804b1-4a18e4a4976mr278830225e9.12.1791906131800;
        Tue, 13 Oct 2026 08:42:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm464244575e9.4.2026.10.13.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:42:11 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2] nbcon/reboot: Switch NBCON consoles into the emergency mode in emergency_restart()
Date: Tue, 13 Oct 2026 17:41:41 +0200
Message-ID: <20261013154141.94016-1-pmladek@suse.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the system is going down a normal way, the NBCON kthreads are
flushed and stopped properly via a syscore shutdown callback, see
printk_kthreads_shutdown().

One missing piece is emergency_restart() where the kthreads are not
stopped. It might be called from several non-panic code paths,
e.g. sysrq-o, kdb_reboot(), or some watchdogs.

Fix it by explicitly entering the emergency (atomic) mode and trying
to flush the consoles there.

Note that printk_trigger_flush() must be used instead of pr_flush()
because the later is not safe in an atomic context.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202608061008.48a1e76e-lkp@intel.com/
Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
This is a 2nd attempt to make sure that NBCON consoles are flushed
during a shutdown.

Changes against [v1]

  + Handle only emergency_restart() where the syscore shutdown
    callbacks are not called. [John]

  + Explicitly enter nbcon emergency mode instead of relying on
    the system_state variable. [John]

  + Reworked the commit message completely.

[v1] https://lore.kernel.org/r/20261008150852.8286-1-pmladek@suse.com
---
 kernel/reboot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index d177d89fcc33..5b9691f45f5f 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)	"reboot: " fmt
 
 #include <linux/atomic.h>
+#include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -94,6 +95,14 @@ void emergency_restart(void)
 {
 	kmsg_dump(KMSG_DUMP_EMERG);
 	system_state = SYSTEM_RESTART;
+
+	/*
+	 * NBCON kthreads won't be flushed and stopped properly in
+	 * the emergency restart. Move them to the atomic mode.
+	 */
+	nbcon_cpu_emergency_enter();
+	printk_trigger_flush();
+
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
-- 
2.56.0

