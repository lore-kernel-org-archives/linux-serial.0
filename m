Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC712880D
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506564; cv=none; b=m+EW9KWGnN1/eiy5bNLc7+aU4lEYhnjwznLhM2NvDrdQtXinnJxi0h2H4WGSX26z5Eh9O2dVS4bcm+xeSn5hqqSV0nLmJYqMy4+r3YEpjatuljT0wV4l2m4J5yazXWaKXLS5KT6WTIE+wYvkMDJ044LPRev4vfQQlZ09XVb76rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506564; c=relaxed/simple;
	bh=rgPr4Ngu722SRDj2ZtjbrxVxv2puo2dZm2D+9CkatPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hl6/Jwwq89yyJcHKB5ubtaB4u0KHUMWNeCDZLkLJpWypCmxJv7ObSs/43RR287hXzJn/vJPOp2oQhabkAoNSOm5FumMGKuZhnqlBopH5FdWVPKAO6bh0u8GjrZxzBhuo8kOBjRd9fpklknwnY5nNidcyyhgJZsNorsyJfNlBsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TttDrzA4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TttDrzA4"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f8f34cb0beso175696b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716506561; x=1717111361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfP9vIEmS390P3O4iAtZjeM8HWFzEOcH0/2SUf3/Hok=;
        b=TttDrzA4qnK/uWrFshTTPAVszxLlkHAJ5wbe4kgITRdvWR/nkEXrJsLEcEQw7On3/t
         wDD8A+GalWqEFGeEcJVTZtMiTEZQKvxPxrbN0Tu5i1XuHGZyQ4gkUC9GYb2sQxyPcbVx
         WwtM5wwMViUyTnhfzAuyhYOLcKjj6EKviLaUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506561; x=1717111361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfP9vIEmS390P3O4iAtZjeM8HWFzEOcH0/2SUf3/Hok=;
        b=UEduT2fcpD2Xw8Gd1VFeUgH+fzuvGK/nIdxl5cQxN2ZmUBp7QSm0VKHHKxf+Ek47xU
         bxGv2ovyI0MWItNqUk8rkJUSZ7w4JFT/xv5gh8NBRWkhWHWunmhUbJnt4Fidlg6jAgve
         JB1ULqhfFE6vh6RGD08+RVC5V/Boo7O4tqQfizXSj/aGOZEmN/IM7/4AVgvwbLiAyXzH
         dUbe3N9fUj7ItRaVv87NaJ9PPXy+otEWxJ2Wzc4Yi8DXGaFlD2S+hXlkB/lrQrndLgf5
         EloDW88a9cj07xOoIBdtS6TDUEPCr/A36RMwZaoNLBJ+7EyxCZJX07S07eQdHB8dWynB
         vKHw==
X-Forwarded-Encrypted: i=1; AJvYcCVJY4ZQnn7Zh7hVHHgVHw4wdSFGoi/EkpYs7zkKS0HQs3Q8bY+cT1h3mmsqoNgDBtmAB7qSCtOMN1YDAjhzK+NyASsJbpV8w+orxJta
X-Gm-Message-State: AOJu0Yw2hj12x1nDylLRtm5ns7ZoGYklv30GT38EH+c4XU6UKqihFahS
	ZBbiqrvr869Unn9uBxUQl1Ej/zb85Q3zm+zrBw6gxuuAj0aTfc8/D5GZuYq38g==
X-Google-Smtp-Source: AGHT+IGv12M53lM+GUULtAWysbxmBRhEDbBtm/AXwGQlH56IEyIRCa/lNDP8GHgZxm6j/t23nijr+Q==
X-Received: by 2002:a17:902:d58c:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-1f448248a0emr11751435ad.31.1716506560961;
        Thu, 23 May 2024 16:22:40 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:b835:ba86:8e6d:41c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c797938sm1279545ad.64.2024.05.23.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:22:40 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-msm@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Douglas Anderson <dianders@chromium.org>,
	Guanbing Huang <albanhuang@tencent.com>,
	James Clark <james.clark@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/2] serial: Fix problems when serial transfer is happening at suspend time
Date: Thu, 23 May 2024 16:22:11 -0700
Message-ID: <20240523232216.3148367-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a set of two patches that fix problems related to suspending
while a serial transfer is going on. The two patches are independent
from each other and can land in any order. The only thing tying them
together is that I used the same test to reproduce both of them.
Specifically, I could reproduce my problemes by logging in via an
agetty on the debug serial port (which was _not_ used for kernel
console) and running:
  cat /var/log/messages
...and then (via an SSH session) forcing a few suspend/resume cycles.

The first patch solves a problem that is probably more major. It was
introduced recently and has even shown up in stable trees.
Suspend/resume testing in ChromeOS test labs are hitting the problem
fixed by this patch. The fix hasn't been tested in labs, but when I
reproduced the problem locally I could see that the fix worked. IMO it
should land ASAP.

The second patch fixes an ancient problem that I only found because I
was trying to reproduce the first problem. Given how long it's been
around it's probably not urgent but it would be nice to get fixed.


Douglas Anderson (2):
  serial: port: Don't block system suspend even if bytes are left to
    xmit
  serial: qcom-geni: Fix qcom_geni_serial_stop_tx_fifo() while xfer

 drivers/tty/serial/qcom_geni_serial.c | 45 +++++++++++++++++++++++++--
 drivers/tty/serial/serial_port.c      | 10 ++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog

