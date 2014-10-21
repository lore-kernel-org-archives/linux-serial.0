From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 10/10] MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver
Date: Tue, 21 Oct 2014 15:23:06 -0700
Message-ID: <1413930186-23168-11-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35788 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933851AbaJUWXj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 18:23:39 -0400
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

I wrote this driver and use it daily on several machines for work, so
why not.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9b..d483627 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7787,6 +7787,12 @@ S:	Maintained
 F:	Documentation/serial/rocket.txt
 F:	drivers/tty/rocket*
 
+ROCKETPORT EXPRESS/INFINITY DRIVER
+M:	Kevin Cernekee <cernekee@gmail.com>
+L:	linux-serial@vger.kernel.org
+S:	Odd Fixes
+F:	drivers/tty/serial/rp2.*
+
 ROSE NETWORK LAYER
 M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-- 
2.1.1

