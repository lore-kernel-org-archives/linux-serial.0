Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA02836A0
	for <linux-serial@vger.kernel.org>; Fri, 12 Dec 2025 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526973; cv=none; b=A3XBHU4ORPc804ldCFhVVW8HCnQKkDhC3lCB+LpbcdhzCtKlJkzSamaifnhyJj78oyIVc8mDDzaknvxMF77D7ssPHYOS8m6LiYWm1SmSa3Ae/fodZH8VLCIOCKrvOCAYiwtOLaYEhcAPdbWGEHVYQ5U+zfkzt0FaIbHHbwwt/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526973; c=relaxed/simple;
	bh=IofNINamgUaxUD/ozHNMzT73NVVktMKx/C8cq9MkyxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6YapV+smmJM21U71UD8sPKaM/VPbqUp3eSkveZgnUeSjzr1KWAA87Bo0ykElYnn3Uj7Rc2jPMCpbh37J1Ibuhf/F4pvoAjj7ECSecuAWleQxWNx5HqmFVmmnF2/3+nuIra+YBCR7iszEWndcjqhuTrhGXiEtyLXx4wUhm6DZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dD2XmTOl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dD2XmTOl"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7277324204so154157466b.0
        for <linux-serial@vger.kernel.org>; Fri, 12 Dec 2025 00:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765526969; x=1766131769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+39K34vOi8xVQNaAaMN1cV4zjvBZg7Po2C7wx93ufM=;
        b=dD2XmTOlMothUQmH6NlmG5erdDdoYR34KL0j6gqbnhoQ6U2UJoD8Pzoukcx/MBJvVH
         zj0yNe5ZTRBXEGwyYFwpHHWW3buJ9GjicCOFkIHOGb+eHBb9JhMG++LtNrHKcbJscjiL
         kOEsM+9QqwzuAVmMEptyM3/L8LFnVY6IYdso9Z22azFOMnR5cD/n1RBCct4mgJStXfIU
         IkfTD/b93XWG5zhZJcBB1Khw+BxRTkN6KrPNm9MUnzyz+uF4mj+EOAT28f9qexkaLiH/
         qB5Lv9PvMWd9Yj0e92sRwIcRnkexdLKKj58f63os9QVZYn5mPj2ecjkqM1k3UUEkVG4N
         hW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765526969; x=1766131769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+39K34vOi8xVQNaAaMN1cV4zjvBZg7Po2C7wx93ufM=;
        b=gxTVMLhOPLSYFh/3qCc7Q7J0vebZPvUgHgcsUBC+rXN6Mh/FslpbyWlnzyt+Pp53jW
         W6LHgZz7XnQzUCp8ur1zt1JaiiCxm/VCVjeyQTI5Iwu5egaF7tH6HPdM9bX/PsiY1oeo
         iuPpHAYEcMuHdZBk5h7iaZXxv8tzyDo5riITcBI4CLLt9zfN+jX3Xbaewk6patUFZyzG
         Oxvby0cLgAH+6Ds8pdZnhRRve7sDjL3pn6Np3bdn2h33b+3/Ygb0+w7QGXVkrQOFbX2s
         QR3yMDhNcZTBo98hxedfLPIAJdYlnTPJOQqM5A5s8IIT2vgzD4XA43tf8W1Z0mfuI2VH
         +xVw==
X-Gm-Message-State: AOJu0YwbBJnm8yfs9uizctFpqJNen22k4hsb2+ttfLzJHVmKZxyp19Ed
	uO68rcTkwLI9elGXjhW+rRLENgITZyJTk2dgq97CF8vXWj5+AqgKJ/R/oOeKr6NJMXA=
X-Gm-Gg: AY/fxX7tCFQ+m96OCUpIOPYpsVs3jaSJtiiMEDXC+DsgbU1wzcTxx1Thir2Shj6Rx+5
	dZ3bamxMRJfJU8G8DTt8M4VaQBR4cZKCnr8IsNU319WdBab5V4PSmaxktqiCOR+dSkI3WMAIuMx
	EY0gvH1QYRAJPaP28o2ofV8D9tpwxX+24TA7wxIOT0/vGFEkMEXvZa1UBHvaUJMKxAwNa4JNhYT
	ZnfSA0SAuObSvrUaFbz/UQ5wWdDDq6QJTSqOJnI3Y6H1chN+n1wGYqEQPIClHDEa6aYBX7rp+he
	sv747mfGgO0P6qbbaAcfZzYEtd6ZDGZ5mDjfyEWbJepG6Za4QmTnjW5afbd0jUbiCskdfQTXz2+
	zG4ofBb4dTTDjVnuUZNT3GRDA6KNBhvxhXh1QgeKOPG9VUoh4rulr8jCUjlBfYaZ6FwC7kEka6V
	kkl1GsnRVdFnblI1BZ3KCrok3eN5yHTaJihfCsBtc0CJgWeMgwbEurBdFDVHzUSuu9TeGgpZMJb
	BI=
