Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466607;
	b=AsYRAegWSsEJgN8KA5yDXYCooLx+7FM4WigIq6o2o9vVCLGzMG9mcyCbzmuN8CpXkKjj
	 Ebar7KKEx7cUJeosmjcySaEU7ecSry3pmv/ppefL3vP2Fcs4QOzUxjS3YVXpMSIGwxrBn
	 KCUjDpyx4aXY6KaxkTFBVKXyztM6o8neovWpuoRwiUcNOIi8h2l/4Z6btFZAkEVheBPRA
	 mxjaM4nSgfpA9KsaAtX5AocciY8o+ZOixZRQ8fdKzmTSR3JIzBpeeaR0p9ZsiuBGXQBvS
	 uzYxOb4c36VxKe8p04nL/V3BjVRTZMao9XzbsBGO1NCBYLQlwiXHUrD4kSrSS+NuEUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466607;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ht3eHe4EzKYxFFLbnOBIrMS9lRut2mY+uEg1RLF4XUA=;
	b=js0FUkD1JtlRLZMCrAinu2//Jc9+F6wlgYd4U28H18MwTzLDXfE05A/rqiHT1giQmYFH
	 cVThOJZcfL221X5Xt1bGmDcNwyaRFmL+o79U5ZAk7umvNpQWT+25NC5726ygEYhXHIleC
	 89Y1LZHSw0SXH/0bjTLqHJ/0VUNhyMiaeurB0r2vf4wu1F6kYlqZGj+7IWkPqgaEARkoz
	 gZF5bEY0B8RlqJ72eNKuALqM+T626Biw4/WP5e/mt4FZeQdyDK6gQeABEEV6Bj8YK653+
	 W2VzyHyUzNK1ZQHRQSjEmp8npnndagrUrY+hFPSshmik8boHlPEfFpFJ3aIeMbETGEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrbN85Oq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EE606A31E;
	Sat, 31 Oct 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrbN85Oq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CB91F000C1;
	Sat, 31 Oct 2026 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466606;
	bh=Ht3eHe4EzKYxFFLbnOBIrMS9lRut2mY+uEg1RLF4XUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KrbN85OqY1lCsidheCnNJolG+HjnxA3FM3VFV1wn90pXbtHW7nKFH6nms0CY0E5Vu
	 QsJ2zC7Cyb0Ez6cVoCm7nX4gF94MWLsJxjPF65GEZKV9oWAvmDiNMVVfMCBELi26PZ
	 5dMzz0TOCAu8uYaGbPWLnaj8ZcOCRHjL2ukFnq7EdpJzNiaaemdYoCaq3OiuL7cIAp
	 i5yW5pb0V6tUzX8GfRGTzWH8AA/FWOYg4qDco0YnDyVj6yeI1SwTEx/5ajQJn+ONnV
	 y7ZCyasozMg/63Ze5mZisuNx8VL4T1Im5njy1NWu3FeF8av2C0TsanGNM7WZm237o0
	 TH7jiFuraDKGA==
From: Joshua Crofts <crofts@kernel.org>
Date: Sat, 31 Oct 2026 18:09:46 +0100
Subject: [PATCH 2/5] serial: fsl_lpuart: remove redundant
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
Message-Id: <20261031-tty-dont-use-autosuspend-removal-v1-2-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793466599; l=1119;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=2oCMjGtbSQHN64VRa5dtTxB0LFjvNWUjbw8MWTfVbOY=;
 b=cLUcxGR7/9wLAmRMhc+sl8k/QOn4ZFAiZc86JXTxphHlomh6NKpgAKNnKN3vaCWkNhcZAIwl1
 Nmfj7RRHhi8ANbairlQHfGVoH2TDp+O673CHwBph0L5tTNU1LJtd1Ht
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..411e14151a50 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2987,7 +2987,6 @@ static int lpuart_probe(struct platform_device *pdev)
 failed_reset:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	lpuart_disable_clks(sport);
 	return ret;
 }
@@ -3008,7 +3007,6 @@ static void lpuart_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int lpuart_runtime_suspend(struct device *dev)

-- 
2.56.0

