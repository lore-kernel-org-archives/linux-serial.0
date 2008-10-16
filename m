From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 3/9] Blackfin Serial Driver: use barrier instead of cpu_relax for Blackfin SMP like patch
Date: Fri, 17 Oct 2008 01:44:01 +0800
Message-ID: <1224179047-13073-4-git-send-email-cooloney@kernel.org>
References: <1224179047-13073-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:21761 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757891AbYJPRoT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2008 13:44:19 -0400
Received: by ti-out-0910.google.com with SMTP id b6so49515tic.23
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2008 10:44:18 -0700 (PDT)
In-Reply-To: <1224179047-13073-1-git-send-email-cooloney@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Graf Yang <graf.yang@analog.com>, Bryan Wu <cooloney@kernel.org>

From: Graf Yang <graf.yang@analog.com>

We are making a SMP like patch to blackfin, cpu_relax() is replaced by a
data cache flush function which will count it to a per-cpu counter.
If this serial function is called too early, the per-cpu data area have
not been initialized, this call will cause crash.
So we'd like to use barrier() instead of cpu_relax().

Signed-off-by: Graf Yang <graf.yang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/serial/bfin_5xx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 16b891e..aea3a53 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -1107,7 +1107,8 @@ static __init void early_serial_putc(struct uart_port *port, int ch)
 	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
 
 	while ((!(UART_GET_LSR(uart) & THRE)) && --timeout)
-		cpu_relax();
+		barrier();
+
 	UART_PUT_CHAR(uart, ch);
 }
 
-- 
1.5.6

