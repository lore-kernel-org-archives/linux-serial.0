Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033212AAE2;
	Sun,  8 Sep 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725782378; cv=none; b=cS2cvQ9yA8OIKMvo/nfkhgbr3u7P7eFO+HEuwIYhqkmXSWTcUETEEqRIy40VWKWOakXO5/lTDHXX0IZh6Nlkjyz95h7OmR+uicKWVKva2hvZT9yb/6M1Lo7S7JXehiyElUWbg9s7r+1r5Dicd2MoyzivWP0bn449396Uy982sI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725782378; c=relaxed/simple;
	bh=VWXmO1RyWUyhWh2dn59RYX/QZ88zhjH3WSnJNNQVVnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyn6YNChsk5AspZvWUg17fkGWQaKGoweZ0LDj/vfGm2GeNO+p0C+zIYuEBSaJRXBpDAf0ToxlU/7b93kHbteRi3tz/XXA0iaBf1xKuYDNlIUEbej03tSsvITcbb6z6Ur3UD77sQN2Aazs+vWeytp99+Mx2PfWbbNkoT//jHY0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyJzVmZf; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyJzVmZf"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e0379a8d96so685386b6e.3;
        Sun, 08 Sep 2024 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725782376; x=1726387176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSAWxbt/KB3N4v3rcDblPZmbY76AbUJCwly8u6qq48k=;
        b=YyJzVmZfq497HkdkLzLmxA+mxNdsvNmZQiA/7D1HJxl0S2TejTyyl/wZosqYz2xm6m
         wMilpwpVR6vBuiyIj2NlECOJEoacf5T5ptwI6shZJT1y5s8rnwOjfvHy5Jzk4NWq9seJ
         5FP8apHuA+maF1Aau5uScm+3Ol44A/M9InBKacvX1M/r92JEnmk5Gk/7I5nwVUfgKd02
         MBtkJa8nvmOIb2xl0uya5LdhxTvN1xsSAQFeeZbH8b6g5+sSquaMWyV5Kj0W+3Ahc7RP
         TTlneQkMxqaWyK/UPF1apvEpOGyH4hV4OGmHrpKc0Osb3qlSPr5AppsxUFEZRg1G+1ex
         Q5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725782376; x=1726387176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSAWxbt/KB3N4v3rcDblPZmbY76AbUJCwly8u6qq48k=;
        b=bLzL7gaxveVJEufWsAO5uf8MNz1it4TYaTkXsgJhHLUKhuls9g0TpfO0DWCLtZXgB5
         I/6fC3Vsyn5Y7Iuj7feN8TeWapRogFNBNZePN2D75JgZ1wB+H7t0DUZuY4dyersSy2o1
         60IdUDITg9wMjuci2qwtLmYN7e5DfnuEk8PXP8AYy+739C9cBP2LMy/ciJp3T7pFGp6Z
         BDETAs4lH7x19NlIeunEblKB/LWBsZCtK+rs7xN8AcAB1AUx5jX+1R+QRD/EUrNW2vi4
         N4v7L/IXRMfpdk62jzV31Izybl/g0c2MYNxj8OPbvZQrsGa6OUbdfMYXfQIM8N5dcG9e
         ZFIA==
X-Forwarded-Encrypted: i=1; AJvYcCU7/npPG5OtjO1fd5o0vU2LWvJ0GUQJHSI3/eMsGrJ9FkY2MVgYcoGZS1m1TTqATm2vGG2hMiXuW+W39YsG@vger.kernel.org, AJvYcCW67kBMIDp+xNh6tdFDo5XWPT4hG35fNXkZym/D2k2HnOnY3VvWbZMG4jA3P37opbfTwk9ov3TkSNlAU13ovE7rV6M=@vger.kernel.org, AJvYcCWrI2+bpgk/ufT68QHa67Obv+MRI40vohyCRt5fr6pAxVv3zCL+mT9BCI77f79IVU01zxmv/qPmiu+M4fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8D1OIOIOuw0oNklB9cS4zqkheky9wVCnhrEf7tyiv7bggnql
	IMgSGkzCPZV9AU+Ln7OSbSLOTkxy7UBkbUS4eSBBRLVP4xuuhMBEUfrE7L1n
X-Google-Smtp-Source: AGHT+IF4X47dLoffOVVo0BcLEvCjOamHYwwrqOfcrpE78LRYitbuMjUJoZKkxWLK9tq8v1Y0uVOraw==
X-Received: by 2002:a05:6808:4483:b0:3e0:4044:7199 with SMTP id 5614622812f47-3e0404472b2mr1298829b6e.16.1725782375953;
        Sun, 08 Sep 2024 00:59:35 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7d8255dc1c6sm2012690a12.68.2024.09.08.00.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 00:59:35 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 1/3] tty: serial: samsung: Use BIT() macro for APPLE_S5L_*
Date: Sun,  8 Sep 2024 15:50:48 +0800
Message-ID: <20240908075904.12133-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908075904.12133-1-towinchenmi@gmail.com>
References: <20240908075904.12133-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New entries using BIT() will be added soon, so change the existing ones
for consistency.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 include/linux/serial_s3c.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index 1672cf0810ef..1e8686695487 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -249,9 +249,9 @@
 #define APPLE_S5L_UCON_RXTO_ENA		9
 #define APPLE_S5L_UCON_RXTHRESH_ENA	12
 #define APPLE_S5L_UCON_TXTHRESH_ENA	13
-#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
-#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
-#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
+#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
+#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
+#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
 
 #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
 					 S3C2410_UCON_RXIRQMODE | \
@@ -260,9 +260,9 @@
 					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
 					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
 
-#define APPLE_S5L_UTRSTAT_RXTHRESH	(1<<4)
-#define APPLE_S5L_UTRSTAT_TXTHRESH	(1<<5)
-#define APPLE_S5L_UTRSTAT_RXTO		(1<<9)
+#define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
+#define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
+#define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
 #define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
 
 #ifndef __ASSEMBLY__
-- 
2.46.0

