Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82C4D6C3D
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773151; cv=none; b=DMUuAiBUqxBbEz3JPFeJMo9N9mefLEKAtD1dsbZwFw3ncC87ceGUTg4/mCfpOIGwiebs8C2rEvhicz5flyia86SaCzHJ7D8rJIeQDSeYg2+gGDRYkXLiMsN+bPnNDMyWf3kdph+K/vNQSw0ahJeS8jtVJpNms1nTc0AsUteq/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773151; c=relaxed/simple;
	bh=ZOZcnBA24NO/pa1vXrsjd8y9HWBPKelZsbY931OX+ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrZu3O9SboN0/QDP0lDUHbcPMsECe09yQciOz3hGyo0E7lsXhK3vILFcbEBq3Y3FUCgbQsNA8icUg4KoJavQYP/J5b8H5Ctx9BmY9b8TOvvfAL1ArzMoxRg7IfbsqgQkSdmP/AGX0LTw7Cr+Z9e4z1Z5LdFfp0mCrTBOmzB0ajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfazufTM; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfazufTM"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d9fdf798so4986705ad.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790773143; x=1791377943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m4F4f3/aIvZt5ojYeBT1ImcwfjE5cVxgdJesU8F13F8=;
        b=nfazufTMB/TLsGxbX9221aXt/VLrQxHmzjlo2IlQrnraKUN8wyNfRggB+q+ni2eKFg
         L/KLcuBg2kqKp2pRQAk9c7SFP4UhuCe2PoV/HNovQ3eWpw7vLzNtwA0KBYMMFZDm9zKg
         64d7xXE+OtM30X5+2qnKZ6NQo0+choAqYA6E4NL7Upa2Zw78Kg/qLOwpuG1G6beiWq2g
         dLbyVJU99DJzYuGiJ8PQnCjmGYQtadzAmmg5PQmRdpFFD6ve880d4tBtTWuaPY8C3I1K
         j174IKdfvd0avAB4T9mKgF/f6+GL0cA/UQoh3F81sTzmgi7999o5Rq4d3KJZtgVquu8Y
         hM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773143; x=1791377943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4F4f3/aIvZt5ojYeBT1ImcwfjE5cVxgdJesU8F13F8=;
        b=bCgZz6BMC3Ht+0UqZFQCdgXm+UsWRkhECxKErMONL4dbj6nO1wC75DWxhgNZnA25I7
         vfc+Mlpv2IkgKamhqrFJJV1uus5p2rT9iNja8VYQhu0VUSKEbzG/Z25WnnZJ2SYRO1/C
         iR4p3LOTY3JPb0uRiTUqr2kSPZ4YKdL1UHSR32nvMM9Ld+NuZfOHQZ4atA5iFpTff30d
         xMQd8M+8jpzEr6q1KSNB0bRFtBaiDJWmc6rRrE6x6uFgbHq65+Lum4YFW4Gdl/r7As4r
         wNmOSf3cUaOaSZZtSBcoZR9TDIUdJv+3GMFcYYoXdJ5r+YSQRETC2pKDKd41txG7+3dH
         W20A==
X-Forwarded-Encrypted: i=1; AKwUvBwDTVr1a2ehziq+ah6BKOA1aBGIec0Umq293xSvU05FOf0j9w/rEg9tzCOY2m44Np/NnWCyRouNDNzDDu0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJccJzjzbUmjJIrQuIKU6DayrvElBkQMvY56iUhWESWSBKeAVpI
	ouoF6AI6vAmhXGY0JQ2WQ3HgrDBRb40wf+S7xGaSFDasTVuqn5voT3sDZifB99Kv
X-Gm-Gg: AYBFou2FtVFqesSJKacvUrEtp84U6FO8JBXKnvDULI9ucvCPbSAcu8qjG4XpxS6OilA
	uuEulO+gXFqTn/0GY7JkfsycKLueUsQmFq0UPr/VPc+oMBg8DdqeALe7vtkSS/vZzeFpx+nhAcJ
	W1Tcet1UltgqvbL9yLEoe3NxwSqNR12PWa7f0F4xlMxXCLLfM8eMI8Nptgtkig9SFc2LML1HAAP
	ksRkY6kB7z52k97DuBYiVFzZz/FMYkqPd0Wapf1nIl+256SiHinPu4o4mIPlZkG/VoSlBY4Gykx
	rNjfjdVQfdC58kTtiQkGrNv+r4D7mfvgTY2GBLjPVwEd5xXCreN8JiqGUqyX1aYhwrkIi/UqnIg
	guCFTdgc0bXFy1KuzwWI+WNIO/R9JvrXSegGA+M11mGHdlEw2gJ/fgNS8TiZRQYsl2te5nNb8G4
	VKIA3wTJnYHNTX0xo1aMbe2nNDtXGFb6697Nl7hM8KhxHcl5d6yBkcqcZjqQGAz0mR62lsSM+JJ
	6K689ks92WZgizQy93lhwzqgOireUbMBKtVh6um5r9sLt97RipMDkbYZDlaz2KUFeC+GbhfS8VT
	CQ4XCgxlGA==
X-Received: by 2002:a17:902:f644:b0:2d3:716e:e2ae with SMTP id d9443c01a7336-2e2e48b30famr11257585ad.6.1790773143429;
        Wed, 30 Sep 2026 05:59:03 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c1b3d7sm6751925ad.70.2026.09.30.05.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:59:03 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v7 0/2] serial: core: fix baud rate fallback loop and baud_base overflow
Date: Wed, 30 Sep 2026 12:58:59 +0000
Message-ID: <20260930125901.778868-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two issues in serial core:
1. Division-by-zero WARN/Oops during baud rate fallback in uart_get_baud_rate().
2. 32-bit unsigned overflow in uart_set_info() when multiplying new_info->baud_base by 16.

Note on v6 1/3:
Patch 1/3 from v6 ("serial: 8250: fix deadlock in serial8250_register_ports")
has been dropped. The hash_mutex race condition was originally found and
reproduced on Linux 6.18.14 (where guard(mutex)(&hash_mutex) was dropped
inside serial_get_or_create_irq_info() before serial_link_irq_chain() linked
the port). We did not realize that it was already fixed in mainline by
commit b339809edda1 ("serial: 8250: use guard()s"), which refactored to
serial_get_or_create_irq_info_locked() with guard(mutex)(&hash_mutex) moved
into serial_link_irq_chain(). Apologies for the noise in v6 1/3.

All remaining patches are ported to the latest tip of mainline (551c722f4080)
and dynamically verified in QEMU KVM with CONFIG_KASAN=y.

Changes in v7:
- Dropped patch 1/3 (already resolved in mainline).
- Clarified in cover letter that 1/3 was found and reproduced on 6.18.14 and
  we did not realize it was already fixed in mainline.
- Retained patch 1/2 and patch 2/2 using check_mul_overflow() as requested
  by Jiri Slaby.

Hui Peng (2):
  serial: core: fix baud rate fallback in uart_get_baud_rate()
  serial: core: reject baud_base values that overflow port->uartclk in
    uart_set_info()

 drivers/tty/serial/serial_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
-- 
2.47.3
