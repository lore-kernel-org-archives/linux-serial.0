Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9A370D76
	for <linux-serial@vger.kernel.org>; Sat, 21 Mar 2026 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774074202; cv=none; b=r0HKvHu+REmF/DW0yO01LghrjbcBuJ8iPkusdCr0uYCNvvTgqXPBeSxGwgr1+GVpDj3NMy2IDsv/DDbRe0cBV+0j/tYtAFNzws+gBHXZJtg22U1HDfAALBGeyfJVDrXjVPX9oVdJ71Ag9KCPF4YLOEnG0lU/FbaTLpqDuAq5R8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774074202; c=relaxed/simple;
	bh=tzcTKnPyjV5Xs4Ol73b4+sOtq45IomqLHnuYEEzr9m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCcYPQIpXpLqqxpafd5yalD/ou3v+uvrccwY/QBg4OxF36CTiIuejxP+JsjKaRiWkES6xLAP+k9B5dUmui0XlxV1127bkp5unruxHGXNa7650p4KShqeii1urHFchVhRplGUufkn/pmBPA2J9Atd7xaKhe5C/hcPbbf4t24iBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpSFREMT; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpSFREMT"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1249400a91.0
        for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774074200; x=1774679000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/ncXf7Uyd8Fgv4CbI3uWeCOjIbbohF3Ht56CY8b9to=;
        b=GpSFREMTr8XFH5DPAi+C2ou9h2G+1vqBnY9sScX82X8aZo3AOfF27SznwA1zu6fI+R
         r0RzgvbkjpZX3oh3bsrWjeubCLyB0RzXy4gKYUyOAWsy527VNwe38wbFQdJhcboJBRy5
         ZbTMQgoL6LtpABnU1Ors5Q7VaZUklK7xYnNH1xwouEadyDw8nRxpNmOtoZtMwwOb7C6v
         B3AeuGd9QCByUH4kViJb2fImWUEOhGVoOYFnTYvHlW6sW5Q9WH4XK3zN32M4K3W3ra94
         32Xi3/8gfX++mJfP3XNvcPDA2J1VY6etjioUrHJFbZNHBMnE00jTWi4HpmTSwZo1LWjS
         t9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774074200; x=1774679000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/ncXf7Uyd8Fgv4CbI3uWeCOjIbbohF3Ht56CY8b9to=;
        b=RIZ5EM7j5ziU97etUl8+MEf8zTEQLQxP6Y4P65y44UmT8/qtcERZVm9fYrnlb/+QgS
         xwHSJ+tGOeLKcJbKz/2kc+nNgH0aDXlmEvMmFAY2fVOgwpSaH1Hnk8xzTQlDOmh9Bh0t
         4ecleYx9ROzOgh8D4pnP0rxMdj3BWYtxHitvproV91nLSDm0GF1uhK89sdAWJIrI2sA7
         fe7RiCQaVqPscTMtb64YoZZYFCLq0JYdKKhzDMoKjOBrlq0bnfbjQrQDiiQO2N1IgSEq
         Gkn0W1rvhpg6rz+zBn5IR72TE2khBADZtkVzuHL/d/TVM2vDKXfTsnR0IZm28InJjjzn
         opuw==
X-Forwarded-Encrypted: i=1; AJvYcCX6E3IXiEHqlsyS4lit/DAmBe5tW9L/n0Hvfd3RQH5zldIE7j+8XQ5dy9TCU6NCGTcV0JR/Ok7/lTp7HqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvQk0+xA7FHsULmlpcabhWmRzi8H0XWoDo2e89Woqe3+B+j/z
	lyYi/8NrHBQVEhDc3t/akRyfm5/FibFUYtJA0WYjuMCYaF5T6pFREvfO0sc2S9rPWbTXow==
X-Gm-Gg: ATEYQzznzIOrM0DF3EiCv/tezEpfWylWQjqmqHDXWjUkgsjuleOKizoPNhUxEcT8AzF
	Gqj7W7x58CPtVzcQvGTLgWF8C7AgVEwGyY/WX11f33cN7PpDbo9JwoZC4w5YnTxqchD6g5QjZur
	lu+NzSXoco8+sA/x/stMh8Z3+zI9wfeXwmnf+s8wk2egVJKelbHiRYHLwC4umihO/lRwy1iaiv6
	HK8pRIY2qIR7sYX52Iqug/YzTSPzeKhBLW6N7TkoQkCARrY3veb8H77z+2noLTBn+I/Crg0EWUR
	XrCw0TqMgDWbz3+kQfqM/ZQurBs4+YNOpSkyoxckiBBZGzmvAxFzwDiJhNO/5c1Y1P+ivbnnmFd
	eiXEwLm0YTd0KTQg7ZZ5xt77sNrhgyr36w4j1KqKs7T60t1iUthfkl0Y+pXINoqLBo4t754z+y5
	W9+BL5mCDkCa1xWM39YidjqMZqcQ==
X-Received: by 2002:a17:90b:3c4c:b0:358:f010:759c with SMTP id 98e67ed59e1d1-35bd2cae22amr4175087a91.24.1774074199868;
        Fri, 20 Mar 2026 23:23:19 -0700 (PDT)
Received: from localhost ([2408:8642:893:d2da:92d:9d57:dad5:f19e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-35bc5ed0777sm7062505a91.0.2026.03.20.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 23:23:19 -0700 (PDT)
From: yuhaocheng035@gmail.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>
Subject: [PATCH] tty: vt: Fix slab-out-of-bounds write in do_con_write
Date: Sat, 21 Mar 2026 14:23:12 +0800
Message-ID: <20260321062312.4290-1-yuhaocheng035@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <yuhaocheng035@gmail.com>

A KASAN: slab-out-of-bounds Write in do_con_write issue is reported by 
a modified Syzkaller-based kernel fuzzing tool that we developed. The 
report indicates the problem lies in vc_con_write_normal 
drivers/tty/vt/vt.c:3141(scr_writew(tc, (u16*)vc->vc_pos)), which writes 
2 bytes to the right of the allocated region at 2634 bytes.

Since it did not provide any repro program or enough information, 
the cause remains unclear. However, adding a validity check of vc->vc_pos 
before scr_writew should avoid this issue.

Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
---
 drivers/tty/vt/vt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6e0089b85c27..95d860f09837 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3138,6 +3138,13 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 			      (tc &  0xff);
 		tc |= (vc_attr << 8) & ~himask;
 
+		unsigned long end = vc->vc_origin + vc->vc_screenbuf_size;
+
+		if (WARN_ON_ONCE(vc->vc_screenbuf_size < 2 ||
+				 end < vc->vc_origin ||
+				 vc->vc_pos < vc->vc_origin ||
+				 vc->vc_pos > end - 2))
+			return -1;
+
 		scr_writew(tc, (u16 *)vc->vc_pos);
 
 		if (con_should_update(vc) && draw->x < 0) {

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.51.0

