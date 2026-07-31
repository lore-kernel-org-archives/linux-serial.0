Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557135AC1E
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521932; cv=none; b=pCuwEhWRZGFPS3VFhoxAZtz0QZ8rmMlxFt6i3+MJ2Y+st4xvF8kaSqxQb/A+X96JAd5ypOzC7ixNxv4ZlVCK8MPypaqLCRDXuB3iGfdQJKP5gHsGnI9378siyh6Ir6MfHJxUDGC2W2bKcJ7fF2kDWrElLUrUlkE9VlJU0+dEWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521932; c=relaxed/simple;
	bh=tA36+oaDcrqq1ErWQWvZt75nn5c0v28h/EegCzrkJ8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p7wzLt068v2Km9Rxqp9E+DpGGABoJvR6H59MLCZ2gnKJ9GxwFfUEBib9pXQGqheMuqgR3EWoQlh4lfwNBJPYqbBsR0E6wELEtTWUDjOjluRHgfO+8MUYtQcq65voyfNy+I7u8VacnFGgqAtZ1F01rkZmX2ewAPwr+M+2NRX737U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC0U5SkD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC0U5SkD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1184463f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521930; x=1786126730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zBCM5Nh2Z+pyL6wOrSHgIaBsinADA485LhOFyzTIsjs=;
        b=SC0U5SkDyiP7crz5Zm2tDRfRGf1+c0pyUW4oWDKc2eAr25PxCH/A6qxhvnFro26Vam
         aOk0Cscpe+CYg3qgq8Y+ZQGNLOhQKN06jVXnbPvXadto3DEB4gKczN3RafLeRPy3VPzQ
         grmQq45814xv1pXJjwNlXr0RHEgaq8jiEyT4uE+Fi7HZULoPfUZlHVnzwUAkKN43VGBU
         73UH59rYpUIwUq0JSr22pkuLs85VrcR44k6lmaY9Ikv5L0FbiqKmx0no4WWQT1tPlbCD
         WjaXwtoc1ZvmPSm0o/fH/fe+KlZWy3Q/5GeUkAsR9DUq6ckolC703G+IToOF8w36kmcA
         ptnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521930; x=1786126730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBCM5Nh2Z+pyL6wOrSHgIaBsinADA485LhOFyzTIsjs=;
        b=gOZUtRbjmhFquwd5UZXQz7gDahOERQRta/qMfsnPMieTr8Kmdf87WA+GHKlWKfPhHN
         nsmzLlwjaHPywhLWGJarKzF4y1bBdW5zlOK56dhXOIoDryMDG9zSP+LVX92heRI6bF0K
         dJOlF8Ld1wV5LEAcIuN32LPCuzvRv8zkI9nkHYRs3z0yNrK57nKyO8zywvkf2a/CN2Wt
         QIryiQBw46xPltisNg7QOw5ECLRfI5u3IFQKG7XwF1iG2Avk97bORmauCcpLMlluJM4e
         njDLHjnykK3ORgQuLi3FmezK3iIj0vUUob3D7j8G8zax77MgTq5C8rnt6b/OsPRbon6H
         QSFQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2S9AgQ6DO277BZVjgNFXcDuzz9AoNh1DN9dMQfJ3dAB2AB98f0algo6Nkx620ODWBHDaQeL9wrxwvd0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9c1mjhn7iqvz1Jn/ydQwxdDZn12CmfhYsuSAg70tFrliDzV21
	TdlJsO9SjyziVoWxJZnDMt6qtZLe8DSR3NCIPmd36ERJuDlWVMvMoDLgv3JNOIuX
