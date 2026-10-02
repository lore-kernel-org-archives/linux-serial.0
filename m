Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1121A46983E
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929954; cv=none; b=Q6YVk8KJyZyOQJLMUINKtNrunLwrSaDczd+LIJGYFDZRy+4bAbPxFy3VAwLsgWLbdkZy1nUe8mJwn1BFiR5afJ5bc3XQbaxP+D1ixKUzS1tmSoO/7aA+5vY+vDVS9J/BVr4EaWL4YXvVGPxvdKt9omcUp4YrmUrEiZwAJVZEeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929954; c=relaxed/simple;
	bh=UQiQFN+YCs4PJ+OcjYuXCsCzURYzWN4BWw5ju07b6Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwjVpHPfbt2NwKWpS8mfuBrnQrvLdxTdXKIkD+4CIyQImCyBExiYKOiX7EMZIgCP2LIOaDbdIldLuEGJGDXl0zOlIOzFthCYtr+/QeTYSUvasOMAjQiulYA4qCB2Dxk1TTxvmy3Z9apKW89r+k6EJKzZY/xyiXTF/DStQLeNon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cNnq0FUV; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cNnq0FUV"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so35238415e9.3
        for <linux-serial@vger.kernel.org>; Fri, 02 Oct 2026 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790929944; x=1791534744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uu76vZAe0vP3OUBixd56EJdM+FLc8teUMApi5uLuSIQ=;
        b=cNnq0FUVHlAyK7FNSy/fMGL3MA3CkGgDq8ZR/DbrLVtmk6ikHns2Dx6kcJTJcFGvlc
         FahVbkOsFYoZ53M32VIr91uMK+V+zwcY6jv+Q0m0Mj6OQMcwd3lqw4tmx29rpPcGbyt6
         bTYFOCRnGwKLDU7GequwiNc/TAmU1V6kY60xhYzHEKAc/R4/ucn4WDY/6wjPoYox27bg
         cyc8mynBlJpUwi92z8D2RBdRoMVEvRDS1btWS6aSN1BtUMcrKgGCxPXMkYM8g4GBo1kq
         MJN1oPfGvu/hfS94PJ0wqT7bmeF0Xu+wkSWwkSnKY1RoBR6yj+5z6S7c02CmkSCiDyx7
         ACvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929944; x=1791534744;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uu76vZAe0vP3OUBixd56EJdM+FLc8teUMApi5uLuSIQ=;
        b=DPhTS4uTGPCRDbkVw48bfzBS4X/paJejedmyHf1Uc9zTnk20lvpzOf0Zvx56uMYxkc
         mmMr/3JfA5vcbHR+c+SjMO0P/BVY6bPnx6B/q7flZSzuKoKzoSqledcbDZWL6zuMsqbo
         qWPyZBMMbWyZmPsJGl4MC2Irv/eYH2twvhZnmgOKHrOC5+UqRRjSl1PkCUny6OQpzxOG
         hkJmxBCJb7j8EX5YtCeGXvn33LCLrx76Et3aCIKwV0lwQzPUMV511COzMs3m96rl7+8S
         d8XcPkzJLzgh/I+FeWJf2RFVWblE65Yw4oSduwTlFb18FrI+NNeUS8i2MrVDlPct10R/
         rybw==
X-Forwarded-Encrypted: i=1; AKwUvBw1IcET8/UW1BnDu99xg5y7Xo/E8deIpKwfXdhmp55B3jZYeo89cgAX3Ucw/ULHFv2kqxeGpR1hb66NdRA=@vger.kernel.org
X-Gm-Message-State: AFuF++mjPOIom/fO9z2rFCuBmBkLln2hVIeg2cbA2b1QneaOeapLF0LI
	Qv4rY2mAipokplwqVpp1NCM00tvPouZsvdrj6tCRV3G47HfT4yc8oZ/f/YGFPBatHaA=
