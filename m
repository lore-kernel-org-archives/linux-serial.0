Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4446F49F
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521939; cv=none; b=BLuYROCkqT4l2PNY89rj4ZIUpUzR64QSvCicTNbZLjkNGDst7qmsTY/JiU2HH2GZ39RBbve1uctRmoQwKvumlN3+wx04xucdU/WrqjZp7YjlQU0zWukzqeas6t8SGnWMRM41spwztDqG9HhA945FLRMEDk9kaL7FuNwMNJOyGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521939; c=relaxed/simple;
	bh=cTYG64TGivhOyzba9yFQoWzDn6YNfHHG/dXeYaMvWmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=filnrfPMWBWFk50R5/mDf8QSRaxhUo7hljK18Nlg1EToNQY47jq7jPSHin6/UtoQXrF0UJg7muYq35C+22+4Ft87a8BFNT/HPhq8pp0tpezNDZI8x/Zrg2WByPwDe9fLNnoeNs8Fqe4dKuumQx0SBhekms7nD3b9a0GKuYDwHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A20cb22a; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A20cb22a"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47640541585so1002772f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521936; x=1786126736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+y5R8hS9hQoRxnn0vN1yJ03OSHzGN5AAZGk9G9/RUpI=;
        b=A20cb22azF5dNbjSdcHOfh30aj583XVF/Ytv7DrrDzF6rRh3jjdsImqO5eovdm/oQL
         j/aDdaKn0LJ0kbhWmK9UCsDVs8SxAMgzoph7mAMyUk/dYrFm53zM3wFsx/aG3pXsXbd0
         JFbTkCWTKR1CadmWsRU75cl1B8huBK2C/wkj4aVKdJONW+sg7gRmnSsqDSZ3zRBMNUZ2
         /1068qpFHr+D4FaIhHwuV4+iMziHP562M3IvO6+SfQP8lkJRncLe/c8FJATNpinp4ke2
         KES7qIzuclcBfvCWGItyY4F3/crKjoN5DvI3IWYdQRiVoH6ur58G82JR10OZ97u0OhY4
         Lbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521936; x=1786126736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+y5R8hS9hQoRxnn0vN1yJ03OSHzGN5AAZGk9G9/RUpI=;
        b=nuX5eiYZKotYzI4hGVn2r9jqr9FLNS7Zv07ddOm1XXaFl7y8mx4P7hnyH0dr3/5Qgx
         N286QgKYquswwJaCkHcAgl7HmgL7dtHc2QF35UU2P0s33oR8bVhdLWQUm3yC5nTHaIPS
         XGXbCG9+jnDYNSSklrbED2N+Coaq+DbtLnkQdesq1zvTJ9chUk2f/TmH+kPMnkUCcHV9
         yNWHfWvrmqmA4S+N6tdKD4Y/to2n9Vypshgra/0NyXZYqXWQwgjtFPOOkjHGj2dsx49M
         XyDLMX2pfdInU4Oj5vX+QLA9faldPuVfXZuRm2g6tp17rGgjtP5u3R8XzcnFr1Hd2Ro3
         C/rg==
X-Forwarded-Encrypted: i=1; AHgh+RoTrAFyehcjV05k/rlHEBIm5tssc+M1FnSbWx4h75pg9Q0dbX4xVFIc1nYRmRLYhv0V6Y5qMGVmzUmvR9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxawyBsWREqScvyX54m4wJNYaUfs1JFX59MnskLP4tc+ndeEABm
	gzvegMSxfrjBtad1B3KkUVMWc92DXiM9SOUAhYYwfltPDsK770X/w+qQgB0PXOGI
X-Gm-Gg: AR+sD11657wvzwv5c162htSv2c4AzNjroeJqgU2NUypaqx3O+fDEUgf8oHLA+4puqZC
	gep483dXkeNSo5MpHyIu3ucFGubx6iuZlCxuElpj949Ii99FDzVy/clmwiixza1h+YZaSTlVE/4
	lcFWOksc8bJnjYD53E+iMaj1VxDrQkFiJpwJAoEY51tRIWr+pUXCb7nJeIip9dIjkgDV/17SQ0L
	TfL/z9Z63Q36M3DuHRVF/8Hkx6B4PgKjTt0gl7QWCKsS+HVUoQGvL5XeT/R9eGX2ykptT+nkZ/g
	8GYWg0QsmKlWLma8NOVLenbltsqhb/3BHNv2ZbbTiH7aCsEhCCSH9HF0JFRC1mRabUuZj3U9zeW
	g3L/O4NmqvCLeu9hBxmclfQmP19XBbqKvz8vAuraK20x01izbzQQfTC3G+x2SXZPG3spU76Yxzd
	6Fr2PteVawBF4y7cctN/17ax31ShjR44qCYZcmwVSusVn3gc/N365aZycKML8vKVLcLfw8k9hI0
	zX/Y8147Nl2fW2mmWqJw/tox3cEDyoYrya5ritOtQGcsTSgVlUsu5D1VBVyODaie1xCqNAqu4H/
	017sH+DXIGPfiHVQ4pJN1729TkzmpfqCPcnTpQlA8gVLxsx0oLKDiB88V0kC1W+KIPnJ
X-Received: by 2002:a05:6000:2583:b0:47f:73ea:37c0 with SMTP id ffacd0b85a97d-47fd73090f4mr1358667f8f.52.1785521935459;
        Fri, 31 Jul 2026 11:18:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm7293694f8f.4.2026.07.31.11.18.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:18:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] tty: skip cdev_del() when no cdev is registered
Date: Fri, 31 Jul 2026 20:18:42 +0200
Message-Id: <20260731181844.11330-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260731181844.11330-1-kmehltretter@gmail.com>
References: <20260731181844.11330-1-kmehltretter@gmail.com>
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
