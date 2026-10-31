Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466609;
	b=tw8SpkXyAksvX8xJwqppknr9ggqM4+BjYxjP7bjHc1ToBUtWEeATmX/Ywv1pgfC27657
	 TpkuTWKj1TVLCKpgDKFKzDd8qd+D6CRyBGCUr4ewDseIuRoFVpaqrrgD1I5RinMBFrbo0
	 9gddfyeRRxa4xCOR9ZxOdgQJ76u4OyNeICwYAPcjJthRsFGX6KcB8cB6mOw3BiQxwNqa9
	 Eypr6vrmtt04Px7WDLX+i4iPqwuSp0d4Y8Ytv97Ctxg+U/apMNx4xoXpbDYiFXlAZtiTj
	 lUszMfZnXKYJJA4iJF+QWYwq3TRcx226AmZv7Imgc8/oEQOaCzcUZkPcHu+h5Gc73NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466609;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=V3lTSEBxFP82FPR6J1VxiQBr8pSV2kirBbaP84zkoiA=;
	b=OwfvyYa/lQ22VpsoS06P8hwOxJylJPiqKvPArGknNbNvC/zOlhfV398/0gc5CwWqQ6np
	 S0deJwMGPYrOSkmspYXzEbNydADyoMhoogmej8GVosSmZx6o7+4FZK2FYVvqHD6QcUyi7
	 SK8KymBK8zdDT2U3sxkasXBTTiBqvhxWTLJ+CXZ1rXcPytbJ+GUhW+jROZj0Vp1oVyION
	 rVQWvZ0/CkVTqPXLhud8h8dxo6bjGtId7z2nhiIeX+t/mEu7lw9Cxyhs22hAuyKT+zL59
	 4rKb3CzKJscupWy2SpI7KD9FOX/+S5mlx6gLnWpaS/buPJy+SnSlAZITc7hanCiHnVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="doJgM/Rk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A43606A320;
	Sat, 31 Oct 2026 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doJgM/Rk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF70A1F0093A;
	Sat, 31 Oct 2026 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466608;
	bh=V3lTSEBxFP82FPR6J1VxiQBr8pSV2kirBbaP84zkoiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=doJgM/RkBgBP720Hvu+93fMsfl4ev+06fwYvoa8PuIaMwgf8oNqvt852DYrgGzR5Z
	 zlYuSnivsPYsF4wB4xGcTgNoZTJzqGZz/w1rCRlaaVEwOuKU/dLVccJc+T07QY9odZ
	 H7FpP8vA5wNFqgVu41lks+t7l6aTNPzNRE/5XElSHXM9GVUU/Cfms9zJikf3AA0yOk
	 W2egmR8n1VlZCjLyqfg6RLteZxkCW6rwnouG75i/0iJ0Xl/uMaF98XUBG1avEmYK0l
	 I2BvK9QIsl5+TZG+OeGNut5va2PRLuyu5TJEjATK1ea0EZvgJ3dH/MfNvEgO+3zhoW
	 sbRHyu4CFc7uQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Sat, 31 Oct 2026 18:09:47 +0100
Subject: [PATCH 3/5] serial: xilinx_uartps: remove redundant
 pm_runtime_dont_use_autosuspend() calls
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-tty-dont-use-autosuspend-removal-v1-3-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793466599; l=1272;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=7bLXE1zIwkiAxLH9OQkboodAxW/t1137Dl+DuqntUDY=;
 b=u486STetJaM/0XNEuOBsXII7plPuhrm3fG///hkv3oZLCIYdWHZt4R87hAW4xfeo9anmOsj+D
 dinCV8/6FqNA+XBnwW39R7v158kvZlFJgLLe4qh8MhbilNA1ArZqy61
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a072b75dbaf2..5901517cce5a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1844,7 +1844,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 err_out_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
@@ -1880,7 +1879,6 @@ static void cdns_uart_remove(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->pclk);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE

-- 
2.56.0