X-Gm-Gg: AYBFou1gwcbJ3WmfxTFRzUKeQ3b7quPctljlB9Mma+Bh9oZjXGb2lTCUvWRWmxSNMMP
	okbLM/8HliBiWN+gcHO+6UpdsZgBZMjrK8UtyLg3WNCOn8BO0rjiiMKCJ+L/y2IPJhcUSW4BwXt
	a2XaitOnwPjrCCUcPNdqTYoOhZYLSR6dq7mrJ3ypdF4ISK7sj122KQvrwX9D+VgKirro0vSmK9y
	wlSLWPIV8WbA8jMwIpXdZa8b1KeBfQsJ+XEF0fMwMRazI45DWYvS6ak0SSt4ORR3afLgMoDPMcX
	/f4M7vudRXYqHq2JxZeHLVAWk3DvoE+2aO1NHaEPGWZP6SGMGp3o23yuvWyYYgqOQeR5U0xrzfj
	GidsPZGe9Wqa/KqhhxuzdLu8i3/syhcGc+vF2EPGHLQgJLPtNfqQv6ZUpq8AaHzS1Tr/sXse6B6
	U+IU2GQS5L0EhAnKDkYP5FD7N53htSnKKAgPblrIbuOMLNmfglWx0+gLjFVrqdX3stGRcfp7Kh2
	p2F
X-Received: by 2002:a05:600c:3b19:b0:4a0:25d5:e853 with SMTP id 5b1f17b1804b1-4a02759a425mr35351595e9.35.1790929944126;
        Fri, 02 Oct 2026 01:32:24 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:32:23 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drivers: Replace __MODULE_STRING() with __stringify()
Date: Fri,  2 Oct 2026 10:31:02 +0200
Message-ID: <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Replace the remaining uses of __MODULE_STRING() with __stringify() in
preparation for its removal.

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Ian Abbott <abbotti@mev.co.uk>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/comedi/comedi_fops.c                          |  5 +++--
 drivers/gpu/drm/drm_fb_helper.c                       |  3 ++-
 drivers/i2c/busses/i2c-kempld.c                       |  3 ++-
 drivers/net/ethernet/atheros/atl1e/atl1e_param.c      |  9 +++++----
 drivers/net/ethernet/atheros/atlx/atl1.c              |  3 ++-
 drivers/net/ethernet/atheros/atlx/atl2.c              | 11 ++++++-----
 drivers/net/ethernet/intel/e1000/e1000_param.c        | 15 ++++++++-------
 drivers/net/ethernet/intel/e1000e/param.c             | 16 ++++++----------
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c |  7 ++++---
 drivers/platform/cznic/turris-omnia-mcu-watchdog.c    |  3 ++-
 drivers/rtc/rtc-ds1374.c                              |  3 ++-
 drivers/thunderbolt/tb.c                              |  3 ++-
 drivers/thunderbolt/tunnel.c                          |  5 +++--
 drivers/tty/serial/8250/8250_platform.c               |  3 ++-
 drivers/usb/atm/speedtch.c                            | 15 ++++++++-------
 drivers/usb/atm/usbatm.c                              | 17 +++++++++--------
 16 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index c09bbe04be6c..05d14839c5a6 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/compat.h>
+#include <linux/stringify.h>
 
 #include "comedi_internal.h"
 
@@ -82,14 +83,14 @@ unsigned int comedi_default_buf_size_kb = CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB;
 module_param(comedi_default_buf_size_kb, uint, 0644);
 MODULE_PARM_DESC(comedi_default_buf_size_kb,
 		 "default asynchronous buffer size in KiB (default "
-		 __MODULE_STRING(CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB) ")");
+		 __stringify(CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB) ")");
 
 unsigned int comedi_default_buf_maxsize_kb =
 	CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB;
 module_param(comedi_default_buf_maxsize_kb, uint, 0644);
 MODULE_PARM_DESC(comedi_default_buf_maxsize_kb,
 		 "default maximum size of asynchronous buffer in KiB (default "
-		 __MODULE_STRING(CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB) ")");
+		 __stringify(CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB) ")");
 
 static DEFINE_MUTEX(comedi_board_minor_table_lock);
 static struct comedi_device
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d4664ed468b2..36009bb02c25 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -31,6 +31,7 @@
 
 #include <linux/console.h>
 #include <linux/export.h>
