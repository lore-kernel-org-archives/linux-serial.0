From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 1/2] TTY: Rename N_AMSDELTA line discipline to
	N_V253
Date: Thu, 6 Aug 2009 13:07:32 +0200
Message-ID: <200908061307.33772.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, e3-hacking@earth.li, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

The patch changes the line discipline name registered in include/linux/tty.h

Signed-off-by: Janusz Krzysztofik

---
--- linux-2.6.31-rc5/include/linux/tty.h.orig	2009-08-05 21:44:33.000000000 +0200
+++ linux-2.6.31-rc5/include/linux/tty.h	2009-08-05 22:54:12.000000000 +0200
@@ -47,7 +47,7 @@
 #define N_SLCAN		17	/* Serial / USB serial CAN Adaptors */
 #define N_PPS		18	/* Pulse per Second */
 
-#define N_AMSDELTA	19	/* codec control over modem, board specific */
+#define N_V253		19	/* Codec control over voice modem */
 
 /*
  * This character is the same as _POSIX_VDISABLE: it cannot be used as
