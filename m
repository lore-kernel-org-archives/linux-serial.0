Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B4347FF7;
	Wed, 19 Nov 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546510; cv=none; b=Y8lDcPG83bGGdLqsYxaX1fJx0u2RpU4/voGAOwwL8giX4a23UmFlhOPdNYaCifT6xYfK/mqAQbrHpzchGCuj8aRyAB+N9nJdLV1xcapvQ4lZ/QdrIG398bmRUmsNL8Xjxtvw8v4g9MuRj3LzLbPxFdwS7XCkQDSFJVA1NQgYcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546510; c=relaxed/simple;
	bh=rmNlTLUmDmktbJUpOcgfcgiLBfJQH5gdGCf28ckt4bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo+ksd98ndvtfORmsy2vThK90PgnH/R5kncHtGame8BbH0QRvsiosJP0dRPK0pEeSRn9Nu8TEPaER349e7/6eI3IYXvo35Nl2Q2+65vk6d+noN4fHKnMahbTYKxmx1PU1KB6BAd/mfZmuSqv4h4cxFxUS7RVFTTieyvXqLntF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjgm6vA0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjgm6vA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C61C4AF0E;
	Wed, 19 Nov 2025 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546510;
	bh=rmNlTLUmDmktbJUpOcgfcgiLBfJQH5gdGCf28ckt4bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mjgm6vA06XYqR54McH7FbPwmU5KlA7vPKweK7C2Ktbtwg/LIBLyG6b29yg/bj1ety
	 BWzQ1YXEx+YzfPcPKfXxyYWEy8YhPweIxkc96zGBEbJvy7zD2EMeOxDCX0Tu5B3jrM
	 KiKmeGZ4UjMZjPbtQKFWSUukpApE/XC/5f/byzdZe8RCn/N8RKHtaQiJEP01/RN67P
	 PqnaqdBW/fRo6aGNYU5nW35KAxF7NCKLtm9uz/zSQUaN4+qrZLtVsWGwW/cKrIM7RO
	 pMAHhwqCXtQkA4qMEpywb30FJHr3J4TSvRJQGgQuuDFqikb1MkSDjqS107MGOvs74k
	 s4YOT4Y9nzJog==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/10] tty: n_hdlc: simplify return from n_hdlc_tty_ioctl()
Date: Wed, 19 Nov 2025 11:01:33 +0100
Message-ID: <20251119100140.830761-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119100140.830761-1-jirislaby@kernel.org>
References: <20251119100140.830761-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cases in the switch() of n_hdlc_tty_ioctl() can return immediately
-- no need to store into error and return later.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_hdlc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 4a4dc58b866a..66bb8ce6ec40 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -584,7 +584,6 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 			    unsigned long arg)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
-	int error = 0;
 	int count;
 	unsigned long flags;
 	struct n_hdlc_buf *buf = NULL;
@@ -603,8 +602,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 		else
 			count = 0;
 		spin_unlock_irqrestore(&n_hdlc->rx_buf_list.spinlock, flags);
-		error = put_user(count, (int __user *)arg);
-		break;
+		return put_user(count, (int __user *)arg);
 
 	case TIOCOUTQ:
 		/* get the pending tx byte count in the driver */
@@ -616,8 +614,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 		if (buf)
 			count += buf->count;
 		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
-		error = put_user(count, (int __user *)arg);
-		break;
+		return put_user(count, (int __user *)arg);
 
 	case TCFLSH:
 		switch (arg) {
@@ -628,11 +625,8 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 		fallthrough;	/* to default */
 
 	default:
-		error = n_tty_ioctl_helper(tty, cmd, arg);
-		break;
+		return n_tty_ioctl_helper(tty, cmd, arg);
 	}
-	return error;
-
 }	/* end of n_hdlc_tty_ioctl() */
 
 /**
-- 
2.51.1