+#include <linux/stringify.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
@@ -54,7 +55,7 @@ static int drm_fbdev_overalloc = CONFIG_DRM_FBDEV_OVERALLOC;
 module_param(drm_fbdev_overalloc, int, 0444);
 MODULE_PARM_DESC(drm_fbdev_overalloc,
 		 "Overallocation of the fbdev buffer (%) [default="
-		 __MODULE_STRING(CONFIG_DRM_FBDEV_OVERALLOC) "]");
+		 __stringify(CONFIG_DRM_FBDEV_OVERALLOC) "]");
 
 /*
  * In order to keep user-space compatibility, we want in certain use-cases
diff --git a/drivers/i2c/busses/i2c-kempld.c b/drivers/i2c/busses/i2c-kempld.c
index 9b4c7cba62b6..d0438960c272 100644
--- a/drivers/i2c/busses/i2c-kempld.c
+++ b/drivers/i2c/busses/i2c-kempld.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/mfd/kempld.h>
+#include <linux/stringify.h>
 
 #define KEMPLD_I2C_PRELOW	0x0b
 #define KEMPLD_I2C_PREHIGH	0x0c
@@ -66,7 +67,7 @@ struct kempld_i2c_data {
 static unsigned int bus_frequency = KEMPLD_I2C_FREQ_STD;
 module_param(bus_frequency, uint, 0);
 MODULE_PARM_DESC(bus_frequency, "Set I2C bus frequency in kHz (default="
-				__MODULE_STRING(KEMPLD_I2C_FREQ_STD)")");
+				__stringify(KEMPLD_I2C_FREQ_STD)")");
 
 static int i2c_bus = -1;
 module_param(i2c_bus, int, 0);
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_param.c b/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
index 6b1d6df8da97..ff3423a4dc2e 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/stringify.h>
 
 #include "atl1e.h"
 
@@ -181,7 +182,7 @@ void atl1e_check_options(struct atl1e_adapter *adapter)
 			.type = range_option,
 			.name = "Transmit Ddescription Count",
 			.err  = "using default of "
-				__MODULE_STRING(ATL1E_DEFAULT_TX_DESC_CNT),
+				__stringify(ATL1E_DEFAULT_TX_DESC_CNT),
 			.def  = ATL1E_DEFAULT_TX_DESC_CNT,
 			.arg  = { .r = { .min = ATL1E_MIN_TX_DESC_CNT,
 					 .max = ATL1E_MAX_TX_DESC_CNT} }
@@ -200,7 +201,7 @@ void atl1e_check_options(struct atl1e_adapter *adapter)
 			.type = range_option,
 			.name = "Memory size of rx buffer(KB)",
 			.err  = "using default of "
-				__MODULE_STRING(ATL1E_DEFAULT_RX_MEM_SIZE),
+				__stringify(ATL1E_DEFAULT_RX_MEM_SIZE),
 			.def  = ATL1E_DEFAULT_RX_MEM_SIZE,
 			.arg  = { .r = { .min = ATL1E_MIN_RX_MEM_SIZE,
 					 .max = ATL1E_MAX_RX_MEM_SIZE} }
@@ -220,7 +221,7 @@ void atl1e_check_options(struct atl1e_adapter *adapter)
 			.type = range_option,
 			.name = "Interrupt Moderate Timer",
 			.err  = "using default of "
-				__MODULE_STRING(INT_MOD_DEFAULT_CNT),
+				__stringify(INT_MOD_DEFAULT_CNT),
 			.def  = INT_MOD_DEFAULT_CNT,
 			.arg  = { .r = { .min = INT_MOD_MIN_CNT,
 					 .max = INT_MOD_MAX_CNT} }
@@ -239,7 +240,7 @@ void atl1e_check_options(struct atl1e_adapter *adapter)
 			.type = range_option,
 			.name = "Speed/Duplex Selection",
 			.err  = "using default of "
-				__MODULE_STRING(MEDIA_TYPE_AUTO_SENSOR),
+				__stringify(MEDIA_TYPE_AUTO_SENSOR),
 			.def  = MEDIA_TYPE_AUTO_SENSOR,
 			.arg  = { .r = { .min = MEDIA_TYPE_AUTO_SENSOR,
 					 .max = MEDIA_TYPE_10M_HALF} }
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index a981c4bcf8ed..2883e9462f6f 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -56,6 +56,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 #include <linux/tcp.h>
 #include <linux/timer.h>
 #include <linux/types.h>
@@ -198,7 +199,7 @@ static void atl1_check_options(struct atl1_adapter *adapter)
 			.type = range_option,
 			.name = "Interrupt Moderator Timer",
 			.err = "using default of "
-				__MODULE_STRING(DEFAULT_INT_MOD_CNT),
+				__stringify(DEFAULT_INT_MOD_CNT),
 			.def = DEFAULT_INT_MOD_CNT,
 			.arg = {.r = {.min = MIN_INT_MOD_CNT,
 					.max = MAX_INT_MOD_CNT} }
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index c9aca219ec9c..5d3b3357d53d 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 #include <linux/tcp.h>
 #include <linux/timer.h>
 #include <linux/types.h>
@@ -2921,7 +2922,7 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	/* Bytes of Transmit Memory */
 	opt.type = range_option;
 	opt.name = "Bytes of Transmit Memory";
