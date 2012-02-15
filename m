From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH] tty/serial/mux.c: linux/tty.h included twice
Date: Wed, 15 Feb 2012 18:55:41 +0100
Message-ID: <1329328541-4902-1-git-send-email-danny.kukawka@bisect.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Danny Kukawka <dkukawka@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

drivers/tty/serial/mux.c included 'linux/tty.h' twice, remove
the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/tty/serial/mux.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 06f6aef..d080bc5 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -17,7 +17,6 @@
 */
 
 #include <linux/module.h>
-#include <linux/tty.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/serial.h>
-- 
1.7.8.3
