Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34619CA6B;
	Thu, 15 May 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296798; cv=none; b=BpR682kyiNjOCZs8MOBZbzu5XzBHavHuD0qkBwbjv0qt44AHziyFVTr5PJflLE46dtjsvztYShPo7N/8ciJUrgBBx9xHBNrKrumn2L6dl5Xk3l2CgMdy+oH31Yx3BXtveb2IjcgwcMBpQxBKE5KAxLgUL062fdrvyUjzWIjRwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296798; c=relaxed/simple;
	bh=DxyT6W9hw+QLqH++O0m3qf0OogpXov8SOzPA1UQb8bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VjHTken4kTdAkin4wxI9fQDlwcs1lJGzLgGsrSEtMNCLtOfPlYBqVEoHxJIfyYWURqqWxAPe4MYBPsFZc9Su1ddDyXNkCqthcNX4MTXhoOdQcxnwAASmqRXTFF4zXp7TwZL1zmr5NrzcrCsSMBpGfKJbT70kOqkKKcBiVPcQ13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEl7eCgo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEl7eCgo"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c277331eso1580496b3a.1;
        Thu, 15 May 2025 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747296796; x=1747901596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pva8j2GZFLttdtKxinE0hP/DJHkfs2IvbbPFLofHyZ8=;
        b=DEl7eCgoTu0Wy07J3lCuUaD3Gkcgzmg1iX9Hdr6u7eOPrEVrATB7ZV1v48M8OAgr2d
         hL4tJoKnco+4+98yt9I9QgJxvZYpLxMFaLa5jKu7KOFUo0KWNZmnKapq+jv8iUKIsRSX
         ciULcSVoNBlABOQ08PGGwues2o+Vda0m3t7JFiyrYgfWpVKh0PX9PYF00w38KPNxslDK
         ScOQHxMhwwdGtRd2h48kBtEEYfV8WAn2UddFz3s0HAQiwqOZ/gQnf9bzaaWsxaYFc6tK
         p0hF5moY62hl91yvR6npcoCCW3r45aTuoB+6SBgRbSEgwUqmr1nbkZg+sE1L3jTGiBbh
         VbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747296796; x=1747901596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pva8j2GZFLttdtKxinE0hP/DJHkfs2IvbbPFLofHyZ8=;
        b=PUygdATxy+lPv6cGPdNfEold/Tvkf/f0bJhf+PSki5wSELaDVG6e06jog0jz4P3DyD
         4kWPftqzrNpeNqUAFYAcoY3lYCvr/+syKvkor466sJUAEGPtzF42lc3wjjTK7s8SybKJ
         SZ4zH5zsh5EGuQBIgUneXKQn9nW4rPX6fMnDt6xgPJKtgUnTTXkWxGCa5eYPNL64UiF6
         qGYcKMXABOaaLaAI4Pddl7pZHbncQiWXYvSj2Kyy4d5u0RcDaj2UDgAzlDdtTPYkqvkw
         vIz/Lm1JVvUi+wnk9hLb/EDPG4r+IzTOJZ9ScAPh/u3dy+37FTb6JaivqGLTmDjE+uk+
         GUQA==
X-Forwarded-Encrypted: i=1; AJvYcCUUwl5GxWgZdKAJBkSNRxBp6Wb6+FelxBOvGgN+5tXNMU7NAsjOTn0o3Y+TfEgqmSzc/aZ6Koceh7wH8d8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4BEXF9UGX4pyFKaiS5hMUB3uDeC8k+riSGb6ty5vLi2SjynYX
	aVIAbxW4MRnVtiMthYqphSE5DqJonMKR90vgfn5PVqZCGlFqAwMc
X-Gm-Gg: ASbGncsx9L0AlMiP04mFMZLVEwkTvz6pdXIP0K+DRHAvJoimOceZchEDktE5QGbYl7N
	Fr3mYNxXjiv1pTJGdXWT+TK1gooRoH6afwj1kwxA0sMLO6A2qxmrBgGT3zWyN+mybjVLvbQnc0G
	WbrJBU8uBQOlOTKFdkzn9yjyRy67BbPrgtT/RunyNxmvLU9u+V99B/7eyrlxeTK3g87KDtjUM66
	aIUYyk79eOOMIHFuZmuSjRRUVz2e28ECdBP66a9R3k2jkWTJp1NaZdaDDUjdwJfLX5fnTvT+3ZT
	Flv0ZZ0a8SJ2Eabq2yGe3b9RYaRkMTqNUtb0GhP+0+23p1mxMkMnoF/NNm6UGZuFA4Mbxo7vKKP
	ah9RAhA==
X-Google-Smtp-Source: AGHT+IHpxEDG8gwBDARRHS3Vz56j9VlacquoxXwyhH0WsZwqbL30t5Q3hYEztXrcC3PUqwMY4AwpIA==
X-Received: by 2002:a17:902:f542:b0:22e:23c1:d711 with SMTP id d9443c01a7336-231b399df70mr43125495ad.16.1747296796237;
        Thu, 15 May 2025 01:13:16 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82a0fffsm111215775ad.224.2025.05.15.01.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:13:15 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH v5] serial: max3100: Replace open-coded parity calculation with parity8()
Date: Thu, 15 May 2025 16:13:11 +0800
Message-Id: <20250515081311.775559-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity8() helper.
This change eliminates redundant implementations.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v5:
- Dropped changes to bitops.h
- Switched to using existing parity8()
- Split parity8() conversion patch out of the series

 drivers/tty/serial/max3100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index f2dd83692b2c..d28a2ebfa29f 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -16,6 +16,7 @@
 /* 4 MAX3100s should be enough for everyone */
 #define MAX_MAX3100 4
 
+#include <linux/bitops.h>
 #include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -133,7 +134,7 @@ static int max3100_do_parity(struct max3100_port *s, u16 c)
 	else
 		c &= 0xff;
 
-	parity = parity ^ (hweight8(c) & 1);
+	parity = parity ^ parity8(c);
 	return parity;
 }
 
-- 
2.34.1

