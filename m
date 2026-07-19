Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C117BA2
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784442991; cv=none; b=YiI8d1Zh1O3ev2sJaxPN3kHHymzgohNbQ0Y8I/ZCVEDS6VrnpF6uTYBkrFXQsESjVMO/6WF+qlu+kDt0jswn+bq0HhwaO6B+TXltobB8c9Y8FQtjA3KR8lxX98HdYTo0OncIBlhjQXodc+P2ve7ryHRPTUbGHc2+rHM4x4jX98s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784442991; c=relaxed/simple;
	bh=3cHYNNdF0JxPczIb6stDSck7qiEQvP2yK54kglp0nTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5SRcluVBOyt2m8VnzJWWfWe1obzok6MVryC6XW6USehQZGBOFE/vEflxn8UDIBVZ0v+qt4XhBHnZQRqMgG+A3phZ7KevgQEzF0ExVTwpw6GkJZoVpzFxNCqo5IjpoJYBmQceVdqkTeFqUgOSMqCpbMvTg35sEE52Z+l8BO3q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el0JIgOa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el0JIgOa"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f633e6058so1761781f8f.0
        for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784442988; x=1785047788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGAR8aGiBoBWo964VuxC9unxOU3E2crPFC6OtuASy+A=;
        b=el0JIgOa0rIT9+nzeBRB/BvqY9Gy9VgqlQOrGiJ3oba7/MsR/P2cIe0KUsZiFznULN
         r83U1cjKr7JW2ROtVgRsMDIYKAiGjzVu1FdTF2gFz+QEujanD3GLz0Gz1115ghW4YpnU
         VJ2YgXeP8IzLkg3Gc200ufGrLBS6JIhlCmWHvfVBNW/0b0Gh+JGcOVfLucUxGO1/HZLG
         1lWvSa9fGKqMUYV25T7K436OaHNpKDuZ6fw1XU15UNayvo6pGPspx+s2KeRB/WcDwhpf
         2mPGYRj+6Ae7sfeemOXpA9WEsEK84Tx14E4VN/mKp/3Lxq32aPuPRDpiLeC4zo/BRvKS
         6TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784442988; x=1785047788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGAR8aGiBoBWo964VuxC9unxOU3E2crPFC6OtuASy+A=;
        b=nOm9VjozDZEZLE4AeW5LJubwX7V6uJBWbbHgR86l/kAqwFSEnXjKWXexKM4AzwnVRW
         54+6kxwD7vZ65fdP6PYBz2ig5JUP9c1R0K66+hF3GehHK3sdnZLrisVmEnIb9L71ylwX
         on/6xfjtrAaCXirTZmqMclMGi4Y4lmQ4JReBqges0EvrDM4llKQMDYT8g7y+ryZInLup
         pxQcMzCEWkTDT1bVXh0qsZL4mPg1fmXb1BgxEJSmx7CCKw2ScJD39nbmRxnQ8V52NR3h
         7rYTwyZFmbjlMaYbzs3IdxZHfvwJ4w4kR2BFeJg+qLHwjuP08N12tS4t7apOZLL/LB7v
         IOkA==
X-Gm-Message-State: AOJu0Yw3/i2ckKH0pD7VSS1pvHNDFTOOv2pGRAqZ4IStQMGH0wYC7gTP
	GgZ00kznTZFa/5hMkuEEh9Z61oT2KXh3mv8FcAuVBYHELTr4lu1Amuii
X-Gm-Gg: AfdE7cl2OU3OOWj+x4TwGRlXdMbb50fvljC6zgNs+WQNPKR4cQ64HFassuQSAEOe/SO
	WWVn9thXxxtQlZykk6NhnCpCupBhBHrfr6/NMdfnfnyCnTGRG0z8TNbX8op4bbankmRY3JKEY4G
	Cr46BjJVJV2KbD4QxoXP2a1OVAt9FP6LUaY3oyJ5I6N9AYNz1Uau6JlhyeExoUseNQcvO21JuDE
	FQZPMZXwanSKrrP13h2WbLz/ia2z5awqIrifxdRo26tSPjyjq1+3HhMhgz9XEGLLOC1jijf/8/r
	cS3FXs2RELyk32c6qq2r8QF/51rwS8yt9dGy4YUTuVVMGnfj6BY5cAqXBZt41460THpYQDaOqU6
	eTSu7ZrcdbflJANdjhWj7SvkZCOs9WSZ3iiw4oiJPDL5V4LvzTrHSKuUPfKZseKbr1eJHaTXCet
	KLXra/2gLjWjFUiw4rVwN72Kd7btsfWWWDAvwxQDVYt6MQmpWRyIpH8s1IN4IWUJJdctE528ZhF
	x+CrhnlAg9ic4ER2V1w0qAYvd9mTe685g/lrR0=
X-Received: by 2002:a05:600c:4e94:b0:495:571e:e5d3 with SMTP id 5b1f17b1804b1-495571ee75fmr23066555e9.36.1784442988176;
        Sat, 18 Jul 2026 23:36:28 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-018-194.77.7.pool.telefonica.de. [77.7.18.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96f19sm193053245e9.9.2026.07.18.23.36.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 23:36:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 0/2] serial: amba-pl011: fix console clock lifetime
Date: Sun, 19 Jul 2026 08:35:00 +0200
Message-Id: <20260719063502.18852-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes an independent bug: pl011_console_setup() prepares the UART
clock but nothing releases it when the console is unregistered, so the
clock's prepare count leaks one reference per registration cycle (via
the sysfs "console" attribute or a driver unbind). It adds the missing
console .exit() and stands on its own.

Patch 2 fixes a PREEMPT_RT failure: pl011_console_write_atomic() runs in
nbcon atomic context but calls clk_enable(), which under RT can acquire a
sleeping lock, so an atomic-context printk on a clk-backed pl011 can hit
"sleeping function called from invalid context". The same lock
acquisition would also be unsafe if write_atomic() is invoked from NMI
context. It keeps the clock enabled while the console is registered and
releases it in .exit(); it depends on patch 1.

Tested on QEMU: the prepare-count leak was reproduced and fixed on
bcm2835 (a gateable CPRMAN UART clock), and the PREEMPT_RT splat was
reproduced and fixed on versatilepb. With the series applied, recycling
the console via the sysfs attribute keeps both the prepare and enable
counts balanced, and the console keeps working after re-registration.

Karl Mehltretter (2):
  serial: amba-pl011: unprepare console clock on unregister
  serial: amba-pl011: keep console clock enabled for atomic writes

 drivers/tty/serial/amba-pl011.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

-- 
2.53.0