-	opt.err = "using default of " __MODULE_STRING(ATL2_DEFAULT_TX_MEMSIZE);
+	opt.err = "using default of " __stringify(ATL2_DEFAULT_TX_MEMSIZE);
 	opt.def = ATL2_DEFAULT_TX_MEMSIZE;
 	opt.arg.r.min = ATL2_MIN_TX_MEMSIZE;
 	opt.arg.r.max = ATL2_MAX_TX_MEMSIZE;
@@ -2939,7 +2940,7 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	/* Receive Memory Block Count */
 	opt.type = range_option;
 	opt.name = "Number of receive memory block";
-	opt.err = "using default of " __MODULE_STRING(ATL2_DEFAULT_RXD_COUNT);
+	opt.err = "using default of " __stringify(ATL2_DEFAULT_RXD_COUNT);
 	opt.def = ATL2_DEFAULT_RXD_COUNT;
 	opt.arg.r.min = ATL2_MIN_RXD_COUNT;
 	opt.arg.r.max = ATL2_MAX_RXD_COUNT;
@@ -2960,7 +2961,7 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	/* Interrupt Moderate Timer */
 	opt.type = range_option;
 	opt.name = "Interrupt Moderate Timer";
-	opt.err = "using default of " __MODULE_STRING(INT_MOD_DEFAULT_CNT);
+	opt.err = "using default of " __stringify(INT_MOD_DEFAULT_CNT);
 	opt.def = INT_MOD_DEFAULT_CNT;
 	opt.arg.r.min = INT_MOD_MIN_CNT;
 	opt.arg.r.max = INT_MOD_MAX_CNT;
@@ -2973,7 +2974,7 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	/* Flash Vendor */
 	opt.type = range_option;
 	opt.name = "SPI Flash Vendor";
-	opt.err = "using default of " __MODULE_STRING(FLASH_VENDOR_DEFAULT);
+	opt.err = "using default of " __stringify(FLASH_VENDOR_DEFAULT);
 	opt.def = FLASH_VENDOR_DEFAULT;
 	opt.arg.r.min = FLASH_VENDOR_MIN;
 	opt.arg.r.max = FLASH_VENDOR_MAX;
@@ -2986,7 +2987,7 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	/* MediaType */
 	opt.type = range_option;
 	opt.name = "Speed/Duplex Selection";
-	opt.err = "using default of " __MODULE_STRING(MEDIA_TYPE_AUTO_SENSOR);
+	opt.err = "using default of " __stringify(MEDIA_TYPE_AUTO_SENSOR);
 	opt.def = MEDIA_TYPE_AUTO_SENSOR;
 	opt.arg.r.min = MEDIA_TYPE_AUTO_SENSOR;
 	opt.arg.r.max = MEDIA_TYPE_10M_HALF;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_param.c b/drivers/net/ethernet/intel/e1000/e1000_param.c
