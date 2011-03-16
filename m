From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 51/76] tty: move ipwireless driver from drivers/char/pcmcia/ to drivers/tty/
Date: Wed, 16 Mar 2011 14:12:21 -0700
Message-ID: <1300309966-5745-51-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33056 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754918Ab1CPVOv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:51 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, David Sterba <dsterba@suse.cz>

As planned by Arnd Bergmann, this moves the ipwireless driver to the
drivers/tty/ directory as that's where it really belongs.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: David Sterba <dsterba@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 MAINTAINERS                                        |    2 +-
 drivers/tty/Makefile                               |    2 ++
 drivers/{char/pcmcia => tty}/ipwireless/Makefile   |    0
 drivers/{char/pcmcia => tty}/ipwireless/hardware.c |    0
 drivers/{char/pcmcia => tty}/ipwireless/hardware.h |    0
 drivers/{char/pcmcia => tty}/ipwireless/main.c     |    0
 drivers/{char/pcmcia => tty}/ipwireless/main.h     |    0
 drivers/{char/pcmcia => tty}/ipwireless/network.c  |    0
 drivers/{char/pcmcia => tty}/ipwireless/network.h  |    0
 .../pcmcia => tty}/ipwireless/setup_protocol.h     |    0
 drivers/{char/pcmcia => tty}/ipwireless/tty.c      |    0
 drivers/{char/pcmcia => tty}/ipwireless/tty.h      |    0
 12 files changed, 3 insertions(+), 1 deletions(-)
 rename drivers/{char/pcmcia => tty}/ipwireless/Makefile (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/hardware.c (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/hardware.h (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/main.c (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/main.h (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/network.c (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/network.h (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/setup_protocol.h (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/tty.c (100%)
 rename drivers/{char/pcmcia => tty}/ipwireless/tty.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1eaeda6..e39337a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3423,7 +3423,7 @@ M:	Jiri Kosina <jkosina@suse.cz>
 M:	David Sterba <dsterba@suse.cz>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/ipwireless_cs.git
-F:	drivers/char/pcmcia/ipwireless/
+F:	drivers/tty/ipwireless/
 
 IPX NETWORK LAYER
 M:	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index e549da3..690522f 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -24,3 +24,5 @@ obj-$(CONFIG_ROCKETPORT)	+= rocket.o
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_SYNCLINKMP)	+= synclinkmp.o
 obj-$(CONFIG_SYNCLINK)		+= synclink.o
+
+obj-y += ipwireless/
diff --git a/drivers/char/pcmcia/ipwireless/Makefile b/drivers/tty/ipwireless/Makefile
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/Makefile
rename to drivers/tty/ipwireless/Makefile
diff --git a/drivers/char/pcmcia/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/hardware.c
rename to drivers/tty/ipwireless/hardware.c
diff --git a/drivers/char/pcmcia/ipwireless/hardware.h b/drivers/tty/ipwireless/hardware.h
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/hardware.h
rename to drivers/tty/ipwireless/hardware.h
diff --git a/drivers/char/pcmcia/ipwireless/main.c b/drivers/tty/ipwireless/main.c
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/main.c
rename to drivers/tty/ipwireless/main.c
diff --git a/drivers/char/pcmcia/ipwireless/main.h b/drivers/tty/ipwireless/main.h
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/main.h
rename to drivers/tty/ipwireless/main.h
diff --git a/drivers/char/pcmcia/ipwireless/network.c b/drivers/tty/ipwireless/network.c
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/network.c
rename to drivers/tty/ipwireless/network.c
diff --git a/drivers/char/pcmcia/ipwireless/network.h b/drivers/tty/ipwireless/network.h
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/network.h
rename to drivers/tty/ipwireless/network.h
diff --git a/drivers/char/pcmcia/ipwireless/setup_protocol.h b/drivers/tty/ipwireless/setup_protocol.h
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/setup_protocol.h
rename to drivers/tty/ipwireless/setup_protocol.h
diff --git a/drivers/char/pcmcia/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/tty.c
rename to drivers/tty/ipwireless/tty.c
diff --git a/drivers/char/pcmcia/ipwireless/tty.h b/drivers/tty/ipwireless/tty.h
similarity index 100%
rename from drivers/char/pcmcia/ipwireless/tty.h
rename to drivers/tty/ipwireless/tty.h
-- 
1.7.4.1

