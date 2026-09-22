Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659454A7CA
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084039; cv=none; b=l9sHGz8wYquRGHQPv5OBHBlpG3Lkl9YzFQwmDpv+luVvYhGLIcaWY/ZXVDCXKmKMvj/fw85fGfZ9jl7T1ULLqf4wktk72oO0AiqGvEETHnUXySFQA0YWpI7DZ/rmhbAEH6H9o8T1XqCca9MI3/3P8aAwixIlvuXga12KHPln7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084039; c=relaxed/simple;
	bh=evJmx6zU8fQkzEQbzllDZgDqYm6DXTHzmtk6SxxvFGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLieIpw2DlnL++gkkmcfSarCh308EaI6VROt/CyhRxLjZh83KAbACPVv17UCxMuFQNH1pKLh6LW2QWB4qU3BsrnuC8ftNooDGdkTTFQdhv05gPDUkf0of68qKX4IHKSTJNroNjSF/Drc1WiasXeNkdaypyE+yT6XN80C7trFDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V/NRxjSv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V/NRxjSv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso36621835e9.3
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790084021; x=1790688821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+NOMWYzzBQUqxYEAWm73IFv3IymMXxn/LCVJ6NlU6GM=;
        b=V/NRxjSvCiaeBaxxeZYchVgjTDsacz8KydP8CM9b1Ksi2ZO7eQya6eICZhF6yBkz4z
         Go1ueP89QcshuTyV6Je1jSAHQy/OiuvLT2wVtlhaU4x2KP3i+5mnhg8cV8l86xfJU/j+
         z1MBWZLjZ6QSLPEjLp2KZTFbNk6m6ehn9w8a49/FzYICF4LVeeCeoCavSqyWnIC8fFIp
         FVItL5omiV+u7iXG1Ju8aQ6uTAJH33vOuGW9vyeJj2t1T5Qu2zPKzf/gqdSldKggIT6D
         hrH4lCs+uIpZXim8LDVdyQ4VLxrdMA5lS5dDjaAAC/vSOlgZFhrG3uSqddVyuwZRC3fn
         7FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084021; x=1790688821;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NOMWYzzBQUqxYEAWm73IFv3IymMXxn/LCVJ6NlU6GM=;
        b=XqKK8KoDsGbq5CUsM78pRVK13aU9Ve21Ewgc1A7MPo1rVV5kXYCQATYNBr79Bk/vcn
         ADamRalTpsxx+6WHLxiV2ZOZ1n0yRQdzOQlDllxB8o+W/hd6hcJfuQ2oERgyq1NTTp3O
         L4yVRv5UwTOgR/MO1H0JFDS7H3lhkwxPN/eYwae4mT51CmemwbPvpzcw8gs+Xyr+Ueyd
         MhVgvxOAMooaYaMnIOjcCK/7PhXtoU/zquv5VBtVpKbJABC5WzZPKvEbwgROF/AeoLeV
         op2udE8VPu7wp9NMCiHFpv4cUgEBOgsAlVNtYUsjA8u4KiKMUmK1i1/D6IWRSTuKZN1M
         Xalw==
X-Forwarded-Encrypted: i=1; AKwUvByzMXXTMrR2V/fB/ZZOmkJcbvIQ2m7wZLhfHMI7q+MfVGcO2butXdhgODv8KHUmmVJuoyUIkXh3YkJMI+g=@vger.kernel.org
X-Gm-Message-State: AFuF++mfmZI7MOROzvga5DYT3FXoFo5D4Y5+q3QSCHseQVOuYi1WWNMN
	crXKtu7rz1UigVnEavbUsWZmronPXj5yMLCZ+EnzWPf3AeLgiZZYz7QrBAXVC0Xh8Tg=
X-Gm-Gg: AYBFou0DFsBvodVJbDhdTKT+w99Kk8h3WdBftZI2KbwfacRuSA/ls5LITNsRgb/OLQr
	U7vOMyWphnT+RfUOnkhYXluFCxrHl+k0ITt+5V1QD2c0fccWsIao/dZryNvOd/yMPqLVHp/m8Ov
	brTHKv7Gwu9rKpr41wznp9wiErRvshCDSQecuHRWh1eo8iX4upLSF7NYF7oY8GdaBwf0ZYmzy9g
	DgDguiB/D2/d/PVlbHOsY5t0wlL+2/kyO/pH2rz/hV8n5IWKPKfHP7rjM9Qigo+gjm8lVWMj/rX
	pOpzhp5QUrso1bOCfTdRKFZgMZxuIElDbH+agER/IVfBHR4FAJ6mqZxF2HeAobriza7437csa4b
	BHK1Emvc4FLcEBO4EiAUoU89QDKq29IIG9e91ybshDS/AzBezEpNv8XgXa+uwuFhzHsBjSTwvE3
	LVzUvAgBcHqyzYUuMvBqoDk/G1aw5fXXTSo2MhqE1OzdDwmavnm40JwaW5/Nz20+ZeCgRxsHsD6
	d0IODSofInWEaVcs+2L+ALKUeqjx394WoinRn2vQvrhZRaY3NqJ3pEppRwgJI2skFVmEiM=
X-Received: by 2002:a05:600c:3b2a:b0:49e:6861:50f7 with SMTP id 5b1f17b1804b1-49fc5687df8mr195929925e9.5.1790084020279;
        Tue, 22 Sep 2026 06:33:40 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdace76e8sm70243845e9.1.2026.09.22.06.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:33:39 -0700 (PDT)
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
Cc: linux-watchdog@vger.kernel.org,
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
Subject: [PATCH 1/3] watchdog: Replace __MODULE_STRING() with __stringify()
Date: Tue, 22 Sep 2026 15:32:21 +0200
Message-ID: <20260922-module-string-v1-1-c18766690185@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922-module-string-v1-0-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
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
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/watchdog/acquirewdt.c             | 3 ++-
 drivers/watchdog/advantech_ec_wdt.c       | 3 ++-
 drivers/watchdog/advantechwdt.c           | 5 +++--
 drivers/watchdog/airoha_wdt.c             | 5 +++--
 drivers/watchdog/alim1535_wdt.c           | 5 +++--
 drivers/watchdog/alim7101_wdt.c           | 5 +++--
 drivers/watchdog/arm_smc_wdt.c            | 3 ++-
 drivers/watchdog/armada_37xx_wdt.c        | 3 ++-
 drivers/watchdog/aspeed_wdt.c             | 3 ++-
 drivers/watchdog/at91rm9200_wdt.c         | 5 +++--
 drivers/watchdog/at91sam9_wdt.c           | 5 +++--
 drivers/watchdog/atcwdt200_wdt.c          | 5 +++--
 drivers/watchdog/ath79_wdt.c              | 5 +++--
 drivers/watchdog/bcm2835_wdt.c            | 3 ++-
 drivers/watchdog/bcm47xx_wdt.c            | 5 +++--
 drivers/watchdog/bcm7038_wdt.c            | 3 ++-
 drivers/watchdog/booke_wdt.c              | 3 ++-
 drivers/watchdog/cadence_wdt.c            | 5 +++--
 drivers/watchdog/cgbc_wdt.c               | 7 ++++---
 drivers/watchdog/da9052_wdt.c             | 5 +++--
 drivers/watchdog/da9055_wdt.c             | 3 ++-
 drivers/watchdog/davinci_wdt.c            | 5 +++--
 drivers/watchdog/db8500_wdt.c             | 5 +++--
 drivers/watchdog/dw_wdt.c                 | 3 ++-
 drivers/watchdog/ebc-c384_wdt.c           | 5 +++--
 drivers/watchdog/eurotechwdt.c            | 3 ++-
 drivers/watchdog/exar_wdt.c               | 5 +++--
 drivers/watchdog/f71808e_wdt.c            | 9 +++++----
 drivers/watchdog/gef_wdt.c                | 3 ++-
 drivers/watchdog/geodewdt.c               | 5 +++--
 drivers/watchdog/gpio_wdt.c               | 3 ++-
 drivers/watchdog/hpwdt.c                  | 3 ++-
 drivers/watchdog/i6300esb.c               | 9 +++++----
 drivers/watchdog/iTCO_wdt.c               | 5 +++--
 drivers/watchdog/ib700wdt.c               | 5 +++--
 drivers/watchdog/ibmasr.c                 | 3 ++-
 drivers/watchdog/ie6xx_wdt.c              | 5 +++--
 drivers/watchdog/imgpdc_wdt.c             | 5 +++--
 drivers/watchdog/imx2_wdt.c               | 5 +++--
 drivers/watchdog/imx7ulp_wdt.c            | 3 ++-
 drivers/watchdog/imx_sc_wdt.c             | 3 ++-
 drivers/watchdog/indydog.c                | 3 ++-
 drivers/watchdog/intel_oc_wdt.c           | 5 +++--
 drivers/watchdog/it87_wdt.c               | 7 ++++---
 drivers/watchdog/jz4740_wdt.c             | 7 ++++---
 drivers/watchdog/keembay_wdt.c            | 5 +++--
 drivers/watchdog/kempld_wdt.c             | 7 ++++---
 drivers/watchdog/lenovo_se10_wdt.c        | 5 +++--
 drivers/watchdog/lenovo_se30_wdt.c        | 5 +++--
 drivers/watchdog/lenovo_se30g2_se60_wdt.c | 5 +++--
 drivers/watchdog/loongson1_wdt.c          | 5 +++--
 drivers/watchdog/lpc18xx_wdt.c            | 5 +++--
 drivers/watchdog/ma35d1_wdt.c             | 3 ++-
 drivers/watchdog/max63xx_wdt.c            | 7 ++++---
 drivers/watchdog/max77620_wdt.c           | 3 ++-
 drivers/watchdog/mena21_wdt.c             | 3 ++-
 drivers/watchdog/menf21bmc_wdt.c          | 3 ++-
 drivers/watchdog/menz69_wdt.c             | 3 ++-
 drivers/watchdog/meson_gxbb_wdt.c         | 5 +++--
 drivers/watchdog/meson_wdt.c              | 3 ++-
 drivers/watchdog/mixcomwd.c               | 3 ++-
 drivers/watchdog/mpc8xxx_wdt.c            | 5 +++--
 drivers/watchdog/mt7621_wdt.c             | 3 ++-
 drivers/watchdog/mtk_wdt.c                | 3 ++-
 drivers/watchdog/nct6694_wdt.c            | 3 ++-
 drivers/watchdog/ni903x_wdt.c             | 5 +++--
 drivers/watchdog/nic7018_wdt.c            | 5 +++--
 drivers/watchdog/nv_tco.c                 | 5 +++--
 drivers/watchdog/octeon-wdt-main.c        | 5 +++--
 drivers/watchdog/omap_wdt.c               | 3 ++-
 drivers/watchdog/orion_wdt.c              | 3 ++-
 drivers/watchdog/pc87413_wdt.c            | 7 ++++---
 drivers/watchdog/pcwd.c                   | 5 +++--
 drivers/watchdog/pcwd_pci.c               | 5 +++--
 drivers/watchdog/pcwd_usb.c               | 5 +++--
 drivers/watchdog/pika_wdt.c               | 5 +++--
 drivers/watchdog/pnx4008_wdt.c            | 5 +++--
 drivers/watchdog/pseries-wdt.c            | 7 ++++---
 drivers/watchdog/rc32434_wdt.c            | 5 +++--
 drivers/watchdog/renesas_wdt.c            | 3 ++-
 drivers/watchdog/rn5t618_wdt.c            | 3 ++-
 drivers/watchdog/rt2880_wdt.c             | 3 ++-
 drivers/watchdog/rti_wdt.c                | 5 +++--
 drivers/watchdog/rzg2l_wdt.c              | 3 ++-
 drivers/watchdog/rzv2h_wdt.c              | 3 ++-
 drivers/watchdog/s32g_wdt.c               | 5 +++--
 drivers/watchdog/s3c2410_wdt.c            | 7 ++++---
 drivers/watchdog/sama5d4_wdt.c            | 5 +++--
 drivers/watchdog/sbc60xxwdt.c             | 5 +++--
 drivers/watchdog/sbc7240_wdt.c            | 5 +++--
 drivers/watchdog/sbc8360.c                | 3 ++-
 drivers/watchdog/sbc_epx_c3.c             | 3 ++-
 drivers/watchdog/sbsa_gwdt.c              | 5 +++--
 drivers/watchdog/sc1200wdt.c              | 3 ++-
 drivers/watchdog/sch311x_wdt.c            | 5 +++--
 drivers/watchdog/shwdt.c                  | 7 ++++---
 drivers/watchdog/simatic-ipc-wdt.c        | 3 ++-
 drivers/watchdog/sl28cpld_wdt.c           | 3 ++-
 drivers/watchdog/smsc37b787_wdt.c         | 3 ++-
 drivers/watchdog/softdog.c                | 5 +++--
 drivers/watchdog/sp5100_tco.c             | 7 ++++---
 drivers/watchdog/starfive-wdt.c           | 7 ++++---
 drivers/watchdog/stmp3xxx_rtc_wdt.c       | 5 +++--
 drivers/watchdog/stpmic1_wdt.c            | 3 ++-
 drivers/watchdog/sun4v_wdt.c              | 5 +++--
 drivers/watchdog/sunplus_wdt.c            | 3 ++-
 drivers/watchdog/sunxi_wdt.c              | 3 ++-
 drivers/watchdog/tegra_wdt.c              | 5 +++--
 drivers/watchdog/tqmx86_wdt.c             | 3 ++-
 drivers/watchdog/ts4800_wdt.c             | 3 ++-
 drivers/watchdog/twl4030_wdt.c            | 3 ++-
 drivers/watchdog/txx9wdt.c                | 7 ++++---
 drivers/watchdog/uniphier_wdt.c           | 5 +++--
 drivers/watchdog/via_wdt.c                | 5 +++--
 drivers/watchdog/visconti_wdt.c           | 3 ++-
 drivers/watchdog/w83627hf_wdt.c           | 5 +++--
 drivers/watchdog/w83877f_wdt.c            | 5 +++--
 drivers/watchdog/w83977f_wdt.c            | 5 +++--
 drivers/watchdog/wafer5823wdt.c           | 5 +++--
 drivers/watchdog/watchdog_dev.c           | 5 +++--
 drivers/watchdog/wdat_wdt.c               | 5 +++--
 drivers/watchdog/wdt.c                    | 5 +++--
 drivers/watchdog/wdt977.c                 | 5 +++--
 drivers/watchdog/wdt_pci.c                | 5 +++--
 drivers/watchdog/wm831x_wdt.c             | 3 ++-
 drivers/watchdog/wm8350_wdt.c             | 3 ++-
 drivers/watchdog/xen_wdt.c                | 5 +++--
 drivers/watchdog/xilinx_wwdt.c            | 5 +++--
 drivers/watchdog/ziirave_wdt.c            | 3 ++-
 129 files changed, 352 insertions(+), 223 deletions(-)

diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index 052f65c48a70..cb62800e89ed 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -64,6 +64,7 @@
 #include <linux/init.h>			/* For __init/__exit/... */
 #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
 #include <linux/io.h>			/* For inb/outb/... */
+#include <linux/stringify.h>		/* For __stringify */
 
 /* Module information */
 #define DRV_NAME "acquirewdt"
@@ -92,7 +93,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	Watchdog Operations
diff --git a/drivers/watchdog/advantech_ec_wdt.c b/drivers/watchdog/advantech_ec_wdt.c
index 7c380f90ca58..2470c4303267 100644
--- a/drivers/watchdog/advantech_ec_wdt.c
+++ b/drivers/watchdog/advantech_ec_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define DRIVER_NAME		"advantech_ec_wdt"
@@ -49,7 +50,7 @@ static ktime_t ec_timestamp;
 
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
-		 "Default Watchdog timer setting (" __MODULE_STRING(DEFAULT_TIME) "s). The range is from " __MODULE_STRING(MIN_TIME) " to " __MODULE_STRING(MAX_TIME) ".");
+		 "Default Watchdog timer setting (" __stringify(DEFAULT_TIME) "s). The range is from " __stringify(MIN_TIME) " to " __stringify(MAX_TIME) ".");
 
 static void adv_ec_wdt_timing_gate(void)
 {
diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index 42d3f3771781..6d24a6bc8f90 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 #define DRV_NAME "advantechwdt"
@@ -71,13 +72,13 @@ static int timeout = WATCHDOG_TIMEOUT;	/* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. 1<= timeout <=63, default="
-		__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+		__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	Watchdog Operations
diff --git a/drivers/watchdog/airoha_wdt.c b/drivers/watchdog/airoha_wdt.c
index 4bd333189b87..c535c48ab6a8 100644
--- a/drivers/watchdog/airoha_wdt.c
+++ b/drivers/watchdog/airoha_wdt.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
+#include <linux/stringify.h>
 
 /* Base address of timer and watchdog registers */
 #define TIMER_CTRL			0x0
@@ -44,12 +45,12 @@ struct airoha_wdt_desc {
 static int heartbeat = WDT_HEARTBEAT;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. (default="
-		 __MODULE_STRING(WDT_HEARTBEAT) ")");
+		 __stringify(WDT_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int airoha_wdt_start(struct watchdog_device *wdog_dev)
 {
diff --git a/drivers/watchdog/alim1535_wdt.c b/drivers/watchdog/alim1535_wdt.c
index 1ecbd1ac5c3a..d2f8d3331fe4 100644
--- a/drivers/watchdog/alim1535_wdt.c
+++ b/drivers/watchdog/alim1535_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/stringify.h>
 
 #define WATCHDOG_NAME "ALi_M1535"
 #define WATCHDOG_TIMEOUT 60	/* 60 sec default timeout */
@@ -34,13 +35,13 @@ static int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		"Watchdog timeout in seconds. (0 < timeout < 18000, default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	ali_start	-	start watchdog countdown
diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index 03a559b41f5b..e9611c76a269 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -36,6 +36,7 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 #define WDT_ENABLE 0x9C
@@ -64,7 +65,7 @@ static int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		"Watchdog timeout in seconds. (1<=timeout<=3600, default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 static int use_gpio; /* Use the pic (for a1d revision alim7101) */
 module_param(use_gpio, int, 0);
@@ -82,7 +83,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	Whack the dog
diff --git a/drivers/watchdog/arm_smc_wdt.c b/drivers/watchdog/arm_smc_wdt.c
index bbba23ace7b8..c73ed1dcdfcb 100644
--- a/drivers/watchdog/arm_smc_wdt.c
+++ b/drivers/watchdog/arm_smc_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/moduleparam.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <uapi/linux/psci.h>
@@ -191,7 +192,7 @@ MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			__stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Julius Werner <jwerner@chromium.org>");
diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
index a17a7911771a..d62b02c40b0e 100644
--- a/drivers/watchdog/armada_37xx_wdt.c
+++ b/drivers/watchdog/armada_37xx_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -70,7 +71,7 @@ MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			   __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			   __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct armada_37xx_watchdog {
 	struct watchdog_device wdt;
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 48454ac86074..d4bd41cb801e 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -17,12 +17,13 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 struct aspeed_wdt_scu {
 	const char *compatible;
 	u32 reset_status_reg;
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index d5afcc634221..8c292d246981 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
@@ -36,13 +37,13 @@ static struct regmap *regmap_st;
 
 module_param(wdt_time, int, 0);
 MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
-				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
+				__stringify(WDT_DEFAULT_TIME) ")");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 #endif
 
 
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 80ba04df54ad..f966da602011 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -32,6 +32,7 @@
 #include <linux/uaccess.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/stringify.h>
 
 #include "at91sam9_wdt.h"
 
@@ -70,12 +71,12 @@
 static int heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
-	"(default = " __MODULE_STRING(WDT_HEARTBEAT) ")");
+	"(default = " __stringify(WDT_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define to_wdt(wdd) container_of(wdd, struct at91wdt, wdd)
 struct at91wdt {
diff --git a/drivers/watchdog/atcwdt200_wdt.c b/drivers/watchdog/atcwdt200_wdt.c
index 7e757c217b0b..ceedc3f67632 100644
--- a/drivers/watchdog/atcwdt200_wdt.c
+++ b/drivers/watchdog/atcwdt200_wdt.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* Register definitions */
@@ -570,11 +571,11 @@ module_platform_driver(atcwdt_driver);
 
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
-		 __MODULE_STRING(ATCWDT_TIMEOUT) ")");
+		 __stringify(ATCWDT_TIMEOUT) ")");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("CL Wang <cl634@andestech.com>");
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 7df703e9852a..02783c1ec526 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -32,6 +32,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #define DRIVER_NAME	"ath79-wdt"
 
@@ -50,12 +51,12 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-			   "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			   "(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int timeout = WDT_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
-			  "(default=" __MODULE_STRING(WDT_TIMEOUT) "s)");
+			  "(default=" __stringify(WDT_TIMEOUT) "s)");
 
 static unsigned long wdt_flags;
 
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 6fd8b1b8e386..1a0fc66cc093 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -20,6 +20,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/reboot.h>
+#include <linux/stringify.h>
 
 #define PM_RSTC				0x1c
 #define PM_RSTS				0x20
@@ -229,7 +230,7 @@ MODULE_PARM_DESC(heartbeat, "Initial watchdog heartbeat in seconds");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_ALIAS("platform:bcm2835-wdt");
 MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index e13ec0975bef..0d7e8a87074a 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -21,6 +21,7 @@
 #include <linux/watchdog.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
+#include <linux/stringify.h>
 
 #define DRV_NAME		"bcm47xx_wdt"
 
@@ -33,12 +34,12 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog time in seconds. (default="
-				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
+				__stringify(WDT_DEFAULT_TIME) ")");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static inline struct bcm47xx_wdt *bcm47xx_wdt_get(struct watchdog_device *wdd)
 {
diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index e038dd66b819..1117026cf959 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/bcm7038_wdt.h>
 #include <linux/pm.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define WDT_START_1		0xff00
@@ -228,7 +229,7 @@ module_platform_driver(bcm7038_wdt_driver);
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Driver for Broadcom 7038 SoCs Watchdog");
 MODULE_AUTHOR("Justin Chen");
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 1b1fb389b89b..1224d1737e87 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -12,6 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/smp.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #include <asm/reg_booke.h>
@@ -43,7 +44,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 #ifdef CONFIG_PPC_E500
 
diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index ad46b33ce5f2..0d635fb8b0f7 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define CDNS_WDT_DEFAULT_TIMEOUT	10
@@ -52,12 +53,12 @@ static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(wdt_timeout, int, 0644);
 MODULE_PARM_DESC(wdt_timeout,
 		 "Watchdog time in seconds. (default="
-		 __MODULE_STRING(CDNS_WDT_DEFAULT_TIMEOUT) ")");
+		 __stringify(CDNS_WDT_DEFAULT_TIMEOUT) ")");
 
 module_param(nowayout, int, 0644);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 /**
  * struct cdns_wdt - Watchdog device structure
diff --git a/drivers/watchdog/cgbc_wdt.c b/drivers/watchdog/cgbc_wdt.c
index 702b055ba6f4..a90e6af13bed 100644
--- a/drivers/watchdog/cgbc_wdt.c
+++ b/drivers/watchdog/cgbc_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #include <linux/mfd/cgbc.h>
@@ -38,19 +39,19 @@ static unsigned int timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. (>=0, default="
-		 __MODULE_STRING(CGBC_WDT_DEFAULT_TIMEOUT) ")");
+		 __stringify(CGBC_WDT_DEFAULT_TIMEOUT) ")");
 
 static unsigned int pretimeout = CGBC_WDT_DEFAULT_PRETIMEOUT;
 module_param(pretimeout, uint, 0);
 MODULE_PARM_DESC(pretimeout,
 		 "Watchdog pretimeout in seconds. (>=0, default="
-		 __MODULE_STRING(CGBC_WDT_DEFAULT_PRETIMEOUT) ")");
+		 __stringify(CGBC_WDT_DEFAULT_PRETIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct cgbc_wdt_data {
 	struct cgbc_device_data	*cgbc;
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index afb7887c3a1e..959cba0a8819 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
+#include <linux/stringify.h>
 
 #include <linux/mfd/da9052/reg.h>
 #include <linux/mfd/da9052/da9052.h>
@@ -34,13 +35,13 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int timeout;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. (default = "
-	__MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
+	__stringify(WDT_DEFAULT_TIMEOUT) ")");
 
 static const struct {
 	u8 reg_val;
diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 9d5a2009466f..cbb87855bd6a 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/delay.h>
+#include <linux/stringify.h>
 
 #include <linux/mfd/da9055/core.h>
 #include <linux/mfd/da9055/reg.h>
@@ -23,7 +24,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define DA9055_DEF_TIMEOUT	4
 #define DA9055_TWDMIN		256
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 6ea0434f45c2..fcee686315c3 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -19,6 +19,7 @@
 #include <linux/device.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/stringify.h>
 
 #define MODULE_NAME "DAVINCI-WDT: "
 
@@ -250,8 +251,8 @@ MODULE_DESCRIPTION("DaVinci Watchdog Driver");
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
 		 "Watchdog heartbeat period in seconds from 1 to "
-		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
-		 __MODULE_STRING(DEFAULT_HEARTBEAT));
+		 __stringify(MAX_HEARTBEAT) ", default "
+		 __stringify(DEFAULT_HEARTBEAT));
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:davinci-wdt");
diff --git a/drivers/watchdog/db8500_wdt.c b/drivers/watchdog/db8500_wdt.c
index 70ccea13288d..7e11c28997ec 100644
--- a/drivers/watchdog/db8500_wdt.c
+++ b/drivers/watchdog/db8500_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 
 #include <linux/mfd/db8500-prcmu.h>
 
@@ -27,13 +28,13 @@ static unsigned int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+				__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int db8500_wdt_start(struct watchdog_device *wdd)
 {
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 39031445d754..c1d40d7b2165 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/reset.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define WDOG_CONTROL_REG_OFFSET		    0x00
@@ -66,7 +67,7 @@ static const u32 dw_wdt_fix_tops[DW_WDT_NUM_TOPS] = {
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-		 "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 "(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 enum dw_wdt_rmod {
 	DW_WDT_RMOD_RESET = 1,
diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
index 8ef4b0df3855..39cc1f7e1cdb 100644
--- a/drivers/watchdog/ebc-c384_wdt.c
+++ b/drivers/watchdog/ebc-c384_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define MODULE_NAME		"ebc-c384_wdt"
@@ -30,12 +31,12 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static unsigned timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
-	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+	__stringify(WATCHDOG_TIMEOUT) ")");
 
 static int ebc_c384_wdt_start(struct watchdog_device *wdev)
 {
diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index 10c647b1226a..4d671c4e148a 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -56,6 +56,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 static unsigned long eurwdt_is_open;
@@ -77,7 +78,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Some symbolic names
diff --git a/drivers/watchdog/exar_wdt.c b/drivers/watchdog/exar_wdt.c
index db62c9797406..553be158a725 100644
--- a/drivers/watchdog/exar_wdt.c
+++ b/drivers/watchdog/exar_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define DRV_NAME	"exar_wdt"
@@ -70,13 +71,13 @@ static int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. 1<=timeout<=15300, default="
-		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+		 __stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int exar_sio_enter(const unsigned short config_port,
 			  const unsigned char key)
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 6a16d3d0bb1e..2790061a68f3 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define DRVNAME "f71808e_wdt"
@@ -81,20 +82,20 @@ static int timeout = WATCHDOG_TIMEOUT;	/* default timeout in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. 1<= timeout <="
-			__MODULE_STRING(WATCHDOG_MAX_TIMEOUT) " (default="
-			__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+			__stringify(WATCHDOG_MAX_TIMEOUT) " (default="
+			__stringify(WATCHDOG_TIMEOUT) ")");
 
 static unsigned int pulse_width = WATCHDOG_PULSE_WIDTH;
 module_param(pulse_width, uint, 0);
 MODULE_PARM_DESC(pulse_width,
 	"Watchdog signal pulse width. 0(=level), 1, 25, 30, 125, 150, 5000 or 6000 ms"
-			" (default=" __MODULE_STRING(WATCHDOG_PULSE_WIDTH) ")");
+			" (default=" __stringify(WATCHDOG_PULSE_WIDTH) ")");
 
 static unsigned int f71862fg_pin = WATCHDOG_F71862FG_PIN;
 module_param(f71862fg_pin, uint, 0);
 MODULE_PARM_DESC(f71862fg_pin,
 	"Watchdog f71862fg reset output pin configuration. Choose pin 56 or 63"
-			" (default=" __MODULE_STRING(WATCHDOG_F71862FG_PIN)")");
+			" (default=" __stringify(WATCHDOG_F71862FG_PIN)")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0444);
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index bf6f733dfb5f..4d39588a49c3 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #include <sysdev/fsl_soc.h>
 
@@ -70,7 +71,7 @@ static DEFINE_SPINLOCK(gef_wdt_spinlock);
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 
 static int gef_wdt_toggle_wdc(int enabled_predicate, int field_shift)
diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index 5b80ade1c681..437cc0a53654 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #include <linux/cs5535.h>
 
@@ -34,13 +35,13 @@ static int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. 1<= timeout <=131, default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+				__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static struct platform_device *geodewdt_platform_device;
 static unsigned long wdt_flags;
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 1abc7d0b78a6..2cd79c8f60dc 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -11,13 +11,14 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define SOFT_TIMEOUT_MIN	1
 #define SOFT_TIMEOUT_DEF	60
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 8af1fad2de0b..7b9eb4e4b6e7 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/types.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 #ifdef CONFIG_HPWDT_NMI_DECODING
 #include <asm/nmi.h>
@@ -432,7 +433,7 @@ MODULE_PARM_DESC(timeout, "Alias of soft_margin");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		__stringify(WATCHDOG_NOWAYOUT) ")");
 
 module_param(kdumptimeout, int, 0444);
 MODULE_PARM_DESC(kdumptimeout, "Timeout applied for crash kernel transition in seconds");
diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index a30835f547b3..006d263cf135 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -37,6 +37,7 @@
 #include <linux/ioport.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/stringify.h>
 
 /* Module and version information */
 #define ESB_MODULE_NAME "i6300ESB timer"
@@ -74,19 +75,19 @@
 #define ESB_HEARTBEAT_MIN	1
 #define ESB_HEARTBEAT_MAX	2046
 #define ESB_HEARTBEAT_DEFAULT	30
-#define ESB_HEARTBEAT_RANGE __MODULE_STRING(ESB_HEARTBEAT_MIN) \
-	"<heartbeat<" __MODULE_STRING(ESB_HEARTBEAT_MAX)
+#define ESB_HEARTBEAT_RANGE __stringify(ESB_HEARTBEAT_MIN) \
+	"<heartbeat<" __stringify(ESB_HEARTBEAT_MAX)
 static int heartbeat; /* in seconds */
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
 	"Watchdog heartbeat in seconds. (" ESB_HEARTBEAT_RANGE
-	", default=" __MODULE_STRING(ESB_HEARTBEAT_DEFAULT) ")");
+	", default=" __stringify(ESB_HEARTBEAT_DEFAULT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /* internal variables */
 struct esb_dev {
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 1dec9cd155b1..0a8bf28f5768 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -60,6 +60,7 @@
 #include <linux/ioport.h>		/* For io-port access */
 #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
 #include <linux/io.h>			/* For inb/outb/... */
+#include <linux/stringify.h>		/* For __stringify */
 #include <linux/platform_data/itco_wdt.h>
 #include <linux/mfd/intel_pmc_bxt.h>
 
@@ -115,13 +116,13 @@ static int heartbeat = WATCHDOG_TIMEOUT;  /* in seconds */
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog timeout in seconds. "
 	"5..76 (TCO v1) or 3..614 (TCO v2), default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int turn_SMI_watchdog_clear_off = 1;
 module_param(turn_SMI_watchdog_clear_off, int, 0);
diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index 5ce6101d236d..3806d86eb36a 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -41,6 +41,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 static struct platform_device *ibwdt_platform_device;
@@ -96,13 +97,13 @@ static int timeout = WATCHDOG_TIMEOUT;	/* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. 0<= timeout <=30, default="
-		__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+		__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 
 /*
diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index cf845f865945..53bd84e6d57f 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -21,6 +21,7 @@
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 enum {
@@ -413,7 +414,7 @@ module_exit(ibmasr_exit);
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_DESCRIPTION("IBM Automatic Server Restart driver");
 MODULE_AUTHOR("Andrey Panin");
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 5a7bb7e84653..eda515b917cc 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
 #include <linux/spinlock.h>
+#include <linux/stringify.h>
 
 #define DRIVER_NAME "ie6xx_wdt"
 
@@ -49,14 +50,14 @@ static unsigned int timeout = DEFAULT_TIME;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 		"Default Watchdog timer setting ("
-		__MODULE_STRING(DEFAULT_TIME) "s)."
+		__stringify(DEFAULT_TIME) "s)."
 		"The range is from 1 to 600");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static u8 resetmode = 0x10;
 module_param(resetmode, byte, 0);
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 65cc8396aa59..bb6227c40de4 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* registers */
@@ -71,12 +72,12 @@
 static int heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
-	"(default=" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
+	"(default=" __stringify(PDC_WDT_DEF_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct pdc_wdt_dev {
 	struct watchdog_device wdt_dev;
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 4b3a192ee3e8..58aa5f999f4f 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define DRIVER_NAME "imx2-wdt"
@@ -79,12 +80,12 @@ struct imx2_wdt_device {
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static unsigned timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
-				__MODULE_STRING(IMX2_WDT_DEFAULT_TIME) ")");
+				__stringify(IMX2_WDT_DEFAULT_TIME) ")");
 
 static const struct watchdog_info imx2_wdt_info = {
 	.identity = "imx2+ watchdog",
diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 855dc9d5083a..f61936194aea 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define WDOG_CS			0x0
@@ -51,7 +52,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0000);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct imx_wdt_hw_feature {
 	bool prescaler_enable;
diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
index 1280b9b1ec2a..fc39f9db4c06 100644
--- a/drivers/watchdog/imx_sc_wdt.c
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define DEFAULT_TIMEOUT 60
@@ -39,7 +40,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0000);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct imx_sc_wdt_device {
 	struct watchdog_device wdd;
diff --git a/drivers/watchdog/indydog.c b/drivers/watchdog/indydog.c
index d3092d261345..5268b1feb7ce 100644
--- a/drivers/watchdog/indydog.c
+++ b/drivers/watchdog/indydog.c
@@ -22,6 +22,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 #include <asm/sgi/mc.h>
 
 static unsigned long indydog_alive;
@@ -33,7 +34,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static void indydog_start(void)
 {
diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_wdt.c
index a39892c10770..d1e9a3f62369 100644
--- a/drivers/watchdog/intel_oc_wdt.c
+++ b/drivers/watchdog/intel_oc_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define INTEL_OC_WDT_TOV		GENMASK(9, 0)
@@ -48,12 +49,12 @@ struct intel_oc_wdt {
 static int heartbeat;
 module_param(heartbeat, uint, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. (default="
-		 __MODULE_STRING(WDT_HEARTBEAT) ")");
+		 __stringify(WDT_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int intel_oc_wdt_start(struct watchdog_device *wdd)
 {
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 1d9f8591f38d..087250ab036a 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/printk.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -105,13 +106,13 @@ static bool nowayout = DEFAULT_NOWAYOUT;
 
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, default="
-		__MODULE_STRING(DEFAULT_TIMEOUT));
+		__stringify(DEFAULT_TIMEOUT));
 module_param(testmode, int, 0);
 MODULE_PARM_DESC(testmode, "Watchdog test mode (1 = no reboot), default="
-		__MODULE_STRING(DEFAULT_TESTMODE));
+		__stringify(DEFAULT_TESTMODE));
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started, default="
-		__MODULE_STRING(WATCHDOG_NOWAYOUT));
+		__stringify(WATCHDOG_NOWAYOUT));
 
 /* Superio Chip */
 
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 395bde79e292..9dec1b822410 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 
 #define DEFAULT_HEARTBEAT 5
 #define MAX_HEARTBEAT     2048
@@ -27,14 +28,14 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static unsigned int heartbeat = DEFAULT_HEARTBEAT;
 module_param(heartbeat, uint, 0);
 MODULE_PARM_DESC(heartbeat,
 		"Watchdog heartbeat period in seconds from 1 to "
-		__MODULE_STRING(MAX_HEARTBEAT) ", default "
-		__MODULE_STRING(DEFAULT_HEARTBEAT));
+		__stringify(MAX_HEARTBEAT) ", default "
+		__stringify(DEFAULT_HEARTBEAT));
 
 struct jz4740_wdt_drvdata {
 	struct watchdog_device wdt;
diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wdt.c
index 7c8e53921e40..11b4b26f7b88 100644
--- a/drivers/watchdog/keembay_wdt.c
+++ b/drivers/watchdog/keembay_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* Non-secure watchdog register offsets */
@@ -39,12 +40,12 @@
 static unsigned int timeout = WDT_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout period in seconds (default = "
-		 __MODULE_STRING(WDT_TIMEOUT) ")");
+		 __stringify(WDT_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default = "
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct keembay_wdt {
 	struct watchdog_device	wdd;
diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index e6c7a2906680..b4cde48d2b10 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/mfd/kempld.h>
 
 #define KEMPLD_WDT_STAGE_TIMEOUT(x)	(0x1b + (x) * 4)
@@ -85,19 +86,19 @@ static unsigned int timeout = DEFAULT_TIMEOUT;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. (>=0, default="
-	__MODULE_STRING(DEFAULT_TIMEOUT) ")");
+	__stringify(DEFAULT_TIMEOUT) ")");
 
 static unsigned int pretimeout = DEFAULT_PRETIMEOUT;
 module_param(pretimeout, uint, 0);
 MODULE_PARM_DESC(pretimeout,
 	"Watchdog pretimeout in seconds. (>=0, default="
-	__MODULE_STRING(DEFAULT_PRETIMEOUT) ")");
+	__stringify(DEFAULT_PRETIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int kempld_wdt_set_stage_action(struct kempld_wdt_data *wdt_data,
 					struct kempld_wdt_stage *stage,
diff --git a/drivers/watchdog/lenovo_se10_wdt.c b/drivers/watchdog/lenovo_se10_wdt.c
index 503e220263f9..1eaf86c85cc0 100644
--- a/drivers/watchdog/lenovo_se10_wdt.c
+++ b/drivers/watchdog/lenovo_se10_wdt.c
@@ -10,6 +10,7 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -48,13 +49,13 @@ static int timeout; /* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
-		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+		 __stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct se10_wdt {
 	struct watchdog_device wdd;
diff --git a/drivers/watchdog/lenovo_se30_wdt.c b/drivers/watchdog/lenovo_se30_wdt.c
index 1c73bb7eeeee..127ea9a1933f 100644
--- a/drivers/watchdog/lenovo_se30_wdt.c
+++ b/drivers/watchdog/lenovo_se30_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define IOREGION_OFFSET	4 /* Use EC port 1 */
@@ -28,13 +29,13 @@ static int timeout; /* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
-		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+		 __stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define LNV_SE30_NAME	"lenovo-se30-wdt"
 #define LNV_SE30_ID	0x0110
diff --git a/drivers/watchdog/lenovo_se30g2_se60_wdt.c b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
index f31ecdb82ad0..c87abdb1a1b2 100644
--- a/drivers/watchdog/lenovo_se30g2_se60_wdt.c
+++ b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
@@ -10,6 +10,7 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -37,13 +38,13 @@ static int timeout; /* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
-		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+		 __stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct se_30g2_60_wdt {
 	struct watchdog_device wdd;
diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 2417519717cc..7f8de11f1b4a 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* Loongson Watchdog Register Definitions */
@@ -19,12 +20,12 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static unsigned int heartbeat;
 module_param(heartbeat, uint, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (default="
-		 __MODULE_STRING(DEFAULT_HEARTBEAT) ")");
+		 __stringify(DEFAULT_HEARTBEAT) ")");
 
 struct ls1x_wdt_pdata {
 	u32 timer_offset;
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index 3e8e80bbcb93..633119e4b126 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* Registers */
@@ -41,12 +42,12 @@
 static int heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds (default="
-		 __MODULE_STRING(LPC18XX_WDT_DEF_TIMEOUT) ")");
+		 __stringify(LPC18XX_WDT_DEF_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct lpc18xx_wdt_dev {
 	struct watchdog_device	wdt_dev;
diff --git a/drivers/watchdog/ma35d1_wdt.c b/drivers/watchdog/ma35d1_wdt.c
index 119d58f338bf..ede4bee594f1 100644
--- a/drivers/watchdog/ma35d1_wdt.c
+++ b/drivers/watchdog/ma35d1_wdt.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/property.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -355,7 +356,7 @@ MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds");
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(
 	nowayout,
-	"Watchdog cannot be stopped once started (default=" __MODULE_STRING(
+	"Watchdog cannot be stopped once started (default=" __stringify(
 		WATCHDOG_NOWAYOUT) ")");
 
 MODULE_AUTHOR("Zi-Yu Chen <zychennvt@gmail.com>");
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index e9073df1a7de..aefda26bbcec 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/property.h>
+#include <linux/stringify.h>
 
 #define DEFAULT_HEARTBEAT 60
 #define MAX_HEARTBEAT     60
@@ -283,12 +284,12 @@ MODULE_DESCRIPTION("max63xx Watchdog Driver");
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
 		 "Watchdog heartbeat period in seconds from 1 to "
-		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
-		 __MODULE_STRING(DEFAULT_HEARTBEAT));
+		 __stringify(MAX_HEARTBEAT) ", default "
+		 __stringify(DEFAULT_HEARTBEAT));
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 module_param(nodelay, int, 0);
 MODULE_PARM_DESC(nodelay,
diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index ed5a98cea525..79148cbad4f2 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -255,7 +256,7 @@ MODULE_DESCRIPTION("Max77620 watchdog timer driver");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 99d2359d5a8a..a762462c25c5 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/of.h>
+#include <linux/stringify.h>
 
 #define NUM_GPIOS 6
 
@@ -37,7 +38,7 @@ struct a21_wdt_drv {
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			    __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			    __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static unsigned int a21_wdt_get_bootstatus(struct a21_wdt_drv *drv)
 {
diff --git a/drivers/watchdog/menf21bmc_wdt.c b/drivers/watchdog/menf21bmc_wdt.c
index 81ebdfc371f4..bb8eda18fbad 100644
--- a/drivers/watchdog/menf21bmc_wdt.c
+++ b/drivers/watchdog/menf21bmc_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/stringify.h>
 
 #define DEVNAME "menf21bmc_wdt"
 
@@ -28,7 +29,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct menf21bmc_wdt {
 	struct watchdog_device wdt;
diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
index 3fe23451135d..962c6867bc07 100644
--- a/drivers/watchdog/menz69_wdt.c
+++ b/drivers/watchdog/menz69_wdt.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/mcb.h>
 #include <linux/module.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 struct men_z069_drv {
@@ -29,7 +30,7 @@ struct men_z069_drv {
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			    __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			    __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int men_z069_wdt_start(struct watchdog_device *wdt)
 {
diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index a48622d11ad7..fb276060e831 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -31,12 +32,12 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static unsigned int timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds="
-		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
+		 __stringify(DEFAULT_TIMEOUT) ")");
 
 struct meson_gxbb_wdt {
 	void __iomem *reg_base;
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 44db4ebc8599..80a4f8771335 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -218,7 +219,7 @@ MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds");
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
index 1ecd5c48a005..db358df2f222 100644
--- a/drivers/watchdog/mixcomwd.c
+++ b/drivers/watchdog/mixcomwd.c
@@ -52,6 +52,7 @@
 #include <linux/timer.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/stringify.h>
 
 /*
  * We have two types of cards that can be probed:
@@ -107,7 +108,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static void mixcomwd_ping(void)
 {
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index a4b497ecfa20..0d5a360b5629 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -22,6 +22,7 @@
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 #include <sysdev/fsl_soc.h>
 
 #define WATCHDOG_TIMEOUT 10
@@ -57,7 +58,7 @@ static u16 timeout;
 module_param(timeout, ushort, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. (1<timeout<65535, default="
-	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+	__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool reset = 1;
 module_param(reset, bool, 0);
@@ -67,7 +68,7 @@ MODULE_PARM_DESC(reset,
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-		 "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 "(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static void mpc8xxx_wdt_keepalive(struct mpc8xxx_wdt_ddata *ddata)
 {
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index db47b131f780..9e0ebec43c88 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 
 #define SYSC_RSTSTAT			0x38
 #define WDT_RST_CAUSE			BIT(1)
@@ -41,7 +42,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static inline void rt_wdt_w32(void __iomem *base, unsigned int reg, u32 val)
 {
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index d9c30e4c80e3..46a83660f098 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/interrupt.h>
+#include <linux/stringify.h>
 
 #define WDT_MAX_TIMEOUT		31
 #define WDT_MIN_TIMEOUT		2
@@ -526,7 +527,7 @@ MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			__stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matthias Brugger <matthias.bgg@gmail.com>");
diff --git a/drivers/watchdog/nct6694_wdt.c b/drivers/watchdog/nct6694_wdt.c
index bc3689bd4b6b..169a6736e9ea 100644
--- a/drivers/watchdog/nct6694_wdt.c
+++ b/drivers/watchdog/nct6694_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define DEVICE_NAME "nct6694-wdt"
@@ -50,7 +51,7 @@ MODULE_PARM_DESC(pretimeout, "Watchdog pre-timeout in seconds");
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			   __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			   __stringify(WATCHDOG_NOWAYOUT) ")");
 
 enum {
 	NCT6694_ACTION_NONE = 0,
diff --git a/drivers/watchdog/ni903x_wdt.c b/drivers/watchdog/ni903x_wdt.c
index c72a9ee9cb8e..68b7c485726b 100644
--- a/drivers/watchdog/ni903x_wdt.c
+++ b/drivers/watchdog/ni903x_wdt.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define NIWD_CONTROL	0x01
@@ -46,13 +47,13 @@ static unsigned int timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. (default="
-		 __MODULE_STRING(NIWD_DEFAULT_TIMEOUT) ")");
+		 __stringify(NIWD_DEFAULT_TIMEOUT) ")");
 
 static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, S_IRUGO);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static void ni903x_start(struct ni903x_wdt *wdt)
 {
diff --git a/drivers/watchdog/nic7018_wdt.c b/drivers/watchdog/nic7018_wdt.c
index 8169423801f0..2b122ba8733a 100644
--- a/drivers/watchdog/nic7018_wdt.c
+++ b/drivers/watchdog/nic7018_wdt.c
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -34,13 +35,13 @@ static unsigned int timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. (default="
-		 __MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
+		 __stringify(WDT_DEFAULT_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started. (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct nic7018_wdt {
 	u16 io_base;
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index f16cee5173d5..0d671b8bb391 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -32,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/stringify.h>
 
 #include "nv_tco.h"
 
@@ -55,12 +56,12 @@ static struct platform_device *nv_tco_platform_device;
 static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (2<heartbeat<39, "
-			    "default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+			    "default=" __stringify(WATCHDOG_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started"
-		" (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		" (default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Some TCO specific functions
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 0615bb816082..171b46d780e6 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -55,6 +55,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/stringify.h>
 
 #include <asm/mipsregs.h>
 #include <asm/uasm.h>
@@ -93,13 +94,13 @@ static int heartbeat = WD_TIMO;
 module_param(heartbeat, int, 0444);
 MODULE_PARM_DESC(heartbeat,
 	"Watchdog heartbeat in seconds. (0 < heartbeat, default="
-				__MODULE_STRING(WD_TIMO) ")");
+				__stringify(WD_TIMO) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0444);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int disable;
 module_param(disable, int, 0444);
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 95c7e44b7baa..2a6de73e6f0b 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/stringify.h>
 #include <linux/platform_data/omap-wd-timer.h>
 
 #include "omap_wdt.h"
@@ -45,7 +46,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 0ea946823b0a..5d56e93f0406 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/stringify.h>
 
 /* RSTOUT mask register physical address for Orion5x, Kirkwood and Dove */
 #define ORION_RSTOUT_MASK_OFFSET	0x20108
@@ -687,7 +688,7 @@ MODULE_PARM_DESC(heartbeat, "Initial watchdog heartbeat in seconds");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:orion_wdt");
diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index fbf835d112b8..29dab0e669bf 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -30,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 /* #define DEBUG 1 */
@@ -577,15 +578,15 @@ MODULE_LICENSE("GPL");
 
 module_param_hw(io, int, ioport, 0);
 MODULE_PARM_DESC(io, MODNAME " I/O port (default: "
-					__MODULE_STRING(IO_DEFAULT) ").");
+					__stringify(IO_DEFAULT) ").");
 
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		"Watchdog timeout in minutes (default="
-				__MODULE_STRING(DEFAULT_TIMEOUT) ").");
+				__stringify(DEFAULT_TIMEOUT) ").");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index d4ea7d6ccd6a..3370a9155276 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -72,6 +72,7 @@
 #include <linux/spinlock.h>	/* For spin_lock/spin_unlock/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
 #include <linux/io.h>		/* For inb/outb/... */
+#include <linux/stringify.h>	/* For __stringify */
 
 /* Module and version information */
 #define WATCHDOG_VERSION "1.20"
@@ -203,13 +204,13 @@ static int heartbeat = WATCHDOG_HEARTBEAT;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. "
 	"(2 <= heartbeat <= 7200 or 0=delay-time from dip-switches, default="
-				__MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+				__stringify(WATCHDOG_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	Internal functions
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index a489b426f2ba..377e5a61faef 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -47,6 +47,7 @@
 #include <linux/spinlock.h>	/* For spin_lock/spin_unlock/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
 #include <linux/io.h>		/* For inb/outb/... */
+#include <linux/stringify.h>	/* For __stringify */
 
 /* Module and version information */
 #define WATCHDOG_VERSION "1.03"
@@ -140,12 +141,12 @@ static int heartbeat = WATCHDOG_HEARTBEAT;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. "
 	"(0<heartbeat<65536 or 0=delay-time from dip-switches, default="
-				__MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+				__stringify(WATCHDOG_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-					__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+					__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	Internal functions
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index d7c18c990649..15511c816add 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -39,6 +39,7 @@
 #include <linux/mutex.h>	/* For mutex locking */
 #include <linux/hid.h>		/* For HID_REQ_SET_REPORT & HID_DT_REPORT */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
+#include <linux/stringify.h>	/* For __stringify */
 
 
 /* Module and Version Information */
@@ -57,12 +58,12 @@ static int heartbeat = WATCHDOG_HEARTBEAT;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. "
 	"(0<heartbeat<65536 or 0=delay-time from dip-switches, default="
-				__MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+				__stringify(WATCHDOG_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /* The vendor and product id's for the USB-PC Watchdog card */
 #define USB_PCWD_VENDOR_ID	0x0c98
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 87b8988d2520..09fc76aaa051 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/stringify.h>
 
 #define DRV_NAME "PIKA-WDT"
 
@@ -39,12 +40,12 @@
 static int heartbeat = WDT_HEARTBEAT;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
-	"(default = " __MODULE_STRING(WDT_HEARTBEAT) ")");
+	"(default = " __stringify(WDT_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static struct {
 	void __iomem *fpga;
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 87a44a5675a1..a7c39849cbfd 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
+#include <linux/stringify.h>
 
 /* WatchDog Timer - Chapter 23 Page 207 */
 
@@ -237,8 +238,8 @@ MODULE_DESCRIPTION("PNX4008 Watchdog Driver");
 module_param(heartbeat, uint, 0);
 MODULE_PARM_DESC(heartbeat,
 		 "Watchdog heartbeat period in seconds from 1 to "
-		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
-		 __MODULE_STRING(DEFAULT_HEARTBEAT));
+		 __stringify(MAX_HEARTBEAT) ", default "
+		 __stringify(DEFAULT_HEARTBEAT));
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
diff --git a/drivers/watchdog/pseries-wdt.c b/drivers/watchdog/pseries-wdt.c
index e97b943e1d3c..5f531a03a0fc 100644
--- a/drivers/watchdog/pseries-wdt.c
+++ b/drivers/watchdog/pseries-wdt.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/time64.h>
 #include <linux/watchdog.h>
 #include <asm/papr-watchdog.h>
@@ -26,18 +27,18 @@ static const unsigned long pseries_wdt_action[] = {
 static unsigned int action = WATCHDOG_ACTION;
 module_param(action, uint, 0444);
 MODULE_PARM_DESC(action, "Action taken when watchdog expires (default="
-		 __MODULE_STRING(WATCHDOG_ACTION) ")");
+		 __stringify(WATCHDOG_ACTION) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0444);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define WATCHDOG_TIMEOUT 60
 static unsigned int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, uint, 0444);
 MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds (default="
-		 __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+		 __stringify(WATCHDOG_TIMEOUT) ")");
 
 struct pseries_wdt {
 	struct watchdog_device wd;
diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index 0e5c5c96af58..5301a93abf55 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
 #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
 #include <linux/io.h>			/* For devm_ioremap */
+#include <linux/stringify.h>		/* For __stringify */
 
 #include <asm/mach-rc32434/integ.h>	/* For the Watchdog registers */
 
@@ -57,12 +58,12 @@ extern unsigned int idt_cpu_freq;
 static int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout value, in seconds (default="
-		__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+		__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /* apply or and nand masks to data read from addr and write back */
 #define SET_BITS(addr, or, nand) \
diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 97bcd32bade5..8c0041ce5552 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/smp.h>
+#include <linux/stringify.h>
 #include <linux/sys_soc.h>
 #include <linux/watchdog.h>
 
@@ -44,7 +45,7 @@ static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024, 4096 };
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct rwdt_priv {
 	void __iomem *base;
diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
index 87d06d210ac9..14056af36445 100644
--- a/drivers/watchdog/rn5t618_wdt.c
+++ b/drivers/watchdog/rn5t618_wdt.c
@@ -9,6 +9,7 @@
 #include <linux/mfd/rn5t618.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define DRIVER_NAME "rn5t618-wdt"
@@ -21,7 +22,7 @@ MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct rn5t618_wdt {
 	struct watchdog_device wdt_dev;
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index c8edd83bb502..38f31d302a4b 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 
 #include <asm/mach-ralink/ralink_regs.h>
 
@@ -51,7 +52,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static inline void rt_wdt_w32(void __iomem *base, unsigned int reg, u32 val)
 {
diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 7c1bd83b056a..6a64adbe1a8e 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -414,8 +415,8 @@ MODULE_DESCRIPTION("K3 RTI Watchdog Driver");
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
 		 "Watchdog heartbeat period in seconds from 1 to "
-		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
-		 __MODULE_STRING(DEFAULT_HEARTBEAT));
+		 __stringify(MAX_HEARTBEAT) ", default "
+		 __stringify(DEFAULT_HEARTBEAT));
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:rti-wdt");
diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 509f9dffdacd..592ea7ce6d69 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/stringify.h>
 #include <linux/reset.h>
 #include <linux/units.h>
 #include <linux/watchdog.h>
@@ -41,7 +42,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 enum rz_wdt_type {
 	WDT_RZG2L,
diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 83540dd9a37b..a8db85e85c73 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/stringify.h>
 #include <linux/units.h>
 #include <linux/watchdog.h>
 
@@ -48,7 +49,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 enum rzv2h_wdt_count_source {
 	COUNT_SOURCE_LOCO,
diff --git a/drivers/watchdog/s32g_wdt.c b/drivers/watchdog/s32g_wdt.c
index 6422a694fc65..bd8740153c17 100644
--- a/drivers/watchdog/s32g_wdt.c
+++ b/drivers/watchdog/s32g_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/moduleparam.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define DRIVER_NAME "s32g-swt"
@@ -42,12 +43,12 @@ struct s32g_wdt_device {
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static unsigned int timeout_param = S32G_WDT_DEFAULT_TIMEOUT;
 module_param(timeout_param, uint, 0);
 MODULE_PARM_DESC(timeout_param, "Watchdog timeout in seconds (default="
-		 __MODULE_STRING(S32G_WDT_DEFAULT_TIMEOUT) ")");
+		 __stringify(S32G_WDT_DEFAULT_TIMEOUT) ")");
 
 static bool early_enable;
 module_param(early_enable, bool, 0);
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index e31f93db0509..8ae60b919c12 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -28,6 +28,7 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/math64.h>
+#include <linux/stringify.h>
 
 #define S3C2410_WTCON		0x00
 #define S3C2410_WTDAT		0x04
@@ -154,12 +155,12 @@ module_param(nowayout,   bool, 0);
 module_param(soft_noboot, int, 0);
 
 MODULE_PARM_DESC(tmr_margin, "Watchdog tmr_margin in seconds. (default="
-		__MODULE_STRING(S3C2410_WATCHDOG_DEFAULT_TIME) ")");
+		__stringify(S3C2410_WATCHDOG_DEFAULT_TIME) ")");
 MODULE_PARM_DESC(tmr_atboot,
 		"Watchdog is started at boot time if set to 1, default="
-			__MODULE_STRING(S3C2410_WATCHDOG_ATBOOT));
+			__stringify(S3C2410_WATCHDOG_ATBOOT));
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			__stringify(WATCHDOG_NOWAYOUT) ")");
 MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default 0)");
 
 /**
diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index ecdd9aeab79c..85efe4db40f0 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #include "at91sam9_wdt.h"
@@ -42,12 +43,12 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(wdt_timeout, int, 0);
 MODULE_PARM_DESC(wdt_timeout,
 	"Watchdog timeout in seconds. (default = "
-	__MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
+	__stringify(WDT_DEFAULT_TIMEOUT) ")");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static inline bool wdt_enabled(struct sama5d4_wdt *wdt)
 {
diff --git a/drivers/watchdog/sbc60xxwdt.c b/drivers/watchdog/sbc60xxwdt.c
index 03eaf48c8f0f..fffe58dcbf93 100644
--- a/drivers/watchdog/sbc60xxwdt.c
+++ b/drivers/watchdog/sbc60xxwdt.c
@@ -58,6 +58,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 #define OUR_NAME "sbc60xxwdt"
@@ -98,13 +99,13 @@ static int timeout = WATCHDOG_TIMEOUT;	/* in seconds, multiplied by HZ to
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. (1<=timeout<=3600, default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static void wdt_timer_ping(struct timer_list *);
 static DEFINE_TIMER(timer, wdt_timer_ping);
diff --git a/drivers/watchdog/sbc7240_wdt.c b/drivers/watchdog/sbc7240_wdt.c
index 21a1f0b32070..077abbdbf582 100644
--- a/drivers/watchdog/sbc7240_wdt.c
+++ b/drivers/watchdog/sbc7240_wdt.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
+#include <linux/stringify.h>
 
 #define SBC7240_ENABLE_PORT		0x443
 #define SBC7240_DISABLE_PORT		0x043
@@ -34,8 +35,8 @@
 static int timeout = SBC7240_TIMEOUT;	/* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (1<=timeout<="
-		 __MODULE_STRING(SBC7240_MAX_TIMEOUT) ", default="
-		 __MODULE_STRING(SBC7240_TIMEOUT) ")");
+		 __stringify(SBC7240_MAX_TIMEOUT) ", default="
+		 __stringify(SBC7240_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
diff --git a/drivers/watchdog/sbc8360.c b/drivers/watchdog/sbc8360.c
index a9fd1615b4c3..dafef1df9719 100644
--- a/drivers/watchdog/sbc8360.c
+++ b/drivers/watchdog/sbc8360.c
@@ -48,6 +48,7 @@
 #include <linux/moduleparam.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 static unsigned long sbc8360_is_open;
@@ -199,7 +200,7 @@ MODULE_PARM_DESC(timeout, "Index into timeout table (0-63) (default=27 (60s))");
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	Kernel methods.
diff --git a/drivers/watchdog/sbc_epx_c3.c b/drivers/watchdog/sbc_epx_c3.c
index 1d291dc0a4a6..b17bd1db7b10 100644
--- a/drivers/watchdog/sbc_epx_c3.c
+++ b/drivers/watchdog/sbc_epx_c3.c
@@ -25,6 +25,7 @@
 #include <linux/ioport.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/stringify.h>
 
 static int epx_c3_alive;
 
@@ -33,7 +34,7 @@ static int epx_c3_alive;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-					__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+					__stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define EPXC3_WATCHDOG_CTL_REG 0x1ee /* write 1 to enable, 0 to disable */
 #define EPXC3_WATCHDOG_PET_REG 0x1ef /* write anything to pet once enabled */
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index e04d42cc7774..3d271b1efb56 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -46,6 +46,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <asm/arch_timer.h>
@@ -103,7 +104,7 @@ static unsigned int timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. (>=0, default="
-		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
+		 __stringify(DEFAULT_TIMEOUT) ")");
 
 /*
  * action refers to action taken when watchdog gets WS0
@@ -120,7 +121,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, S_IRUGO);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Arm Base System Architecture 1.0 introduces watchdog v1 which
diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 1d3300c98d43..34cd57420c86 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -42,6 +42,7 @@
 #include <linux/semaphore.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #define SC1200_MODULE_VER	"build 20020303"
 #define SC1200_MODULE_NAME	"sc1200wdt"
@@ -92,7 +93,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 
 
diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index 9670a1ea57cb..a2a0b5c2b55b 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
 #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
 #include <linux/io.h>			/* For inb/outb/... */
+#include <linux/stringify.h>		/* For __stringify */
 
 /* Module and version information */
 #define DRV_NAME	"sch311x_wdt"
@@ -68,13 +69,13 @@ static int timeout = WATCHDOG_TIMEOUT;	/* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. 1<= timeout <=15300, default="
-		__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+		__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	Super-IO functions
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 719f100aae60..8adecf54b9bc 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -30,6 +30,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/stringify.h>
 #include <asm/watchdog.h>
 
 #define DRV_NAME "sh-wdt"
@@ -329,14 +330,14 @@ MODULE_ALIAS("platform:" DRV_NAME);
 module_param(clock_division_ratio, int, 0);
 MODULE_PARM_DESC(clock_division_ratio,
 	"Clock division ratio. Valid ranges are from 0x5 (1.31ms) "
-	"to 0x7 (5.25ms). (default=" __MODULE_STRING(WTCSR_CKS_4096) ")");
+	"to 0x7 (5.25ms). (default=" __stringify(WTCSR_CKS_4096) ")");
 
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
 	"Watchdog heartbeat in seconds. (1 <= heartbeat <= 3600, default="
-				__MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+				__stringify(WATCHDOG_HEARTBEAT) ")");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
index 1e91f0a560ff..addeecccf2e9 100644
--- a/drivers/watchdog/simatic-ipc-wdt.c
+++ b/drivers/watchdog/simatic-ipc-wdt.c
@@ -22,6 +22,7 @@
 #include <linux/sizes.h>
 #include <linux/util_macros.h>
 #include <linux/watchdog.h>
+#include <linux/stringify.h>
 
 #define WD_ENABLE_IOADR			0x62
 #define WD_TRIGGER_IOADR		0x66
@@ -42,7 +43,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0000);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static struct resource gp_status_reg_227e_res =
 	DEFINE_RES_IO_NAMED(GP_STATUS_REG_227E, SZ_1, KBUILD_MODNAME);
diff --git a/drivers/watchdog/sl28cpld_wdt.c b/drivers/watchdog/sl28cpld_wdt.c
index c0b5e5fff5d7..e32b757372eb 100644
--- a/drivers/watchdog/sl28cpld_wdt.c
+++ b/drivers/watchdog/sl28cpld_wdt.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /*
@@ -30,7 +31,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int timeout;
 module_param(timeout, int, 0);
diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
index 9f2c2ab4e2f1..0ee36ae3113e 100644
--- a/drivers/watchdog/smsc37b787_wdt.c
+++ b/drivers/watchdog/smsc37b787_wdt.c
@@ -55,6 +55,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 /* enable support for minutes as units? */
@@ -611,4 +612,4 @@ MODULE_PARM_DESC(timeout, "range is 1-255 units, default is 60");
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 0820e35ad2e3..0ff125958b8a 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/reboot.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/workqueue.h>
@@ -33,13 +34,13 @@ static unsigned int soft_margin = TIMER_MARGIN;	/* in seconds */
 module_param(soft_margin, uint, 0);
 MODULE_PARM_DESC(soft_margin,
 	"Watchdog soft_margin in seconds. (0 < soft_margin < 65536, default="
-					__MODULE_STRING(TIMER_MARGIN) ")");
+					__stringify(TIMER_MARGIN) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int soft_noboot;
 module_param(soft_noboot, int, 0);
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 72ad59649ccc..c4809858a6fe 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -39,6 +39,7 @@
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -69,18 +70,18 @@ static struct pci_dev *sp5100_tco_pci;
 static bool action = WATCHDOG_ACTION;
 module_param(action, bool, 0);
 MODULE_PARM_DESC(action, "Action taken when watchdog expires, 0 to reset, 1 to poweroff (default="
-		 __MODULE_STRING(WATCHDOG_ACTION) ")");
+		 __stringify(WATCHDOG_ACTION) ")");
 
 #define WATCHDOG_HEARTBEAT 60	/* 60 sec default heartbeat. */
 static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (default="
-		 __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+		 __stringify(WATCHDOG_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started."
-		" (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		" (default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Some TCO specific functions
diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 5a3254c83d3b..044b4fdb7350 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* JH7100 Watchdog register define */
@@ -72,12 +73,12 @@ module_param(early_enable, bool, 0);
 module_param(nowayout, bool, 0);
 
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (default="
-		 __MODULE_STRING(STARFIVE_WDT_DEFAULT_TIME) ")");
+		 __stringify(STARFIVE_WDT_DEFAULT_TIME) ")");
 MODULE_PARM_DESC(early_enable,
 		 "Watchdog is started at boot time if set to 1, default="
-		 __MODULE_STRING(STARFIVE_WDT_EARLY_ENA));
+		 __stringify(STARFIVE_WDT_EARLY_ENA));
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct starfive_wdt_variant {
 	unsigned int control;		/* Watchdog Control Register for reset enable */
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 060447101f48..c9cbf9728a2a 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/stmp3xxx_rtc_wdt.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
+#include <linux/stringify.h>
 
 #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
 #define STMP3XXX_DEFAULT_TIMEOUT 19
@@ -21,8 +22,8 @@
 static int heartbeat = STMP3XXX_DEFAULT_TIMEOUT;
 module_param(heartbeat, uint, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat period in seconds from 1 to "
-		 __MODULE_STRING(STMP3XXX_MAX_TIMEOUT) ", default "
-		 __MODULE_STRING(STMP3XXX_DEFAULT_TIMEOUT));
+		 __stringify(STMP3XXX_MAX_TIMEOUT) ", default "
+		 __stringify(STMP3XXX_DEFAULT_TIMEOUT));
 
 static int wdt_start(struct watchdog_device *wdd)
 {
diff --git a/drivers/watchdog/stpmic1_wdt.c b/drivers/watchdog/stpmic1_wdt.c
index 45d0c543466f..17f0cdecd22c 100644
--- a/drivers/watchdog/stpmic1_wdt.c
+++ b/drivers/watchdog/stpmic1_wdt.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* WATCHDOG CONTROL REGISTER bit */
@@ -25,7 +26,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct stpmic1_wdt {
 	struct stpmic1 *pmic;
diff --git a/drivers/watchdog/sun4v_wdt.c b/drivers/watchdog/sun4v_wdt.c
index 8db86ad5ee3d..ad56d778776e 100644
--- a/drivers/watchdog/sun4v_wdt.c
+++ b/drivers/watchdog/sun4v_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 #include <asm/hypervisor.h>
 #include <asm/mdesc.h>
@@ -27,12 +28,12 @@
 static unsigned int timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
-	__MODULE_STRING(WDT_TIMEOUT) ")");
+	__stringify(WDT_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, S_IRUGO);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int sun4v_wdt_stop(struct watchdog_device *wdd)
 {
diff --git a/drivers/watchdog/sunplus_wdt.c b/drivers/watchdog/sunplus_wdt.c
index ae0c11a15a05..f2e45907d882 100644
--- a/drivers/watchdog/sunplus_wdt.c
+++ b/drivers/watchdog/sunplus_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define WDT_CTRL		0x00
@@ -38,7 +39,7 @@ MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			__stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct sp_wdt_priv {
 	struct watchdog_device wdev;
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 3db34524ed13..1e55c5fd43b8 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define WDT_MAX_TIMEOUT         16
@@ -357,7 +358,7 @@ MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds");
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-		"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Carlo Caione <carlo.caione@gmail.com>");
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index d5de6c0657a5..6b3f65c4d593 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* minimum and maximum watchdog trigger timeout, in seconds */
@@ -67,13 +68,13 @@ static int heartbeat = WDT_HEARTBEAT;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
 	"Watchdog heartbeats in seconds. (default = "
-	__MODULE_STRING(WDT_HEARTBEAT) ")");
+	__stringify(WDT_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int tegra_wdt_start(struct watchdog_device *wdd)
 {
diff --git a/drivers/watchdog/tqmx86_wdt.c b/drivers/watchdog/tqmx86_wdt.c
index 83860e94ce9d..1da45a3f8cf3 100644
--- a/drivers/watchdog/tqmx86_wdt.c
+++ b/drivers/watchdog/tqmx86_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/timer.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* default timeout (secs) */
@@ -23,7 +24,7 @@ static unsigned int timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. (1<=timeout<=4096, default="
-				__MODULE_STRING(WDT_TIMEOUT) ")");
+				__stringify(WDT_TIMEOUT) ")");
 struct tqmx86_wdt {
 	struct watchdog_device wdd;
 	void __iomem *io_base;
diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
index 24b1ad52102e..1bfc8db323c6 100644
--- a/drivers/watchdog/ts4800_wdt.c
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -12,13 +12,14 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /* possible feed values */
 #define TS4800_WDT_FEED_2S       0x1
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 69a622646d75..d5e06dcf74d9 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -12,13 +12,14 @@
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/twl.h>
+#include <linux/stringify.h>
 
 #define TWL4030_WATCHDOG_CFG_REG_OFFS	0x3
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int twl4030_wdt_write(unsigned char val)
 {
diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index 305349844b4f..161a779dc74d 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/stringify.h>
 #include <asm/txx9tmr.h>
 
 #define WD_TIMER_CCD	7		/* 1/256 */
@@ -27,14 +28,14 @@ static unsigned int timeout = TIMER_MARGIN;	/* in seconds */
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. "
-	"(0<timeout<((2^" __MODULE_STRING(TXX9_TIMER_BITS) ")/(IMCLK/256)), "
-	"default=" __MODULE_STRING(TIMER_MARGIN) ")");
+	"(0<timeout<((2^" __stringify(TXX9_TIMER_BITS) ")/(IMCLK/256)), "
+	"default=" __stringify(TIMER_MARGIN) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started "
-	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static struct txx9_tmr_reg __iomem *txx9wdt_reg;
 static struct clk *txx9_imclk;
diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
index 8e9242c23022..d09fb2acfdde 100644
--- a/drivers/watchdog/uniphier_wdt.c
+++ b/drivers/watchdog/uniphier_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* WDT timer setting register */
@@ -245,12 +246,12 @@ module_platform_driver(uniphier_wdt_driver);
 module_param(timeout, uint, 0000);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout seconds in power of 2. (0 < timeout < 128, default="
-				__MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
+				__stringify(WDT_DEFAULT_TIMEOUT) ")");
 
 module_param(nowayout, bool, 0000);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_AUTHOR("Keiji Hayashibara <hayashibara.keiji@socionext.com>");
 MODULE_DESCRIPTION("UniPhier Watchdog Device Driver");
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index be4ca619da65..effa9bc8d354 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/stringify.h>
 #include <linux/timer.h>
 #include <linux/watchdog.h>
 
@@ -56,12 +57,12 @@
 static int timeout = WDT_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, between 1 and 1023 "
-	"(default = " __MODULE_STRING(WDT_TIMEOUT) ")");
+	"(default = " __stringify(WDT_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-	"(default = " __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default = " __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static struct watchdog_device wdt_dev;
 static struct resource wdt_res;
diff --git a/drivers/watchdog/visconti_wdt.c b/drivers/watchdog/visconti_wdt.c
index 7795e7fbf67e..fc4f0d4d3d55 100644
--- a/drivers/watchdog/visconti_wdt.c
+++ b/drivers/watchdog/visconti_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define WDT_CNT			0x00
@@ -29,7 +30,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(
 	nowayout,
-	"Watchdog cannot be stopped once started (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT)")");
+	"Watchdog cannot be stopped once started (default=" __stringify(WATCHDOG_NOWAYOUT)")");
 
 struct visconti_wdt_priv {
 	struct watchdog_device wdev;
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index db77599e43a0..5aa4d9c0fc00 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/dmi.h>
+#include <linux/stringify.h>
 
 #define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
 #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
@@ -55,13 +56,13 @@ static int timeout;			/* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+				__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int early_disable;
 module_param(early_disable, int, 0);
diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
index 53db59ef774b..3187ea9d1b57 100644
--- a/drivers/watchdog/w83877f_wdt.c
+++ b/drivers/watchdog/w83877f_wdt.c
@@ -54,6 +54,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #define OUR_NAME "w83877f_wdt"
 
@@ -84,14 +85,14 @@ static int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in seconds. (1<=timeout<=3600, default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static void wdt_timer_ping(struct timer_list *);
 static DEFINE_TIMER(timer, wdt_timer_ping);
diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index 3776030fa7c6..019fbf65eeb4 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -25,6 +25,7 @@
 #include <linux/reboot.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/stringify.h>
 
 
 #define WATCHDOG_VERSION  "1.00"
@@ -49,7 +50,7 @@ static	DEFINE_SPINLOCK(spinlock);
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		"Watchdog timeout in seconds (15..7635), default="
-				__MODULE_STRING(DEFAULT_TIMEOUT) ")");
+				__stringify(DEFAULT_TIMEOUT) ")");
 module_param(testmode, int, 0);
 MODULE_PARM_DESC(testmode, "Watchdog testmode (1 = no reboot), default=0");
 
@@ -57,7 +58,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Start the watchdog
diff --git a/drivers/watchdog/wafer5823wdt.c b/drivers/watchdog/wafer5823wdt.c
index 291109349e73..c564d51fe5a5 100644
--- a/drivers/watchdog/wafer5823wdt.c
+++ b/drivers/watchdog/wafer5823wdt.c
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #define WATCHDOG_NAME "Wafer 5823 WDT"
 #define PFX WATCHDOG_NAME ": "
@@ -61,13 +62,13 @@ static int timeout = WD_TIMO;  /* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
-				__MODULE_STRING(WD_TIMO) ".");
+				__stringify(WD_TIMO) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static void wafwdt_ping(void)
 {
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index d7895009a2de..1e1c3431b007 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -44,6 +44,7 @@
 #include <linux/types.h>	/* For standard types (like size_t) */
 #include <linux/watchdog.h>	/* For watchdog specific items */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
+#include <linux/stringify.h>	/* For __stringify */
 
 #include "watchdog_core.h"
 #include "watchdog_pretimeout.h"
@@ -1314,9 +1315,9 @@ int watchdog_dev_resume(struct watchdog_device *wdd)
 module_param(handle_boot_enabled, bool, 0444);
 MODULE_PARM_DESC(handle_boot_enabled,
 	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
-	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
+	__stringify(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
 
 module_param(open_timeout, uint, 0644);
 MODULE_PARM_DESC(open_timeout,
 	"Maximum time (in seconds, 0 means infinity) for userspace to take over a running watchdog (default="
-	__MODULE_STRING(CONFIG_WATCHDOG_OPEN_TIMEOUT) ")");
+	__stringify(CONFIG_WATCHDOG_OPEN_TIMEOUT) ")");
diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 55ea16e73652..a418da46bda2 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #define MAX_WDAT_ACTIONS ACPI_WDAT_ACTION_RESERVED
@@ -54,14 +55,14 @@ struct wdat_wdt {
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define WDAT_DEFAULT_TIMEOUT	30
 
 static int timeout = WDAT_DEFAULT_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
-		 __MODULE_STRING(WDAT_DEFAULT_TIMEOUT) ")");
+		 __stringify(WDAT_DEFAULT_TIMEOUT) ")");
 
 static int wdat_wdt_read(struct wdat_wdt *wdat,
 	 const struct wdat_instruction *instr, u32 *value)
diff --git a/drivers/watchdog/wdt.c b/drivers/watchdog/wdt.c
index 3980d60bacd8..d8681ee547ee 100644
--- a/drivers/watchdog/wdt.c
+++ b/drivers/watchdog/wdt.c
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #include "wd501p.h"
 
@@ -60,13 +61,13 @@ static int wd_heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
 	"Watchdog heartbeat in seconds. (0 < heartbeat < 65536, default="
-				__MODULE_STRING(WD_TIMO) ")");
+				__stringify(WD_TIMO) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /* You must set these - there is no sane way to probe for this board. */
 static int io = 0x240;
diff --git a/drivers/watchdog/wdt977.c b/drivers/watchdog/wdt977.c
index 4f449ac4dda4..f0fb82dc3c93 100644
--- a/drivers/watchdog/wdt977.c
+++ b/drivers/watchdog/wdt977.c
@@ -34,6 +34,7 @@
 #include <linux/reboot.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #include <asm/mach-types.h>
 
@@ -59,7 +60,7 @@ static	DEFINE_SPINLOCK(spinlock);
 
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (60..15300, default="
-				__MODULE_STRING(DEFAULT_TIMEOUT) ")");
+				__stringify(DEFAULT_TIMEOUT) ")");
 module_param(testmode, int, 0);
 MODULE_PARM_DESC(testmode, "Watchdog testmode (1 = no reboot), default=0");
 
@@ -67,7 +68,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Start the watchdog
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index 3918a600f2a0..4b1ef22d0df2 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -49,6 +49,7 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 
 #define WDT_IS_PCI
@@ -72,13 +73,13 @@ static int wd_heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
 		"Watchdog heartbeat in seconds. (0<heartbeat<65536, default="
-				__MODULE_STRING(WD_TIMO) ")");
+				__stringify(WD_TIMO) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /* Support for the Fan Tachometer on the PCI-WDT501 */
 static int tachometer;
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index d96ad8f38bd2..1aeb532dfeba 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 
 #include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/pdata.h>
@@ -22,7 +23,7 @@ static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 struct wm831x_wdt_drvdata {
 	struct watchdog_device wdt;
diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index c82c1b77d91b..5eca195eac18 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -14,13 +14,14 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>
 #include <linux/mfd/wm8350/core.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static DEFINE_MUTEX(wdt_mutex);
 
diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index b343f421dc72..3bc323d886d0 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 #include <xen/xen.h>
 #include <asm/xen/hypercall.h>
@@ -30,12 +31,12 @@ static time64_t wdt_expires;
 static unsigned int timeout;
 module_param(timeout, uint, S_IRUGO);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
-	"(default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+	"(default=" __stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, S_IRUGO);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
-	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	"(default=" __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static inline time64_t set_timeout(struct watchdog_device *wdd)
 {
diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
index 799ce8d22b2f..b7cdf8140666 100644
--- a/drivers/watchdog/xilinx_wwdt.c
+++ b/drivers/watchdog/xilinx_wwdt.c
@@ -12,6 +12,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 /* Max timeout is calculated at 100MHz source clock */
@@ -47,11 +48,11 @@ static int closed_window_percent;
 module_param(wwdt_timeout, int, 0);
 MODULE_PARM_DESC(wwdt_timeout,
 		 "Watchdog time in seconds. (default="
-		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
+		 __stringify(XWWDT_DEFAULT_TIMEOUT) ")");
 module_param(closed_window_percent, int, 0);
 MODULE_PARM_DESC(closed_window_percent,
 		 "Watchdog closed window percentage. (default="
-		 __MODULE_STRING(XWWDT_CLOSE_WINDOW_PERCENT) ")");
+		 __stringify(XWWDT_CLOSE_WINDOW_PERCENT) ")");
 /**
  * struct xwwdt_device - Watchdog device structure
  * @base: base io address of WDT device
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index f3bb935c08c2..10d4eaa8592a 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/stringify.h>
 #include <linux/watchdog.h>
 
 #include <linux/unaligned.h>
@@ -94,7 +95,7 @@ MODULE_PARM_DESC(reset_duration,
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
 
 static int ziirave_wdt_revision(struct i2c_client *client,
 				struct ziirave_wdt_rev *rev, u8 command)

-- 
2.55.0
