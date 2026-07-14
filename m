Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AB20DD51;
	Tue, 14 Jul 2026 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992384; cv=none; b=G9AEv08VVuhSRCVufSY1NzhV0DEzDbNpK0oVmKmp4DiOv1pcd/lawLqIzcUUmB+iIHUVN0zGGVcWKeHCG1FTi7BNqHI+Om43/qZu3ScBqOvNbVLmOELrAjy7Ye/Arb0PvzkV9/jbkZunvMpCHjnEDxsgjUcRpmDht+w6pn7xCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992384; c=relaxed/simple;
	bh=RFVLDK8flH+XURygZZnCOLwVo6FcxEFcwZmHbiauCUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6X/X1X59T2xbsMRPyFvQKQgDcyWP1OWJO8afUf205DDj/M21qOEOnWb2uls6EFNnrnSPwWgSG38JDaQZDSiLdGhidRXH5+L57pgaNJ/vALgesXVtgYWswVpdWqqTGDQ2pzQalbVmCTl2dceHwZKuT7amoz3zCBoYCC/3/ZTBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=frYQREiC; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="frYQREiC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=Scr4IlM3+GHeb+0hRYBzLg+qziEtyr0kuHOIquSjuPM=; b=frYQREiCpj5V7e+48YUrZDvyv2
	HzWCLdkyrQGbYMNeXdosffh8ScDS5z9vKwCFHyHlJniBd5f6v9rz9xK8yLY/nHKwgfSlDigskXptC
	s9+Ckou2H/Oakp2KYot/qL4fuHLwoUwi+xl6zBm15JFpe6WWRRSdSvjro4Ap2EXPYbhw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wjRuX-000000005M0-15u0;
	Mon, 13 Jul 2026 21:26:13 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_hub6: add missing include for hub6_match_port()
Date: Mon, 13 Jul 2026 21:26:07 -0400
Message-ID: <20260714012610.576746-1-hugo@hugovil.com>
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

Add missing include to fix compile warning:

  drivers/tty/serial/8250/8250_hub6.c:44:6: warning: no previous prototype for
  'hub6_match_port' [-Wmissing-prototypes]

Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607110715.VGT2dVVz-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202607111219.QG9uOW8H-lkp@intel.com/
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Not CCing stable as commit is still in Greg's tty-next tree
---
 drivers/tty/serial/8250/8250_hub6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index eae32c924e29b..b6767633c966c 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -7,6 +7,8 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
 
+#include "8250.h"
+
 #define HUB6(card, port)						\
 	{								\
 		.iobase		= 0x302,				\

base-commit: c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503
-- 
2.47.3

