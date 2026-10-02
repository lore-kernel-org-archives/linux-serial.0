Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B20463B70
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929948; cv=none; b=LwGYz/75joTQTPSSbiEBa4Z2BUPJii0Wt3Cb2XGx7uFXMPy3XTp2yygyrCja7gmTyWlLlIfQWeXEr1gllaR3knupwPw+0ev9q1k6Vv659Mf81yKEu9u6PIYncRa2WDY+Bsza3wyupFi0h5XVXcqLIa6+WqWHbUEOTut2ARbkZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929948; c=relaxed/simple;
	bh=EgqUB+DoKqq6OdA2iGZBD4HDoUMih1j7Hjl6LdTfq+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrrqwUmpc0lJYAts5sdNkO4xAxbNwc14rdSue5JFiLtj9cgDER/CZ8Ji/srEEM54BF7fe+K5btjmIK1KCmQMENpszbhgfKU2125M/XXUt8Ls9PJzRS4TypVkLV9cQHOJFE6alN4AVa6neA0U9zW93mpL3p2mM1V/WQr8N5+Dnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nyn3a88T; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nyn3a88T"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so1174250f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 02 Oct 2026 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790929942; x=1791534742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
        b=Nyn3a88TOZtlgUwXBQxc99DKzD5cFPgYsqvYvDeQwuAmd8ZmJn0iuNV/Q+c1/wucVB
         zzUsZx4MycUbiDevM2/3mVWsrsq83OvHZitjpilMq50kbLXwEAuL/gkDz8kmL2rID9TN
         9C9duiA8OpJDOe81uhktZU2HpmpC2ZJKWCJDRaojX5FQpEm2OJv7z5TcKeCwwh/20hRp
         qwchnpBQY39cOcpQkuR4dYP7JgRuh+jDGQpoxkCcpKst2Gwm6+fbG1WmEd/Bl1nUIwTO
         QlzwsvcYDuZoIhYKWAvxKLTusMQYC1w3u9iaDJE3GRLFswFPJIiFSo2GHrKbY8tu2GsM
         yhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929942; x=1791534742;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
        b=wC1gQWhiGPw4sXLnoHWuu2PHFdDMuJ3AIWIZkMbkayyuZcX/Ex0GN89c3pEJF3m3pt
         8OA3fByZrN0RNVzr0CxLJe7qGsDS/Od5S3RbHTLkb1RNX4frRj9IrJmhwRXRAHeJjAIK
         d5okbY/n28UEinUXXLKBasQePcS7X/fS2EP+2oyaPSbs55Q6KNWB6M34TtFleeAajXbM
         INdlcGkDm7iEzEU7MHa5QhqUHE702huTl8geZp+WI3+n9E7QCAPwo4/Wkmzyt72ZuYxW
         DiA/ao4VOtJQGtsStwEeulnAlq4ijtGeAdw5flAw3fdfM3UC1SSYqkXCZYqcLfaV2Uwa
         anQw==
X-Forwarded-Encrypted: i=1; AKwUvBzUhtfM7jJzO6gE0Ey+62tE2HiuX+SDWxnqTGUxUuFI4bVRiqTVFrGyAs+L5oADByzLtkAtSv0FQvz0G2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mgxm9NgcJ0KXiQMKPRjZK7W4OTaJaMZeMLGBWuAigTScn9uUhG
	/4C/ufgR4OONRBLLE2qpQruAj9FpUAH3V7O7F57R0X9utaf28g1/cP/8c4yW3OatLro=
X-Gm-Gg: AYBFou3txrypSUDhr8V3SiTSdBbP/7kFoP1EsLB5Nb2KTT0VU7PC2n/hupYvUUQlvJD
	GqAR0bdRI77iM/cIB2kO10d2Y5xtCcKLGYdJf8PCyvqtz6D3q+NSO5fpi4yNJO2wd3zLAcCFoos
	/b0QaHr7zraxJAt31Cj3+ysQxwGuDDrCyjiJpmvTK6jYF6ZrzUtxkzKGtVT7KkisZ50E5qKm0vZ
	FtsCBBiA486q9nX0/WeXionW1Ruvv+EIqrQV5TSFdChAa3gWEAuY3BOQp3aZ/FtQf1frWPI9Bv3
	J6+zYLqmAOqKMYVPGFvKANkqHhT/6YvpZ8xmMrk8suY+VZo+5ITp+vP9mqOaAa3NYZu/Ghbw51K
	rNtI2CqeKK/GYLzfE2hCdEmrk/GQZ5AwDMzPLpheZ6Rg2me5obRStUV/Cs11xJiOgaYdO9WAogb
	A1LaajYqyJF81KdGaHEvSI7kX6YiI3DFB+/F+PkRwAAKWa5M1IU9Xrzh+xWtuyaxT8qkI=
X-Received: by 2002:a05:600c:548c:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a027534bd7mr33259805e9.5.1790929942490;
        Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
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
Subject: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with __stringify()
Date: Fri,  2 Oct 2026 10:31:01 +0200
Message-ID: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
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
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/hwmon/fschmd.c         | 3 ++-
 drivers/hwmon/nct7904.c        | 5 +++--
 drivers/hwmon/sch56xx-common.c | 3 ++-
 drivers/hwmon/w83793.c         | 5 +++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 019fc32bf318..df9418a86c83 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -35,6 +35,7 @@
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
 #include <linux/kref.h>
+#include <linux/stringify.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
@@ -43,7 +44,7 @@ static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 enum chips { fscpos, fscher, fscscy, fschrc, fschmd, fschds, fscsyl };
 
diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 976b8a008e44..04e1a8e6db37 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/watchdog.h>
+#include <linux/stringify.h>
 
 #define VENDOR_ID_REG		0x7A	/* Any bank */
 #define NUVOTON_ID		0x50
@@ -113,12 +114,12 @@
 static int timeout;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
-			__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+			__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static const unsigned short normal_i2c[] = {
 	0x2d, 0x2e, I2C_CLIENT_END
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index a385aae3bb0f..febb8ba7dc2c 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -18,13 +18,14 @@
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include "sch56xx-common.h"
 
 /* Insmod parameters */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define SIO_SCH56XX_LD_EM	0x0C	/* Embedded uController Logical Dev */
 #define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index c6ef04c69856..e1f2708b5db6 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/jiffies.h>
+#include <linux/stringify.h>
 
 /* Default values */
 #define WATCHDOG_TIMEOUT 2	/* 2 minute default timeout */
@@ -57,13 +58,13 @@ static int timeout = WATCHDOG_TIMEOUT;	/* default timeout in minutes */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in minutes. 2<= timeout <=255 (default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved

-- 
2.55.0
