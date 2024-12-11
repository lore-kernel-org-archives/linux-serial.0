Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A051D5CF4;
	Wed, 11 Dec 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931602; cv=none; b=r1rkuJpdrkZjq2xxPtsM4FVRQfT7Q7Mf/MeK6K7oQ1ZbUXhdnHuUdMlkaBOlMEeogac12jZHaxTkoJu8xq02XIJ85KuTuzVM1yz7Z1A9LAIUfWws/lsKE/IG86fGzc1YTXiDWRAsNxIzHnzei0KRSbwHgxNh0HnJLB0EaCFwfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931602; c=relaxed/simple;
	bh=xCNtIGvZnNIu5/QbFT3pZymo7sFLzI6Gj4+mZZnRzu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mINhvLwbOP3XARO3f9WmbScffmE5epm1WRPBiZwi2myy/92ODCykylJChtppkxmG9eGoSLtXCuQSO7iFJzk+yVuyJtbipkJT0mR92qcIXhkIZZS4ZUVNA/pzzqsc9ZNVZ/doOzbSIubQG5qN8oGFv2OzrXH5wbShze3oFRd3WMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUPsRsit; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUPsRsit"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e8fe401eso119476985a.2;
        Wed, 11 Dec 2024 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931600; x=1734536400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKV6ykmIkdoQNyGHHuYy+sKRiD2AqpahzC1WLoezEII=;
        b=SUPsRsit9LBznlpQcKiLduap3C4ToWncklG6WbOg7bvstElChikpAtbBnttGaFIrSP
         gqTTEmgehTpTtNK3RKm2jU0PfxRy7IqpBsDulhEqODUW4s0JjKd/xHZJYIZ4LJxb9dQt
         cv6ObqE/UlQ5P6C/VQpIyKtYj+Qz4i2Vs5iqbxOnBD5I7L9vYcbHa8oHjlahBwEdwdx9
         BPCn4W7ZvL8SOjkC1LKLrcybVLgzkRtCDMAZosbidtIgwzVIxl8Jelw2tjpFvRyjHoaZ
         yuQmQxSoi6fqzxDuHQmmrHy/Ly1kfMIr5kRzY/E3O6hIp7shcllCwg2ETN8V+ScbAjN/
         3fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931600; x=1734536400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKV6ykmIkdoQNyGHHuYy+sKRiD2AqpahzC1WLoezEII=;
        b=Brp8xcVRqS+EIoPSC6UkI4kvBhj9Uw7Po3UEnpNKjleAmkIVYB16BpN3vfZJHiajjI
         gG1a0IqFSFkUSUVZfxApsKWxq/HNJwjj5ftuY8p9QdZjV5OtfLykxSdK/KTxkLc6aUZe
         63qjb/JLwoKBQBpdfCqS0y+R6WpUJRNh4iJaBXdlUel/xWsBIUNoQUqa29QiOgAjvhjV
         t3VYvn8YIMtFdDvzYAN6RC2RV5XRiFEQarWG0cQmH+xkfJCYgsAE798ke81xb9LmJHqL
         gnXz38Tz7nLAWdJQfQ0jU47GmIbjjVHvAgs3ern7J8sZ9b6hduh562qcnHUVQCZzp4ij
         F2rw==
X-Forwarded-Encrypted: i=1; AJvYcCVXDn21jW7U7WmsW1pp5Hfxh/UhsjQQh68FqSZqTlBE87smDnZD4CvQ/pIjQQHEWKHBKZufahZu75zMMzXa@vger.kernel.org, AJvYcCXSCa4P6N9o2TmrRfUMqIHT4EDtCDETAz4x++38RQ8Zte3HNBuy34y56qXOEoq88xNFQZ1rQB1cWkwsUTCiUXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvlzoLQvzrQXfE0E0hJofS9HzTcy0yEJRoPgWgXP91KhRGt6S
	QyIq4P2M8X4YP1rJtlJ+MYsUq0Kbz/VrHznZ+T6JBQfHVcW3FRzq
