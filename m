Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9003B9D97
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345269; cv=none; b=D5OqHi9WOdR6j6TZwpNWmt1ei2RxWesLm65/aGjQa123DCIpO9EklEu0TaXKqOcemhgrWnO6VlNnGiibUtvmFhj+P9xgy/tdNFOpY44wR8WCp8qs2P1IuKdcn1HacjPbB8wetqXvXZgEUlebKNZqLsDU3L/sJT9UKSzQ0l+E8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345269; c=relaxed/simple;
	bh=5AJsOgYaQnITGNqOqit9HwSaFnKSSLcZyF7ZFqvmlgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f96y6lIL/K1gL8jZfbfNcwa97Bpxgcwx5sjrpMcA7rvv3KrdfrBfyfJnbAS93HnclrLpHiHroMHkmucwS+FipuOVIC5rUgP4qk9hdnXr7jcmLPjU21yW6Jv2+PqArdAVfFIqnbj5T89DODOiOfxKXVY0pvURTrE7ouiEJPJWvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFuaiIlC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFuaiIlC"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70f91776fcso3320394a12.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345268; x=1776950068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrdHztCp3KFh57kUoKZvj6n8RP0Ytj76L6PrWda2Ixw=;
        b=oFuaiIlC05RZkgswANAiQzSRxne9NaW/x2hH0687bHlRg8I5xNwNIH9l/DTq1jg2QP
         HOvZ50ZgVMKjwmi2UJyvoZFLDWODrPvqlXPeZN1xqgvrv3K56OOVXEpCig+peVlJQ1E0
         K6wnRX/9pjTFiddLzsNlt7ZW3JIybfv3HxsRReO/ly35g1IpazkfwRrxyWqs3ZKN8gxW
         36MMU6VClQYlHap/vvNa63tOKD9mUiXl2lFI4S4kOqgN5rYzImKxhOpmG6+xNsLvg06L
         0NBFwaVfHYprrHx+SUmzpRK6ULQNDoHYr7+6vachlAmeBHlS9Z6PjJ9kNEA7VisZDMo6
         gQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345268; x=1776950068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrdHztCp3KFh57kUoKZvj6n8RP0Ytj76L6PrWda2Ixw=;
        b=ZLSJQL/RzGM3jmi2yrqUdxQYXKybcJs0w9gJGO0Jn3LvmfbMa3cl4qBL2RIT4VAbhb
         /1uajZ8Idh8EGcsBGfjPjh1UVKhljBSGSaGaszcoKcmGUaFzKL+1ZdTQdk6onQOgUggU
         bD9WN4du2QgPATgOHp4f/rlSaq8cCjFchiUVVfb68ZXvFzomykgRLgjsEiLdt55HFBnV
         1fJoRDRz2VL6Tfj6ssc2rh5cO5hKiG0Mk93+sNV6hwbDIde2r7EiEfZaOBOieMVxbln1
         fMyRTMTBqZtdhK0ilkSLIzyuwPsNhqXJNioWnobVz0OJmSx4WAwQ9cqiVCIAcR9KpDbw
         owdA==
X-Forwarded-Encrypted: i=1; AFNElJ//j0hFcUZ4PI85ff+QJ9DLGhI1OaeFBiw7EmbaOsUw5s5FeQCNY47JZpSJCtpWR9dNhpJr3TJdxxak86E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlXv9yXtwk2DBxhR9rkJcXIGDR64erChO2BPlhlt2y/lCI9VP
	S5f0VyZJvyCGgqLSwsfq5CmJMbwqDZn7EHmevytQhH6bfTfQA150UJQy
X-Gm-Gg: AeBDiespXKpYQhZV2ABfclrZyBTiqdAqvBM4awkejNRl83w309GgeJ6nINcSKsYHdOk
	VXP3/T5wqO8sPvWc0KJdJeQOsX8pa21z1GsUVBv6xCBklTin2OSgh473P7euzRH32966uPRAmCP
	bPcM6vLdi+l4O9fKQdhwdh3gED/nLYxcj0dVcJ4o3bftPjk7swJ9cv2QtWKMWMNYAcRVSys9XZK
	AXxER6wX5DXEs4Mc62dwgEVHXAqtmcZxYKgGwOKptnxpxzPvxxS2gM0J6lKsq3TVoRDVulqADzJ
	8/Et0+HLnprCDyRb4gcI3Ez5ayTOBBB7bEfIBetneIFxCUURz/KqE/QUSv9+Q58EEPdn5DkprnC
	OPNjmkl3r3zA/IA/KfwTgVc1V5Vgcj0DemRjarcWvq9235YF4Y3NL5Lf4XhW+YUemL0N+ZtDly+
	iFGnkLsn24U3EdjYE19o4jnohvv2mNEowm
