Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87533EB10;
	Wed, 19 Nov 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544311; cv=none; b=jKp0xPvYE5SRwpsK6Z+9rmT2CALr19+dQ5rauCJLdl+bfwxXDkdHBgqVSoEkAEs7cL9q4HL4qzkvO3knTbv1APPE4KViRYDIq1HIMgCO39slpxJN309rXl3sYK02IPhf/xwCKyw09tOECVBrF8PB18ClKZm7j+0062+E8pok4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544311; c=relaxed/simple;
	bh=NLb0YGQMrP2Yt0bQsyXsXONWpxEsUuifqfc1ANvBTko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H88X+Z28aVS4kgWYyDe4HhrmXlu78BGCQF5a3aKSFwnnkjmLiku0yPPUQAxyjCsqp+qhjFuTBaBAEJijs/PCocIFt8zeQKSkcSWWoELVqqoREgJI6bq5CpEif/Sw4Z0P9CwM1ES2cKGG/FaWgc3BuIWyzg/N/R336+KyQ7vRnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVd/yLjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVd/yLjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E53C4AF11;
	Wed, 19 Nov 2025 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763544310;
	bh=NLb0YGQMrP2Yt0bQsyXsXONWpxEsUuifqfc1ANvBTko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVd/yLjGJjAEuapPN7EckvTB5WzpNP1tfu5ye3a8stcTd4jfHE7ee41c4fALELZen
	 mTIkceSxzQedQBoY7ZIeqcbEo2Yo6c3dV3G3VPym3rp0kUpSUkvoQdLY4dY1c1ySqF
	 NJbg+s4Feio1WMQgDarX+f7oH15Vx3bgQOdJxe39+8K0s186gFFo6H/RsUGtLJxtCW
	 C/iJiLNllUJqggKwfzMO+qCt3/L4mMxyDrtGUu20DWKjNtCWimTDh2LwKO1/wHvgSu
	 TZmWFwf2m4YNFPHZcOJ2yRePaW4nxtYLLJd7RZ7xNmZBtVfzzoOSTRRAaFCVxTHn61
	 gPUUUrUJHV8dg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 5/6] serial: 8250: make share_irqs local to 8250_platform
Date: Wed, 19 Nov 2025 10:24:56 +0100
Message-ID: <20251119092457.826789-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119092457.826789-1-jirislaby@kernel.org>
References: <20251119092457.826789-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

share_irqs is used solely in 8250_platform. Make it local to that file.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250.h          | 8 --------
 drivers/tty/serial/8250/8250_platform.c | 4 ++--
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index d8a726b355d5..3cd8614e6339 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -98,14 +98,6 @@ struct serial8250_config {
 
 extern unsigned int nr_uarts;
 
-#ifdef CONFIG_SERIAL_8250_SHARE_IRQ
-#define SERIAL8250_SHARE_IRQS 1
-#else
-#define SERIAL8250_SHARE_IRQS 0
-#endif
-
-extern unsigned int share_irqs;
-
 #define SERIAL8250_PORT_FLAGS(_base, _irq, _flags)		\
 	{							\
 		.iobase		= _base,			\
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 6f09416d4107..4c1166a46a1f 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -30,7 +30,7 @@
  * share_irqs:     Whether we pass IRQF_SHARED to request_irq().
  *                 This option is unsafe when used on edge-triggered interrupts.
  */
-unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
+static bool share_irqs = IS_ENABLED(CONFIG_SERIAL_8250_SHARE_IRQ);
 
 unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
 
@@ -378,7 +378,7 @@ module_exit(serial8250_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 serial platform driver");
 
-module_param_hw(share_irqs, uint, other, 0644);
+module_param_hw(share_irqs, bool, other, 0644);
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
 
 module_param(nr_uarts, uint, 0644);
-- 
2.51.1

