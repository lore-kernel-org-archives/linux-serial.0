From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/3] serial: sccnxp: Make 'default' choice in switch last
Date: Mon, 24 Sep 2012 21:12:02 +0400
Message-ID: <1348506722-17457-3-git-send-email-shc_work@mail.ru>
References: <1348506722-17457-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp24.mail.ru ([94.100.176.177]:36813 "EHLO smtp24.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757244Ab2IXRIW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Sep 2012 13:08:22 -0400
In-Reply-To: <1348506722-17457-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 22e9b8f..d3054dc 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -550,8 +550,8 @@ static void sccnxp_set_termios(struct uart_port *port,
 	case CS7:
 		mr1 = MR1_BITS_7;
 		break;
-	default:
 	case CS8:
+	default:
 		mr1 = MR1_BITS_8;
 		break;
 	}
-- 
1.7.8.6

