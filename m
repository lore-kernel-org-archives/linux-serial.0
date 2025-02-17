Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BB183CBB;
	Mon, 17 Feb 2025 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765289; cv=none; b=CaLr9dd6mIZWNg0xwXmzsuM51wnSGAYwSqHaqdiHM2zt4F5KSsF9UqBnWg/IXmEhmbMl7eeD61rRn/EXoXowuCKQRc03qfDg/8W9WjUAzlmxbrNsCHbTssp5OublxNEqN21BqY9y3QmM55UUFYt2ZiL5Bx5yRXTC3n7evbqKuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765289; c=relaxed/simple;
	bh=RLUrjXEZhDGki/Pjxx6XNvFMLKuYY0/Z5oalpjyhVtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI8pLnylpJObu7mOSTl52VNc+8x+fDQ4p3jLycxQhE7M5LI3lx/8zLwjR5isz1f2rwZ0bOL1uMSOghXJY69yp5JrmLAIpoz/Fk/YnhXg/LBnHWdDaBliRe2mTX4jYlYse2Us7m2rhmEP7Cde+sFeQRP6XZ/E1ToJYRTwMKSfkm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx2qeKRh; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx2qeKRh"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0818add57so288600985a.3;
        Sun, 16 Feb 2025 20:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739765286; x=1740370086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo3zhZXJ/GxhiVMRgC/sUpGvGabIKgXyUMS9I6R5PMM=;
        b=hx2qeKRhiwjTsETHl/ERd9Z/U+50xx9sk5lMnYz2+6FhqkmrD3DVYhPG2zFpQMgWj/
         OjSCtxrJCajCmsvgnXZmcx9iEwkOm+OWHElAnjlXCOI6UpHPxT096+8SpoC7QYrf47pN
         MykvCyHJTdAdPldTiJGTfAiVf6lKYTH4a4aK72UKcM+B+t5QCitVoW3tjl82GFDCIb6c
         IE/Ztk1XqJEiKHAqMCVUSudKXVy6DGzgj262JASj4U8XyaSjK8Fvuyl9XJaynDgr2vdT
         PO7r0qFAX1PHu5g2mmlLCl97g10eoQ1VKzEJMZ/Fcie+AUL7CCgDAMfkPO42rrcXrKsT
         l9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739765286; x=1740370086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo3zhZXJ/GxhiVMRgC/sUpGvGabIKgXyUMS9I6R5PMM=;
        b=wrp/746eG5iEY66bGHUk3VfYH0lad0WPVoZX8hfW1fj2Ri+sWB9ztJsNbwAZpdRbuK
         2aljjvyq+3hL20OSzSh4Vg98R0pzCjayQaroxY2hIh35mPVm0P5M/JPGP6Bp4pFP9LQr
         JBQreGOD7fq1ZkVnKKiQzaf8m26R/IfGILA0QQUggiMy6N7o6SodmR08l+czNxOUrcdB
         AaRj0Jamlu14JSdnBMeTN6Uzt7XlZOVvamxaR3AJIytOq5GrrcDbIcoC2PxZc+ooUQJ+
         ie6s0DfqDPmey0ly6awCGyzzWeJE58T2VRhMzeMN2TXC6/5TiF/KWKOgzAKSs1H9ZVbZ
         kD+A==
X-Forwarded-Encrypted: i=1; AJvYcCW4vzNhfJx9XGDH1YQfd2tFr1R6Cjn2naWKM5GO6zlsnxKtJNZ4Fu7t5vItCuwGeK+kVc+JPpmSevCBhWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3hDwy0HbaEKYGHqEqWOr+4b6JBxKxphht5mRravrlDk1XCzR
	P/sz+iL4ooHr+HZGu36fpUbnK1mJnvTYD14AGySTX21v5/ri/fGwMssGp6dJ
X-Gm-Gg: ASbGnct36l93JfLfESN3XNB6Fm+qjyrIIxNY1R0WU93fIAw5wzRy8OgDYBrAOxJbbTV
	ZUVPFoCa+meTUnyZoXhar4rM2X4kpl93yOVjCflgpg2FBVuMu1UVXzeMZpscmKgFriM+9/ucQ9x
	bFzUehPJi5BEm7eH3xHHn1K1FMyGsiDR9+ekTqKDBvH6AhgxjCEIQa9zK/DvSTjsZaJMFeO5NsE
	bgjS5Dkjxgn2QljEVL6Xlin9EMK6doWdfLftJTXJ6oMvx5V6UU/Pun3gO40CcGuoCJ/D9o2enha
	TvK4ODgJMm0kD216FGqmXcUPbGGbZY0pi3LlzvODrvgttEMDgbR6hQ==
X-Google-Smtp-Source: AGHT+IE3L6dhYZ7OhRr0jAVQ8rAZvgYg5WBzscoQSsbMWLe45VPcaPMJKhv6zmE5DjcHRhxrpZxX7w==
X-Received: by 2002:a05:620a:4105:b0:7c0:7f7d:8c36 with SMTP id af79cd13be357-7c08aaa913cmr862475285a.42.1739765286268;
        Sun, 16 Feb 2025 20:08:06 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:3bda:f60d:1567:d3d0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c861537sm488465085a.67.2025.02.16.20.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 20:08:05 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v2 2/2] tty: Change order of ttynull to be loaded sooner.
Date: Sun, 16 Feb 2025 23:07:48 -0500
Message-ID: <20250217040748.2017975-3-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217040748.2017975-1-adamsimonelli@gmail.com>
References: <20250217040748.2017975-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

If CONFIG_NULL_TTY_CONSOLE is enabled, and CONFIG_VT is disabled, ttynull
will become the default primary console device, based on the load order.
Users and distributions that are migrating away from CONFIG_VT will
benefit from this as /dev/console would not suddenly become /dev/ttyS0
which could otherwise cause some user space behavior changes, namely the
TCGETS ioctl failing, which causes libc's isatty() to incorrectly return
false when /dev/ttyS0 is disabled, and will prevent a device that is
connected to a user's /dev/ttyS0 to suddenly start getting kernel log
messages.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55..03bb47e11e1c 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_N_GSM)		+= n_gsm.o
 
 obj-y				+= vt/
+obj-$(CONFIG_NULL_TTY)		+= ttynull.o
+
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
 obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
@@ -20,7 +22,6 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
-obj-$(CONFIG_NULL_TTY)	        += ttynull.o
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
-- 
2.45.2