index f4154ca7fcb4..5faf6d6280c8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_param.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_param.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2006 Intel Corporation. */
 
+#include <linux/stringify.h>
 #include "e1000.h"
 
 /* This is the only thing that needs to be changed to adjust the
@@ -259,7 +260,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.type = range_option,
 			.name = "Transmit Descriptors",
 			.err  = "using default of "
-				__MODULE_STRING(E1000_DEFAULT_TXD),
+				__stringify(E1000_DEFAULT_TXD),
 			.def  = E1000_DEFAULT_TXD,
 			.arg  = { .r = {
 				.min = E1000_MIN_TXD,
@@ -287,7 +288,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 			.type = range_option,
 			.name = "Receive Descriptors",
 			.err  = "using default of "
-				__MODULE_STRING(E1000_DEFAULT_RXD),
+				__stringify(E1000_DEFAULT_RXD),
 			.def  = E1000_DEFAULT_RXD,
 			.arg  = { .r = {
 				.min = E1000_MIN_RXD,
@@ -354,7 +355,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 		opt = (struct e1000_option) {
 			.type = range_option,
 			.name = "Transmit Interrupt Delay",
-			.err  = "using default of " __MODULE_STRING(DEFAULT_TIDV),
+			.err  = "using default of " __stringify(DEFAULT_TIDV),
 			.def  = DEFAULT_TIDV,
 			.arg  = { .r = { .min = MIN_TXDELAY,
 					 .max = MAX_TXDELAY }}
@@ -372,7 +373,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 		opt = (struct e1000_option) {
 			.type = range_option,
 			.name = "Transmit Absolute Interrupt Delay",
-			.err  = "using default of " __MODULE_STRING(DEFAULT_TADV),
+			.err  = "using default of " __stringify(DEFAULT_TADV),
 			.def  = DEFAULT_TADV,
 			.arg  = { .r = { .min = MIN_TXABSDELAY,
 					 .max = MAX_TXABSDELAY }}
@@ -390,7 +391,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 		opt = (struct e1000_option) {
 			.type = range_option,
 			.name = "Receive Interrupt Delay",
-			.err  = "using default of " __MODULE_STRING(DEFAULT_RDTR),
+			.err  = "using default of " __stringify(DEFAULT_RDTR),
 			.def  = DEFAULT_RDTR,
 			.arg  = { .r = { .min = MIN_RXDELAY,
 					 .max = MAX_RXDELAY }}
@@ -408,7 +409,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 		opt = (struct e1000_option) {
 			.type = range_option,
 			.name = "Receive Absolute Interrupt Delay",
-			.err  = "using default of " __MODULE_STRING(DEFAULT_RADV),
+			.err  = "using default of " __stringify(DEFAULT_RADV),
 			.def  = DEFAULT_RADV,
 			.arg  = { .r = { .min = MIN_RXABSDELAY,
 					 .max = MAX_RXABSDELAY }}
@@ -426,7 +427,7 @@ void e1000_check_options(struct e1000_adapter *adapter)
 		opt = (struct e1000_option) {
 			.type = range_option,
 			.name = "Interrupt Throttling Rate (ints/sec)",
-			.err  = "using default of " __MODULE_STRING(DEFAULT_ITR),
+			.err  = "using default of " __stringify(DEFAULT_ITR),
 			.def  = DEFAULT_ITR,
 			.arg  = { .r = { .min = MIN_ITR,
 					 .max = MAX_ITR }}
diff --git a/drivers/net/ethernet/intel/e1000e/param.c b/drivers/net/ethernet/intel/e1000e/param.c
index 3132d8f2f207..c6f400e6cdea 100644
--- a/drivers/net/ethernet/intel/e1000e/param.c
+++ b/drivers/net/ethernet/intel/e1000e/param.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/stringify.h>
 
 #include "e1000.h"
 
@@ -238,8 +239,7 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 		static const struct e1000_option opt = {
 			.type = range_option,
 			.name = "Transmit Interrupt Delay",
-			.err  = "using default of "
-				__MODULE_STRING(DEFAULT_TIDV),
+			.err  = "using default of " __stringify(DEFAULT_TIDV),
 			.def  = DEFAULT_TIDV,
 			.arg  = { .r = { .min = MIN_TXDELAY,
 					 .max = MAX_TXDELAY } }
@@ -258,8 +258,7 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 		static const struct e1000_option opt = {
 			.type = range_option,
 			.name = "Transmit Absolute Interrupt Delay",
-			.err  = "using default of "
-				__MODULE_STRING(DEFAULT_TADV),
+			.err  = "using default of " __stringify(DEFAULT_TADV),
 			.def  = DEFAULT_TADV,
 			.arg  = { .r = { .min = MIN_TXABSDELAY,
 					 .max = MAX_TXABSDELAY } }
@@ -278,8 +277,7 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 		static struct e1000_option opt = {
 			.type = range_option,
 			.name = "Receive Interrupt Delay",
-			.err  = "using default of "
-				__MODULE_STRING(DEFAULT_RDTR),
+			.err  = "using default of " __stringify(DEFAULT_RDTR),
 			.def  = DEFAULT_RDTR,
 			.arg  = { .r = { .min = MIN_RXDELAY,
 					 .max = MAX_RXDELAY } }
@@ -301,8 +299,7 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 		static struct e1000_option opt = {
 			.type = range_option,
 			.name = "Receive Absolute Interrupt Delay",
-			.err  = "using default of "
-				__MODULE_STRING(DEFAULT_RADV),
+			.err  = "using default of " __stringify(DEFAULT_RADV),
 			.def  = DEFAULT_RADV,
 			.arg  = { .r = { .min = MIN_RXABSDELAY,
 					 .max = MAX_RXABSDELAY } }
@@ -324,8 +321,7 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 		static const struct e1000_option opt = {
 			.type = range_option,
 			.name = "Interrupt Throttling Rate (ints/sec)",
-			.err  = "using default of "
-				__MODULE_STRING(DEFAULT_ITR),
+			.err  = "using default of " __stringify(DEFAULT_ITR),
 			.def  = DEFAULT_ITR,
 			.arg  = { .r = { .min = MIN_ITR,
 					 .max = MAX_ITR } }
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c
index 81fc5a6e3221..6a1a6678bd1a 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c
@@ -7,7 +7,8 @@
  */
 
 #include "pch_gbe.h"
