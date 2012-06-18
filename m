From: Jeff Liu <jeff.liu@oracle.com>
Subject: [PATCH] drivers/tty/tty_io.c: fix a potential memleak at do_tty_write()
Date: Mon, 18 Jun 2012 20:23:54 +0800
Message-ID: <4FDF1DDA.3030704@oracle.com>
Reply-To: jeff.liu@oracle.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:31946 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab2FRMYX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 08:24:23 -0400
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by acsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q5ICOKFl004669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 12:24:21 GMT
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id q5ICOKC6015086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 12:24:20 GMT
Received: from abhmt120.oracle.com (abhmt120.oracle.com [141.146.116.72])
	by acsmt356.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id q5ICOKZZ024826
	for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 07:24:20 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

Looks there is a potential memory leak at drivers/tty/tty_io.c: do_tty_write().
It did allocate a buf_chunk if tty->write_cnt < chunk, however, buf_chunk was not
freed after the writing is done.  Below tiny patch could fix it.

Thanks,
-Jeff


diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index b425c79..f09e73e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1011,6 +1011,7 @@ static inline ssize_t do_tty_write(
 	size_t count)
 {
 	ssize_t ret, written = 0;
+	unsigned char *buf_chunk = NULL;
 	unsigned int chunk;
 
 	ret = tty_write_lock(tty, file->f_flags & O_NDELAY);
@@ -1041,8 +1042,6 @@ static inline ssize_t do_tty_write(
 
 	/* write_buf/write_cnt is protected by the atomic_write_lock mutex */
 	if (tty->write_cnt < chunk) {
-		unsigned char *buf_chunk;
-
 		if (chunk < 1024)
 			chunk = 1024;
 
@@ -1082,6 +1081,9 @@ static inline ssize_t do_tty_write(
 		inode->i_mtime = current_fs_time(inode->i_sb);
 		ret = written;
 	}
+
+	if (buf_chunk)
+		kfree(buf_chunk);
 out:
 	tty_write_unlock(tty);
 	return ret;
