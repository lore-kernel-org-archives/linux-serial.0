From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] serial: sccnxp: Make baudrate table struct static
Date: Mon, 21 Jan 2013 19:38:57 +0400
Message-ID: <1358782737-3386-2-git-send-email-shc_work@mail.ru>
References: <1358782737-3386-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2.mail.ru ([94.100.176.130]:47102 "EHLO smtp2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab3AUPjG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jan 2013 10:39:06 -0500
In-Reply-To: <1358782737-3386-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This struct is used only for driver, so it should be static.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 79d6aeb..f9cad65 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -179,14 +179,12 @@ static int sccnxp_update_best_err(int a, int b, int *besterr)
 	return 1;
 }
 
-struct baud_table {
+static const struct {
 	u8	csr;
 	u8	acr;
 	u8	mr0;
 	int	baud;
-};
-
-const struct baud_table baud_std[] = {
+} baud_std[] = {
 	{ 0,	ACR_BAUD0,	MR0_BAUD_NORMAL,	50, },
 	{ 0,	ACR_BAUD1,	MR0_BAUD_NORMAL,	75, },
 	{ 1,	ACR_BAUD0,	MR0_BAUD_NORMAL,	110, },
-- 
1.7.12.4