X-Received: by 2002:a17:90b:2689:b0:35f:b953:244c with SMTP id 98e67ed59e1d1-35fb953263bmr15728963a91.0.1776345267649;
        Thu, 16 Apr 2026 06:14:27 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132cd52c3sm2483648a91.10.2026.04.16.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:14:26 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH] sysrq: add optional logging of caller info on /proc/sysrq-trigger write
Date: Thu, 16 Apr 2026 21:14:19 +0800
Message-Id: <20260416131419.1231012-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Gao <gaoxiang17@xiaomi.com>

When /proc/sysrq-trigger is written to, there is no record of which
process triggered the sysrq operation. This makes it difficult to audit
or debug who initiated a sysrq action, especially when the write comes
from a shell spawned by system()/popen() where the immediate caller is
"sh" rather than the originating application.

Add CONFIG_MAGIC_SYSRQ_TRIGGER_LOG (default n) and a runtime toggle via
module parameter sysrq.trigger_log (default off). When both are enabled,
the kernel logs the triggering process's comm, pid, tgid, uid, and walks
up to 5 levels of the parent process chain. This allows tracing the
original initiator even through system()/popen()/fork+exec indirection.

Example output:
  sysrq: proc trigger: comm=sh pid=68 tgid=68 uid=0
  sysrq:   parent[0]: comm=my_app pid=67 tgid=67
  sysrq:   parent[1]: comm=init pid=1 tgid=1

Usage:
  # Compile-time: enable CONFIG_MAGIC_SYSRQ_TRIGGER_LOG=y
  # Runtime: echo 1 > /sys/module/sysrq/parameters/trigger_log
  # Or boot parameter: sysrq.trigger_log=1

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 drivers/tty/sysrq.c | 29 +++++++++++++++++++++++++++++
 lib/Kconfig.debug   | 16 ++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c2e4b31b699a..e9277e7de35b 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -48,6 +48,9 @@
 #include <linux/uaccess.h>
 #include <linux/moduleparam.h>
 #include <linux/jiffies.h>
+#ifdef CONFIG_MAGIC_SYSRQ_TRIGGER_LOG
+#include <linux/cred.h>
+#endif
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
@@ -59,6 +62,12 @@
 static int __read_mostly sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
 static bool __read_mostly sysrq_always_enabled;
 
+#ifdef CONFIG_MAGIC_SYSRQ_TRIGGER_LOG
+static bool sysrq_trigger_log;
+module_param_named(trigger_log, sysrq_trigger_log, bool, 0644);
+MODULE_PARM_DESC(trigger_log, "Log caller info on /proc/sysrq-trigger write");
+#endif
+
 static bool sysrq_on(void)
 {
 	return sysrq_enabled || sysrq_always_enabled;
@@ -1209,6 +1218,26 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 	bool bulk = false;
 	size_t i;
 
+#ifdef CONFIG_MAGIC_SYSRQ_TRIGGER_LOG
+	if (sysrq_trigger_log) {
+		struct task_struct *task;
+		int depth = 0;
+
+		pr_info("proc trigger: comm=%s pid=%d tgid=%d uid=%u\n",
+			current->comm, current->pid, current->tgid,
+			from_kuid(&init_user_ns, current_uid()));
+
+		rcu_read_lock();
+		task = current;
+		while (task->pid > 1 && depth < 5) {
+			task = rcu_dereference(task->real_parent);
+			pr_info("  parent[%d]: comm=%s pid=%d tgid=%d\n",
+				depth++, task->comm, task->pid, task->tgid);
+		}
+		rcu_read_unlock();
+	}
+#endif
+
 	for (i = 0; i < count; i++) {
 		char c;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index aac60b6cfa4b..46bd361decd0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -705,6 +705,22 @@ config MAGIC_SYSRQ_SERIAL_SEQUENCE
 
 	  If unsure, leave an empty string and the option will not be enabled.
 
+config MAGIC_SYSRQ_TRIGGER_LOG
+	bool "Log caller info on /proc/sysrq-trigger write"
+	depends on MAGIC_SYSRQ
+	default n
+	help
+	  If you say Y here, the kernel can log the process name, pid,
+	  tgid, uid and parent process chain when /proc/sysrq-trigger
+	  is written to. This is useful for auditing who triggered a
+	  sysrq operation.
+
+	  The logging is controlled at runtime via module parameter
+	  sysrq.trigger_log (default off). Enable it with:
+	    echo 1 > /sys/module/sysrq/parameters/trigger_log
+
+	  If unsure, say N.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
-- 
2.34.1