X-Google-Smtp-Source: AGHT+IGWoL0XbNTGLHz8ZMU3qIOVibIWmHjvpfqntUFsxPPnIC82hljoVzU0mysv424t1g+zGsP5hw==
X-Received: by 2002:a17:907:961e:b0:b74:984c:a3de with SMTP id a640c23a62f3a-b7d238f0517mr103594866b.28.1765526969146;
        Fri, 12 Dec 2025 00:09:29 -0800 (PST)
Received: from localhost (p200300f65f0066082ad4229ee042f7ed.dip0.t-ipconnect.de. [2003:f6:5f00:6608:2ad4:229e:e042:f7ed])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5d0b20sm509586566b.64.2025.12.12.00.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:09:28 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Yang Li <yang.li@amlogic.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 1/4] serdev: Provide a bustype shutdown function
Date: Fri, 12 Dec 2025 09:09:06 +0100
Message-ID:  <ab518883e3ed0976a19cb5b5b5faf42bd3a655b7.1765526117.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
References: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=IofNINamgUaxUD/ozHNMzT73NVVktMKx/C8cq9MkyxY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpO82lAtuYw6Euh1IHnIa6xp9GNMOn1AaC2Ib0i 9lpX36+U8SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTvNpQAKCRCPgPtYfRL+ TqNACACH1o7gDLn5mSsNnqmEeWdHjGGepoGjub0UwowXB0KqPgYNHHlXzwyIqTZHOOQBkbFjNpf vyrAK2pkvbg+a/xWPkX58TZB60Swhut8sU610vYfNubAGFvQ0/myc/EzLQLw/ITKJTyef19yVdu KIOGWMTtaBKXjx9a+dLYM3o77G7gNlAxbbinORTJcte8D73D/fAzsdTHEtgmUaNiwNM+2BZnUTh 0Lgz13OMX3yedVsT2kd9+jx+4VwZV8U2oy9wXgqB9D6UjFWqmYO5gLX2vElXV5WASbcDmyxbnYe EMFzOL/CgtH8WJICT0P4sNqRSy1NLW6ffoZyYeejkOpKXu23
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

To prepare serdev driver to migrate away from struct device_driver::shutdown
(and then eventually remove that callback) create a serdev driver shutdown
callback and migration code to keep the existing behaviour. Note this
introduces a warning for each driver at register time that isn't converted
yet to that callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serdev/core.c | 21 +++++++++++++++++++++
 include/linux/serdev.h    |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index b33e708cb245..40eedc15277c 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -414,11 +414,21 @@ static void serdev_drv_remove(struct device *dev)
 		sdrv->remove(to_serdev_device(dev));
 }
 
+static void serdev_drv_shutdown(struct device *dev)
+{
+	const struct serdev_device_driver *sdrv =
+		to_serdev_device_driver(dev->driver);
+
+	if (dev->driver && sdrv->shutdown)
+		sdrv->shutdown(to_serdev_device(dev));
+}
+
 static const struct bus_type serdev_bus_type = {
 	.name		= "serial",
 	.match		= serdev_device_match,
 	.probe		= serdev_drv_probe,
 	.remove		= serdev_drv_remove,
+	.shutdown	= serdev_drv_shutdown,
 };
 
 /**
@@ -814,6 +824,14 @@ void serdev_controller_remove(struct serdev_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(serdev_controller_remove);
 
+static void serdev_legacy_shutdown(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct device_driver *driver = dev->driver;
+
+	driver->shutdown(dev);
+}
+
 /**
  * __serdev_device_driver_register() - Register client driver with serdev core
  * @sdrv:	client driver to be associated with client-device.
@@ -830,6 +848,9 @@ int __serdev_device_driver_register(struct serdev_device_driver *sdrv, struct mo
 	/* force drivers to async probe so I/O is possible in probe */
         sdrv->driver.probe_type = PROBE_PREFER_ASYNCHRONOUS;
 
+	if (!sdrv->shutdown && sdrv->driver.shutdown)
+		sdrv->shutdown = serdev_legacy_shutdown;
+
 	return driver_register(&sdrv->driver);
 }
 EXPORT_SYMBOL_GPL(__serdev_device_driver_register);
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 34562eb99931..5654c58eb73c 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -65,6 +65,7 @@ struct serdev_device_driver {
 	struct device_driver driver;
 	int	(*probe)(struct serdev_device *);
 	void	(*remove)(struct serdev_device *);
+	void	(*shutdown)(struct serdev_device *);
 };
 
 static inline struct serdev_device_driver *to_serdev_device_driver(struct device_driver *d)
-- 
2.47.3

