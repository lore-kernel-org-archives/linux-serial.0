Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D63101B5;
	Wed, 24 Sep 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728281; cv=none; b=G1RyNlcgqJ9dF//rX29RJRgnSQ9UI750+V98SYUa1Zb87689mCsp+OEVa1iFWz4cqMvV0XcVevDwJKFoIVWTQev3I/WRXvwP7y7mudj9Ipn98zjJLhm90/ji0ESIU8F0o0NcgJredNuBbdgtV1mn6S2F0P5OuqpGZ8TtnJKbNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728281; c=relaxed/simple;
	bh=3ftqvKqq7q6e7O0TPKo+0TG2tqZME1C8OVxRtTXixMI=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=ugbxZzvxOTEURD/pPkLZPVFL/TwzfQy3w0Px1airgRHAFTxdpM3KRY3JTg90yjMgQOdT94xLb0m1RxOJ1CNq45jUJUSxrcYDp796MTP9Y6WSOChg4f1tfSHtRkVQrjWqBzCQp9W6qR21eUtKQUDwrbN+SFFkfw41ceY6SYpc7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=BBPvHPEj; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BBPvHPEj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=g6rITN11GQ2tLx4IWN346Ob6yiOj9oDme1YNRmSi1nY=; b=BBPvHPEjsPIvgmKL8gaF9dZmz+
	NmwssiCLXfLuk1RU21n4zeYaOotW6hm29qeFQowSW69xFBcHyNqvnXGtF0nLGki1Vy23dhSKbTSNI
	11VstGpZeYiSt3zbUAm8Qik8T4kt6hcJ8t6Of1LnwAz/ukZnr2+gdKKgNyFu4ggcOmPc=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZ1-0000RT-Nf; Wed, 24 Sep 2025 11:37:52 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:30 -0400
Message-Id: <20250924153740.806444-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924153740.806444-1-hugo@hugovil.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 05/15] serial: sc16is7xx: use guards for simple mutex locks
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Guards can help to make the code more readable, so use them wherever they
do so.

In many places, labels and 'ret' locals are eliminated completely.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

---

Based on patch by Jiri Slaby (SUSE) <jirislaby@kernel.org>:
commit("serial: use guards for simple mutex locks")
---
 drivers/tty/serial/sc16is7xx.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 72e4c4f80f7f5..7af09535a1563 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -783,13 +783,11 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
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
 
@@ -829,9 +827,6 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		break;
 	}
 
-out_port_irq:
-	mutex_unlock(&one->lock);
-
 	return rc;
 }
 
@@ -874,9 +869,8 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&one->lock);
+	guard(mutex)(&one->lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&one->lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -943,9 +937,8 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
 
 	if (one->port.state) {
-		mutex_lock(&one->lock);
+		guard(mutex)(&one->lock);
 		sc16is7xx_update_mlines(one);
-		mutex_unlock(&one->lock);
 
 		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
 	}
-- 
2.39.5

