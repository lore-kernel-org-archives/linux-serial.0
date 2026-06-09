Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5143A6EEB
	for <linux-serial@vger.kernel.org>; Tue,  9 Jun 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044656; cv=none; b=kFBeZPJiajyUaXAKd/WmDf6IjZFqA0UtqJJsKRbNW8oa8uqCrQCuIQyfjKmVxGmN5lLAfQoUNqcY740RQu/JXoELj/86SvB3sdhqwDFzJiUkOR8ZTBSq+pFJ+L3L5g3On4cQ9GN3FLAdU/eGTnP4+2iWL7wlmhJVN60IJaQqumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044656; c=relaxed/simple;
	bh=v1YU80TyDjrf/JHPL91vspsLFYxHtHImDi2ezqOw4BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryWn7TFNmS7sGauBy1eBaW5j24OlwAKlJDZ75tMgBRpGCEFGTCbJe0avoe2nd+B7xOVJ9j8Yzk/OYE8rctC5HifSL3faPj60O5j9lhsiiOgGwwYKJkoRc73OKEV/sl3OdHGsJ+HRHLxU/e/doMbAoJeA3BQ3yV6R7XxqXWusYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQHB83sM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQHB83sM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so41281035ad.1
        for <linux-serial@vger.kernel.org>; Tue, 09 Jun 2026 15:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781044655; x=1781649455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kO2t5PyjdfFMvsUWeszR7GAdmLCj2iCqR/ekO1AQQMc=;
        b=WQHB83sMakgkJn7+Rw8hT2QqZQPJLUW/ydS7L195ooZhsNGRAt62fr+yWaiL46gDux
         i5xCEprudVaDSucwb0JXPbwn5wD6XtQZ/QlVlHS8IyDc67cfvsqrgyZxqoENmTD+/2ZF
         tUNiP+SE/3Y5KVhd2HPoT2A/qh8e46PdOnn1SfEdQZi9mgyC+wTCn5gyuxc0T+5om+sE
         YL5nIOpJj9x0ciBhlsZIATDwOMUFoaIXKatUdmHGu4V5IYkMZKRnmEMfC8ane9LiBSP9
         +MhrHNfsEzKjpvqTMTMDJnXj630DRSaPMZq9VikE2x3nKhYgpSratc2AKC/rawmZBIoA
         qtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781044655; x=1781649455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO2t5PyjdfFMvsUWeszR7GAdmLCj2iCqR/ekO1AQQMc=;
        b=JdlAzdS3XHJK5KU9TomM0bF7VY0hsOWBpPaXYl6egy92rPZluLF2HN4Uu1pYKfooXQ
         ZVfEUYjlfh6L5Qs67k5ksryXKT5r3kW+HDaEozw32zuZzNptrZPQxGCSHyY3G5rz8PjK
         r7gsTGSeGf653r7oUJbUWqznCwIC5l0NR5vYqyZObi5D5BpXK7oyRkClcyGsUUIZLGfA
         KGcv22ucqH+AsD69b+IMnAXNkSpsC8YMMJqG7esboeWI8KmAJawyqYxxYXEsl4Bn+3Lr
         7m+U8ox/UDsaZ55a1hlI3SVbBKTt7TTNweHGULA6Wl8jhVqA/lxi6WZtUMR8gNKT9kKn
         Zp1A==
X-Gm-Message-State: AOJu0Yw5Pblhq73I+oDTq56fzw6LU63bMNM2mxd5gXotkE0R6DA4GcOI
	HwdVy8NpJgiKph3iJjSa6eFz0IWlqFdOIhf7jWLT9eOD4d4KntyMk+JLjNaB4OFO
X-Gm-Gg: Acq92OFpD80xNLkp+lfc6NYAs85/WzJzBUmfgk4ZP4YWVqd9ZSKibNvdwoXq8sAYuL1
	qZ0kxDwW8PPZIFsyqyZVhtN5xcp9lL2mRk+2SYLX42vRKQzFPwINfzpd+hGxU6EPcFzQp6WnsOi
	xyI81sYXY/437IMUQD1GbtBenh5D+f0nt2QmwvXifVHo4WNFwTt2jt2l2cTU9IgsVONTxm/YzAs
	jmRzOiq9VK++98yVdnkt0EmNI0fCmeMj1gyjga9tTp0FZKTSrEEN0amz5hOfMp8u/vsTq8Fo7aW
	X0sawGYrxGe5LE+S4YlL+kOrJBEz//aMBAoHC+3IPMaY7PdnPL4cEjDFbKjtmskf2dSGwiMX6y1
	Mw7ySCXZmhnfx8gBk4KcgmOmecyAWI7KnbKYOtlUHhYRbm+SkJ0zj+Z5C6BHC03AiIrFkLRzZtr
	z1t4riuBCI9d2uqNOYN87I0hErdOTaguQuXo77q7nx0PmTZmmnfOXFoHCPSAcIABoaK9Mg/9TkJ
	f5Vq7qd6y8X40NN9YLbgkS294Calga7AShmDj9a6IAUmg==
X-Received: by 2002:a17:902:cecc:b0:2c2:9254:4c22 with SMTP id d9443c01a7336-2c2a1c66cbcmr59800935ad.17.1781044654694;
        Tue, 09 Jun 2026 15:37:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm293750655ad.9.2026.06.09.15.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:37:34 -0700 (PDT)
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
Subject: [PATCHv2 0/4] serial: mxs-auart: devm conversion, clock rework, and IRQ ordering fixes
Date: Tue,  9 Jun 2026 15:37:13 -0700
Message-ID: <20260609223717.41670-1-rosenp@gmail.com>
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

v2: split off of_device_get_match_data change.

Rosen Penev (4):
  serial: mxs-auart: fix cast type for of_device_get_match_data
  serial: mxs-auart: rework clock handling in mxs_get_clks and probe
  serial: mxs-auart: use devm resources for iomem and GPIO IRQs
  serial: mxs-auart: fix IRQ registration ordering and manage console
    clock

 drivers/tty/serial/mxs-auart.c | 141 +++++++++++++++------------------
 1 file changed, 63 insertions(+), 78 deletions(-)

--
2.54.0

