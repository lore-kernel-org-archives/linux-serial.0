Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075223ABAD
	for <linux-serial@vger.kernel.org>; Mon, 23 Jun 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674419; cv=none; b=HpsTs/nfqVbN3934V6sYaX2cQpKOf266dhQfRdcTRQ2UrxiHXtBipY29U4XvkDEjOb22ZAg5oukwdhwZTPR/I2OM7t/olLdwVYa5aLBmXxj7CoOriqHPOek3+9Z4vPlfGbdAN0+tfAIAwcLe83nxWsfT1TxWAKGdYGFeJsX7j/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674419; c=relaxed/simple;
	bh=onx6T6RBeETvzGvhk86+9IYzDmJS5l1Ek060u5vgorA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bupp6x5HlGteS5aXDxGNFFwjLdNeIyyPUaHnicV8YjQtAdAbKRmALUhMHEGpzYM3d7RY0qfyOchM32ABXS5cwvwU01kq1Hj1ZQYBv+jU5szaNez4nI2keTE0e1AnWof9fHBtNne2ugxp/SvU3WAiRF+lLIpCKE22O5ippNFlWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YQ2DUyWf; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YQ2DUyWf"
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:109b:0:640:c015:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id E9DB26092D;
	Mon, 23 Jun 2025 13:26:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id lQPBDf3LaOs0-BIhIJC6Z;
	Mon, 23 Jun 2025 13:26:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1750674408; bh=HfaWUDJyB755F+sD1a7+5v0KWUKn+y0VImwa2n1SgKQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=YQ2DUyWfxSH+pmAIbz1F01uyAUIohw+r1tCUX8xIOFWQRE0k2hM2BPmgts4dZoNRg
	 Eg7c1APQTiKsudUbT9EaqN1vWndZLB5uaCSElg4CEDYLA171f5VGKV29+3rHoObCMu
	 Tc5mf0oMtuUjOnvdUCzo0l+Lr6tDUDcER7UrPXyg=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>,
	linux-serial@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] tty: fix data races in read buffer management subroutines
Date: Mon, 23 Jun 2025 13:25:44 +0300
Message-ID: <20250623102544.510761-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running anything causes an intense enough tty output, for
example 'find /' on a tty console, KCSAN is likely to report a
few data races around an internal routines which examines and
manages the read buffer:

BUG: KCSAN: data-race in n_tty_read / n_tty_receive_buf_common

write (marked) to 0xffffc90003ae5008 of 8 bytes by task 100 on cpu 1:
 n_tty_receive_buf_common+0x710/0xc30
 n_tty_receive_buf2+0x3d/0x60
 tty_ldisc_receive_buf+0x6b/0x100
 tty_port_default_receive_buf+0x63/0xa0
 flush_to_ldisc+0x169/0x3c0
 process_scheduled_works+0x6fe/0xf40
 worker_thread+0x53b/0x7b0
 kthread+0x4f8/0x590
 ret_from_fork+0x28c/0x450
 ret_from_fork_asm+0x1a/0x30

read to 0xffffc90003ae5008 of 8 bytes by task 5844 on cpu 4:
 n_tty_read+0x6b2/0xe00
 tty_read+0x16f/0x490
 vfs_read+0x595/0x600
 ksys_read+0xe7/0x1b0
 __x64_sys_read+0x4a/0x60
 x64_sys_call+0x2ff1/0x32b0
 do_syscall_64+0xfa/0x3b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: KCSAN: data-race in n_tty_poll / n_tty_receive_buf_common

write (marked) to 0xffffc90003ae5008 of 8 bytes by task 68 on cpu 6:
 n_tty_receive_buf_common+0x710/0xc30
 n_tty_receive_buf2+0x3d/0x60
 tty_ldisc_receive_buf+0x6b/0x100
 tty_port_default_receive_buf+0x63/0xa0
 flush_to_ldisc+0x169/0x3c0
 process_scheduled_works+0x6fe/0xf40
 worker_thread+0x53b/0x7b0
 kthread+0x4f8/0x590
 ret_from_fork+0x28c/0x450
 ret_from_fork_asm+0x1a/0x30

read to 0xffffc90003ae5008 of 8 bytes by task 5844 on cpu 3:
 n_tty_poll+0x2fb/0x480
 tty_poll+0x80/0x100
 do_sys_poll+0x618/0xb30
 __se_sys_ppoll+0x1c3/0x210
 __x64_sys_ppoll+0x71/0x90
 x64_sys_call+0x3079/0x32b0
 do_syscall_64+0xfa/0x3b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: KCSAN: data-race in n_tty_check_unthrottle / n_tty_receive_buf_common

write (marked) to 0xffffc90003ae5008 of 8 bytes by task 68 on cpu 4:
 n_tty_receive_buf_common+0x710/0xc30
 n_tty_receive_buf2+0x3d/0x60
 tty_ldisc_receive_buf+0x6b/0x100
 tty_port_default_receive_buf+0x63/0xa0
 flush_to_ldisc+0x169/0x3c0
 process_scheduled_works+0x6fe/0xf40
 worker_thread+0x53b/0x7b0
 kthread+0x4f8/0x590
 ret_from_fork+0x28c/0x450
 ret_from_fork_asm+0x1a/0x30

read to 0xffffc90003ae5008 of 8 bytes by task 5844 on cpu 5:
 n_tty_check_unthrottle+0x86/0x1d0
 n_tty_read+0xb05/0xe00
 tty_read+0x16f/0x490
 vfs_read+0x595/0x600
 ksys_read+0xe7/0x1b0
 __x64_sys_read+0x4a/0x60
 x64_sys_call+0x2ff1/0x32b0
 do_syscall_64+0xfa/0x3b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fix all of them by using smp_load_acquire() accessing buffer's
head and tail marks in chars_in_buffer() and input_available_p().

Fixes: 70aca71f92ca ("n_tty: Fix unordered accesses to lockless read buffer")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/tty/n_tty.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6af3f3a0b531..9478d2bd637a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -213,9 +213,11 @@ static void n_tty_kick_worker(const struct tty_struct *tty)
 static ssize_t chars_in_buffer(const struct tty_struct *tty)
 {
 	const struct n_tty_data *ldata = tty->disc_data;
-	size_t head = ldata->icanon ? ldata->canon_head : ldata->commit_head;
+	size_t head = ldata->icanon ?
+		      smp_load_acquire(&ldata->canon_head) :
+		      smp_load_acquire(&ldata->commit_head);
 
-	return head - ldata->read_tail;
+	return head - smp_load_acquire(&ldata->read_tail);
 }
 
 /**
@@ -1919,11 +1921,12 @@ static inline int input_available_p(const struct tty_struct *tty, int poll)
 {
 	const struct n_tty_data *ldata = tty->disc_data;
 	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
+	size_t tail = smp_load_acquire(&ldata->read_tail);
 
 	if (ldata->icanon && !L_EXTPROC(tty))
-		return ldata->canon_head != ldata->read_tail;
+		return smp_load_acquire(&ldata->canon_head) != tail;
 	else
-		return ldata->commit_head - ldata->read_tail >= amt;
+		return smp_load_acquire(&ldata->commit_head) - tail >= amt;
 }
 
 /**
-- 
2.49.0

