Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA5268FE3;
	Wed, 11 Jun 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636214; cv=none; b=TSPfXOvEbCU6Yysk9jepG9EDLivInGBNQP/vcR0wZI66R7v6o13WbrPZwGqKem296Y97dNwX4phUvcOsLOuMrQ/I7bRzP1gqEDcLTwI+F5G+XW7cOdjmGpg54ap9yHUpJi6oM7A0p7QELM1bFJYCL8Q+Kk42MElYGAM0XGNV6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636214; c=relaxed/simple;
	bh=1Y4FzCo2NXl7c/uhn5imstUY3/t8FVzQeKAbJ6gBnw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Puj9WXkhoVjJziIMNIZq7Jd5fCy6zFYvoWDQ4gtIvaFsBJv7aUMyzu9sipBsn4RHAKy4WIAaEIrDroviLqJGN3os54KHQ8GoMRSLrU7F2Nqs85LqOmUMNzMOhfDes1JQOYfWQURO2/OLAXt93Nqui7b7bTvT7BaZ8MTTdIfJUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEBsnaz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEBsnaz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85E4C4CEEE;
	Wed, 11 Jun 2025 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636213;
	bh=1Y4FzCo2NXl7c/uhn5imstUY3/t8FVzQeKAbJ6gBnw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEBsnaz3HFBeb6TLd44ARGPr1njs48kgrOk8UmpNQ9H/Mf4p9EEA58bcbHQfkB0YA
	 v6V7kryKz6vtl8E53F+yVU5Kjt8pAJ9zjgLJYChIYmswnZiYBT8BZXePN6xzWvD886
	 /NPx8ASjPIzGL76qv2mFyowgjwnWRnFfXpik2wa+trTX7Swuj/lPhGOQEoE19BcyVY
	 /xCU+oxXn/t6qmjgzof55tVILyLhqIUNLo8n+nxRxxtI1N69oNvZzhOTH27pplBVRr
	 3/Q1ACd8ytmrcVMGHmYoz5sMFxF2jrzOV2wYyEoOg1lKiUek8sVZ3vGDIVf9Ia2S2Q
	 J5pxKySzUTZnw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Joshua Thompson <funaho@jurai.org>,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH 04/33] m68k: remove unneeded tty includes
Date: Wed, 11 Jun 2025 12:02:50 +0200
Message-ID: <20250611100319.186924-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All these includes must have been cut & pasted. The code does not use
any tty or vt functionality at all.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/amiga/config.c  | 2 --
 arch/m68k/apollo/config.c | 2 --
 arch/m68k/atari/config.c  | 1 -
 arch/m68k/mac/config.c    | 2 --
 arch/m68k/q40/config.c    | 2 --
 5 files changed, 9 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 0147130dc34e..242d18e750b0 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -16,12 +16,10 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/seq_file.h>
-#include <linux/tty.h>
 #include <linux/clocksource.h>
 #include <linux/console.h>
 #include <linux/rtc.h>
 #include <linux/init.h>
-#include <linux/vt_kern.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/zorro.h>
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index e161ecd76035..e324c5f671de 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -3,9 +3,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/rtc.h>
-#include <linux/vt_kern.h>
 #include <linux/interrupt.h>
 
 #include <asm/setup.h>
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index b48a0606a000..ee2d061efb2a 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -33,7 +33,6 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/usb/isp116x.h>
-#include <linux/vt_kern.h>
 #include <linux/module.h>
 
 #include <asm/bootinfo.h>
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index d26c7f4f8c36..c0033f885ed4 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -15,7 +15,6 @@
 #include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
 /* keyb */
@@ -23,7 +22,6 @@
 #include <linux/delay.h>
 /* keyb */
 #include <linux/init.h>
-#include <linux/vt_kern.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/adb.h>
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index de7870ad2a30..5a4258697622 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -13,14 +13,12 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/console.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/major.h>
 #include <linux/serial_reg.h>
 #include <linux/rtc.h>
-#include <linux/vt_kern.h>
 #include <linux/bcd.h>
 #include <linux/platform_device.h>
 
-- 
2.49.0

