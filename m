Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B05336F
	for <linux-serial@vger.kernel.org>; Sat, 11 May 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440844; cv=none; b=Lp/SBKs4NKR74elipMUrULVQRMilH/4Cy5FabvjegBJSqzDIGgxLKUxyeoobstvAb1C6tFX3AGNWSW7MLPx8rcxtRJDnpuuC3EJ8l1VqRhSoykDJA30nKp8v51GNRR09q8f/ZIrlxtqO6XGUDwNzT5XxZKEtLVwqlW1PXRoMW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440844; c=relaxed/simple;
	bh=wxSw8FErhBJR354Mc/m6iIpn8aFQz7O++PY3dNSazlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLipbrev6G+2OLds/QU7ky/NQPISXPbnsdV7b/9F7q5xKecpBsYtr6q0Mn/bP1TyNebCqiqmEUAW88xeY4KrDu7g63dgE/yLc6wuksdVwDmrcOKr4rQ+X5evMpPt/b9Fu8dZYrxRJcf6r9zM6tdI3QK5bhZ6wdr4Uj2HbzVl4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ag5LYg+9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ag5LYg+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715440842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ap5iZn6E52VNTy/DKwLlXZo2g8IqDogFPYuoHiYex2k=;
	b=ag5LYg+94H2NhzKA4D+hWyp1Vd+19nAu4vsOm8to6eC5IybKlUlWaxe+6NKCTMSA+aC5yu
	nfpVBGDBfHMRT2K4I+EOyURNWaLEZN1NC6Fx7JNYC0mk+KGWp6bVTYUPxkSee+oMOpj6aJ
	fccoAtoMRR4CQtuQj//ldT35KnMHZXA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-LbCvA40OPaiL7Zr0l23udw-1; Sat,
 11 May 2024 11:20:37 -0400
X-MC-Unique: LbCvA40OPaiL7Zr0l23udw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D536380226D;
	Sat, 11 May 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 193B3C7FCFA;
	Sat, 11 May 2024 15:20:35 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] vt: keyboard: Use led_set_brightness() in LED trigger activate() callback
Date: Sat, 11 May 2024 17:20:30 +0200
Message-ID: <20240511152030.4848-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

A LED trigger's activate() callback gets called when the LED trigger
gets activated for a specific LED, so that the trigger code can ensure
the LED state matches the current state of the trigger condition.

led_trigger_event() is intended for trigger condition state changes and
iterates over _all_ LEDs which are controlled by this trigger changing
the brightness of each of them.

In the activate() case only the brightness of the LED which is being
activated needs to change and that LED is passed as an argument to
activate(), switch to led_set_brightness() to only change the brightness
of the LED being activated.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/tty/vt/keyboard.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index a2116e135a82..804355da46f5 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1033,9 +1033,7 @@ static int kbd_led_trigger_activate(struct led_classdev *cdev)
 
 	tasklet_disable(&keyboard_tasklet);
 	if (ledstate != -1U)
-		led_trigger_event(&trigger->trigger,
-				  ledstate & trigger->mask ?
-					LED_FULL : LED_OFF);
+		led_set_brightness(cdev, ledstate & trigger->mask ? LED_FULL : LED_OFF);
 	tasklet_enable(&keyboard_tasklet);
 
 	return 0;
-- 
2.44.0

