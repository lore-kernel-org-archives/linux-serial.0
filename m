Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E631865B;
	Sun,  5 May 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714914523; cv=none; b=FR8EGhCGFwzNxjuOldbNL0dQ9FShHTDrNVom4WcyVl5C82L2V0752fiewyBY9PxW+/li65LISa2wIi+xCUDIQOQPXK6L5ooYpt+0zUO9ioZ3JJeMgbm5nT1EHVi6qCdimVjTc0phHzSfwHs9iB3LA15zi3791JG8waZWkQOEBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714914523; c=relaxed/simple;
	bh=Px8PRHZ803xOrqkehMecytmPVy2Bj6D7/bRb+lKTk9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDYq7Qfl+qSBd2el4LmIBJ/P1FneIP52vv5H+VacSYObzYCsi/+LwbBqNq4zouQXfofBRYIGoduM1ILEJniWV39qTkB+A4mWHSqcPvQ1RR040xANb5yH/7mIhk42QFYrW72AVj/oKYTFcgno0omvg7sRZQF/Khg6MzHIda9kLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsPypYXb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsPypYXb"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so857450a12.3;
        Sun, 05 May 2024 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714914520; x=1715519320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=82t8iKOnzOMcTOXyExboVbky/f5PQ2Kw9lsluTPOV48=;
        b=DsPypYXbEASRXTXV+5AFNm6zgAIjOb5TwAMANrkEOHwqQ0oJrSuZnXLiemO6NhsmRZ
         ep1Dvl16vPiwjkKQ9I6TdMAhyyh/dpeAeOAbmd+1towZFqbhYBl8bREhbUXt0Pce7Evc
         IAc5j4MHXU7paWdWitG362FT9+ymBF5zfDI1VkzBOqfdphTppq4jlJzFyM+uZjeWESJd
         kzwhLMKFgKC0ciSckCjMOyhrXfLaipcZXUC+en5O3MSq02r5eykeYhK7IOGNatt9pKkv
         I+vk4/QROD968Al4iS8EyHVoapTlGYc6w4dmGoz9ODL+Sh77AgjAr9S8VcJzBcHLdm47
         /fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714914520; x=1715519320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82t8iKOnzOMcTOXyExboVbky/f5PQ2Kw9lsluTPOV48=;
        b=qXBYXCuSK60sk5u4YX+ZeDdi8G+Wr5qQjffETQBiudKkbRCXFkBsmTgLXJhp6Oz36R
         pjSJWoMt+E3SWM+2TQRy4pNUR9XxnHL6/dha+HHIByU1JsbfALx1H5FpXZC1NS8TR5i/
         Ia3gcxg5OHf1M+MzRVVg40MD1pD9xLioZvvQ/sJvZDl77rMRewtQyCcT0QrTUuwveBU7
         cx43bmLRQVfDDX01uE7jpluKkBfygWsY9qiCffDCE6nD/+NRqjpqXekd3FA31T1GJcYz
         dY2a/Bw4a3w4SPp7JgsoFZ8K95EA3ejPg6rD4uja5Ewho+p5oRUNTm/X8kXvPm8DTqP7
         C2gg==
X-Forwarded-Encrypted: i=1; AJvYcCXkjWZ2bDPI4ioZb47y+vr8h0cWEIZmOT7IAfFWUlMSnFfdZ8gE53/TOAOwHHzWh2GzfAqUgiDkb8+/b64kXmZzYubIHLSKMApS2PM4
X-Gm-Message-State: AOJu0Yx+/Yw+RP53qXXZ6ZMScEyXfJhY/SWXaoHeZBtxUjKc9H01+56D
	3fBtdrx8eNURI0/8Lo2gRCFWgLuD83swu+zywfZQt9qIKgKDsgXSolb+sh4emqdDeWEB
X-Google-Smtp-Source: AGHT+IFaLbgAnNKhIox09dwN/Fh+vfBvzSu4E1eIxm8+2M+I5oYXmakwTf1X41gix4GhviO0p0Tpig==
X-Received: by 2002:a05:6a00:3cc6:b0:6e8:3d5b:f3b1 with SMTP id ln6-20020a056a003cc600b006e83d5bf3b1mr8057710pfb.22.1714914520073;
        Sun, 05 May 2024 06:08:40 -0700 (PDT)
Received: from localhost ([103.192.227.200])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00218400b006f3e3d928fesm6029471pfi.220.2024.05.05.06.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 06:08:39 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/2] Defer probing of SAM if serdev device is not ready
Date: Sun,  5 May 2024 21:07:48 +0800
Message-ID: <20240505130800.2546640-1-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 changes:
* better formatting, nothing special

v2 changes:
* resolves Andy's comments

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

Weifeng Liu (2):
  platform/surface: aggregator: Defer probing when serdev is not ready
  platform/surface: aggregator: Log critical errors during SAM probing

 drivers/platform/surface/aggregator/core.c | 53 ++++++++++++++++------
 1 file changed, 39 insertions(+), 14 deletions(-)

-- 
2.44.0

