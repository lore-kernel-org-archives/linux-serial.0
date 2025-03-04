Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA111F12E7;
	Tue,  4 Mar 2025 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060502; cv=none; b=CX0ZfOp0K+SlFds655DbaS+5c2QUH8CqWMy+EIt6FrG+1wxoyPVXY/r688DBTvQc1/AG1JTHckfFammMsBXBOlWLNcKolhD1vlA879/MT2uE/Xyf1dYTZqxrRCyzOBgE8D297ru0VkVTnyo0HqNMkJ5vnfKpy4AmnSIgtW2N7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060502; c=relaxed/simple;
	bh=aMuLi0cFdrxkp4efrxFeE79RPAtt10/3L8Ja4bvdE+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVJYRJFxwCjGlhD6yP9a64+MGtHQWcJv9xPgFkHrbZwuv8hRecyM+TyH16Ry0jX5O6PsHbhdd44aXTUWvO/5oNRkyG0UbyWXZ1UQUz/ZjQpZdTEw/m/sk0KqN58s4SZdQDb1rwEIJm4rbbI31LVjx9LrIvo4U/ij2/4qQS6o4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiB155rh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiB155rh"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47220d28138so72767621cf.3;
        Mon, 03 Mar 2025 19:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741060500; x=1741665300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNAkXef11zdfcgjeJ3kpSPOXc080QlYH+4o4TcrHlyw=;
        b=RiB155rhpf2Nat+D3Zn2jMfuO/TW/Y3LMqyQl9okCoxfv4oXtgNAl7vCMmReScx+iw
         iB/PPFD3UCYGFVt12BzL7uMd/laSQkgxSZRsH8x1i8uO4D/Df9bQLEtpRmsj2coNdrUJ
         0qrqVOle/QJY9Yf6Qmvr3yeSDN0z3BMXSI3sA/tYLlqvG+9ebDl/WQ2RVrOxwOShqQiR
         KXx9p76ON+oSXH1MNvWdt33F2mJwzJdqQEHomHCBkPkiajf+zikGvM/WjGNTqQutD3LT
         lh6LfgBX0ORGjGg05Axm+kbPd6PHZc66t1UbqY/aL0yl5ZZFljK7JMcDEaTC9Al9+CUv
         Disw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060500; x=1741665300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNAkXef11zdfcgjeJ3kpSPOXc080QlYH+4o4TcrHlyw=;
        b=hgOs0FH4UPDNcd3/b6nz6hST84t/p8BdppTariUulYiATGfCsek9raJbH6D5S1jmz1
         xjJCAuPH3jH1eRGyXSyHVUTBSjNWpI5suGCTMK5++UestUfwG2dpU+qYecJV60cuH3CE
         qZhia9DI4eVSWwBtArRWX/lMf+YhIZRRYs1+au0F1AZOyLs9Dkv/1wE++WGCqVaIlOTn
         I8INUgF8GMXxlJW8beWFAFzd6AlDYTyxu0L0PNOgr+M7APzCtL2p8g/DX4M2q1E92lUD
         1JIXxjz6DnUvmm61UNeGvU8aWfjPNKsd1s3g96QejrdDzwzcPoejkVBm7EGwpQUIELxs
         VLLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv9olJr0vQNiu3LA5g2u8FBuws039rB3Nr3rkaV0M5H5tv3Isdp0y3wcLLKkuQPmsX4w+CGKFEKX//Amw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OajyzUuFhwApSi9NatTp/8zYHf0NlB5lCwmgI3ZCiBp4voG0
	JT1zUQj9+eXGxpyYRQqr4XVRLbgrDBOtP/liXkzFwP+Dei07BZl9ho4oKvEc
X-Gm-Gg: ASbGncu9elUEL+93JSrb0PniknMda+GVoyvW6IJUREXneR/nxXBQZ/38IDw9TM6s3v2
	s2MChN0/fch/XSWe8LERIYH4IhfsppyiRwnK9CrFQugQBs38pBFf0lVTJC4Rj5+UHUyZUnGxA80
	dr25kaUhymoiZV2F8mTyBUF0c6IEiGbseiW8G3A6egBDSjCWzPiHA3DMVdjyonGFI2nwBJH7ayb
	vE1p8cVZNf78qNCrp/Fmf7zWEc/YaJCwy63XoThqz29s3hIO5GANH3Zh/TPDM3CtzFiMm4A4FP/
	gZUaTj0W6Zf9KWtSulyWKW9U65HrS+nKTmuQ2EyqlHGHbGUOKh9Wn2nMf9/i7bGz3urFUnqf77j
	WuNxPo8Q=
X-Google-Smtp-Source: AGHT+IEJRv1Z1puHuTTDS5BASBzewCEEpv3HGY0UCNruNC1c4UgHWBCzRGInQGoqxonwoxHSrJHP6g==
X-Received: by 2002:ac8:5a09:0:b0:472:744:e272 with SMTP id d75a77b69052e-474bc0e1912mr231157041cf.33.1741060500153;
        Mon, 03 Mar 2025 19:55:00 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:745f:1ed4:1113:4077])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a1f2csm67567041cf.13.2025.03.03.19.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 19:54:59 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v6 1/3] ttynull: Always initialize console index to -1
Date: Mon,  3 Mar 2025 22:54:45 -0500
Message-ID: <20250304035447.3138221-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304035447.3138221-1-adamsimonelli@gmail.com>
References: <20250304035447.3138221-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/ttynull.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564..d8b51edde628 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -57,6 +57,7 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
 static struct console ttynull_console = {
 	.name = "ttynull",
 	.device = ttynull_device,
+	.index = -1,
 };
 
 static int __init ttynull_init(void)
-- 
2.45.2

