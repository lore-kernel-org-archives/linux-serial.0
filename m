Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379667;
	b=wuShvfxU+wVerPAAmKDfRxaXKSyvpNTSc/FWUaqm/2jArLp7lr35wtsYOdkBgrttkfWc
	 KncSalyUNQpJZVw+AHvnSMg2lrldToEReCLWVKkpaPNmVteFgWjaEQrpr5KZ9AI2qyx5e
	 L3eDRluVY1T0K9Kae4G6+CLZclts5YUUTsxHPGQK1zYIzT73+8ndWYIyYAaHwpRqQFRsS
	 /3gm+J+LS1KlSNpyuzGaI8wtCyIZ2uAS11dEr5rcqbzkvuvVJVdZbfwuE6LhQ6gBc1oL9
	 V+Rnde/wodZUTztUK3BzuTPJAs1IK2b68qGI0ekSPfaQLzeX8aUzc1u9O3mQd4ggpPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379667;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XucTGbVjZgxDO8F+HvPdU57TgwxnzHAOkD33WW5Xf3g=;
	b=Xk48pgWcj2eKx64FuYPKej32OHCKnw+Lv1jNbupXx23+1t1Ycg8P6mI5NF+PJCd5LOsk
	 yL83d+uDZArYRKzzTWSQjdgCJNm58ACZhSMwyfSGueAkVM4+OHgRUHY+ZHpdTlXVHG/fl
	 /sIXCGhrvMXFrKw1Cv1ntMuwvzQH8mRJiK6n7lNToa9B22/DSm+J455xFua6dsIonVPst
	 hqlk1uSIppxI0Hon8E7zY0YCW0Tss2G1A+H/nH2svZWMEMSFVBnQ9YmMFDkHqdl7Wvoj3
	 71z06R6t7A/txRdmuNsgjOqAWr6u8t/8GCKnwgNrLnNsLgdAmC+fbVoilKohvua3nhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=cbDP4ZTi;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC511606B47A;
	Wed, 11 Nov 2026 06:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC511606B47A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=cbDP4ZTi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=cbDP4ZTi76vF0MYTreN48Dyg66gRpwm6JrT68O636XjTkkC7/hd00SDIkE/YWTq+p7Nu8zKslH/Y0
	 +AT2Z2Og/O8MZa3XoO6Sgg+wmgH7NcAD+YzVD0n2VZiPr9klMp3tQRjaAf4C9VpeMEnCOeTgIM7lE3
	 4RnT+6UPe8lWq+IE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af40f900a5-75218;
	Wed, 11 Nov 2026 14:47:45 +0800 (CST)
X-RM-TRANSID:2ee86af40f900a5-75218
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af40f90dd3-d1ea3;
	Wed, 11 Nov 2026 14:47:45 +0800 (CST)
X-RM-TRANSID:2ee46af40f90dd3-d1ea3
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b80089f747a307017a6c@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tty: pty: mark lockless flow control snapshots
Date: Wed, 11 Nov 2026 14:47:44 +0800
Message-ID: <20261111064744.17235-1-zhujun2@cmss.chinamobile.com>
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

The PTY write and write-room callbacks inspect flow.stopped without
flow.lock, while TCXONC updates it under that lock. KCSAN reports the
write-room check racing with __stop_tty().

These callbacks take a snapshot of flow control: the state can change
again before a write, and the flip-buffer operations provide their own
serialization. Use data_race(READ_ONCE()) for both checks to document the
intentional race and ensure each check uses a single load.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/tty/pty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 9a37008c4e91..5c605edb79a0 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -110,7 +110,8 @@ static ssize_t pty_write(struct tty_struct *tty, const u8 *buf, size_t c)
 {
 	struct tty_struct *to = tty->link;
 
-	if (tty->flow.stopped || !c)
+	/* Flow control may change concurrently under tty->flow.lock. */
+	if (data_race(READ_ONCE(tty->flow.stopped)) || !c)
 		return 0;
 
 	return tty_insert_flip_string_and_push_buffer(to->port, buf, c);
@@ -126,7 +127,8 @@ static ssize_t pty_write(struct tty_struct *tty, const u8 *buf, size_t c)
 
 static unsigned int pty_write_room(struct tty_struct *tty)
 {
-	if (tty->flow.stopped)
+	/* This is only a snapshot; flow control may change before a write. */
+	if (data_race(READ_ONCE(tty->flow.stopped)))
 		return 0;
 	return tty_buffer_space_avail(tty->link->port);
 }
-- 
2.51.0


