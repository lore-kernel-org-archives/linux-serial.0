From: Ilya Zykov <linux@izyk.ru>
Subject: Re: n_tty_write() going into schedule but NOT coming out
Date: Wed, 03 Apr 2013 09:44:15 +0400
Message-ID: <515BC1AF.1070103@izyk.ru>
References: <5156DC21.20901@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:59824 "EHLO
	mail.izyk.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762340Ab3DCFoR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Apr 2013 01:44:17 -0400
In-Reply-To: <5156DC21.20901@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

Please, try this patch maybe it can help localize your problem.

 drivers/tty/n_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 05e72be..28f15d0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -230,6 +230,7 @@ static void reset_buffer_flags(struct tty_struct *tty)
 	ldata->canon_head = ldata->canon_data = ldata->erasing = 0;
 	bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 	n_tty_set_room(tty);
+	check_unthrottle(tty);
 }
 
 /**
