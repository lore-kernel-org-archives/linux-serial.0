Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B184A2E2D;
	Tue, 21 Jul 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645333; cv=none; b=Ig7XXCH3tsulH5kKdU4yJoYJD8jp6pEzs+4+cgrUQwHhs/c3d9GTl8UNx07F+k4a/8YAFHXvMiDZq6AMg77jNhWsAE79OIRKl8h9fmEPm3xPPKqTgNuGbF4S6cnvhOX/sAiBJstOZPbNDWyQ4Q2tWKC/YnjkQHcU6hbGhVPRWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645333; c=relaxed/simple;
	bh=lHgxHzbMxJg/tv/QEPHmQSswEhzspF0/S7R8sL4Y3q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5PU9oE0Kabv4yHpYTbt/NWaNHveZy7YZGMge+XxjTZrRkGUb2Er0Qm6LzXA3wtufKADb/e9kR1IlKj9dWe8DW2ufDkGN5ZE/IrMVXImWEE9uHUVF9YcF34BWvd27kQ/9O1RVrGpXij1AI/d6DUVbuB7ydNP1CjhvrenM73tC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=YpYr84WB; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="YpYr84WB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=2zMjWyq8HMdouGVu06ZkDB6ix/Y/r85Hp2SV5hLWg/8=; b=YpYr84WBIEMubwdCX8nxmiBipq
	f2rre4crE+C0T2mRufq6ZJuKFFCIY/EYueAlFc3S6Gx2bpQhgJ3Y4ROtKPi6wFO5L6ZNpfhYfom+C
	zfc4Kgo40NJpmj+P0o73JzkhwqLUeJiYgN1EWQUI3pNWEmZ5UpeFKx+7F2XuFausyAZo=;
Received: from [184.161.19.61] (helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wmBm5-000000001tX-35Jy;
	Tue, 21 Jul 2026 10:48:49 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: remove always included kconfig.h
Date: Tue, 21 Jul 2026 10:48:32 -0400
Message-ID: <20260721144847.3728422-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The inclusion of <linux/kconfig.h> in commit 7ab80d1e72431 ("serial: 8250:
fix compile error with hub6_match_port() when compiled as a module") is
unneeded as it's guaranteed by the build starting from commit 2a11c8ea20bf
("kconfig: Introduce IS_ENABLED(), IS_BUILTIN() and IS_MODULE()").
Remove it here.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Maybe this could be merged with commit 7ab80d1e72431 ("serial: 8250: fix
compile error with hub6_match_port() when compiled as a module") since it
is, for now, only in tty-testing?
---
 drivers/tty/serial/8250/8250.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b62f88eec881f..f72c7e7bb94f6 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -8,7 +8,6 @@
  */
 
 #include <linux/bits.h>
-#include <linux/kconfig.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/dmaengine.h>

base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
-- 
2.47.3