X-Gm-Gg: ASbGncuj1wUrAEBXgoUb/QFZp4v9wKgnu/5LzWhWbbTjs7dqdvWG4EiNmN3XZPRocqM
	zD6xpygjDAjAGmUP4Tlmm4AnLGB6LmUy25iYDmzEERpuN3zfAtRjw7/tgWssClUdwlS/l8vdWpK
	tL0roKTgOdkfi0nwSqFQs0zTTvO0BMWEPIg8msApNb5BEOLTmYpA7PMGpG1dIOkQM/vOLKB+Seb
	eqMGyVGUW+t1vgCqGp03tTKaAgUDE5bn2vRYUkn2wx/xGc=
X-Google-Smtp-Source: AGHT+IFSPqOSxpGMChdT2H6lTn5vsbQE4pfhlqzSy7VLPkTfCcuKn0I6YHYQWdwVHrD5XqsqWDeEIA==
X-Received: by 2002:a05:620a:2814:b0:7b6:cf48:ed5 with SMTP id af79cd13be357-7b6eb42fa43mr490786985a.7.1733931599686;
        Wed, 11 Dec 2024 07:39:59 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:16::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6de8a8caesm186786385a.43.2024.12.11.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:39:59 -0800 (PST)
From: Amal Raj T <tjarlama@gmail.com>
To: danielt@kernel.org,
	dianders@chromium.org,
	jason.wessel@windriver.com,
	stephen.s.brennan@oracle.com
Cc: tjarlama@gmail.com,
	amalrajt@meta.com,
	osandov@osandov.com,
	linux-debuggers@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH v2 3/3] kgdb: Add command linux.vmcoreinfo to kgdb
Date: Wed, 11 Dec 2024 07:39:55 -0800
Message-ID: <20241211153955.33518-4-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211153955.33518-1-tjarlama@gmail.com>
References: <gmail>
 <20241211153955.33518-1-tjarlama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amal Raj T <amalrajt@meta.com>

Add a new query `linux.vmcoreinfo` to kgdb that returns
vmcoreinfo to the client using the mem2ebin encoding.
Maximum size of output buffer is set to 3X the maximum
size of VMCOREINFO_BYTES (kgdb_mem2ebin() requires 1x
for the temporary copy plus up to 2x for the escaped
data).

Signed-off-by: Amal Raj T <amalrajt@meta.com>
---
 kernel/debug/gdbstub.c | 10 +++++++++-
 lib/Kconfig.kgdb       |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 6198d2eb49c4..5bec444fc6d3 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -34,13 +34,14 @@
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
 #include <linux/unaligned.h>
+#include <linux/vmcore_info.h>
 #include "debug_core.h"
 
 #define KGDB_MAX_THREAD_QUERY 17
 
 /* Our I/O buffers. */
 static char			remcom_in_buffer[BUFMAX];
-static char			remcom_out_buffer[BUFMAX];
+static char			remcom_out_buffer[MAX(VMCOREINFO_BYTES*3, BUFMAX)];
 static int			gdbstub_use_prev_in_buf;
 static int			gdbstub_prev_in_buf_pos;
 
@@ -768,6 +769,13 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 		*(--ptr) = '\0';
 		break;
 
+	case 'l':
+		if (memcmp(remcom_in_buffer + 1, "linux.vmcoreinfo", 16) == 0) {
+			remcom_out_buffer[0] = 'Q';
+			kgdb_mem2ebin(vmcoreinfo_data, remcom_out_buffer + 1, vmcoreinfo_size);
+		}
+		break;
+
 	case 'C':
 		/* Current thread id */
 		strcpy(remcom_out_buffer, "QC");
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 537e1b3f5734..012529eee79e 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -12,6 +12,7 @@ menuconfig KGDB
 	bool "KGDB: kernel debugger"
 	depends on HAVE_ARCH_KGDB
 	depends on DEBUG_KERNEL
+	select VMCORE_INFO
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb.  It is recommended but not required, that
-- 
2.43.5

