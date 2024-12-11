Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9921A4F22;
	Wed, 11 Dec 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931600; cv=none; b=BAetw7shd4nTskt7ZmaTJZ1l6I2wu3psc60Ykhfq3+ztvX5tlOWj7A8t48NYErIxitRmQJUQpd82LCeJDLtteCxi+Jza4dRirf9HRVVWM0RQ7+8u+2cL+m1YkNaR9orV+IPT+XVQdnfgqiHF2v7nejTVQTui5dyznZEsqbnKcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931600; c=relaxed/simple;
	bh=bK/LnE7gV1izWYMHECvFCMWCwCay1mdcdg4l2UtGcYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8KY5mYVN5OqePXq0eP+PC3T+LN9brAXs4aZ0OZtvoiMT8pCBF3mZ5UQDVDQ9bRTovnrCorrEtdpY7jfpOkVDxCRZ6E9uSfiDf12LrUHJXdnv2xY2lJNG09IsvfYbHuy/iGxrpRPMlNqxj+0uxveI63lv8zRPAULjXQee3Ncq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB49Zi80; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB49Zi80"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4676e708aeaso26088781cf.1;
        Wed, 11 Dec 2024 07:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931598; x=1734536398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5g7lXWcRcM3HNMmQpadh/PSrKzcaUKwuppIIByAAAY=;
        b=bB49Zi80MZNywcl176hYpapwbBk3v6G7N8RdXHIQQs97mFMLG0ddUN1oRmmpCbwpba
         bWHQl9AkNgrZpSujZybMzlXkXkEhrcyXGLVDIt0cSTkHGpOb8S14iMiwKC0XlAWAmmIR
         F6eAxZjfiSR8a6OxPkuQq4rsHCKrcNPLWs901nVJ5FD7A7LiMzrO3/3PPxy3mUtGpVrp
         DGc4P6Dx/jMwEav4tk/qXNlJC4SnBSyvR9P0kzc8awTXt1UNa0uel9MBdvSb61C7Y4zR
         Vkf6HwVUYRO+6NLmKciBB5syRDPswmqmdJTrWPWgF3bpqThutFHypshU92yjy8JsovUT
         KMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931598; x=1734536398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5g7lXWcRcM3HNMmQpadh/PSrKzcaUKwuppIIByAAAY=;
        b=Mls16sz1j65KbBOVLy2YdcWtJQOLdbseFXyEvvxGVs89W2Gb/c7y1kIm/hNQlV8Kgj
         VqR/UyMZLuWMe0iI/oOXI8cH6HoBDUSfBbd/OCHKQQgv9PVUS4V+KtShKLulihM2wuiK
         hH3eILf6G1hlv17pxp2rgGLjbdFzHWnp0/aNbRao7lf65R/+mrC31Bx+YabKt6lz2UjE
         X+2GpNrVMmgogtDMrqaHxWTiFKA8a7xthJlEAYcoQQtjksr2MFQ3Dl7EQFOy8yczySyI
         DDCTTfDDfncPDLa+6vOtXS94fowxMYAOsA3zK8nTLHXM725YarjZ4S2m3SHKP5SeCDQM
         VVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq9aEklDEho1Au2ZiPpSfNUQlMqc9aXy2ye5Ox4QaF9VmERObMdQ4xm+GJfpcpL4mvpJwc6vZRsjPBGm8BRFw=@vger.kernel.org, AJvYcCXmg8K/E8b5WgjaVWZH/yFlBycpCPGoreArXuwQU/QcLbO5M86mx/zTAtGLfYPpELyAs2r99eNOf9OhBaYR@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEyvyv0YXN7FNOwuCEchNyanh//NKnfic1ZTmT97PnCwYietY
	Bz+Pw0KzsbTfco7c3RnZuqOhsUs1k1cr//G1b+Sqn6jTzi99006U
X-Gm-Gg: ASbGncucBKn4knJ0LSrdjpye9rQOWqWCAFl08nV/qG4zIXk7d7tOieuqIBmeHszxTAP
	g71cuUWEnWpwmirTJHDUETpB/hcXVyDckwJrz/qinbBTqVYnl+F2bqmiLQMnyrnIAUWTdxelNQM
	Hl0qH+hUqeLN0JgQ1gJUCSgJ+mrFs8IN+YdESpaVakFEWpQ/tUFvFdOKfiQvHoy5coQOCSy2Bss
	TNEOdbg0/dtIv8Dwu/HNZtB7mkN6DUf8LLYGTDbUjVQ6WM=
X-Google-Smtp-Source: AGHT+IFFLNsQdk6dvD0dZBjIsUu+IjGKHxOJT/DadpFaifHqYZURdCbfbL+/qV3TIxCfAhTl4mu94A==
X-Received: by 2002:ac8:7fc6:0:b0:461:2616:84c3 with SMTP id d75a77b69052e-467892a2539mr63734041cf.8.1733931597600;
        Wed, 11 Dec 2024 07:39:57 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:13::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4677fd42b1csm16184971cf.82.2024.12.11.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:39:57 -0800 (PST)
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
Subject: [PATCH v2 1/3] kgdb: Add kgdb_mem2ebin function for converting memory to binary format
Date: Wed, 11 Dec 2024 07:39:53 -0800
Message-ID: <20241211153955.33518-2-tjarlama@gmail.com>
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

Add a new function kgdb_mem2ebin that converts memory
to binary format, escaping special characters
('$', '#', and '}'). kgdb_mem2ebin function ensures
that memory data is properly formatted and escaped
before being sent over the wire. Additionally, this
function reduces the amount of data exchanged between
debugger compared to hex.

Signed-off-by: Amal Raj T <amalrajt@meta.com>
---
 include/linux/kgdb.h   |  1 +
 kernel/debug/gdbstub.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 76e891ee9e37..fa3cf38a14de 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -322,6 +322,7 @@ extern struct kgdb_io *dbg_io_ops;
 
 extern int kgdb_hex2long(char **ptr, unsigned long *long_val);
 extern char *kgdb_mem2hex(char *mem, char *buf, int count);
+extern char *kgdb_mem2ebin(char *mem, char *buf, int count);
 extern int kgdb_hex2mem(char *buf, char *mem, int count);
 
 extern int kgdb_isremovedbreak(unsigned long addr);
diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index f625172d4b67..6198d2eb49c4 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -257,6 +257,37 @@ char *kgdb_mem2hex(char *mem, char *buf, int count)
 	return buf;
 }
 
+/*
+ * Convert memory to binary format for GDB remote protocol
+ * transmission, escaping special characters ($, #, and }).
+ */
+char *kgdb_mem2ebin(char *mem, char *buf, int count)
+{
+	char *tmp;
+	int err;
+
+	tmp = buf + count;
+
+	err = copy_from_kernel_nofault(tmp, mem, count);
+	if (err)
+		return NULL;
+	while (count > 0) {
+		unsigned char c = *tmp;
+
+		if (c == 0x7d || c == 0x23 || c == 0x24) {
+			*buf++ = 0x7d;
+			*buf++ = c ^ 0x20;
+		} else {
+			*buf++ = c;
+		}
+		count -= 1;
+		tmp += 1;
+	}
+	*buf = 0;
+
+	return buf;
+}
+
 /*
  * Convert the hex array pointed to by buf into binary to be placed in
  * mem.  Return a pointer to the character AFTER the last byte
-- 
2.43.5

