Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFEB19DF4B;
	Tue, 10 Dec 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837693; cv=none; b=ss/4tS65rr+7GUioW5p0+57/5aIdhc66/nU/poTTLLggjVaOYBpHf+YNmru1KLvcmR0D3GULmTiUmbFo4wHI3ChVCRemjrmEnEXTJ9cGml5oRsZUCT4ZUMaZDVW/vo0besAQNBwPx9l4J9dRt2Ploe6E6HEVOPMYgRfBQeGJGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837693; c=relaxed/simple;
	bh=bK/LnE7gV1izWYMHECvFCMWCwCay1mdcdg4l2UtGcYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9z6QpmUCRbFD1r/O5mKTelsheiwpNlCmo1nRwomTEWJ9fleqRkDu3rLFtgBS2UKTSCf0b4Xlg9oZF/8IRHmjlCTxOjXH1J0tiorxwkw1r7MQ4uANTfb/rjV9k3xRrsGZd1MTmx3kuo3oLr79K+toHT6zvXATo2PMkjWrJtB6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd/geRuN; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd/geRuN"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b676152a86so643595585a.1;
        Tue, 10 Dec 2024 05:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733837691; x=1734442491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5g7lXWcRcM3HNMmQpadh/PSrKzcaUKwuppIIByAAAY=;
        b=jd/geRuNu9vjBNfC0RtKXD4f0RGcpxCnVVUsp6S9RmpxxNHPMYWuvOqttRfJIxuQ28
         vWH/euPfW1wuQLIiiVWRX7pWTuMk1u5i5+NCjJ8rDePC+n3OsblyPJB8wqB+SmM1R7qt
         XF6yWpVNCFZ3G4DlZXCSHn1ikr9EolIEB84QGnP48SBaz4TlN6FmRxCmuujYS8b3KRF4
         JC+se5YDeINvBfiPj1HoqRU1Xx4Arn3g2hPGkRWuVz5v1MQU8FLmfFvDpQg3yOS2SMTV
         wewiI+B82h+KHvTo23rM5Z8JJiYLuf0oXoIIixeBRnLtbRZ6i1KeH2WEoHzusKxF23Wh
         gJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837691; x=1734442491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5g7lXWcRcM3HNMmQpadh/PSrKzcaUKwuppIIByAAAY=;
        b=UWUkQzihOAMCMmdLrcLYz3ksM/YwqhwYUQnjNccW2ddmsXLIm3cclMwN99i/4pCd+4
         9jcwVdewFqAtlnAS0O2Cu8o3yGKgW/ytqMZ8c5JxnaA8FZvl0wnPXjZlg0Ow6icv6G/n
         frpmN5JkTcm0PRkEJGoAdbtwD0Vv/tJ0WSHvUf57Tl3SOCV092OLK9Mxiu8EB5Qm+IKi
         w6BwrsTNn6xwh9eu7kMRgrFC5jAbzZU0XWcrxFEM64Mc1Di5xbGiLdVCJ3JQmfJKiVEQ
         uhKk0CyIzbnJ60zZcsGfuE8FJTrX2TV+oij2xqI2UuTiT24L4eltYxLOWwgPndg3K9lj
         BNqg==
X-Forwarded-Encrypted: i=1; AJvYcCWIwMESO2J9wxIJ9qH7jebeVQFuvvAIuCtOG3d9plrk2XOe1tJHAVq+SbXHnH82AOz/tgVRn1bGj/wLupMp@vger.kernel.org, AJvYcCWcuhBoeFc6RXdhW5PhqxUVCy1O1hiACNbFneP+vXfIhBRXt4c4XjnvQRCBrmsE18gLlr9GSJgVhzAEeR5+r+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr06w2Zva3SvXSROYrZ7YqnYy18hvRK00nsfolRIr/12FRE2Bm
	QIAcoRhXPywDusYVfTmJ0i2U4iWTP5uu0xaDYmQSCXYxdTJX5WiK
X-Gm-Gg: ASbGncuN65SNGgauT549W+03cbCNuEovkOxCiZ6b+05YcFA9x9ma4W4eIcGuoRJHWbM
	u9Pp5cH9HRHTftzGTAgC6B/c3ETRJ1dhmRF7lQ0eemLN/mlmMIt8dO3vZ18B9uCikzm50q4XiAw
	r+zA0d9jFl9NLJDUhqYhJ6ubuaL3vad4+ftiz2IXHAzzwxDKXM8qabpZukgkHko/ZgrGSc7J/9Z
	+w5DxqHRipFegpRKDItZzo9tuXFIe16W8lc99P2MVk4Zg==
X-Google-Smtp-Source: AGHT+IHsdEiFcBMVLE0Xz056LUrSy3ouyFjrlQjCQuYSqZnp2QaRfzRg6kBsaPvDj6TPb9vHkWjP4g==
X-Received: by 2002:a05:620a:3951:b0:7b6:d241:3f07 with SMTP id af79cd13be357-7b6de732d58mr540119185a.15.1733837691072;
        Tue, 10 Dec 2024 05:34:51 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:b::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296fe9bcsm62098551cf.51.2024.12.10.05.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:34:50 -0800 (PST)
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
Subject: [PATCH 1/3] kgdb: Add kgdb_mem2ebin function for converting memory to binary format
Date: Tue, 10 Dec 2024 05:34:46 -0800
Message-ID: <20241210133448.3684593-2-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210133448.3684593-1-tjarlama@gmail.com>
References: <gmail>
 <20241210133448.3684593-1-tjarlama@gmail.com>
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