X-Gm-Gg: AR+sD12/K847QHOXxUJnmcHzQtonKfbYylIMLLnpwwBvxHrfo0jVSM3PLi07jB3aDA9
	3P+mxYFty32pqVQUNPELqBlWsrTgjK7FXZnSxr58PS3D86P8H7+kdKzZfqquySnnWNzcQiLBG+U
	XIGpPXFWEPPPCimTwcH9aQjRl8JCbK2ag9xz4fkSJwSDiOxHMaSvjhqHyc4gFRn2wqKqdARpv92
	zgSvXKQoKWrH7ylqIO1TBvE979Vpn//HRDMBuJ2KXC8w/66UABiP1Vgh4lXjtXQvY1PU3Lq6+n6
	MvOfiFC5OLgN+ZHsKuJgn3zOyJKqUGLmJlXiNXrzlT3WdZgfqtMmGQO+TWFsTg4wgVjgKow+2/E
	rAEKM17NlxnSAd2KF/JaitZiF2vHSFGj9JVonhrwWVAcWdbAFwqpVNXOh/ZW0++Xu4Jf/E/nM+e
	lWs3DWd59pPZg9dlCtcWZd0+MxRDBv7ZZEUzQIzVyaBj2p9ZCX9IvCiZjI3Lf3iDAKKNaQojp5i
	aM5VZRIjtSPvOYYfql9sAtNWeV9KCmKtVI0eUgsSu/8Bmm5pM6eQRIXUPKq7YAVa3hZBf2ndPQ4
	13ksLe6nncQbKw8TI6x8HL/ECH/0M5NjVWsvXIAHiFPATlQU/untpALowP98y6aYb8ZE
X-Received: by 2002:a05:6000:c90:b0:47f:d0fb:ea40 with SMTP id ffacd0b85a97d-47fd72db353mr1079198f8f.21.1785521929339;
        Fri, 31 Jul 2026 11:18:49 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm7293694f8f.4.2026.07.31.11.18.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:18:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/5] serial: fix console lifetime bugs on failed bind and removal
Date: Fri, 31 Jul 2026 20:18:39 +0200
Message-Id: <20260731181844.11330-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes four serial/tty error-path bugs and an i.MX console
port-table lifetime bug. The fixes were found with failslab fail-nth sweeps
and sysfs bind/unbind sequences under KASAN on QEMU's raspi1ap and
mcimx6ul-evk machines.

Patches 1-4 fix shared serial/tty core code. They move fallible allocations
before console registration, clear pointers after uart_driver registration
fails, and make a non-NULL tty cdev slot mean that the cdev is live.

Patch 5 clears i.MX's devm-allocated port-table entry after failed probe and
removal. It keeps the entry valid through console unregistration, rejects
duplicate lines and serializes table updates against other port probes.

Validation includes fail-nth sweeps on both boards. The i.MX tests also
cover the sibling-probe race, sequential unbind/rebind and
CONFIG_PROVE_LOCKING=y.

Changes in v4:
- No code changes. v3 was accidentally sent as individual mails.
  Resending as a single thread.

Changes in v3:
- Drop Cc: stable from patches 1-4.
- Patch 1: remove redundant uport->name clearing and credit Sashiko's report
  with Reported-by and Closes trailers.
- Split v2 patch 3 into two patches with corresponding Fixes tags.
- Shorten the changelogs.
- Patch 5: use scoped guards, reject occupied slots, remove the unnecessary
  line variable, document the console-callback locking constraint and add a
  backport note.

Changes in v2:
- Patch 4: serialize port registration and removal with imx_uart_ports[]
  updates to close the reported sibling-probe race.
- Patches 1-3 are unchanged.

v3: https://lore.kernel.org/r/20260731180343.10818-1-kmehltretter@gmail.com
v2: https://lore.kernel.org/r/20260719221014.44354-1-kmehltretter@gmail.com
v1: https://lore.kernel.org/r/20260719160812.35407-1-kmehltretter@gmail.com

Karl Mehltretter (5):
  serial: core: do fallible allocations before the console can be
    registered
  serial: core: clear freed pointers on uart_register_driver() failure
  tty: skip cdev_del() when no cdev is registered
  tty: clear cdev pointer after cdev_add() failure
  serial: imx: serialize imx_uart_ports[] lifetime

 drivers/tty/serial/imx.c         | 20 +++++++++++++++++---
 drivers/tty/serial/serial_core.c | 32 ++++++++++++++++++--------------
 drivers/tty/tty_io.c             |  6 ++++--
 3 files changed, 39 insertions(+), 19 deletions(-)

-- 
2.53.0
