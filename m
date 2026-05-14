Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BA4218BB
	for <linux-serial@vger.kernel.org>; Thu, 14 May 2026 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769488; cv=none; b=EHAAVzVSjaucme7S83r0d9NJGThVbaULUtnFM7RHQFL1ltZIynRoJZrkEHCzWp2OZmz1HgO8j3JJ1GBPcnfwSZddwGRb0U4cU3bM/WmvO0j5V+r7qmIpnTaQbWE2LZKpC2WKeDy+Z591RK/X6E9nLlT8e30h2IvJmqprbX4QD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769488; c=relaxed/simple;
	bh=zluCpqhMM6VvBgJlcAiGgCuazimnhyHm88ivrs6R8LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IA8kJi7+p/jjoknywLshk5olHtvRiyLHhPdA36AFROS/kRa+gUuY10DYW7lycQJ15Z/j/tjoJRnO5K+uZC8ok7Y5x185fTIDFFXbRI+Xm44khY+oEA+QmDImbX+FGtA35maec3ypj5iiC1oFSPKkM8o0XH3I2v9wea7lfCFyfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kcr8LY88; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcr8LY88"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3937a1f9f7aso10791471fa.0
        for <linux-serial@vger.kernel.org>; Thu, 14 May 2026 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769484; x=1779374284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjPi7BZ5+dULqS5lccVpY5SGYZnwsN2PwYz3FOHrrHg=;
        b=Kcr8LY88vzRSTMpMO9bb/Ov3tYmMrPDJaj0LlelqVAN7oxL7wdHs+9+IFM9ZsesDej
         C2HEw4xbmgcnPZYTUBfSJSnROGj59qkn2UFeLJ6VOkxbbOgcvW5pN32I3MPtq0rMjnfN
         Rlgvwm1e8VSZuoWy54X+MnT7lV/ZQkCD3IScMDnuqmxmMOUKbmyuUikgFNKjM3UDxe14
         cXk8AmQMC7scSMnPi3dLluIP7drQM26jK4PPKg9qTa9wF6GJvXdyve5sJzh/mGx+08Bo
         ucM+tVmGqT94xV4njLr79DT3NWcsQseEXAc8TJ04hZFu4Ih+cS9eNjlHGrgWhRZKYURY
         gwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769484; x=1779374284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjPi7BZ5+dULqS5lccVpY5SGYZnwsN2PwYz3FOHrrHg=;
        b=ps+JBBC9tWudWcOIUqnqTyAdBfYyoOslw4oCxDYgg7QTih4IFFDaRB9eI1B3Ych3z5
         K9HqXv8yDvgvpdphh8Iqgyt/Dx4Y7Za2W8gQ6y+YmUoJOHgWv3SlUye5tUpXbL5gTDKQ
         HUVt13O8ULqaMgoklaCqJ1Y4qkSQ2GilNrM77cHRVt5lrX4NbLF1Ll4/rkK9KEBwsH4/
         X2v6ZHGNLNbXJEw9dF+kXgaXC4MZYYr6lBYK393zYaxrOsSMCXYCAUGAN4q/VltZkezS
         rZDk5BzYRl4XwZ6GlFBJkFVDFWZc/LztAi7XzVgArnubLgbjZq/xEI122q0d0wwS6eiP
         1T4A==
X-Forwarded-Encrypted: i=1; AFNElJ+wy2GYTaJtiW38kVcFJNtO/qG1jxwKHkVLHDBX1thQSmivT4YaLwB2osWa6x2dtpytHhrIQi8loob/XBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpeqTcEYySByu4rMhSlZplYFFW0n0Z/mVGe5ArpKj8gkzhXcX
	9SltzIung2iXuE/5wSJG4F7Ex/HUp8z61MFwOjDpixJyqQhzkQ4/BJ9g
X-Gm-Gg: Acq92OGXHaeCSD+qTndduBjxNJMl7hh2w7l+gvDCyOo6cW1zrEHNlN1vjNGDk3VXwuO
	WNt+sIeedT3qgf73pYnG6C+PLO2Cw5naM5mLFX5Mwf6ubXyKQHzdA4GFqHESD3VVa6RYJoO2tqa
	dxc/Kl/687ePBtA7JMgOq3+NO9uN3HY6nA7svEj0jZBYnfwHO5mH/ZZjgBqRmL3sLc13NmqEZ3o
	JraU1/4KHmcqAzDbFgMmeUtPV9vjRGwp95bJ3azIJAX2xFZq8bJvRAfyQH3v83A6RJM4CxjnaGf
	B2KzptWz0ycaKWCAnqe/LKOUf07IlXTblX7OkCyIdhtBH5lSxVYC8MdCV0dRYOTtNDkCFHMmORW
	nwXWZH7kT3WowmNOf9U9yT2piW6wmDTbODtxoHc9vkpD8FzU3rj0BXrNJ2aaIC/kdXnGUahXwB8
	VPoMNuKUUkd1OgW03tSY/2H/iYwBXchFdkouM+wtuH2MhE4vk=
X-Received: by 2002:a05:6512:1288:b0:5a8:7c42:bebe with SMTP id 2adb3069b0e04-5a8ef9a8fc3mr1056037e87.4.1778769484152;
        Thu, 14 May 2026 07:38:04 -0700 (PDT)
Received: from localhost.localdomain ([144.124.192.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c578sm518716e87.12.2026.05.14.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:38:03 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH 1/2] serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
Date: Thu, 14 May 2026 19:37:45 +0500
Message-Id: <20260514143746.23671-2-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260514143746.23671-1-sozdayvek@gmail.com>
References: <20260514143746.23671-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
and then, if the device has a clock, registers a clock notifier. If
clk_notifier_register() fails, probe returns the error but leaves the
8250 port registered. The matching serial8250_unregister_port() lives
in dw8250_remove(), which is not called when probe fails, so the port
slot stays occupied until the device is rebound or the system is
rebooted. The devm-allocated driver data is freed while the port still
references it (via the saved private_data and serial_in/serial_out
callbacks), so any access to that port slot before a rebind is a
use-after-free hazard.

Unregister the port on the clk_notifier_register() error path.

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 94beadb40..7dbd79a91 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -850,8 +850,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_dfl_wq, &data->clk_work);
 	}
 
-- 
2.43.0

