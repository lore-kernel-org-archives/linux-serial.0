From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 12/12] Avoid null pointer dereference
Date: Sat, 13 Feb 2010 17:10:37 +0100
Message-ID: <20100213161037.22311.92183.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0BMQKj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:10:39 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:10:39 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de



Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index 9b0ede0..33b21b9 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -301,7 +301,8 @@ static struct tty_struct *receive_chars(struct uart_port *port)
 		if (status & port->ignore_status_mask)
 			continue;
 
-		tty_insert_flip_char(tty, ch, flag);
+		if (tty)
+			tty_insert_flip_char(tty, ch, flag);
 	}
 	return tty;
 }