-#include <linux/module.h>	/* for __MODULE_STRING */
+#include <linux/module.h>
+#include <linux/stringify.h>
 
 #define OPTION_UNSET   -1
 #define OPTION_DISABLED 0
@@ -440,7 +441,7 @@ void pch_gbe_check_options(struct pch_gbe_adapter *adapter)
 			.type = range_option,
 			.name = "Transmit Descriptors",
 			.err  = "using default of "
-				__MODULE_STRING(PCH_GBE_DEFAULT_TXD),
+				__stringify(PCH_GBE_DEFAULT_TXD),
 			.def  = PCH_GBE_DEFAULT_TXD,
 			.arg  = { .r = { .min = PCH_GBE_MIN_TXD,
 					 .max = PCH_GBE_MAX_TXD } }
@@ -456,7 +457,7 @@ void pch_gbe_check_options(struct pch_gbe_adapter *adapter)
 			.type = range_option,
 			.name = "Receive Descriptors",
 			.err  = "using default of "
-				__MODULE_STRING(PCH_GBE_DEFAULT_RXD),
+				__stringify(PCH_GBE_DEFAULT_RXD),
 			.def  = PCH_GBE_DEFAULT_RXD,
 			.arg  = { .r = { .min = PCH_GBE_MIN_RXD,
 					 .max = PCH_GBE_MAX_RXD } }
diff --git a/drivers/platform/cznic/turris-omnia-mcu-watchdog.c b/drivers/platform/cznic/turris-omnia-mcu-watchdog.c
index 3ad146ec1d80..daabd88eb913 100644
--- a/drivers/platform/cznic/turris-omnia-mcu-watchdog.c
+++ b/drivers/platform/cznic/turris-omnia-mcu-watchdog.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/moduleparam.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/units.h>
 #include <linux/watchdog.h>
