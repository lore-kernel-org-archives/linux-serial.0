Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA24078FE
	for <linux-serial@vger.kernel.org>; Wed,  2 Sep 2026 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387436; cv=none; b=UboKUIv/StwMMhslaBYB7uYYEZYXS8XvrDaW9Wpjq0oRdWs/08TloOkw7KnLdsH72GM8PZbcKKEbm1cvazxbCXC+37Wozp3fmllc+81BOgTNIMC/dTnxw1O0lye3SZrut8PaFh0tUIN2ykyumztDkAoH7tcZNL1VFfjybriwLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387436; c=relaxed/simple;
	bh=KBQhq/c+LMHJVVAXAOkUDjcq+u+ONWOcVbdfKT0tUFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4lC1q8eNYpLLx+ytuMqyJmhKUJorLffEpLoFY39qGKKiAdP9b58vkPNqCkE2/Sm0Bj7W2rKVEbLv+0aq9HBYJPLlktMPuDcWSQwFavxZmBuu6xMUIpVm0EcIM7WCfbcxH8Kn79BPJ2TJHG3emGnSQkSw+ta7PGXwrDOogoU6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6IwlNi5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6IwlNi5"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so1675105a12.3
        for <linux-serial@vger.kernel.org>; Wed, 02 Sep 2026 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788387432; x=1788992232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=68TMRCoJZibya560Gslbsv50pFJcZXRG1soThBLnF+s=;
        b=c6IwlNi5cup49XRgRPDIGqJMVAkJlo5Kj2oK6bX05opADhr3+2hGH519r3fJW+MkwZ
         BCSzfy4Hq7vW/ridA+DwwYyqJSf4zxEQuUlnaekndz0Pn/Mfup73S6eJ1FjCr+Q5x6kE
         N5+vgfzVKP1Ea4lw4XBvC+bTVgg6tX1UFl3csjwtItQcA843S4sKqrb5gDn+Egb+hnPA
         58zcwuMOB2p8xeucl41dRAVBE+A2LO2/WLhQ6nnpWcKryMcEV5DJ5MKO/H/YiCNBDMFA
         +bh7NqhurTvH1gMGUPw/fPNzYA3+33zM6IsNRLc/D7tLi6FmAoWfSBjc+TbfMSDk4fJN
         rq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788387432; x=1788992232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68TMRCoJZibya560Gslbsv50pFJcZXRG1soThBLnF+s=;
        b=oX9yvITwES5OQ08GxtTGyF0UC7WbV+iIxJkINbiyyZSx88AmHTVYARy9V7/z27zb5p
         gBqbsKs4nWgFWmyAMOas5gB9JMuTGjJxiz5i6EfbqUStDzO47gYm/HP80mTwYlb8DECO
         brdzPIjw7LxErVXqFPyOTEm+VhxGppe386o6ScBMdgUS9kTLJFZ6tqfxbCemDjcuWXdx
         ZlS53ctKNG4JxwsrKRMAVsuRDARCSI9f1igNDfCScVdjHasLmEmbSYWzxzXwoDKgAjic
         g5644F8IUik9HJ01rmmMwMpfLyqZuOegqls+QI1IMVtFWkUomRYJqjeIjsZ80TFUgZOz
         gjGQ==
X-Gm-Message-State: AFuF++kkcXI91KTVL4OVZw3VAPr7kAXw3JvZQWR4Vmi1UQMydikQSLg+
	EJG1AgBZWb/7GBs8v4fYLjYJKNgvfzU6J64BqC4WqrxsQcv/W17jFBjPoFHDNg==
X-Gm-Gg: AYBFou1rpi9AwknnjGJQM6h//5egbIYdgXip91+CH2H2YbMuy7IGq3Kr4pEJFJEKaxz
	jiFRedZGjEtaqqQ3TbP8sSIMheMdX0+EdTDQ8+kFpN0/S8lkI6EG8IvwhkHLyv6Sy1r6Fs0Y1u3
	VDeUhhdJLTXUofNKrqNIU7mWO/fThKWwhZ6ZKESFr6j37wGns3jJma1fvel9X36oCMpW9yQz7O8
	bQBwNswxoBP68DVr++WsV6UHyHGq1ZcDnxC4JEJyVQdk+nHzqllF5ymFiDinrT7l3VJG65YEXgd
	z7IJ6IBADP0TtbALJX8f27rU/UqcZEQ3b66jRwj3SOClUAbrPTzYzfaIXmUUqOaaRNlKkyj+XaS
	n1GNGgx0I6Lr50sARRG2oaoIjq9PVu3+4gWqZOUAfkAgSt9+JskIaFFYcnf4G5EqGJMZRsPbnR4
	u3N3tR3eiAyb4Y65b9UHawPhYDpYeX6iU6IngkZEUz8Fa+MdJqnH5wSQPHWj0h8MdXocU9LFYl3
	Bzi0J5loZI5ySFAEj9qNRibtLCjgkQzRO8zxxl44o+GYg1yAhhVjsHYD5JjJoRkNztxQk5d+qNB
	qG/ZwIBDO2LeIoBeFP70QkkbDvAYmMkbGYmtqg==
X-Received: by 2002:a05:6a00:4f92:b0:857:73e2:9105 with SMTP id d2e1a72fcca58-85ed94bb426mr10739539b3a.21.1788387431568;
        Wed, 02 Sep 2026 15:17:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc003a8fbsm1881138b3a.35.2026.09.02.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:17:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH] serial: 8250: Add Armada 38x earlycon support
Date: Wed,  2 Sep 2026 15:17:09 -0700
Message-ID: <20260902221709.340393-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the Armada 38x UART compatible with the built-in 8250
earlycon implementation so stdout-path can enable an early console
without adding a generic ns16550a compatible to the device tree.

Keeping the vendor-specific compatible avoids exposing the UART to the
generic OF 8250 runtime driver while preserving the DesignWare driver
Armada-specific runtime handling.

Assisted-by: Codex:GPT-5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/8250/8250_early.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 44ec209f37c4..265d49850e15 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -175,6 +175,7 @@ EARLYCON_DECLARE(uart8250, early_serial8250_setup);
 EARLYCON_DECLARE(uart, early_serial8250_setup);
 OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
 OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
+OF_EARLYCON_DECLARE(uart, "marvell,armada-38x-uart", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
 OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
 
-- 
2.55.0

