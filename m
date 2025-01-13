Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD11192D8B;
	Mon, 13 Jan 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789384; cv=none; b=o1Ntu9VmxRM2A/1aACbGTeJVKmYZ0NNjIj1YOUaa/7PLolZHjDxFf/DlGmmAbIEmqqvDNWszjONYFGxxjNm9ypXF1+0bIzpTdKw/4475Ge/WCdWbPq0RCrb0xCZbE7wFIkMa7rPEGM2Dl6R6dA54S9wysveKUQ3LO2Ysx/Greqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789384; c=relaxed/simple;
	bh=r+H0u8lzc7IEahUBtUDTwiEJxv8TgyCVGKnxxjKhRwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTut/tilZUQn4bBSw01DH/Hn4xqG0cH4maj6yAoHi6GxhvKRx2jWncI+gsdyU7uEaF6artlPQKUyDIB/9iQqDbhZVSLEdO6+Yz5na/PMNe6zwth1eyeNHyJSpo9A53sSSGqbXPe6K+bBED+fafGQ1oBdHVU8mdXBLW3wFkgB8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AovW7ork; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AovW7ork"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467918c360aso51663661cf.0;
        Mon, 13 Jan 2025 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736789381; x=1737394181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfQiNBgUgAWKlD8O7d4LRyIYa+awTxMXg09SlbXcej8=;
        b=AovW7orkRmfkEhfPXklC9TDVt88e5tYpyCjYZd9nVNCnhZpb8nyUEToUKww3lUSSc6
         6CJcP/ay1xyGfFf6T+QUib9k8v9s6E/8/yTpuEHKxDcqqPsyei+NaIa+6hR9SJIF57s6
         xpUEOXyPkcpWtrgk/DH0NY8uO5UgZIfokakNJca0q/F3qRGUW8UeVcuKBfhTysseMdFk
         nql6hdqmxnBGpP+7NAu8rt0qUuOVJXQ+qy4SjbrjmMCK6Wm7FZPK533upe60R5yjzlUg
         l/EiuJZ0OQzL39LRoXmgg1bbmKoUusQRkwx45iPoD83WuN/0ZuDhQGGO/TxrB1pYAiy9
         wtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789381; x=1737394181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfQiNBgUgAWKlD8O7d4LRyIYa+awTxMXg09SlbXcej8=;
        b=G2ZMB5fzMIQ3cbejjkM9a88zpvi8/rdd6QNY7Q7tXv3L+FUtWULbgbc7WDYRn++25K
         XslB3qY8PPaxfb8ZiCXpim3FnyCilXqf0B6sgRln9fXoz4hfugDgi2gGD8EdaqS16Rg/
         DyLMlkxGw+chbGnz3ulfAl81DTlwwRnlJP/yByC+7ZCC7wLmsNy6fUnLqVRRy+Efc3nF
         9kIsQlmZ3DQ9nhf+a+NN9qJrbhhAB3EXBoJmyyL6kuuO6QGc6JIuvgX24vvh829KXiHA
         bdC4xmkl8IrUcEimXZ4sTSiKsQJDAFHRJ+I4Y/uQAZGwdjrXKYnVWqdvl35Pu3DRV/89
         qzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv9KifLM1ZDBk9nlj6jVMmyf2A8NWZv4jzme8HGx6lQH8KwlEiM2CjZJ3ENgie2cHk6zhj1NCWtA59ygk1qVo=@vger.kernel.org, AJvYcCVcz/pg+s8s06TNDLh3VBXBY6ZYylDj7VmtMm1FG0GYmYqGKV8B8T7dmgzUrDfmibOWNdEcHboB3In5JBdP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SaNjToctkvUu8v45/kDkf2F+AyanTqXEG8nJsoPSaYO9pGDj
	SjHZbo8KWADJgT17uorI/+lH0jTE4NxxUMdx+4fYvNRj8iZ+vP2T
X-Gm-Gg: ASbGnctRWviJjePaTLRhVuZqYaT5UECDq6oM7Qlpap8ftC6XEyoOkF8pbQ4dn2Bl+b+
	7LWzu4Z7ZMrTLnPFtKMIgsaEbFP44HZn1wmgoIo8e5PugO8YQX5WH7QkMd88RX6TcJ5BVtNLpMs
	SAv5ij2T6v5lP8fUfI62rDFrXAbNA7SJ8WABTe6qN2Z4NmGJ/oWmd/FDpJCyNHFNEFUmGgXIrxX
	IL0h9H5e3Wz1VNK6YzH3aXYUahI7BgxnNj9NlOIi0rMr2gagg==
X-Google-Smtp-Source: AGHT+IFextOpLB62peaMPVxSUM4Vf/kwrRdt37GPMJSkRfLqUHl4ZRrGCQ6zR09dol+Hyg62hPrxXQ==
X-Received: by 2002:a05:622a:91:b0:460:8e3b:6790 with SMTP id d75a77b69052e-46c7109e694mr279888771cf.48.1736789381401;
        Mon, 13 Jan 2025 09:29:41 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:49::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873dd08csm43396831cf.73.2025.01.13.09.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:29:40 -0800 (PST)
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
Subject: [PATCH v3 3/3] kgdb: Add command linux.vmcoreinfo to kgdb
Date: Mon, 13 Jan 2025 09:29:36 -0800
Message-ID: <20250113172936.1434532-5-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250113172936.1434532-1-tjarlama@gmail.com>
References: <gmail>
 <20250113172936.1434532-1-tjarlama@gmail.com>
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
Maximum size of output buffer is set to 2x the maximum
size of VMCOREINFO_BYTES (kgdb_mem2ebin() requires 1x
for the temporary copy plus another 1x (max) for the
escaped data).

Link: https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal:-linux.vmcoreinfo-query-packet
---
 kernel/debug/gdbstub.c | 18 ++++++++++++++----
 lib/Kconfig.kgdb       |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index f88e21d5502a..f2c80bd368e2 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -30,20 +30,21 @@
 #include <linux/kgdb.h>
 #include <linux/kdb.h>
 #include <linux/serial_core.h>
+#include <linux/string.h>
 #include <linux/reboot.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
 #include <linux/unaligned.h>
+#include <linux/vmcore_info.h>
 #include "debug_core.h"
 
 #define KGDB_MAX_THREAD_QUERY 17
 
 /* Our I/O buffers. */
 static char remcom_in_buffer[BUFMAX];
-static char remcom_out_buffer[BUFMAX];
+static char remcom_out_buffer[MAX(VMCOREINFO_BYTES * 2, BUFMAX)];
 static int gdbstub_use_prev_in_buf;
 static int gdbstub_prev_in_buf_pos;
-
 /* Storage for the registers, in GDB format. */
 static unsigned long gdb_regs[(NUMREGBYTES + sizeof(unsigned long) - 1) /
 			      sizeof(unsigned long)];
@@ -292,8 +293,8 @@ char *kgdb_mem2ebin(char *mem, char *buf, int count)
 		} else {
 			*buf++ = c;
 		}
-		count -= 1;
-		tmp += 1;
+		count--;
+		tmp++;
 	}
 
 	return buf;
@@ -777,6 +778,15 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 		*(--ptr) = '\0';
 		break;
 
+	case 'l':
+		if (strncmp(remcom_in_buffer + 1, "linux.vmcoreinfo", 17) ==
+		    0) {
+			remcom_out_buffer[0] = 'Q';
+			kgdb_mem2ebin(vmcoreinfo_data, remcom_out_buffer + 1,
+				      vmcoreinfo_size);
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

