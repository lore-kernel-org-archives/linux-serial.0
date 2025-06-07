Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097A1EB2F;
	Sat,  7 Jun 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749303738; cv=none; b=M7hZTZ4c7trh9jIYHjMcUJfVKkmf4gb7z2D3gES/wkH2MoswPIkOQLmCK6+RaQCnK84z2pvHxrwxKDhfFhsHgVBCSsLCGAj7armj/S1gl0+ISx1C7YL+0suva+LEaSxpzzyrTM70auqhzF5SMnd/BQH2HpEbKBq8dyyAXQ0t0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749303738; c=relaxed/simple;
	bh=7OMXm2oX7DsrPRUa9wedeBvqixpmVGGeyS+cECzQPmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+Lho4GmU5+NiHVf1tkSvN55EZTtSQjeoSftNKUp0XJ+caMh7M3XvDszfEJnQFgJ/mLueNcisaDKdC2ZF+eyzw8d08ueal29lCXGlRKOl2ncgYrBUCJATLXfLijKm+BAFihVVDCDayIolKTyWEb5xHhjyKwwKvIfJT/GtDtAflQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+V52lKW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+V52lKW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b200047a6a5so3457811a12.0;
        Sat, 07 Jun 2025 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749303736; x=1749908536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYbdjoen+GlgAnAOQhE/zXRa8mz64qBD934C8Difs2E=;
        b=f+V52lKWNUbNDji+2R9/ZLkJKxz/aaqF9suIZ0Cjp1BjhMr4/+9Khd/Nr2qVyhDOsT
         Aqba/6kpYkOBsWyPPbWXHQi4QpFu04vEDh9vnXpR0GC8LAKYI+/UEKOY/+s/PBSiSOgT
         ZV6AmnWRW+8IHzRKoUQC6lK3Jaalcv5Jstngr1BplfMzVSZanCDu6JNEsbARUsTQsYEJ
         3KbVinJnHU3CobGByRLj0xGV4hZ9xfeTu0Ep0CKLblSjPTJYVx/jixZG23mIS65Fj+Zv
         Ktnptuia7wb23TziXGght2MedEmae3SFRXNMoZnVqewT8ie1XQbIqjaYep8o575ml+44
         lJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749303736; x=1749908536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYbdjoen+GlgAnAOQhE/zXRa8mz64qBD934C8Difs2E=;
        b=V+EMDQvhP+DEA887RLdZK2vvdA/UyYeZgOc4vbr6m6U3EIWkr2Nk5GzxjuVuwnJbOl
         Aghx/8KkhjjJzGR+kXre9UwNUuJ9mzVwPDFPgo4pukzHIw4Y4RFPMsOD0Q7yAhk2cRTg
         VhBtCV386uCORnjiihlwGv9YXpH4/wxCNkp18fEMl7D977aXQs4KcVLxZBULmJAo4fDg
         uik7RFvgXCQpFGuKJAz6llE/fl0BR13dDONXbaGKOAufn/kvvxBNpf4Hw0CpKJtcnvng
         hA1y67Hb2gLbUE/YBjASYeZ3ecX1zCfM48DBfO620jHqZG9IZeqkG2wBwPQbz+1NiCA/
         B9dA==
X-Forwarded-Encrypted: i=1; AJvYcCVAFAHo0wONE++o8/4yF0TzTRRejmuTJkOg2fwabeWMCMXiMQR7SL2o/YMad5aQu4AVfVaRKFVVAXBRsp/d@vger.kernel.org, AJvYcCVUjwpUTgxsoj3oxpuTiA2KSRAHaIFlE+Jgy9kXfBH61h04GgPnhLXzMn6klTfcRjJx3WHNAUz8FxJVlLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5VCusc1LCd1MmJPxG9aVdDSEk56JD6VTcTZE3MP9NazqeMW5
	qZA8jzcpwAEdQH7ojBq8kt8lbwbXtkxU7PPkfDku7cc1lXc0aE6UuIDZ
X-Gm-Gg: ASbGncsIRUmHVizdIzkO645iReot5U79SeAiwsEH9K7WjguuQBjUJbd991BnQTA8+pL
	aVGXh+v0TVK9kiDXyCwv9+0F52pq3thbAvwYhm0FNxV536P7wkd5+upo4lIdApMu8n8yZhGBpW2
	1kfVB8bBhXWq3f7GMZ+WmhqXsJPjzccM/5mkIqVbJsBRqxtZSuRqUjshMel2I5k5HfiLTWYZbo/
	AYyspNyDLTkqAH+qw3XZS5XoUxfXIr+VEBQn9UO7sf08DrEMnFtLqsGC2csqWRVPPVQOhMDgPE7
	l7rBNr4h6J1GLysB6smDtrEZWB5E4L3ezyN0TszY5v7UnmDG4LL5uDUMZ7msctu35V6o2eeJ5oo
	+28Xs4A==
X-Google-Smtp-Source: AGHT+IF9hhixo6qXrT5bf39wdeQ5dKAy/YMwF7LT99pO1uz5iof/4mKamI3R1vKkxZ3Er9xloCYr3g==
X-Received: by 2002:a17:90b:57c3:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-31349f424a2mr8764626a91.5.1749303735811;
        Sat, 07 Jun 2025 06:42:15 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:bf5b:2e56:6e66:c9ef:ed1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035069f3sm27157455ad.231.2025.06.07.06.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 06:42:15 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: kees@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] tty: replace capable() with file_ns_capable()
Date: Sat,  7 Jun 2025 19:11:14 +0530
Message-ID: <20250607134114.21899-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TIOCCONS ioctl currently uses capable(CAP_SYS_ADMIN) to check for
privileges, which validates the current task's credentials. Since this
ioctl acts on an open file descriptor, the check should instead use the
file opener's credentials.

Replace capable() with file_ns_capable() to ensure the capability is
checked against file->f_cred in the correct user namespace. This
prevents unintended privilege escalation and aligns with best practices
for secure ioctl implementations.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
Link: https://github.com/KSPP/linux/issues/156
---
 drivers/tty/tty_io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e2d92cf70eb7..ee0df35d65c3 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -102,6 +102,9 @@
 #include <linux/uaccess.h>
 #include <linux/termios_internal.h>
 #include <linux/fs.h>
+#include <linux/cred.h>
+#include <linux/user_namespace.h>
+#include <linux/capability.h>
 
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
@@ -2379,7 +2382,7 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
  */
 static int tioccons(struct file *file)
 {
-	if (!capable(CAP_SYS_ADMIN))
+	if (!file_ns_capable(file, file->f_cred->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 	if (file->f_op->write_iter == redirected_tty_write) {
 		struct file *f;
-- 
2.49.0