@@ -25,7 +26,7 @@ MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			   __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			   __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int omnia_wdt_start(struct watchdog_device *wdt)
 {
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 8c247215d611..2ed6777e7035 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -26,6 +26,7 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
+#include <linux/stringify.h>
 #ifdef CONFIG_RTC_DRV_DS1374_WDT
 #include <linux/fs.h>
 #include <linux/ioctl.h>
@@ -381,7 +382,7 @@ MODULE_PARM_DESC(wdt_margin, "Watchdog timeout in seconds (default 32s)");
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default ="
-		__MODULE_STRING(WATCHDOG_NOWAYOUT)")");
+		__stringify(WATCHDOG_NOWAYOUT)")");
 
 static const struct watchdog_info ds1374_wdt_info = {
 	.identity       = "DS1374 Watchdog",
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 4da608ccbccb..57c11ba13459 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/stringify.h>
 
 #include "tb.h"
 #include "tb_regs.h"
@@ -46,7 +47,7 @@ static unsigned int asym_threshold = TB_ASYM_THRESHOLD;
 module_param_named(asym_threshold, asym_threshold, uint, 0444);
 MODULE_PARM_DESC(asym_threshold,
 		"threshold (Mb/s) when to Gen 4 switch link symmetry. 0 disables. (default: "
-		__MODULE_STRING(TB_ASYM_THRESHOLD) ")");
+		__stringify(TB_ASYM_THRESHOLD) ")");
 
 /**
  * struct tb_cm - Simple Thunderbolt connection manager
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index ffd2d04b3bfa..2b911372001c 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/ktime.h>
 #include <linux/string_helpers.h>
+#include <linux/stringify.h>
 
 #include "tunnel.h"
 #include "tb.h"
@@ -89,12 +90,12 @@ static int dprx_timeout = TB_DPRX_TIMEOUT;
 module_param(dprx_timeout, int, 0444);
 MODULE_PARM_DESC(dprx_timeout,
 		 "DPRX capability read timeout in ms, -1 waits forever (default: "
-		 __MODULE_STRING(TB_DPRX_TIMEOUT) ")");
+		 __stringify(TB_DPRX_TIMEOUT) ")");
 
 static unsigned int dma_credits = TB_DMA_CREDITS;
 module_param(dma_credits, uint, 0444);
 MODULE_PARM_DESC(dma_credits, "specify custom credits for DMA tunnels (default: "
-                __MODULE_STRING(TB_DMA_CREDITS) ")");
+		 __stringify(TB_DMA_CREDITS) ")");
 
 static bool bw_alloc_mode = true;
 module_param(bw_alloc_mode, bool, 0444);
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 0570366a71d0..972e474654ac 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -16,6 +16,7 @@
 #include <linux/moduleparam.h>
 #include <linux/once.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 
 #include <linux/serial_8250.h>
 
@@ -389,6 +390,6 @@ module_param_hw(share_irqs, bool, other, 0644);
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
 
 module_param(nr_uarts, uint, 0644);
-MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
+MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __stringify(CONFIG_SERIAL_8250_NR_UARTS) ")");
 
 MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
diff --git a/drivers/usb/atm/speedtch.c b/drivers/usb/atm/speedtch.c
index 000f8eb24ead..b834eba09656 100644
--- a/drivers/usb/atm/speedtch.c
+++ b/drivers/usb/atm/speedtch.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/stringify.h>
 #include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/usb/ch9.h>
@@ -77,31 +78,31 @@ static unsigned int num_ModemOption;
 module_param(altsetting, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(altsetting,
 		"Alternative setting for data interface (bulk_default: "
-		__MODULE_STRING(DEFAULT_BULK_ALTSETTING) "; isoc_default: "
-		__MODULE_STRING(DEFAULT_ISOC_ALTSETTING) ")");
+		__stringify(DEFAULT_BULK_ALTSETTING) "; isoc_default: "
+		__stringify(DEFAULT_ISOC_ALTSETTING) ")");
 
 module_param(dl_512_first, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(dl_512_first,
 		 "Read 512 bytes before sending firmware (default: "
-		 __MODULE_STRING(DEFAULT_DL_512_FIRST) ")");
+		 __stringify(DEFAULT_DL_512_FIRST) ")");
 
 module_param(enable_isoc, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(enable_isoc,
 		"Use isochronous transfers if available (default: "
-		__MODULE_STRING(DEFAULT_ENABLE_ISOC) ")");
+		__stringify(DEFAULT_ENABLE_ISOC) ")");
 
 module_param(sw_buffering, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(sw_buffering,
 		 "Enable software buffering (default: "
-		 __MODULE_STRING(DEFAULT_SW_BUFFERING) ")");
+		 __stringify(DEFAULT_SW_BUFFERING) ")");
 
 module_param(BMaxDSL, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(BMaxDSL,
-		"default: " __MODULE_STRING(DEFAULT_B_MAX_DSL));
+		"default: " __stringify(DEFAULT_B_MAX_DSL));
 
 module_param(ModemMode, byte, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ModemMode,
-		"default: " __MODULE_STRING(DEFAULT_MODEM_MODE));
+		"default: " __stringify(DEFAULT_MODEM_MODE));
 
 module_param_array(ModemOption, byte, &num_ModemOption, S_IRUGO);
 MODULE_PARM_DESC(ModemOption, "default: 0x10,0x00,0x00,0x00,0x20");
diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 7b0c791399ea..d4052d206e00 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -64,6 +64,7 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/stringify.h>
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/kthread.h>
@@ -103,26 +104,26 @@ static unsigned int snd_buf_bytes = UDSL_DEFAULT_SND_BUF_SIZE;
 module_param(num_rcv_urbs, uint, S_IRUGO);
 MODULE_PARM_DESC(num_rcv_urbs,
 		 "Number of urbs used for reception (range: 0-"
-		 __MODULE_STRING(UDSL_MAX_RCV_URBS) ", default: "
-		 __MODULE_STRING(UDSL_DEFAULT_RCV_URBS) ")");
+		 __stringify(UDSL_MAX_RCV_URBS) ", default: "
+		 __stringify(UDSL_DEFAULT_RCV_URBS) ")");
 
 module_param(num_snd_urbs, uint, S_IRUGO);
 MODULE_PARM_DESC(num_snd_urbs,
 		 "Number of urbs used for transmission (range: 0-"
-		 __MODULE_STRING(UDSL_MAX_SND_URBS) ", default: "
-		 __MODULE_STRING(UDSL_DEFAULT_SND_URBS) ")");
+		 __stringify(UDSL_MAX_SND_URBS) ", default: "
+		 __stringify(UDSL_DEFAULT_SND_URBS) ")");
 
 module_param(rcv_buf_bytes, uint, S_IRUGO);
 MODULE_PARM_DESC(rcv_buf_bytes,
 		 "Size of the buffers used for reception, in bytes (range: 1-"
-		 __MODULE_STRING(UDSL_MAX_BUF_SIZE) ", default: "
-		 __MODULE_STRING(UDSL_DEFAULT_RCV_BUF_SIZE) ")");
+		 __stringify(UDSL_MAX_BUF_SIZE) ", default: "
+		 __stringify(UDSL_DEFAULT_RCV_BUF_SIZE) ")");
 
 module_param(snd_buf_bytes, uint, S_IRUGO);
 MODULE_PARM_DESC(snd_buf_bytes,
 		 "Size of the buffers used for transmission, in bytes (range: 1-"
-		 __MODULE_STRING(UDSL_MAX_BUF_SIZE) ", default: "
-		 __MODULE_STRING(UDSL_DEFAULT_SND_BUF_SIZE) ")");
+		 __stringify(UDSL_MAX_BUF_SIZE) ", default: "
+		 __stringify(UDSL_DEFAULT_SND_BUF_SIZE) ")");
 
 
 /* receive */

-- 
2.55.0
