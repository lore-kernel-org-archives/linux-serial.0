Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FCF29D06
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039972; cv=none; b=UHMAECQE3UwH6ob/oKN6u9Dw8EtUi5s2sWdKFWdhSNT6uSBZSQXTTF803GfXchpJ4dMld4w2f4N/9f759QTbVv3k95fP30N4eceGXyYmFu0g0fIM6MWRyB2czvREbkXbQ5omHJLNRHfkjbozS7sNxevG4XpVXyUTvqF9HDC8dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039972; c=relaxed/simple;
	bh=MwwwlILPBrJubGFy6q/y6XZ7ELEBOo3CsDbrxodDZtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GN1WDdwoG5awrD+5H86kwn0PeDQj8Ayodv1X2DHh3Q4l3KW9rqAlR4nIl3r/XkK+r7BlGNvUSYewPxKbCCWmi2IrJTomdRAFohLRcgCaLGBvzcC6Mm2PC5ZJJlUl6xAQk5pjhgnT9CpZIFG35Sa4x0MtWSP6g+IgDLyz4aDuPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L5phjNjl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L5phjNjl"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-530e22878cfso213048e87.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039968; x=1723644768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhnBrsrtx8JhjXSaZo5MeZvYsFC+QghJ1OF9fPH+ytE=;
        b=L5phjNjluLI/du9LQX4NRL8zcDidFj1bjJsF67/W7epwNpES3X1/P1oyqBZ8SfcDKB
         sHQBbIUFybOsPsqRsRXtrUH8H6T+TMcOOO8qn6FzMX1s0KrJaiR3hnzyZvQJ6EHR+N9i
         ZEPPL4bU9yG0R4igzB8g5sTciptxLkMzVFGiv2EAIDCoVJe2ldAQbdlIEZKe33HbXQid
         PpkS9J5zrEv8Aq/HwsWjeiUBNTOXxP2rsxXljPoenGO2d0KXiETVVAQBQOoMUSSO5Nd8
         RBzdZ2iUrRuUbZYZJ0d+FBKTiaD8lLNKz239xjhfcyNDqbaC03rEICcaVevCGX0LxwTP
         S63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039968; x=1723644768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhnBrsrtx8JhjXSaZo5MeZvYsFC+QghJ1OF9fPH+ytE=;
        b=kI5BxdMobpkWXBcn4Q4cVfTaK3HStiJZVp/0fQceuaKkSjoY6cu0BeWQSJJ4oFTOf6
         W3jAI7/2i0Sb2yO8CjncYZNXCzYptMNX0xkPQk6xKJzm4g8McTU0mcC7j6sqm9SIv7tx
         mxOT/YKOE4onKossTB2Fy4tbNlEybApb16UtsKP18rxTtezuszlsfbS2+N1u46n2P9cQ
         J8uwJDJDWyXxNhq1l4HLRv2xm7YlCd2OBrctW3vzS6hiT2opyNkO3HDZz954btaFjSZJ
         iOGVT6HZCHGpVFo5dicJFINGgqkfi1azakvY3Xe0XrlPv5G8KcSvGMtnnLnJ8cdHXEIf
         luiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmhZ/XMhkEXDW02c1MRky91jf8IPKGkufIVrL9n098ZOa3m30cZGRnqlqapUL/eujhFqS0/WWJ5VwWUk4fpMhGMfPTEsftMBsGVRyi
X-Gm-Message-State: AOJu0Yz4mneA8kfYhJ9SBrNntGRQjr72o+mmHRfsE1BdWoT57qlb6AMO
	mulCO2AIUJKDur8AKl8ST4JBQFhJePfxc0RTx8X6q5NpWtiKHizZl0F80WBr984=
X-Google-Smtp-Source: AGHT+IEJyt0WGEXWzqRXsX8JTktfdH+4TvqQykj+Gjwr32tHfWEz80uMq7FNr1g7QseHu2DJb76PiQ==
X-Received: by 2002:a05:6512:3d11:b0:52c:d750:bd19 with SMTP id 2adb3069b0e04-530bb39d200mr10835746e87.8.1723039968086;
        Wed, 07 Aug 2024 07:12:48 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:47 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Udit Kumar <u-kumar1@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] serial: 8250: omap: Add am62 wakeup support
Date: Wed,  7 Aug 2024 16:12:22 +0200
Message-ID: <20240807141227.1093006-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v2
--

In Version 2 I removed the Partial-IO specific patches as these can't be
tested due to power issues in Partial-IO on am62-lp-sk and similar
boards.

I added a patch to add DT 'wakeup-source' support.

Series
------

To support wakeup from several low power modes on am62, don't always
enable device wakeup. Instead only set it to wakeup capable. A
devicetree property 'wakeup-source' can be used to enable wakeup. The
user is also able to control if wakeup is enabled through sysfs.

Base
----
v6.11-rc1

Tests
-----
I tested these patches on am62-lp-sk.

Previous versions
-----------------
v1: https://lore.kernel.org/lkml/20240523075819.1285554-1-msp@baylibre.com/

Changes in v2
-------------
 - Remove Partial-IO patches
 - Replace device_init_wakeup with device_set_wakeup_capable in
   omap8250_remove as well

Best,
Markus

Markus Schneider-Pargmann (5):
  dt-bindings: serial: 8250_omap: Add wakeup-source property
  serial: 8250: omap: Remove unused wakeups_enabled
  serial: 8250: omap: Cleanup on error in request_irq
  serial: 8250: omap: Set wakeup capable, do not enable
  serial: 8250: omap: Parse DT wakeup-source proerty

 .../devicetree/bindings/serial/8250_omap.yaml          |  1 +
 drivers/tty/serial/8250/8250_omap.c                    | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.45.2

