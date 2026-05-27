Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAC3E9C20
	for <linux-serial@vger.kernel.org>; Wed, 27 May 2026 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873694; cv=none; b=g6R/r0fCVlalArUtZSek+KL68wVe9KoBHC2PPzPkGjMYglAt/JjWiWb1t7nBiIyGqdOft8EeG6tj9CPshx93fuYvzLCBhs36c14fxMr3vSK/iNa+qcG8r6YZYlRxecFDYWEAhg8uaPoqZKvM4xInhgqdrXWgjSJ/h0Xkic0r/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873694; c=relaxed/simple;
	bh=S+5GI1blprI6x2YklGfEGYsrCFCSjrI/gKpgddM49DY=;
	h=To:Message-Id:Content-Type:Date:From:Cc:Subject:Mime-Version; b=T0+1c+NWqSk2WO2KwLHEJm2w+Gq63XCPZK9pB0PkZO48UcS2HzXCJ3f8NoRNJ4RUYF+phqgAePwlM4ZLZGtN7BHNW0zTFCOsIoIUMA6KjO/VUtyHhckwFviIFNfNZDpTdQ7bHeN6cGuUSQldS6HdztFm/qKLOxwG+H3NCop36o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=VpH5rKFj; arc=none smtp.client-ip=209.127.231.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="VpH5rKFj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1779873673;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=InUK12/NH4edD4/4dGiVUh9j6QptA0Nv0X9+dE9Re14=;
 b=VpH5rKFjcxuABYBKjekDRvIwqk3oeqPJ4q/V5dHZf/MzPPJansa4yG8Q7QGqoCvirxec8y
 z2qB+nY4lgtVCeLaEW/8D2Ft5W1vsmYnJO3lxlWEnEWQIxUdtCUn+3X5E6fuIM/zJDDR/h
 GKVZmoUoRtvS0KGMpcZkJJn1aQshPavL2McHepv9nIUCP8XUUuZcHfS1GSgkvqIrr/4Fh1
 ViZlz1aM/I/txLhL7+VKYoKihqDh2REycHGeLGp4TpQl7/TLp3z3iqJHtHBDQtziOJMSNW
 gf089dQNHNdv7ZckuZT4Q/IOU86tg0ExBCu87rJ8kQioL7adtDKf4DFCxW0X6w==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Xin Zhao" <jackzxcui1989@163.com>, 
	"Andy Shevchenko" <andy.shevchenko@gmail.com>, 
	"Kees Cook" <kees@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, 
	"Bing Fan" <tombinfan@tencent.com>, 
	"Guanbing Huang" <albanhuang@tencent.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Message-Id: <20260527092052.2086342-1-wangzhaolong@fnnas.com>
X-Lms-Return-Path: <lba+26a16b787+9545ca+vger.kernel.org+wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 17:20:51 +0800
Received: from MiniServer ([113.111.184.228]) by smtp.feishu.cn with ESMTPS; Wed, 27 May 2026 17:21:10 +0800
X-Original-From: Wang Zhaolong <wangzhaolong@fnnas.com>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 7bit
Cc: "Wang Zhaolong" <wangzhaolong@fnnas.com>, <stable@vger.kernel.org>
Subject: [PATCH] serial: 8250: serialize shared IRQ startup
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Concurrent startup of two 8250 ports sharing the same IRQ can trigger an
IRQ core warning:

  Unbalanced enable for IRQ 3
  WARNING: CPU: 0 PID: 580 at kernel/irq/manage.c:774 __enable_irq+0x3b/0x60
  Call Trace:
   enable_irq+0x8d/0x120
   serial8250_do_startup+0x80d/0xa80
   uart_port_startup+0x13d/0x440
   uart_port_activate+0x5b/0xb0
   tty_port_open+0xa1/0x120
   uart_open+0x1e/0x30
   tty_open+0x140/0x7a0

The second port can then run the shared-IRQ startup test while the IRQ core
is still enabling the line for the first port.  The local
disable_irq_nosync()/enable_irq() pair is balanced, but the interleaving can
still unbalance the IRQ core disable depth.

That makes the QEMU legacy serial ports enter the shared-IRQ THRE test path:

  serial8250_do_startup()
    if (port->irqflags & IRQF_SHARED)
      disable_irq_nosync(port->irq)
    ...
    if (port->irqflags & IRQF_SHARED)
      enable_irq(port->irq)

One possible interleaving is:

  CPU0, ttyS1                         CPU1, ttyS3

  serial_link_irq_chain()
    hash_add(i)
    i->head = &ttyS1
    request_irq()
                                        serial_link_irq_chain()
                                          find i in irq_lists
                                          list_add(&ttyS3, i->head)
                                        serial8250_do_startup()
                                          disable_irq_nosync(irq)
    irq_startup()
      desc->depth = 0
                                          enable_irq(irq)
                                            WARN: Unbalanced enable for IRQ 3

Keep hash_mutex held in serial_link_irq_chain() until the first request_irq()
has completed.  This prevents another 8250 port sharing the IRQ from joining
the chain and running the THRE test while the IRQ core is still starting the
interrupt.

This was reproduced in QEMU with ttyS1 and ttyS3 sharing IRQ 3.  With this
change, 100000 synchronized open/close iterations on /dev/ttyS1 and /dev/ttyS3
completed without the warning.

Fixes: 64c79dfbc458 ("serial: 8250_pnp: Support configurable reg shift property")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: Codex:gpt-5
Signed-off-by: Wang Zhaolong <wangzhaolong@fnnas.com>
---
 drivers/tty/serial/8250/8250_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb..64eed4dc343f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -132,12 +132,10 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  */
 static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
-
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
 
 	i = kzalloc_obj(*i);
@@ -154,10 +152,12 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 static int serial_link_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 	int ret;
 
+	guard(mutex)(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
 
 	scoped_guard(spinlock_irq, &i->lock) {
@@ -169,10 +169,15 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 
 		INIT_LIST_HEAD(&up->list);
 		i->head = &up->list;
 	}
 
+	/*
+	 * Keep the shared-IRQ chain locked until the first handler is installed.
+	 * Otherwise another UART can join early and run startup IRQ masking while
+	 * the IRQ core is still enabling the line, unbalancing the disable depth.
+	 */
 	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
 	if (ret < 0)
 		serial_do_unlink(i, up);
 
 	return ret;
-- 
2.54.0
