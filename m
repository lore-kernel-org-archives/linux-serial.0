Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3983F5BED
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928848; cv=none; b=TA+P23VVGFNmrfqEr92MFD+phx7t0VGbsVHVC8b4TJzHbN1MYrJ+pOc/+F3GTuVALXh3t4Ao0hWjADjGNN/tWWJHnyk6NVsSfjxlsPWHUjltN9jAZzrtS2IpjfDe9CBuJbiNlXWgJydog6FHNEDLANNWIvzwbUG/1fRf8iqu2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928848; c=relaxed/simple;
	bh=L8/5qgDEjoP17OJ0HMJ/A3XES9LvHVdVUJiHHaCp36M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+zhL4frRzTlRbD+kv/QJbVPAywnuPjv1AY4o1VX48oEYzcfyVpxZty3D24rpf7TdQ1UVHUQGna2ozcZSUhEbl6eQkKWZaTitwdi/vje7RAcLGCCOrbacP3coiVXmUg4nNtb+yv92zc3C6qlkYAYO+aaI9iY7lxaPQvRSuXEJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MztzKEnZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MztzKEnZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so6608935e9.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928844; x=1785533644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WOnGh4nCACqtC0cvfPaQrFlO41pTulyeZNkgwFh3MsI=;
        b=MztzKEnZrbFmabIKtUXA7T4m362qzA+q/nUZJ+Bx5fkRiQzjIBur7bomZ9Feg47sjv
         xVH7OSM3sGxvT1rvs6/8jAScSurDOP8ZnCaUWipHBcMzH4IuUSwen9A/IZP8hEljLeDB
         sF5WsOPO6Zjr/G83H/fK5GGfY+EQDBEevrhe+ug7orBoX5zC2vToyDMiXfJqsmVU9laE
         7cZePTWzG/RJS8tecW0eyd+9JB6DclN3kDCAaRkeT7wZe6/+CR4Io2ocjyGWZyna6DVq
         I1Va2tqSMwBH1MIs+o1ZM99iF1tqSXyu06UwlVoxdw/rEUhdQp+kqBkvYCbvree0Kk8w
         pItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928844; x=1785533644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WOnGh4nCACqtC0cvfPaQrFlO41pTulyeZNkgwFh3MsI=;
        b=Vq5jrfH9Zl5ttABwErK1xq2vMD6OFYSuTCaEgqyW+uia5UD3ONs0x3b12T8jxCsoCy
         ItFalhmCXZmK/+38PQ3ONo7J5+UtjRY7ICooD6Os5XVw1j/g+CTJYG4Hj0bioDp9G/i1
         BORDJZYlIQb/IxfH8bOLSgYv4MNuKCJlkDZ+D2+P11qeLlZfTeYIkhF6f/+Cr4tMFQ2N
         iqva5WsmD03O6lqsPm5+CBWz8OKE34qqgBCZKtlYHCxGOcUm0w5Ybglt5L9VO61cGm0i
         v6uA8eTQ7kBIYj2waD1pwoyujtG6yFag3Ajcg6Py6ESSLgAJ7gtN3XNG08GVOvrt3ahn
         /fkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4H310PHcY268Eq0TTwALnI7U3lzM7YT3jYcujd6MBzWmW1bmcGHBR6Iyvx4K1FbgRiOetlV080gaeP50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlD4LjFB0ZLmpd7M2j3e9+DTeg6tpAvTH/LLgHh/upCKbl+QXx
	/ZrthLDp0mRem8WmZm45Av4bwMQRHbOrhT/bGEiU9o2d2bxwuFXDgnkE
X-Gm-Gg: AR+sD13aYlMl4SX/AI7DpYyLiXZ5UBqSc54UDHp/M4z9oxMviU3MrGUdLII35loDJAb
	dSHovQ83XFKlqiKU1lsN8VmvnozUpXSPWr42ClM90G/doG4AbMqGYQScrDqx9/eYsKKmwrffu96
	ChQWnsFl33DhLsL9ZwagyylXGPn8Qb0GLC3TURrYHxrvhBJmczd+ePitTBSf1kSxVIwy1Fk7i/O
	xVE/FWrrjND4Stsrn2JVs4rtdnlesd9ZH/dIFMTF053wi0v3eHrNrUzM3sqe9pCn2JDA2G5C/dJ
	BUFqpnHDhXbJbLov2vkMHrxYXx/3SYDNqNrodvmJNUsJbC4MNqaP4xjj3ELXxynntsWqaZ4iqlP
	XjHJuTv7i+v7lNIRg+navwwzvx5yAyke8EzwdajYAw9Auxgum90SY1AZ8u/PKGdGhnrIa8ANFF1
	ZdCYXH2uiKP/IrAKNEU4BNtofoZwABdkcuWfVFh68i83ThX9KChiGiIORrqZHvfuS7M3yTvV1Ct
	aPsQTl3MyB/Iyy0PK04EfXzXkn4ximOcMoLJiSWMAb0UGSzri/S/ioh4e8tm9oymSMk06ZAqr7I
	FgeaOvWffem4XA==
X-Received: by 2002:a05:600c:870c:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-496b56f9749mr527725e9.15.1784928844090;
        Fri, 24 Jul 2026 14:34:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae93-f301-cdd9-d5ea-080d-9131.310.pool.telefonica.de. [2a02:3100:ae93:f301:cdd9:d5ea:80d:9131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm20754015e9.9.2026.07.24.14.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 14:34:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
Subject: [PATCH v2 0/2] serial: amba-pl011: fix console clock lifetime
Date: Fri, 24 Jul 2026 23:33:46 +0200
Message-Id: <20260724213348.77418-1-kmehltretter@gmail.com>
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
clock's prepare count leaks one reference per unregister. It adds the
missing console .exit() and stands on its own.

Patch 2 fixes a PREEMPT_RT failure: pl011_console_write_atomic() runs in
nbcon atomic context but calls clk_enable(), which under RT can acquire a
sleeping lock. It keeps the clock enabled while the console is available
for output and releases it in .exit(); it depends on patch 1.

Changes in v2:
- Add suspend/resume management for the persistent clock reference.
- Keep the reference for no_console_suspend and RX-wakeup ports.
- Document the platform-dependent power impact.

Patch 1 is unchanged.

Tested in QEMU on raspi1ap, raspi2b, and RealView ARMv6 SMP, and on arm64
virt under PREEMPT_RT. Actual s2idle suspend/resume (RTC-wake) dropped and
restored the PL011 clock reference, balanced across repeated cycles, while
wake-capable and no_console_suspend cases kept it enabled. Strict clock
checking found no access while stopped, and RX behaved as expected.
Toggling /sys/class/tty/ttyAMA0/console showed the prepare-count leak
without patch 1 and a balanced count with it.

Full-platform-sleep and actual RX-wakeup were not exercised.

Karl Mehltretter (2):
  serial: amba-pl011: unprepare console clock on unregister
  serial: amba-pl011: keep console clock enabled for atomic writes

 drivers/tty/serial/amba-pl011.c | 53 ++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

-- 
2.53.0
