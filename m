Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A321D3DF;
	Mon,  9 Jun 2025 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749512152; cv=none; b=bHUfPd9LudC/2J7Bbg2wgSiBz3ci4EM8tJZEsU58Y7olaDMSyyUwv5p7KxL+M5IMuhWMbisoVfiAe0C2phqpy793+4yxo/duzA/9XgPQsQE657Tph9r5ntZjUQ1mENgS7hEg+r/h/6qc5Ls8ThcWM25nKS10AQoVbECtDY8K+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749512152; c=relaxed/simple;
	bh=w/GL+mj8bQYIANGl3yIcT+DA7Bds2Z69Os710eHh57M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQsGnUGBgcwdWbwjhovd/JqGIZY2DL5l/zW6gAjDbJACwqLjsnWw1obgD2TGnejhBpJR65/eB8tpPVeopp3j5IsYklTdmOpJ4Jx1D0vHFmGsVOwRmzZMq+0Yj9BRxFht6bQSUBtux/FUyHK/qPf04NdJClyVNuulYkwaRDkwLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvUFdhwg; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvUFdhwg"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8a70fe146so93316126d6.0;
        Mon, 09 Jun 2025 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749512150; x=1750116950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4VuZtE4rUm5jy4wnNJLez49lBHWyhH0Dn/21RvXZ9s=;
        b=AvUFdhwgh56BA1Yi4vPJlktwiRF4nV8DMdTfxelxlUpTWOeelr2hktwF9j6YkX+c63
         zy2cDNuR1BKjpawl5bj79rIh9GAEee6rluE2BjGqAZi7snWuLrBy/5yLDi6Tz+XJzqIZ
         SX3xJtDCcFG3IDEAXp/oFQuoNZodToZO0m9rq2lWUJrIH9IdI/8lSLQrxX6/tpiUql5P
         pQKAYn/lcWFbhx0DK1sYOGP67pg37pf1cu/THjgf0NCRyES4tVpHOM4LrcZuv93suJZK
         vblGyggLI++/YKUZCF4oulcM/s3AhRc7oUhgNadzLYaXtCKAHWBFG8DSzUhu+2SWPXLF
         maIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749512150; x=1750116950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4VuZtE4rUm5jy4wnNJLez49lBHWyhH0Dn/21RvXZ9s=;
        b=SrIoLgBS4yKBqmTP6Z/E6lBHt3euZG0u8lP9zjt1K9m9XOxFWKrh0b3zo1T7I1qpaF
         PhuOB1zcQye0jHjnAsRtqvYGtCZ6w2Rs/4Oy4/z4uiMUTUlpVa4Bos/m9rYCqHXUDRVy
         vyv+kB4oCMQYsYqvmhIKIxzH7oHJmDyhQU++MTlJ5z/Xd0hHy8wV4DGb2HT/jEEx74IY
         99xVg2iXYbxhgMkx58psk+N9kp/+gBJZDqUkTettebBbhL7gIXbwmK0rzXQZX6GxE/rD
         z+39gPEchCoMOOeaDyf2fkw4zK2lAQ9A4RON/e5XlLo4Cz1dfJchn5zbvJ9SZUWaBip4
         32gg==
X-Forwarded-Encrypted: i=1; AJvYcCUfdRjOwYVmfuIP1VbSKgiWxdf2mBlS/kb025PYVECibAqqi0GurNHm0PNPbmKxWOYsgibIXHl1ogJAJpOB@vger.kernel.org, AJvYcCUo9SnkOY8QtK6k/NqmWtQr2AO4ltvnVqmzcc1w/gTBVIv4MsiOT72Bwyl8SRVwWIb599lGcy9V00cR/oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXtdyX1JewdKkIJBREHfGfxp9+AW195NVSAT722U83M4aucjM
	EWSpra5yfwTHBXgc4knQF+WKXVOVTyhHBYpCvyDsVxtBouCJQBRqDT2f
X-Gm-Gg: ASbGncvRFjg5we5JYhFwe23oL57NoqNNzF45sF/8oJkVJoSX1/Xx4GpYhdi6J253ALO
	SDF9pkhsdzbd2N2FbjAQHXtQrakMzduJyr5083CA6m3ynSdJTYJHkm7SgieYqwVcCmW1PpnIRS8
	V+O6f4p8hErFg15OX9DWv1cGmBYTMBN3A8XTQMd3HVxkWcJGr9yXdP0CMufS4GkiDvgIzsyKtty
	xhrHzo91BwxeLEajkyDFK6V77q6fEbzuO7OlTwBmQ3+14QP2z7CIPVDbhw33HSa74ZqIUZAehc9
	1d4vWQvH/sKQpf6xQGzNx/HaTk/gz2A3mA37WOeloF5O1IsQwVZyBl/Mq3qJOd+8vPfU30E63QO
	UM6E10+MoKPZkYt4ht8vIXrKFnw==
X-Google-Smtp-Source: AGHT+IFz3oc1IO+Bv2N+B84/4uhowwz5+aJ3yZ6Ch3vSOOb2rKvZtBlRDFcAsM21zApr0U+brrdJQQ==
X-Received: by 2002:a05:6214:c2f:b0:6f4:cdca:2a6e with SMTP id 6a1803df08f44-6fb0906fda5mr253760046d6.45.1749512149883;
        Mon, 09 Jun 2025 16:35:49 -0700 (PDT)
Received: from node.. (dhcp-24-53-249-184.cable.user.start.ca. [24.53.249.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d2518ee8dbsm605781085a.18.2025.06.09.16.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 16:35:49 -0700 (PDT)
From: shanmukh.iyer@gmail.com
To: hugo@hugovil.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	shanmukh.iyer@gmail.com,
	trivial@kernel.org
Subject: [PATCH v2] drivers/tty/moxa.c: Fix spelling mistake in comment
Date: Mon,  9 Jun 2025 19:34:52 -0400
Message-Id: <20250609233452.164722-1-shanmukh.iyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609083906.2612e881444ee04360715aed@hugovil.com>
References: <20250609083906.2612e881444ee04360715aed@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shanmukh Iyer <shanmukh.iyer@gmail.com>

Corrected some spelling and grammar in the comments, such as:
- Units (baud -> baud rate)
- Sentence flow
- typos

This is part of my first patch to get familiar with
the kernel's patch contribution workflow.

Signed-off-by: Shanmukh Iyer <shanmukh.iyer@gmail.com>
---
 drivers/tty/moxa.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 329b30fac8fc..bf86f24e5655 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1627,10 +1627,11 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *           long baud          : baud rate (50 - 115200)
  *
  *           return:    0       : this port is invalid or baud < 50
- *                      50 - 115200 : the real baud rate set to the port, if
- *                                    the argument baud is large than maximun
- *                                    available baud rate, the real setting
- *                                    baud rate will be the maximun baud rate.
+ *                      50 - 115200 : the real baud rate is set to the port, if
+ *                                    the argument baud rate is larger than 
+ *                                    the maximum available baud rate, the 
+ *                                    real setting baud rate will be the 
+ *                                    maximum baud rate.
  *
  *
  *      Function 12:    Configure the port.
-- 
2.34.1

