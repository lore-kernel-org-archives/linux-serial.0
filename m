Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA141B1D67;
	Mon,  9 Sep 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871377; cv=none; b=Cf641wfp4b/KMzGO6uK5AoHxugqXbdhvsOjiPcyIgerEF+YVSkT4/osffVinMDO9vzK+vbVoiclktgi+p3oFXZ6MdZMQM2yDcKKqmyCW4YA3ZRdDJSkicrqM5PhEz3Z0DMgXEvnpAqAPQO65ApfuX5c+9pL9m3OrxVNyLqZ3ZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871377; c=relaxed/simple;
	bh=VWXmO1RyWUyhWh2dn59RYX/QZ88zhjH3WSnJNNQVVnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXpthfO9HHJRKfUIdmBf/fH2aJpQ52Rxb2XhHjLfi7JdOaoEKOl80A8N2J1vKqXHPnzdmQtOp7GIkFqGQ96EP/uqRW8YzxyITXxTxKSejtD0maaRQoBoUNEsIXxg+vWJfROnyTDhS2NqLdV0LWQt5kL8RRrDON568ZhZGni9peg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRx2//bK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRx2//bK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206bd1c6ccdso36197635ad.3;
        Mon, 09 Sep 2024 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725871375; x=1726476175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSAWxbt/KB3N4v3rcDblPZmbY76AbUJCwly8u6qq48k=;
        b=BRx2//bKDXOT0EOli4y8CJLrUtMKQyDzIxIiwDK6XqLvV0l1MaggpLSd8qqiApVsvq
         I2Xw01rAqGCfPc8iJuw2JipLnxvhq4cjI8s51lSkSGLHFnRLGbzIT0t6SacF0IW6rEYk
         Zjr+UzI/o3wsbhB9EWoDdBhbjCtHO647KyPZM4ZuDcjxRjCiaTuCcS//qBpE2eSf0eN5
         eVrWvXUQSqCAkKaxXzY14Zyih5r6Fl4OHu22DaZQ4qySqTlgwr5yPR80QjfMMGYt1Gpb
         NCp7WvBVAK2P47T0z6UIsUggjA/wUmJWgL+5hkQzEaowXmXRlOi5+5LlrncoA/LwBdY+
         grpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871375; x=1726476175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSAWxbt/KB3N4v3rcDblPZmbY76AbUJCwly8u6qq48k=;
        b=mL3rQ9nz7xllRfeNdd78lZ/XxxvR9Y9RkwpxIhB02K/FhBW+U/+KYEaR+a6BqDWrDc
         Ej0M3v5J70juGv8LwR1PUN4MqgRS7xXyqoNP6gRN2APqAjwkbIFAxGqhh1QekrIC37gJ
         ASYXd+m4zQqSsUhqjUd5Fl/iyYz//GBlhuzgD31SjltgbK/z90GNADkQ3NUYlFccbOJA
         mK8K1zF2gH2vyfhPyvsFB7byeLy4A1Fnnsx1hIenAOgApMxAY6wBq0DSVGq0PPleNsCM
         xR8dI5sk8/E5WUWTEgp1YhHHiSx9rNEAFI3ioQ8qtQmXP8oT3QrjU4Y/7BlNoTy1tRLh
         Hrzw==
X-Forwarded-Encrypted: i=1; AJvYcCUE1r4hpkvGEa01/zHswGjNUtLML6b6Wc6v6w6AR3Tk9AM1jQa+dn8/7JvnLl79p0vnHoUNkalJJM7DZYE=@vger.kernel.org, AJvYcCUaW528SQcdxyWCEvk1NwmN5DWBG5mduqQEzCw3NHD0a76rD9dx8wZqqrXBoaiC4ApMLcRcicqdvHILS7k4@vger.kernel.org, AJvYcCVZyOP5dZasKQIoQmFxDT3wURjk19HuX9RYnj8WEozHi6MN63dZd7eFrkso5ogF6RwDUIPImuhRHskniTgchqslAnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5qF42P5NCBTJ3zkU2YXs5HJ0dKxnNx85rUhJ0cy2QvxjbXE2
	5cYFEs5gkIQUY/Kwy0hMoPvrHn/+C9/mwfWzTPtEF8ADR5YmUovU
X-Google-Smtp-Source: AGHT+IHiDYxp2luZ1A4jiUkw8o2xWduuxjjGAFTCAzkleRs2eiF+6NUWiZjUn6ZHSoKHqp3vyv42cw==
X-Received: by 2002:a17:902:ea01:b0:1fb:93d6:9fef with SMTP id d9443c01a7336-206f05f643bmr99589505ad.38.1725871375038;
        Mon, 09 Sep 2024 01:42:55 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710f1d663sm29678675ad.188.2024.09.09.01.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:42:54 -0700 (PDT)
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
Subject: [PATCH v4 1/3] tty: serial: samsung: Use BIT() macro for APPLE_S5L_*
Date: Mon,  9 Sep 2024 16:37:25 +0800
Message-ID: <20240909084222.3209-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909084222.3209-1-towinchenmi@gmail.com>
References: <20240909084222.3209-1-towinchenmi@gmail.com>
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

