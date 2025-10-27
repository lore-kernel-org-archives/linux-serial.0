Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19030BB87;
	Mon, 27 Oct 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575414; cv=none; b=REINZMF73bpBX5djqa11P7bMnFcUGAC50+uj23G+1fjSXICJmGYCG5SvzamGz2WJ7oEeCnNQ6PhcnwZPz28qxGu5pC5dmTwwpmd01TGAU5XSHFlmDCaOi7uAxHyeNfZ82b1nsGJNQeeGK/NQCrFceY9+VEadv1CQiQEn3FZ9dR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575414; c=relaxed/simple;
	bh=1DAS4rdhFoWP3g/phk9RE5Jk9RdcoTqceCOsHOSwo1E=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=Cw+Q5EQp+7Zj8tH1YbrHBlGVIN0X+mtQnVHEzSfXRpiprPJNC9N8jLEx72g+sFF9/1IcwHeIvVyZQwITwI6s5KjaHFun5h51x2grkvfegJV3wZo3JReED4fAdkUeufIVMZOeqvJ6V1i8dpmvWDp2z08ZrlsyGbqm9hXqgTjUM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=n6EH7dyo; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="n6EH7dyo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=jfX0u/k11WtqaDvYGV08FTUGbESdLYPWBkzZWH4ORMg=; b=n6EH7dyoADHnJL77BCFRTRGahF
	HJgh3CbHq1vJ9z0A37hpN1GD2CdqyZ+zNaNaWYCD4ZEnyjkZXjFRFBIK95FTuVHR4A1rL0O0wMB4O
	7KWnd8EzWl6WYQ9PAgZudVW3COVDgAAzHMXbljvuS0jxQAkh5YhkTnnXz/kZSLLMWedY=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOEX-0007wg-Pj; Mon, 27 Oct 2025 10:30:06 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:47 -0400
Message-Id: <20251027142957.1032073-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027142957.1032073-1-hugo@hugovil.com>
References: <20251027142957.1032073-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v3 05/14] serial: sc16is7xx: use guards for simple mutex locks
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Guards can help to make the code more readable, so use them wherever they
do so.

In sc16is7xx_port_irq(), labels and 'rc' locals are eliminated completely.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

---

Based on patch by Jiri Slaby (SUSE) <jirislaby@kernel.org>:
commit("serial: use guards for simple mutex locks")
---
 drivers/tty/serial/sc16is7xx.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 335695d0e7aa7..1acf5be03d489 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -11,6 +11,7 @@
 #define DEFAULT_SYMBOL_NAMESPACE "SERIAL_NXP_SC16IS7XX"
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -778,18 +779,15 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
-	bool rc = true;
 	unsigned int iir, rxlen;
 	struct uart_port *port = &s->p[portno].port;
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	mutex_lock(&one->lock);
+	guard(mutex)(&one->lock);
 
 	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
-	if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
-		rc = false;
-		goto out_port_irq;
-	}
+	if (iir & SC16IS7XX_IIR_NO_INT_BIT)
+		return false;
 
 	iir &= SC16IS7XX_IIR_ID_MASK;
 
@@ -829,10 +827,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		break;
 	}
 
-out_port_irq:
-	mutex_unlock(&one->lock);
-
-	return rc;
+	return true;
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
@@ -873,9 +868,8 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&one->lock);
+	guard(mutex)(&one->lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -942,9 +936,8 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
 
 	if (one->port.state) {
-		mutex_lock(&one->lock);
-		sc16is7xx_update_mlines(one);
-		mutex_unlock(&one->lock);
+		scoped_guard(mutex, &one->lock)
+			sc16is7xx_update_mlines(one);
 
 		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
 	}
-- 
2.39.5

