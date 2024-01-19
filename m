Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748F1E48B
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704355; cv=none; b=Z9A6wpXrNbw5q7M6PI9xTSWmKq1RfyZL7Hf7ZpWpSIL00pH5kPnjzAebd0DPz5kyWlz7wd6sAVtW4G6Ka2IMxogomFTR2cOHSt/3xitqwx4epVOjpyCR0rwbi/j50xi4Suw2Au5Morbrt9J4awYHLkHNzM2za6iaYVyV3/Pc748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704355; c=relaxed/simple;
	bh=uA4FdWifBIyvvaSzLAe1j5JokAg2Yd8ZAqmFqenknLs=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=TYL+9tAcexsNUKAWe4oUxnNbL/7IkTqoCk7bSBhGpwiS66vMiF2yD0abZT8cpEonVoDP0VD5UJ7b7Ay9Xt6YsvY94MfAyff+z0LdCrOPb3Rr0Jn7hm/xlP49N1ol8ZtYd7Tw+hcjkJsARgaTae4lWbuht62Typg7YVys3cGiebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=v7hoBNwf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="v7hoBNwf"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d71cb97937so10425605ad.3
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705704354; x=1706309154; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=2m1XhtygbnQtWGP2mbVBYdagXNcPKgbqxOJjRe6fvag=;
        b=v7hoBNwfzatVyTIrzBUh27gG6hOIeg/qxyPjdrIrVIyLzgJ1iOWjNlUAgCWIN2xWrg
         pfP1fnfOvio8jMiu0apESO3EKDCOpi7dj12x905G/0p+yNFlzhzSYZwOKfWzn7osYx5g
         nlntyGT22bW1Yj/4vjxClsgHLNb5uM4nt85wI0NeKuZsFxRJfX+V+ERhBJFIvlnQfjLl
         ohKh3gzbOnkbYZC1cwpgn0jPiMZRLvGBu1pdsBq7mUxn9UdUgqGboYgniTQshwVUq1JP
         gJjgu0ROlvDpyUCOhjj3fx67JgL/vlejmDgzln8UqTIsSTmh28H1KkG7N9QVtykz6NlE
         2grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704354; x=1706309154;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2m1XhtygbnQtWGP2mbVBYdagXNcPKgbqxOJjRe6fvag=;
        b=hrfOQIP+T1E1IDOm5AH7vc8eYlraztCWiQWtozOsYbXP9lgKaQDATIV+rz96okaius
         K8ORSZ8OGAayoaC96B2t/bPdX37NajaI2vspxpyXaFpCZni4mYWlGOiowhfaIXik+jDb
         vfcfDB0Yy+PvXqBaGRoPgRvmd0+Iw+vPogAprf2kJ76VegXipQkBRKKdcqIJmnwY6CP5
         Kmoc/LuhK5XNqLUAlnp2kAflvv+891JF7OWrgLDMuNuERuiR5d/JqAQYqCtgNNUt0tCw
         Rwofr1mbgAZ8MRJ1nGiBWaUXH1MShy0HVWgmMph0ywBJ7Q+6TwWzJuS2Qe2eRQebZWcK
         EBew==
X-Gm-Message-State: AOJu0Ywnfcwdr0DTkseKmFrsiAjG0nNrYOK7KVSjLPYe807M+tjIVjIc
	RsxTEYJvl02EJSKAcwM7Zje971sLTgyy69xQyF4Oz8bcVjeSk4PG3OvmGt6Jz2U=
X-Google-Smtp-Source: AGHT+IGDYcz91ZsFkrsdeetEFLWkVDikcqnEMGNi7rrUqJxNwbVFtPK97ae9vNTPyqHIMS90uGoxFA==
X-Received: by 2002:a17:902:6b02:b0:1d4:e2bc:88f1 with SMTP id o2-20020a1709026b0200b001d4e2bc88f1mr582016plk.110.1705704353758;
        Fri, 19 Jan 2024 14:45:53 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902c71400b001d5e2127632sm3525800plp.9.2024.01.19.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:45:53 -0800 (PST)
Subject: [PATCH v2] tty: hvc: Fix the RISC-V SBI driver for a refactoring
Date: Fri, 19 Jan 2024 14:44:05 -0800
Message-ID: <20240119224404.26695-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
  ajones@ventanamicro.com, apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
  linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
  linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I missed the int->size_t refactoring in f32fcbedbe92 ("tty: hvc: convert
to u8 and size_t"), which causes the newly used ops in 88ead68e764c
("tty: Add SBI debug console support to HVC SBI driver") to fail to
build due to a

linux/drivers/tty/hvc/hvc_riscv_sbi.c:59:15: error: incompatible function pointer types initializing 'ssize_t (*)(uint32_t, const u8 *, size_t)' (aka 'long (*)(unsigned int, const unsigned char *, unsigned long)') with an expression of type 'int (uint32_t, const char *, int)' (aka 'int (unsigned int, const char *, int)') [-Wincompatible-function-pointer-types]
        .put_chars = hvc_sbi_dbcn_tty_put,

Fixes: f32fcbedbe92 ("tty: hvc: convert to u8 and size_t")
Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
Link: https://lore.kernel.org/r/20240119215612.20529-2-palmer@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Changes since v1 <20240119215612.20529-2-palmer@rivosinc.com>:
* Fix the return and arguments correctly.
* Also fix the hvc_sbi_dbcn_tty_{get,put}().
---
 drivers/tty/hvc/hvc_riscv_sbi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index 2f3571f17ecd..f8cd3310ef35 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -15,7 +15,7 @@
 
 #include "hvc_console.h"
 
-static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
+static ssize_t hvc_sbi_tty_put(uint32_t vtermno, const u8 *buf, size_t count)
 {
 	int i;
 
@@ -25,7 +25,7 @@ static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
 	return i;
 }
 
-static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
+static ssize_t hvc_sbi_tty_get(uint32_t vtermno, u8 *buf, size_t count)
 {
 	int i, c;
 
@@ -44,12 +44,12 @@ static const struct hv_ops hvc_sbi_v01_ops = {
 	.put_chars = hvc_sbi_tty_put,
 };
 
-static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
+static ssize_t hvc_sbi_dbcn_tty_put(uint32_t vtermno, const u8 *buf, size_t count)
 {
 	return sbi_debug_console_write(buf, count);
 }
 
-static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
+static ssize_t hvc_sbi_dbcn_tty_get(uint32_t vtermno, u8 *buf, size_t count)
 {
 	return sbi_debug_console_read(buf, count);
 }
-- 
2.43.0

