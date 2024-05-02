Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463F19478;
	Thu,  2 May 2024 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622603; cv=none; b=Le+wjtdDF6EvA0gTIaDEyvYPKaHIUdqyCV1q/UfkrIVj4fvk9X8xwzXz2kHkTCWn9gzVNKnO+HnUNiicJuB7Dnvh8LtGxBTpmbTXnOkVv1gdiOHDsfLKi9fEjqgqAtGsGz6IpbxpGQ6CcPlrOJFq8w4QkPm9hq8xQozLTqsYutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622603; c=relaxed/simple;
	bh=gN64eOf42HsNbWKuw6bxq2dc37o1Di5PiibRGJf5Guo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9R4apas05pg9Zma/zmyUGDMtDv68yoiEBJJkSsdwr1rmyC+cH3L+nTwRo4HvSeAzljzKEGbMLh0sb7Yo5/CsShX1lGYDYBGla7YZxfYMEPA6F3Xlq4bj83mJTcuOotQMweVFrSBPmd8cAUP8vG9GpZw+p5MKO9kXwJUJ5U8dvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSjmqekL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSjmqekL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so6744775b3a.0;
        Wed, 01 May 2024 21:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714622600; x=1715227400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gIiiJAMb0hd82fV5a9ljk4muPzg1aujZ9+bTCRYQsyA=;
        b=SSjmqekLtAYXG+yckuTFywABJNzcLbng1XGLkb4KMwh7GCT1AkwWIbdO7/i48qH8UN
         YmkvbCLgyR1b8IM+33XBoBTEr5IHQptA5pQfRNcy9eDDhL2bMAKUWTOvS5dFQpb2s2Hy
         n/Sav9p/nWHuJH63xNsikW54bje2cXAhy36EdwoOTBHiqM+o+XNs57oghdbIIzC/YjT3
         /VBX1hOCAQsOTWUHXxjoNHAvpo4vOXZBjp+dxaE/xAZpCdeSlMz1coS+uhADzgMrShfz
         Pkbqm7s0KtkPc2Tf1KaViNjoTJDiRheVNBmvjz2hO0ioWW3u6xT3Zy6SQC/HbIfbpdtR
         M1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622600; x=1715227400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIiiJAMb0hd82fV5a9ljk4muPzg1aujZ9+bTCRYQsyA=;
        b=lT/a6ePdLZbKfZvn8Uc2jMu7NJ0iXY5r8LxeO5qPUkXogFrVVBIHYy/IGMETHfTbVb
         3XezwSDp+djkKaDTeWe6vup57nXGH/VQ0e/BS43yF5PYl2UqteEjFvMVVTvw9U9MhNYK
         M6Gud3TVlCWe0HkQJzgwckSznzP2F+d+YbBEil/JJDataQnjK7cstRICCBwxqtkxZgPH
         twQ/6StRVtgP7xbSNiPT7yqfGmkh+FWPLVQ6yQ2xoxWUez3EIgfphYch831dCThpatNm
         aCOU78GLCYZzj91dZMDK7ZnFSWeoUBTgjvLAn2CpeSw2gqyrlT8GrTFcFOAl1W8xNaA4
         2N2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWosXUoYI349FbNjTJOQKYG0wVWIceLBur858SGPQgRi72GLbmsCqHamuQH3JxMhnZx7j9bRA0+hnC2RZehG5uGovMBFivV4YXXz8Em
X-Gm-Message-State: AOJu0Yw2zO6+DqxxdQfmmTS3SRwjM4og//lDIpEAdlaXXbNWyBmdg0DS
	yMYwapePx6187PHR8/0DRvcFnJfwmitZQTejc0mG1x15743xRaeJD7cZqroMzio2Ndt5
X-Google-Smtp-Source: AGHT+IEmE85q3WMG3lIZA/rag5w8RC/lJPRjTPjJsCLoKWIUNzEw7+jZKQ81lglg/RuFwiI24jQqCA==
X-Received: by 2002:a05:6a00:1acd:b0:6ea:d149:c4e with SMTP id f13-20020a056a001acd00b006ead1490c4emr1085004pfv.14.1714622600344;
        Wed, 01 May 2024 21:03:20 -0700 (PDT)
Received: from localhost ([103.192.225.104])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a001ac700b006f3f062c4f4sm188083pfv.136.2024.05.01.21.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:03:19 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [RFC PATCH 0/2] Defer probing of SAM if serdev device is not ready
Date: Thu,  2 May 2024 12:02:45 +0800
Message-ID: <20240502040255.655957-2-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/platform/surface/aggregator/core.c | 39 ++++++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

-- 
2.44.0

