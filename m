Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466604;
	b=Iv1c2W1UTMkFBHTIVH73H5KPmLC2zfwsO5KW1SzVIiUmjyG+PSOm2BANZqsyeF6PeY+3
	 waYznNO8SrVzDfXyFW0rLbCeNlliXzn8bYfhazj7SGfGrh0qd+2q6DVCMezy9Y2xEpaJo
	 OPTWsiaRPpoYQlU2oPPccCx0HT7/TkIwPQIYov2rw3ETaEdAUUSh/B2RHv1uE3GD3hXPl
	 tFnqVH+Q09UXL0DOr6dyOrBCONqTChc5cGIlHiKO0LmgAFZWq8oVBMAXCgCrHb7TtL0Qz
	 MUxPjgReU0nRFF6fqrXp5sRX2bLmvV9MGHGGEfXTgvMk9/ADxnHawFGBOfeE9cK1t2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466604;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=W5pbACeLmZxOgIPqMZmA7R0XTuCDvCRAkd65xmmHjps=;
	b=xNZPw2Kv5yXLX1D0xUxGEXXoQTYjZI7QHzoMJCB/M4YbwuQsTJMHERBRXXXbCpCmPxTu
	 AziwWtZTsuKwCXdeo1dp7kdVh35T1KhUeayXqo0o8pUzmo9yIq4Xc/4ZpHS18M6F+WZec
	 BhSjF00X/uv6y+uiFjrdRIsYsC3CHI5jxJyTB8GphPVpJh+RfSS9a+PWisNUlE8ehLWRy
	 8n8/EmC671nHgHlOOVrNxVCqjTmXPBvNvYAJ9va122NIdQdqZFjP5JbJTFU4h8i/V2MII
	 XAfZu3XeHyzc7v52PUUsnR896HWh6jN5N57MUM/yRbQoQA2z4evdn5plLaSZJYyHz4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXr8VFkh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A83606A31F;
	Sat, 31 Oct 2026 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXr8VFkh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172B71F00919;
	Sat, 31 Oct 2026 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466604;
	bh=W5pbACeLmZxOgIPqMZmA7R0XTuCDvCRAkd65xmmHjps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WXr8VFkhseeAagtDUGfC8bF92PTIxvdLT1NpPWhdA6T92SXjh9DnkGQlCi2zQ+a9H
	 JNCyE9o3HBjdPGWUwzIXbGfG+t5/yHTYmdhfzBqGcPIh6iHBuZBpyD1hPrZPlkDbUk
	 vgs6B/XD7wrFwVr21G+r60HjC4ATEbb7Mi31RmijnmbEB6a+CuQeI+e2tLnfpC2bh8
	 yl9tUDAXDV2A23OMP7x6HzHa53vCXkS6Py4V8RQFAZX/NNVwfaM7GJN97WOrOMLHLH
	 kS86fu1ufMo8mwo0C9IXofNdMrAz2Dt+Jqct6s3Bmu3c3nWfqFHmAqyiAuK53Zeh/2
	 yU1xRmfdxtJWA==
From: Joshua Crofts <crofts@kernel.org>
Date: Sat, 31 Oct 2026 18:09:45 +0100
Subject: [PATCH 1/5] serial: 8250_omap: remove redunant
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
Message-Id: <20261031-tty-dont-use-autosuspend-removal-v1-1-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793466599; l=1219;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=MJ3P6Nb034L4X0qZnePc1m99BfQRbCOFnwq53NCQfmI=;
 b=DI3XA8FRtJKLJpa/DleKCsuR9oBj0b1rJwiZPWuwjd8XYHTP4/yIKWfmLw5WgkzESw1XV7FOj
 kENn+QC1qGMCQsE1TkWHJ4Im38hNr5AsK3eqBGqljRoLaz+oQcR71LN
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 29a203ed93fd..5d6911b1a2b0 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1608,7 +1608,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	return 0;
 err:
 	dev_pm_clear_wake_irq(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);
@@ -1631,7 +1630,6 @@ static void omap8250_remove(struct platform_device *pdev)
 	serial8250_unregister_port(up);
 	priv->uport = NULL;
 	dev_pm_clear_wake_irq(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);

-- 
2.56.0

