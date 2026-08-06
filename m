Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF8E3B3C1D;
	Thu,  6 Aug 2026 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996655; cv=none; b=BVO+frGRG5PBIs766qVq2yvuB4/JYfC+rA0txfOdZa0qJzDPqgFfHXfu/VcgDPx78rBDDlopEa/fYwvCQSNZRJWTeMWzKSkEWMYHHIHnQ2iCXQPTqI2fzlL1ttG5kxJZPmJSTd7sNqA5KndkRlNJ7Mso9zSY+DD6xdd0t+aQfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996655; c=relaxed/simple;
	bh=BBAawUIgmqTjssKl3AyD9QjMcVWC1xw4KaUd40/vViM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxqZHvJJhZ+V2pQag6yJ3RYztSA9OzmJk/Ajsyel+N0y1IeCenpPp1eU7itc5uol1LANXjOgJm2zXqY/A1upOomlYO40tkzFMSeFxwGfk4fD1vMUYNV5m6wkClk7wQya4rHSW9NCBh5vjDbp0sI3ak3IRrtHEFX0BHvmlxvpQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07707395|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.000709742-2.15949e-05-0.999269;FP=12043138144921380423|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=lixiaochun@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.if9m0nn_1785996614;
Received: from dev02(mailfrom:lixiaochun@open-hieco.net fp:SMTPD_---.if9m0nn_1785996614 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 06 Aug 2026 14:10:27 +0800
From: Xiaochun Li <lixiaochun@open-hieco.net>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xiaochun Li <lixiaochun@open-hieco.net>
Subject: [PATCH] serial: core: Fix a NULL pointer dereference in uart_parse_earlycon()
Date: Thu,  6 Aug 2026 14:10:11 +0800
Message-ID: <20260806061011.9007-1-lixiaochun@open-hieco.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

console=uart and console=pl011 can reach the preferred console matching
path without an options field when a comma is absent from the command
line. In that case uart_parse_earlycon() receives a NULL pointer and
immediately passes it to strncmp(), which triggers a NULL pointer
dereference during console matching.

Address this by returning -EINVAL when the options pointer is missing,
ensuring incomplete console arguments are cleanly rejected while
preserving the behavior of all valid earlycon-style command lines.

Fixes: 73abaf87f01b ("serial: earlycon: Refactor parse_options into serial core")
Signed-off-by: Xiaochun Li <lixiaochun@open-hieco.net>
---
 drivers/tty/serial/serial_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a530ad372b43..02e770bf8bf6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2084,7 +2084,8 @@ EXPORT_SYMBOL_GPL(uart_console_write);
 
 /**
  * uart_parse_earlycon - Parse earlycon options
- * @p:	     ptr to 2nd field (ie., just beyond '<name>,')
+ * @p:	     ptr to 2nd field (ie., just beyond '<name>,'); %NULL if
+ *	     no console options were supplied
  * @iotype:  ptr for decoded iotype (out)
  * @addr:    ptr for decoded mapbase/iobase (out)
  * @options: ptr for <options> field; %NULL if not present (out)
@@ -2104,6 +2105,9 @@ EXPORT_SYMBOL_GPL(uart_console_write);
 int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
 			resource_size_t *addr, char **options)
 {
+	if (!p)
+		return -EINVAL;
+
 	if (strncmp(p, "mmio,", 5) == 0) {
 		*iotype = UPIO_MEM;
 		p += 5;
-- 
2.52.0

