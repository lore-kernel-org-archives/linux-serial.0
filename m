Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076813B9D93
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541305; cv=none; b=P0RiWdd6JnjWVNDPYJKFqpqHK+dTN7GIDK5FkDlEvBrlr1iP2/u8loW08ZU8IHSZO4W4F+GfRCwy7TtpEYu3ve7A30q0tUTye2kUxfmrLZdC+T3jIUViMraxt1N+wfflhZC/XM3g3GnR559WxM4gVJFvB1BmoBgzQmjziRJxG/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541305; c=relaxed/simple;
	bh=3bIzl9Orz+VX8c43Yu1CKKnUt+5gibYznMOCZRoI80w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoBsCsS7oUDPAiHDGW7iLwdU/BOhpdG3uCtRxHeuj3XAFrHECePvH0/lZLeK/ApGC0cfJUd5g6FnOGmilxmPrBamfjNqZR4ak6h1xcvGWV6eIzkqpJP8s9OHeOWIZjEa6O9P49hcXIH13GOUHGpsLQObdDUZrLPgssLSUkobR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoVQZniU; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoVQZniU"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1089965a91.1
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790541303; x=1791146103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5sot5gf02iW9KatLlMM7GFUIn+IJuBNvzHGlsRj0G4=;
        b=WoVQZniUiYchS5zR0gwiWbRdhd9PoI4CiG5iCuczHs4ldignNhEFTIvWEAC0sot3MS
         ZpQMxNYlA+Lfph6DvpvI8EKc3RnQ2GsrrXyx5OwWT7zgtvxz0C6NULwueJ7Tz36iacY1
         uqFVvl6cbwsL7YnIQ1zM35kjwLbwmCUfkBiZtzgVLYtTk9/512UW2tjD+W2ULrpsgUCX
         B/RzdZixxh5YItyIUwnVCrV60ZmVob7/zH7k1FHSk0mZFdLAxy4BbNO4mbGsvWSZwtsZ
         oTfW3jyN2KqXFaNjSaAZzYXCCmzhpuB/wxAtbimNKJTVCm1RRWQQzGnLrNkp5M4pPS1g
         z+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790541303; x=1791146103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5sot5gf02iW9KatLlMM7GFUIn+IJuBNvzHGlsRj0G4=;
        b=t1CPUXFpXnscXj/EaTMTmo+VflMi5e/ibEZo4Y/WaiPtfeGUztKIv2FZH6513jVuw3
         1iTu7/9ZZZ144n3ZUMoWh+0At754loeUQuHG4XUSxdB4q9fAKCw/QqsPIAdV0/UT9hGD
         rKtdCGsfaNUU53QkRBvm0LLJ+68Zt1F5cEXAiq3K//2O1ghwpBSBlqydyA3wuj0hvK3G
         8uiSUgXYD49/xLDPPhPyRv63Oy0J8RARCsGv7AvR3ag1dG3wGWM2GaFBqwsRsiOkz63q
         ms0BYfhDxr3JoEqznySNsmOHDeteGVS1ajiqT2ZxS+m/jNNV23y+Bcuicta/8OPBkppM
         NfDg==
X-Gm-Message-State: AFq9FYJ6exXY9L4ilDfRFF4SqbEi0/Yf9hJfYTfrsYTVflZey5FaZNxw
	UcVcNMwoFshzvo4v7nv5Ihnov3XG/nbhsFgiLXwajtIGPuvJN+bvYbojGjo+/rwV
X-Gm-Gg: AYBFou3l+NzRf+lYKopwzcJGXlB9t9mrN1dfvy4Aw7bIsv6xl1U+0tc8nW/Qozg4cKV
	7sL//pM3G1kPscl6oFrFXv0f1XcjLQ9SSGaJKZQov4y//lmPrJkKmB0utw7lTcqswCoOuGy5aZ6
	YOsRFTknZ2ARzG/FWPlx/1j32t3BQZN67hgMAYbBIOfmsKuRSDC5H4i2bAz3w3gfyHjkV/eY2tU
	1gwARvFVHnx89dcGWXI4e75Ae3eVg9YRYyYXuoko4VSTFyzXLI1ZSfyic2Eekf/JZ7LLm5Gx80l
	16yFvZ/eGdd695JHREnyt1kOu6wJ+pn+fX61ZyDWJz+L5JJaqYnZXLlgywMQ2Cu0dXtj++31FWS
	Wft2KDtBG1GW3FxNmE2i22bQPs3Wq3J/icZy+97sUFc0gz85pOZWkJoR91lYSI3/TfI+0RVZcZv
	HKsZzfzDZTRcYCww/yuCrivgo4+F9MNWTrhLeLzIhidLPnfO8UmN6hZkSGM2sGX9EJisrluZjsD
	txUJc85YJcylfppVXK3YYY6+YFpiRYpWTm8JadzHqeolwARQ1bWFKJCOTSQkqb8ctJIkc1KbXly
	B8o9daij9y0mYpFqwIKgknnFQmzXzuoUDvmYzyEhzTSmeQ5I
X-Received: by 2002:a17:90b:53c3:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3a09896a5a5mr9550874a91.47.1790541303373;
        Sun, 27 Sep 2026 13:35:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773e7c3sm22752416a91.17.2026.09.27.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:35:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH] tty: serial: mpc52xx_uart: move static declarations up.
Date: Sun, 27 Sep 2026 13:35:01 -0700
Message-ID: <20260927203501.14105-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid a compilation error so that they're not used before being
declared.

Fixes: 4d105880666a ("tty: serial: mpc52xx_uart: add bounds check for psc_num array index")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609260356.tJWbd1WU-lkp@intel.com/
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mpc52xx_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index b566206f42a2..472ec39caf27 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -634,6 +634,9 @@ static void __exit mpc512x_psc_fifoc_uninit(void)
 	}
 }
 
+static struct clk *psc_mclk_clk[MPC52xx_PSC_MAXNUM];
+static struct clk *psc_ipg_clk[MPC52xx_PSC_MAXNUM];
+
 /* 512x specific interrupt handler. The caller holds the port lock */
 static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
 {
@@ -654,9 +657,6 @@ static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
 	return IRQ_NONE;
 }
 
-static struct clk *psc_mclk_clk[MPC52xx_PSC_MAXNUM];
-static struct clk *psc_ipg_clk[MPC52xx_PSC_MAXNUM];
-
 /* called from within the .request_port() callback (allocation) */
 static int mpc512x_psc_alloc_clock(struct uart_port *port)
 {
-- 
2.55.0

