Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A513DCDB0
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 02:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455557; cv=none; b=IMn2azMdeOJxLKUuNV9phWfRtxKkBfdEhXKuCFAWOJoxYxA7xEs3ZUmbs5vBztaKepMuwFBtBm5G3lIMTfs/Xp0HAFWE3+4G6kXXPXaDD9CHY9LQprJng0KCCzC4c5mmqt3hEhycLG6njcYrtTFMsUSlc8iBHaTSJdNOuqrjrb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455557; c=relaxed/simple;
	bh=gX6a4+NLwKi7rV6ZInPZFYyjhB+ssYjt8EtCqQtXz7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ltlf5BIY4Q4okJ7TS+Q/EF1gQw3o9sBMnNU0zTYpbQLikR5Ju70pCBbxi0tZabYlbHrZyyq6kYXusL7w5TGMaFT8pEeqXHUO884CCF/qguQFRzpRryisMeYS15Ie8YUpYvwYKpbbqNIS+7f/jKa773YweMzKfIBsM/9Kes/ytJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsKLhw+j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsKLhw+j"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c168baac83so978705ad.2
        for <linux-serial@vger.kernel.org>; Tue, 02 Jun 2026 19:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780455555; x=1781060355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3USj/+ztE88i2k2s18GnugDmZKrDU3UbbzkTJE6QuT8=;
        b=DsKLhw+jhZPi6C7UUahqXtPtj8MWGrWFDA5Cdj3cHD6tWS8seqe9k98Ub6AKe5ndJY
         h71QmsJGP6L1tUOFxf/n98n6UUyGDfpuBQbNTCIbh/VBwIRZ429KF8dbZ1qL99a9ysaR
         nekZEjtZUUUD2vruLIU2+K+UJhkTNK/yvjHtIBsmtEF8DF4TQj40AJCiC4MEDwFFACmo
         jQp5DMSG3/Ftipvhe5gAZrePX9uBEYkf9PVwp2R00+k4q9JVt0kdd8ZLTXmX5ciQZmcv
         0LkJUFva0FZ1JEhcmybMmafN3/YsyvkEM643Km0mcKMzrwnqTHyJHGDcbuCyu/LtiUk8
         WhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780455555; x=1781060355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3USj/+ztE88i2k2s18GnugDmZKrDU3UbbzkTJE6QuT8=;
        b=ZSqhC4o1Y2wqGRHcy6FB3ExdIszsmxvkjXZ2GfS4+cuCPqE2qgsaEzf6CQShsh2Kyr
         cb9WNpYKpp9i5cik8K+05dAHGrbpfLKs4yzsPu/dJ0PsuaXX0yQkPNqF0a6J+s8KJPX8
         h5D86769Bt1gS1TQtwaTqGg8bZUnLot558N8QLmYLTlAtr3gyobgZm7LUOxjheOKdDJU
         j952UCFMplq4O60rFRY3KbA6Mk0/hOW1ffDQDr9TgyYzsFu+pNj1hDqiFNKgExRpdzex
         bib75uXTjhg+tKCy8fMb9QEbtpPsMH9p7IGIWe0UoFRB4nt8rG5+esJ0tzmoOoREoGcG
         P4Aw==
X-Gm-Message-State: AOJu0YzCUS26InbTTEupvNEHGu3Jd+2mrKkIXLOkN9mOBDf97lmRPxii
	4rhRpr4P/Tm2TLD/meoZVVchahARUlevLmuG1llUTpqFVhSQWr28/DRj8XrN6WOW
X-Gm-Gg: Acq92OGhNkI9aBEheW2//7TzHrOHKao4vmxjcUHqaxEe+EFu4I0531WAmDFPQREhrTv
	CuHMIDhcs8NG0fa/tkqzjuJCzMgBMTefgFVRiWZqDKZVyKH87YKcaul2DWuRsCSqk0Inrcz9hjv
	2zVprpH6C705qibIQabSQoHduL+c/9/sAW6051phdBvKx6Rlirp/tH0BaEPzVFzLsaZBRXkM0jR
	37kuJKV3t/++75m2FhELWomimJKyg2dbNchaIlEs0eI973A67JCpZV/i5PiQluh/2902Ww9EYrj
	g7jlWWGWFToDgKeE4336T7wwHvJfpiKdq1dqt0aKwbRhIJZnzY40C5ZV0ogrDGGxrQ/kcifNom+
	g/G6X2bHbFOkLLdZDvIA0FufQLuw0mjC4QloayorYtiP98HSZOsmVF2CL/8aluzQ8j0OmSaIClS
	8NBHl6DciVQP4NL555LB2G1EreH9Vjp0XFCujs51YkLgIqXutC//l6y3zVTS9izf1NxTWI17Bzp
	qIJBtrZp0udeA8tkBPv/OlvMguqTCDgWexGDDehnCp6zQ==
X-Received: by 2002:a17:903:2410:b0:2c0:b6c7:2273 with SMTP id d9443c01a7336-2c163a257e8mr14341345ad.3.1780455555160;
        Tue, 02 Jun 2026 19:59:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm8093805ad.17.2026.06.02.19.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:59:14 -0700 (PDT)
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
Subject: [PATCH 0/3] serial: mxs-auart: devm conversion, clock rework, and IRQ ordering fixes
Date: Tue,  2 Jun 2026 19:58:54 -0700
Message-ID: <20260603025857.287148-1-rosenp@gmail.com>
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

Patch 1 reworks the clock handling to use devm_clk_get_enabled and
reorders clk_prepare_enable after clk_set_rate to avoid
CLK_SET_RATE_GATE failures.

Patch 2 converts iomem mapping and GPIO IRQ requests to devm,
removing the manual cleanup paths.

Patch 3 moves the main UART IRQ registration after uart_add_one_port
so the port state is initialized before the handler can run, and
manages the module clock for console vs non-console ports correctly.

Rosen Penev (3):
  serial: mxs-auart: rework clock handling in mxs_get_clks and probe
  serial: mxs-auart: use devm resources for iomem and GPIO IRQs
  serial: mxs-auart: fix IRQ registration ordering and manage console
    clock

 drivers/tty/serial/mxs-auart.c | 133 ++++++++++++++-------------------
 1 file changed, 55 insertions(+), 78 deletions(-)

-- 
2.54.0

