Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386480;
	b=AVFv1YksHxvI7eCEGj5Skc3cfr+r1E0xFvQaCOWKxWn/VIAGFnIRAPgEfpK/FPFtVERI
	 5pmoHZCSE/Mf5VVbqV/mj2JCj5zTRz/zqiXn+dBeig/vTMbb7u40VRAx16m1VxOc+HtMS
	 rvZJLbC0+F3t4Dtm/RHzWF7qprIRadY/Y29XQ+Nuak09QM6Nk+SNdg/030JyJdfsn+ZMQ
	 aUsRdiO9JZmMpwlLGMwgwXjdL1rq9XA54+lqV6XnyqPjhm4LQd8Ixw/k2jNO27xN3gnUT
	 rB6MpNjAc/x5qrFTZJ4t/zS2tdWtkSylsaBP/jlQ4NPrVcXHagUMQwXLtn/axeu3knQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386480;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0qoAmh7+BMOPKKZQhlGmWmSp8MOPvdU9NJMZ5QYQsLQ=;
	b=1KqNQibAnUJZ6sLAwOoASGAPl7lDKn+4hagaZo9NZsBb+CxA8chHCplsrJkvTtCaZRVD
	 ssZOmPoid1iHC3y4qfK687LFTBhMe8UvLaajy7RumnKgnaow/rq4iHJ/oip862LxauCIY
	 H2sC+Pl65fBonS9SzmEmB+PGsq850ljHpXCMjAxzCc8eTCVHIpBgVcEY12IwZFJAfOGD/
	 soZcDfCslBktfyEtQueDDxpQ7Cvb1xnz8BREG5tHPfyWNR+G9limdF5a/nNYVApS1T8r0
	 KDwVQLitlXf3KOgTcood/ws8pcDXtTgAFb0UVY6DmToGYvrOoz55WUfyiIvmTFhB+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UcwmE3fG;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2D60A2613;
	Wed, 11 Nov 2026 08:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA2D60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UcwmE3fG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=UcwmE3fGxXV2/Q687TPzUwhvX1v0QpFanANNCILcj8sTLUzz8OdqYb8PZweW0W1E6Qt5slvRfCHjJ
	 2Cu/lFJQZ1uglg5zk75T69NuYaYWVpjl/TW8z+U5euH/DSd62RLjB8qiozlyNFrKYmfZx1XhqZ8kgv
	 0EMOmSOQr4gBcL0s=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af42a2d972-76af9;
	Wed, 11 Nov 2026 16:41:18 +0800 (CST)
X-RM-TRANSID:2ee86af42a2d972-76af9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af42a2c876-d5a05;
	Wed, 11 Nov 2026 16:41:18 +0800 (CST)
X-RM-TRANSID:2ee76af42a2c876-d5a05
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3a7eb6d437d568d1c34d@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tty: n_tty: Protect poll input checks against termios changes
Date: Wed, 11 Nov 2026 16:41:16 +0800
Message-ID: <20261111084116.80897-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

n_tty_poll() calls input_available_p() without holding termios_rwsem.
It can therefore race with n_tty_set_termios() changing the canonical
mode and resetting the buffer indices. In particular, the availability
check can combine one input mode with indices from the other mode.

Take the read side of termios_rwsem for each poll input check, as the
read path already does. Release it before flushing the receive worker,
since that worker also needs termios_rwsem.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/tty/n_tty.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40d0a..115bc4a67e8a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2416,6 +2416,12 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	return (b - buf) ? b - buf : retval;
 }
 
+static bool n_tty_poll_input(struct tty_struct *tty)
+{
+	guard(rwsem_read)(&tty->termios_rwsem);
+	return input_available_p(tty, 1);
+}
+
 /**
  * n_tty_poll		-	poll method for N_TTY
  * @tty: terminal device
@@ -2437,11 +2443,11 @@ static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
 
 	poll_wait(file, &tty->read_wait, wait);
 	poll_wait(file, &tty->write_wait, wait);
-	if (input_available_p(tty, 1))
+	if (n_tty_poll_input(tty)) {
 		mask |= EPOLLIN | EPOLLRDNORM;
-	else {
+	} else {
 		tty_buffer_flush_work(tty->port);
-		if (input_available_p(tty, 1))
+		if (n_tty_poll_input(tty))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
 	if (tty->ctrl.packet && tty->link->ctrl.pktstatus)
-- 
2.51.0



