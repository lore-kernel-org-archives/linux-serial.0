From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver
Date: Sat, 18 Oct 2014 19:30:18 -0700
Message-ID: <1413685818-32265-3-git-send-email-cernekee@gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59065 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaJSCap (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Oct 2014 22:30:45 -0400
Received: by mail-pd0-f173.google.com with SMTP id g10so2897951pdj.32
        for <linux-serial@vger.kernel.org>; Sat, 18 Oct 2014 19:30:45 -0700 (PDT)
In-Reply-To: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

I wrote this driver and use it daily on several machines for work, so
why not.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 809ecd6..c08d8d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7663,6 +7663,12 @@ S:	Maintained
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

