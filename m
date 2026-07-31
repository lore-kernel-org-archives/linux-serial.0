Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B34562AD
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521092; cv=none; b=iS610oqFnsuFWmkdcKqiBc+3yvpF588Ix4eMhnXgVmUwD0ODjC8j24lX4yOWAGVn8le0cpT3xQBnaEA/fGDkLEHyHl7SD9GnY7HYpraB9SZFP19a4PCH7dSvcZOUWn7P1sXkOPvZ8XvpfLfnHpqt9i033Eu7P80wG61DH6rnrhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521092; c=relaxed/simple;
	bh=cTYG64TGivhOyzba9yFQoWzDn6YNfHHG/dXeYaMvWmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JiFqOuirsnG5t1FhaU/i+XsboTO99HL+7aEtLv8EGbTHS5T5fEWdAfe4+fEpyquULYVu/8P6mMXVafV0AR61bpjePoGPlf/R4Nj0irvjItCwCo6GV0/96dnq6aRzkEr7LkOA6EQIqH59Oo5Jpl70w9oxN4DqBWQfOvr7hozf2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrL2ZzKA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrL2ZzKA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4728c12ba97so790995f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521081; x=1786125881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+y5R8hS9hQoRxnn0vN1yJ03OSHzGN5AAZGk9G9/RUpI=;
        b=lrL2ZzKAXAS7r6hg20uJ/0NFLrayE4/HZUkXijy/bXlgueMsG9zjSZY/U7DMqLY8DA
         zuxlN00Wpxd6U4hKrbm4DFi8Vck1I+5f9pQEhX2QPlp5/AnPAA2LD+POemiXCfb6Kc75
         +lrJdEhDHODgTSpOcntWP6XWcap14CZsn/rm9Tn5GtkJZWalDzTMZ+1EC7bICIGT+lSi
         Ks8tJ7spl41oe5xSzaalTELqfV69XzYtzVs/RWYHcE1I+sX1UCqR2z+wYMIpAADo73Dm
         NWP3t+pnMikHWlOTo5VTB08Z5Krts81UpA5bttKA6Qgivioc5j9ciZkQY2VLKk2f29I6
         uWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521081; x=1786125881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+y5R8hS9hQoRxnn0vN1yJ03OSHzGN5AAZGk9G9/RUpI=;
        b=oanRUMGQNt7j70X1/rIwS0DX4E9nsAZosC6t8AzRXuZSwuv0dns7hCi8wMnv62etDR
         DMPFDZm+TwfdfCF/LoITPZY1YtRJtSmHTGBe0J4G7R1k3ySbxXWJXfUpqihc1N0qoTJd
         anG2O7Lv0r8pUkP8i0h+fJzJXm2rErySLHX23qG7MH+MPvApH4hChZEyD6wLWGTmzyZe
         hWZTiM4pJ6pqwXEMCyDKFJNKzBIJ39frCTs7qeazGdAPX4bswwhDt+Mfd+pFRX6K9/zF
         OnfVWXYdPHxgA3Y9Tr9DeFPR4cVsA5x04qE/2x4k80Xx+BlWmWjUV6zkF8cfFen8Q51s
         N61g==
X-Forwarded-Encrypted: i=1; AHgh+RoK9yBB/WAVGo/vjYlflsDeo3bm1WewQz5MUhSiVSJJryva8kKX0lm/N0GsJPz/blkoWTE5i1PSVh77WJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYctV4xbrZFQKEVj1KPO8/3s2fFXejN7BNCFXksvZwNCDidM3D
	v1z/7zki2R/NinDS0Pa8gRMU3fRwbG9mDD5lv3jSOrCy3XBgKVRLs52u
X-Gm-Gg: AR+sD12fxm1QgD8Xt0DEPjHgrHES7H/E169WZWeUSfHMRlqFSGYGNATu1LNGQmI1Rp8
	Rp4zsxiO85qOgSMfexd0Xm5S1YLqUslJzxLd8XEHdIMdKSZMhvP9/SQDRQq1j0A52UvJEJlYoce
	dESDtx9URhdkRTOgmdnT4Mj9aHLpZ6gs5xpKrpFrLF8g8IwrYuddjFb6FR0+FppFsJldHZw2lH7
	BF0QB2HH5xgpNef1UYEWk1AnALYoKERFAmpgLMQ+AQMLGxM3t0rlT+uYLBeKWF6/knWKJqfCBMA
	n3tfC4Od4IAXCPQrlo2oR/QajKMnU+Xy40NV1sKj/jhMnMW3GhlEPU00HYO+3BdMqQFsrvtBKZ2
	zjomM0OJoEt6G1Xdb1kck80NwB0sjoaD8vLTBuOoZCI72L5YQ/51GSzK3QVoKkJ52FD0q+8H1EU
	sf9rqQ+z1dTmyEnAXwl4ckOSQPw/W+EagrERKktYsjD2JuzbsAZReOlNVmvWfhG4k2REnmmZy13
	fKqR4FGVywk6R5/eusIZXGC+I0UrP/KlknGy6csMwFKQwkDsL30QwNEIndGLoHCQt/072L9Vo7F
	6coeyvzhyuobZhwO104Xf0+6wGa8emAdlNbuYQu3LkE/a3gNcAV8N0B7OhOwMsuK26Yj
X-Received: by 2002:a05:6000:2dca:b0:47f:9752:3277 with SMTP id ffacd0b85a97d-47fd72a5be6mr1381659f8f.2.1785521081337;
        Fri, 31 Jul 2026 11:04:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm7170742f8f.36.2026.07.31.11.04.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:04:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] tty: skip cdev_del() when no cdev is registered
Date: Fri, 31 Jul 2026 20:04:36 +0200
Message-Id: <20260731180436.10898-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TTY device registration can fail before a cdev is allocated.
Serial core keeps the port so setserial can still use it, and later
removal passes the NULL cdev slot to cdev_del(), causing a NULL-pointer
dereference.

Only delete the cdev when the slot is not NULL.

Fixes: a3a10ce3429e ("Avoid usb reset crashes by making tty_io cdevs truly dynamic")
Fixes: da4c279942b0 ("serial: enable serdev support")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6b283fd03ff8..e742bf9d8631 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3305,7 +3305,7 @@ EXPORT_SYMBOL_GPL(tty_register_device_attr);
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	device_destroy(&tty_class, MKDEV(driver->major, driver->minor_start) + index);
-	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
+	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) && driver->cdevs[index]) {
 		cdev_del(driver->cdevs[index]);
 		driver->cdevs[index] = NULL;
 	}
-- 
2.53.0
