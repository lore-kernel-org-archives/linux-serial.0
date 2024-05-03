Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8430D29E;
	Fri,  3 May 2024 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705806; cv=none; b=AtMoMNswOSWKF49XSx4l6QxrNORlRFWbx4fKU2N/U0NhGvx+HWY17K7ZUSjEgZsh6WvCs51sc7/OViDwHR6h5GwbLJ9u/OZsSDdqJ5YLT7dIvfsilcHiTOZeyfn6tCb4Te83R2i5je8U9YNcYQ0PLCHWcLu60iuRCoXUItqfAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705806; c=relaxed/simple;
	bh=dKqACnhDRsBcm8kKVpEu0ty0FAvZOBv7uFTmGbsEiFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E44AESH4a/0DSnlIvqYvfmS3ydPSIXVKRgFa9RT2VoWpGLWR1gb7TxvXmxCPqwucO9JvYT4OTzeEmw7P4KfsErdYFL/rX957v7tkJwH38Nu5nF98Qbwh3bbKY8VXeM26MyDGHP0tz0d8zk+dfSjRdZUIFYdT0JfIp82j14Ji7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1HIZDLP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1HIZDLP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecff9df447so8364149b3a.1;
        Thu, 02 May 2024 20:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714705804; x=1715310604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYlMUAZ7xJHWAbfMzwsBD0Len+US/NBR0Z3gHNhfrnk=;
        b=R1HIZDLPabjpX+xkg/sr9i+6tvWY5yCoGEAa4yelAf5zmJD1T7oKgxGAvC+X/J7qm0
         c44XOc2EIaKu6va04vU43Y7yyP9/ngeUkbpKu+11x9G00t7OT9+jSkiJkO8S9fInK27X
         3g1T7tlw0v0+dXbZYgn1KJ8CFT1D5iCh5dYptY4H89q12rNbeOVo0R/h6B8YvQWWnMry
         ou47DscPf4FrdP5C57/LMD4lTyT+P34Lj6QFzn97iaYXMm4MM3FmZe5YzN5UuJfxxnFl
         Un/0agCFSn77p3Lz8E7cmc8XgQ1hakXsKKoiMChv0xUIX+sbmmHm9WrQREtBtzXpqyBQ
         g6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714705804; x=1715310604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYlMUAZ7xJHWAbfMzwsBD0Len+US/NBR0Z3gHNhfrnk=;
        b=owIpIrh56E+rE70ZuifApQePvxel5Sk6Wd9vVtPzy/Hw5qCVuQgBqFyKFdDxFTbCO1
         lHdUv1x6PkmopZQOAOhCvkVigg4FQnaMHjduYMjKHTC9xuRKtTmHLODGfphxVBI6agKc
         I3XnrSIAGKhOaBHzsDBHAPGRk/QOCHipncPbOf/b7M9T8uwb2pVGYWOGFNBA/FufcDrI
         +YCVnyceJzajApWdJKbMC15x6x3Zo7fnx3vp0X7zuGR4hcSIsqtEmQMsoCzMS4smuPzG
         SEHXZ1qOy2CDTZ1sx0enR/T3V3365j7EGsu6kJF86RJqWaIR8vmYMFKYlU+y1Z4/8pqM
         nvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKABUtGb7irW+8anCkjShk1WtwlE7Gi5SoKVZhPJ2fNUjnCBQfeSAYZeI/QU+6BltwTOlFf/tEspJVNLK6wwaPOH9JR6awGxPtxbdO
X-Gm-Message-State: AOJu0YzoU7uRTjygMUM5bhaMgqY5gU2AKLQsiay0jmkOvICCm7zIMZDx
	g9/MruYPN9mTdepT0B7Bg9ke903aSdIZm3fOnfba8wRKXgFnktzY60Y5R5CdpDfra+5v
X-Google-Smtp-Source: AGHT+IEWFCSc7yXQ1kGar0pCfPCZSwSDVgmmQ3w/PQq1E8TouwC1yAROk01cT8sdYWJFxzFJMaZo2g==
X-Received: by 2002:a05:6a20:2d22:b0:1af:5a6f:1c62 with SMTP id g34-20020a056a202d2200b001af5a6f1c62mr1871505pzl.4.1714705803543;
        Thu, 02 May 2024 20:10:03 -0700 (PDT)
Received: from localhost ([103.192.225.105])
        by smtp.gmail.com with ESMTPSA id n93-20020a17090a2ce600b002b4478f1c0dsm204151pjd.56.2024.05.02.20.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 20:10:02 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/2] Defer probing of SAM if serdev device is not ready
Date: Fri,  3 May 2024 11:08:45 +0800
Message-ID: <20240503030900.1334763-1-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This version simply resolves Andy's comments.

Best regards,
Weifeng

Original letter:

Greetings,

This series is intended to remedy a race condition where surface
aggregator module (SAM) which is a serdev driver could fail to probe if
the underlying UART port is not ready to open.  In such circumstance,
invoking serdev_device_open() gets errno -ENXIO, leading to failure in
probing of SAM.  However, if the probe is retried in a short delay,
serdev_device_open() would work as expected and everything just goes
fine.  As a workaround, adding the serial driver (8250_dw) into
initramfs or building it into the kernel image significantly mitigates
the likelihood of encountering this race condition, as in this way the
serial device would be initialized much earlier than probing of SAM.

However, IMO we should reliably avoid this sort of race condition.  A
good way is returning -EPROBE_DEFER when serdev_device_open returns
-ENXIO so that the kernel will be able to retry the probing later.  This
is what the first patch tries to do.

Though this solution might be a good enough solution for this specific
issue, I am wondering why this kind of race condition could ever happen,
i.e., why a serdes device could be not ready yet at the moment the
serdev driver gets called and tries to bind it.  And even if this is an
expected behavior how serdev driver works, I do feel it a little bit
weird that we need to identify serdev_device_open() returning -ENXIO as
non-fatal error and thus return -EPROBE_DEFER manually in such case, as
I don't see this sort of behavior in other serdev driver.  Maximilian
and Hans suggested discussing the root cause of the race condition here.
I will be grateful if you could provide some reasoning and insights on
this.

Following is the code path when the issue occurs:

	ssam_serial_hub_probe()
	serdev_device_open()
	ctrl->ops->open()	/* this callback being ttyport_open() */
	tty->ops->open()	/* this callback being uart_open() */
	tty_port_open()
	port->ops->activate()	/* this callback being uart_port_activate() */
	Find bit UPF_DEAD is set in uport->flags and fail with errno -ENXIO.

I notice that flag UPF_DEAD would be set in serial_core_register_port()
during calling serial_core_add_one_port() but don't have much idea
what's going on under the hood.

Additionally, add logs to the probe procedure of SAM in the second
patch, hoping it could help provide context to user when something
miserable happens.

Context of this series is available in [1].

Best regards,
Weifeng

[1] https://github.com/linux-surface/kernel/pull/152

Weifeng Liu (2):
  platform/surface: aggregator: Defer probing when serdev is not ready
  platform/surface: aggregator: Log critical errors during SAM probing

 drivers/platform/surface/aggregator/core.c | 47 +++++++++++++++++-----
 1 file changed, 38 insertions(+), 9 deletions(-)

-- 
2.44.0

