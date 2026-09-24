Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B49470139
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247848; cv=none; b=pKBLRmH4kN1WAW2DD/ZXxvCUZ3cC9XMx/nv8Tv/QMzcC0BbCVGzgkroQRN5jmg839TBf/jrzOWGwtpk2dtlgxfp0kG53WutmG0uc6cM5hYZCfll9/kN/HxBkXW4HTuUXTwD9bJH5iXhLiQc6lFFodnOTpY1+1kBRRhQl7PPzQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247848; c=relaxed/simple;
	bh=7f7KgU8ghEm+ZsQ4Wsyw6XqLTiDahmNcP4zN/LWSayk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaJFWbklgCpkhkOOLlM5KXSPCsw0HNimaSwxMSiOQH9QkiTjRoyI8nSAxEdyN9Ui+yNG4JnFeqibZZrPGFIXvcEyrPE26xb38hdyXgMVK6mJmitiS3ZBO4MnVlLc4yMobjW9XenufqiuGvgSb4Saug2k6sDP3E+x7yyrbox9Ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH/OkfUe; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH/OkfUe"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469f204f6so961693b3a.2
        for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790247846; x=1790852646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MSWrvTJhaw4ng9HaxkyKXVaI1YO7DDOsINRc0X8/7pc=;
        b=aH/OkfUeiSP/AqySZOOuIUh4wCOPS0dsci2J4Lnz3PCb4qjFOfWc6m4ADaW8g2Izy4
         kDlzmDv6mHwtSKhPa+6NNDtxf4dsMQaSAiRVAE1A4NlxVOdsYyxMw5X0rO3omD8A6Tmn
         F928VCUbniDnAoZ6/v9ZUogp2hYJKJskEDE8PZlN5llcng4koh0gqrLEJSqsTWRDmxYE
         T97k9jC33zhak/vedKxyUR3Lm6r33kpDYE2vvyDqpy4t3Kx3rSoh9uQPjhYm06fySScG
         GHJS81qY/AH7yfKMKniMzu/ndWcjtXZMumxncudwGRc88C1Prhu7zyxOvh7CEVi2mVCq
         E39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790247846; x=1790852646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MSWrvTJhaw4ng9HaxkyKXVaI1YO7DDOsINRc0X8/7pc=;
        b=Fd9tbxKO+Jmp/xSXWBgkHx2z33357gtevBzz4AUO5FIqqanWX26DsobAT1MVaHRxxr
         EOF/SZDlNztpo83TW1DjCVOEO2IbJEFndOyZa842+5XimBEP8BEyQGXO5Ssv3g8ysHtL
         U8fcDE607UZ/8fgWVtnXow7rlMqvjnCqzUjp+4vjp9YuzbX+htIjq4bFLncDYf+BRGCm
         BtuJai6mxY3Yilutwc0aTjGGO7zlpzmnmODBoMeEFRqc3msbhmyqBTv2x/54JAihPAob
         48l9CldLJj6IIHRKIOgmflHWDC9SdrEvKp4Bf2Qxlu4sb/egiDe5PLlT1N5lX/cvn6fn
         dnLw==
X-Forwarded-Encrypted: i=1; AKwUvBx/NLx246UTWgQ58Tmqq+t9mx1p3CoAQnP7tSeSptPU/f0FVsPTq4n35XyPE14yTGFg+eJld7ZF6+IC66Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lXI4vvT14DIwBRg81erRJYF4kjeDcNNrPv6gUAtxgSkIB5LDus
	qYOf3d3q9scuNln1nObDtkEfFEuhTioCWaB34EW/1fPUTvQaQu4HlfTN
X-Gm-Gg: AYBFou3yr7spr0GHX7eNZFHBzbWdFWtwMl+5NMNmcvsET1jdcerGTEeLYllBfqLi0HG
	jS+t3mDgGlNcRCky3+ABScY6A7A/qT8rpGoyJHeGeL1D5VSC5jVP30NvTcYzwvmIpvveQhib42b
	XR/TjD1/tigfSgg9/HS+xT7zMwUMF4fsOysWeyLzzvIq9t8bftkenzJGx2MAD4aQll5l+oHxMv1
	WXohZ5ddc1eJYfgFKJ3Y9DGiIIzQeeU7mUS+U/eX4A1w2bOazWPc0i9ZRsiitd5abLRWnj9v/i8
	/VDQI4bJPP/JCOzGX4DtvUIwFnJfH3SMqVS5aUy+CpyoQfv4rTrczAqQETTtNL1Qoqsu98EqVqD
	tIw8leK0hE0KIW4PMTPPdNj4g9YMkhsg0ZtzAkzrmBLEVCDuwkj/XSZbPhGicyM0SPwTk9LsuL1
	s/jocViHK+5eAk0xdzmsyLODc5eeVw1C7t/shCoO/vnhzLcSBONv2lfw==
X-Received: by 2002:a05:6a00:a244:b0:874:708d:b61e with SMTP id d2e1a72fcca58-87e9b6a1475mr1819911b3a.28.1790247845878;
        Thu, 24 Sep 2026 04:04:05 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fbbsm2751981b3a.52.2026.09.24.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:04:05 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	lgs201920130244@gmail.com
Subject: [PATCH] serial: ma35d1: unmap MMIO on remove
Date: Thu, 24 Sep 2026 19:04:00 +0800
Message-ID: <20260924110400.1556396-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ma35d1serial_probe() maps up->port.membase with ioremap(), but
ma35d1serial_remove() does not perform the matching iounmap(). The probe
error path already releases this mapping after disabling the clock.

Add iounmap() to the remove path after clk_disable_unprepare() to match
the resource cleanup order used by ma35d1serial_probe().

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/ma35d1_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 920fe7ff5083..e5eaaf154911 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -770,6 +770,7 @@ static void ma35d1serial_remove(struct platform_device *dev)
 
 	uart_remove_one_port(&ma35d1serial_reg, port);
 	clk_disable_unprepare(up->clk);
+	iounmap(up->port.membase);
 }
 
 static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)

base-commit: f03c39de3a1307371a4032757cd1732e91087c7d
-- 
2.43.0

