Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CE3128A3
	for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149156; cv=none; b=gWoB+lJVI/hXROh62FDJP7f46TwjWq1HaQab05B6FArLwFfLbMRivGpU10vJDGAWjS91i6dFJYeRqZ6Uqg4FI9Kk0vwK5NastOeWNDKORkeYvsYniwEO430QhEPRUa/v6IG/I0zx7inxcsjELCXCDRP8yDKLA/3DoRDftJ5S8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149156; c=relaxed/simple;
	bh=5idmto1kQjWZRSxLHpCehDOoykYdwe6Ve3kdEE0kCRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAHWbzTHFQnEIZ+KWQkM+XIYhCXFXwN9t05ZYp1lD4dZDZmPdL37/UwlRBh9MDCm0FNANs5T8RWO2DkwcZY95IQzRGXHrPO1RBaMPxcNCK/gemHEP7PeTZw38z9hTwWVP4sfhs2FISPXMAh2+K4JVVHGm1S7j9F61hHmDnVRFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO/v1Fpc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO/v1Fpc"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c858b5de728so4777951a12.0
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 20:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149154; x=1781753954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VRuVCbEtc0C7t5RgetDXysYNFKdENiHIcQZQ71JcPw=;
        b=NO/v1FpcKiB9ufpHSpQ7IEXaahCKZj/3l0bJtkJTRGIcxdIV5npNLBxazcNMWoSOVY
         aSYYijmidW9Cx6lUKiN67uKN2okmvfrPPQSfiy1cagGSngjH0UHBBosKgYPxUKWD5Tv7
         /2Kl3VFDYVz79z2dnSA/FKCoYxxThh9JM3DGpsFyMwXYM/I8l7vbDn47JvY6FMtLvAVv
         74PfcV43e+1px6FXR4OzdQua7PpM3wIk8DBVMTJHRw9z2ZVmAkSlkFZiPm5HKKy9N7Ja
         gJm2v8tDecC6CqDMi5kfpAHVrkd+TOSUwC4fPGwvld22eYSuGyHJ5AuUeDGnC/VNlmCo
         ZVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149154; x=1781753954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VRuVCbEtc0C7t5RgetDXysYNFKdENiHIcQZQ71JcPw=;
        b=gwMOpHDuQ3WN+c7ADBKOC4tSmPh2sKbedZKfBbiIHc2y4K8miPW6OuBU0c0prYNs1u
         Lv6xuZv++ShFC4ik0U/sP0mM0SIOR2R+MQpAkSdVv1HXMejtDLp8i56/Rj55dOvqwLRr
         OpoFIaS1XVcNDeiGnHo/NyF3X1QPCcD8LLpTS0xOjXsiiKn3Edr/NgiBI8jVTgdw39XE
         jjn7nRJ4PrwXP4S80ka7TaRM6wIzkq3jbajsXWAFmnuyB4TJ2s3CEdEVQ9CCec/aGCUJ
         WorAaq3XMgp6PaYs/CeUY53QvP+TYol+MBXNy8H9O0I7Wj1rInVVsuFfDspxTPYOBAPe
         2P2w==
X-Gm-Message-State: AOJu0Yy5ZigPe0Qk++mJN9PhoxwqbSDTvxePYWPeZZU8JaU9jOBV0Wau
	9Tx7YDmLWjGzI3lk8p176ToLINQ2K4b4XQA9PR6AFkMznmIZ4tQU6Z9ah0XO/Q==
X-Gm-Gg: Acq92OELpg4LXQDFz5X3YlUS/hZ31ICsbJbUBfwWdkRps9Jpw8ZtWUS+qXxgyR0XQEs
	8RFFQNRFb22lVKGyskr11weEc/r2mG6rI3gSsHy2bMkUZ8Wa+UTPn4m0/hVNkscalYOj/Z47Ljr
	8qM3a/WiIQ7t8WXznQqnslNBxOeZcLlGJuHPW3OWvEKYlEONepV1mz35swAaNN+ZbSYLjUAJW6j
	tU2bLsJcpqKpa9L2QC29u4jAAIoBHXeySz3R/WIZWV83d8fDkdiQWAASwmVDhMheoN8NwP/6Lb6
	gO4nG5iQ7d80V+hbBcu/TePE/kzHz0zsKeRxsPdWuR5hf/m5tVWwNiVGfGOL/SLSNTDlcun0OLl
	HKRSnjDm9RYcJJ5nDGU6E2VwZ22Ag37rxlsiqKK2QxBJZ6fTytVJ6k0xJgigiKzBpfbA11+ZvOg
	SsFlNgmSxKwmG0r6qM8KIgya0g3xzmS5qf/VK/xQhDxHDnyoPK873x+Jb8wJVQo+HrzsgrIORW7
	d4Hv3lvzDuxoKdBu5wN0wccS1OGMmKgH3RVowsXoe0+bg==
X-Received: by 2002:a05:6a00:2e93:b0:842:57e8:1bdb with SMTP id d2e1a72fcca58-843368fc321mr1004033b3a.20.1781149153985;
        Wed, 10 Jun 2026 20:39:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb47eesm334548b3a.13.2026.06.10.20.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:39:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCHv3 0/6] serial: mxs-auart: devm conversion, clock rework, and IRQ ordering fixes
Date: Wed, 10 Jun 2026 20:38:50 -0700
Message-ID: <20260611033856.6476-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the mxs-auart driver by converting to devm-managed
resources, fixing clock prepare/enable ordering, and addressing IRQ
registration races.

Patch 1 fixes compilation on 64-bit build with W=1

Patch 2 reworks the clock handling to use devm_clk_get_enabled and
reorders clk_prepare_enable after clk_set_rate to avoid
CLK_SET_RATE_GATE failures.

Patch 3 converts iomem mapping and GPIO IRQ requests to devm,
removing the manual cleanup paths.

Patch 4 moves the main UART IRQ registration after uart_add_one_port
so the port state is initialized before the handler can run, and
manages the module clock for console vs non-console ports correctly.

v3: two more sashiko fixes
v2: split off of_device_get_match_data change.

Rosen Penev (6):
  serial: mxs-auart: fix cast type for of_device_get_match_data
  serial: mxs-auart: rework clock handling in mxs_get_clks and probe
  serial: mxs-auart: use devm resources for iomem and GPIO IRQs
  serial: mxs-auart: fix IRQ registration ordering and manage console
    clock
  serial: mxs-auart: clamp RX DMA count to buffer size
  serial: mxs-auart: terminate DMA before releasing channels in exit

 drivers/tty/serial/mxs-auart.c | 145 +++++++++++++++------------------
 1 file changed, 66 insertions(+), 79 deletions(-)

--
2.54.0

