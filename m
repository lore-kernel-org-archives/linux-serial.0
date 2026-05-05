Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988E26A1A7
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944067; cv=none; b=o5pfnwjaedobKr5J0DzCCVgAotmvuDlarAoCGj2V326WRKbIQ38qQCHrJaa55qfB78YH/ZvavNNGNvGD/UUC3hMk19IquSWpEQ2YwLmyU2D4GMm4nwQ1PGWQD65hASwGQbtl9qFEkkc2KnQ2PaCe25ZIfx0u75cMvPi9Ci6ohiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944067; c=relaxed/simple;
	bh=oQ801at+aVVOdHzItiNq0tfuWGeAsjoWuonI4Z0bqcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1X5hiu3+BAV2NpiXgOBUO72XjyDawqwOGV5/QmqkCzem9Jd53QlH6eRX5kKXRMX4MiR8W9Mp4avaNpUL+QEksXq3kAMRxUxMLl3AkfSxhuzGH/jVg1PljcDuGglMu2PzEC3mlboYBd9R6Busoyc0jqnbRRaZbweY75oIQMyh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z35XBKv1; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z35XBKv1"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2ee990e8597so4665879eec.1
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 18:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777944065; x=1778548865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAifaghCXFrYgmlDfXQqkxY3YtsjbY5V02mePz73ekE=;
        b=Z35XBKv16OsJyTb28gIuvMrcf9ziH6nei7dGB7jA4FrLJcvxKiFWrCp2c1nP7xZli0
         5vQjNxQiOPtT1TW7gzWbg3YDnJIJND0JCpaGU1lN7NXx4k25UJ7vAiWBzlg5i4k2hM+6
         MT2lLNp532iCQDIahtPhcjCNRfASWQerjtHrK5IL348XHzP7Ev3nP6XmqsrcydEWpGOh
         A2F7L2xIsQhT0mgUQyxqoGJGtcEPEyP5qe/hCF3W8D67RlKiGYwatAQ+ot028t4LFnTT
         hjuFHbS441gQucu2qVRM80g/J/KsfZfPXkslLTjQFzanwC6y2KhMFJT8KcvBgglxI9LV
         LNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777944065; x=1778548865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAifaghCXFrYgmlDfXQqkxY3YtsjbY5V02mePz73ekE=;
        b=Lr1RfPidTAxtZ/byH6lKFLqT1DUHOHJJ2rjBEg2iNJ0XaVE7u553myqC4UosQuWiWh
         t7hnUgCRUvUs51AcOaMh2cZeIq1TiEkUUlvFgJDgx/90goqyAtpJfaccJcteqEXXwHrO
         htRVN0SDgcLfnXzdZi8XrnnUVhbf4438mHYch6ANtmMz63IQWCPCsb3lC/LbOHMQY7yr
         GKrOyeFkrG0036YH1UZNOdTRoobnvuHV+ezIRYcVmufM3gMSGweQe+yh4UC3fGMqd4sV
         ugwJePnoRKx1II3IlqfYxqKaC9sOCfvfVnldNF6OfU/sM+nDPXEZZ+DnkHmKD4HIiNuL
         NkAg==
X-Gm-Message-State: AOJu0Yz0LVus0unlsSfjQCJRnMZPR2nH9forgnXd3rA/hlRCrUNqDs6X
	/Ej5i1G/qfP9ik6qyhtCP3Nmm4PMYfkGbH1LqChxhWgkGmiuEH2C04j1urKRsGyH
X-Gm-Gg: AeBDievtEYQLkWG0EgK9Dp6N8haDP6sqV2aE0eER2oNf5gcM/jV4v5wpHFf0PKIOy4L
	zTXtc54cJ0y9BtPJE85WZl+y/CNpkWCE59rkwt2ebFYi3Fz+LAaHkDTV0HcqoBNjehSy3utzUSj
	JQZoAnIjrv9w42Y7H65F8d6DQTCbnx3WhX99FJT1XBsvQX8CbFtXWVWr5A0IqZghUacqtr95Rx3
	tuSOCpzn6u3y6Ui/w17dq1Xt3Gs/y5f6Q1TlN7XvvmP7JqgmI7jIbx2X/gI7ahC4+vjVycYnRef
	eMqrwAUhXt4FgldCxdo/+8FF8z9I1ve8aXniqopYU4/uYXXkzsqWSccs6UyvOYNUd3yfj9RkZJC
	Awgf8kIYrO73dAcU90kZLz2Lm3k6trdlOEC0PKpNaeFVRyLRe3BmSlSIS/SksqfqkxsAbPfYEae
	2P8ql2UT3ysSDPN1RQQ5Wi5AUKGRVp7H8rMrWf/s5P3dJrQynvMxrCy01EGCD4mxe4QlcGitHEN
	6/Rg4hYWyQH0EryqJr5gLsENxgJA39Z63vUJzaoTMwx4r2hK8qqyCrgruEECh63fwkK4c63NyY6
	PBA6aAfMCTwmQFJpidUPtFzncP/L
X-Received: by 2002:a05:7300:3b0c:b0:2f1:3aa8:f2c with SMTP id 5a478bee46e88-2f40745e041mr579181eec.4.1777944065296;
        Mon, 04 May 2026 18:21:05 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm24060034eec.1.2026.05.04.18.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 18:21:05 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH 0/3] Small cleanups to serial driver organization, configuration, and documentation
Date: Mon,  4 May 2026 18:20:33 -0700
Message-ID: <cover.1777943090.git.enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series moves some serial drivers into the serial/ directory
to improve organization, and removes the SERIAL_NONSTANDARD config
option, which adds unnecessary complexity. It also fixes a number of
issues in Documentation/driver-api/tty/index.rst, which I noticed
while making the above changes. The patch to remove SERIAL_NONSTANDARD
touches sections of the tty and serial Kconfig files which are also
touched by the patch to move drivers, and therefore the patches would
fail to apply separately, so I am sending them as a series.

Ethan Nelson-Moore (3):
  tty: move remaining serial drivers into the serial/ directory
  tty: remove unnecessary SERIAL_NONSTANDARD config option
  docs: driver-api/tty/index.rst: copy-editing; improve organization

 Documentation/driver-api/serial/index.rst     |  1 +
 .../{tty => serial}/moxa-smartio.rst          |  0
 Documentation/driver-api/tty/index.rst        | 47 +++++++++----------
 MAINTAINERS                                   |  4 +-
 arch/arm/configs/footbridge_defconfig         |  1 -
 arch/arm/configs/lpc18xx_defconfig            |  1 -
 arch/arm/configs/mps2_defconfig               |  1 -
 arch/arm/configs/neponset_defconfig           |  1 -
 arch/arm/configs/stm32_defconfig              |  1 -
 arch/csky/configs/defconfig                   |  1 -
 arch/loongarch/configs/loongson32_defconfig   |  1 -
 arch/loongarch/configs/loongson64_defconfig   |  1 -
 arch/mips/configs/bigsur_defconfig            |  1 -
 arch/mips/configs/lemote2f_defconfig          |  1 -
 arch/mips/configs/loongson2k_defconfig        |  1 -
 arch/mips/configs/loongson3_defconfig         |  1 -
 arch/powerpc/configs/cell_defconfig           |  1 -
 arch/powerpc/configs/microwatt_defconfig      |  1 -
 arch/powerpc/configs/ppc6xx_defconfig         |  1 -
 arch/sh/configs/polaris_defconfig             |  1 -
 arch/x86/configs/i386_defconfig               |  1 -
 arch/x86/configs/x86_64_defconfig             |  1 -
 drivers/tty/Kconfig                           | 41 ----------------
 drivers/tty/Makefile                          |  3 --
 drivers/tty/serial/Kconfig                    | 23 +++++++++
 drivers/tty/serial/Makefile                   |  6 ++-
 drivers/tty/{ => serial}/amiserial.c          |  0
 drivers/tty/{ => serial}/moxa.c               |  0
 drivers/tty/{ => serial}/mxser.c              |  0
 tools/testing/selftests/bpf/config.x86_64     |  1 -
 tools/testing/selftests/hid/config.common     |  1 -
 31 files changed, 54 insertions(+), 91 deletions(-)
 rename Documentation/driver-api/{tty => serial}/moxa-smartio.rst (100%)
 rename drivers/tty/{ => serial}/amiserial.c (100%)
 rename drivers/tty/{ => serial}/moxa.c (100%)
 rename drivers/tty/{ => serial}/mxser.c (100%)

-- 
2.43.0

