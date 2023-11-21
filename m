Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1693B2B3
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiCF7hYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB03C433CA;
	Tue, 21 Nov 2023 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558585;
	bh=mTUBCg9Yy/6tTejWqtj99Kn79h3uid57bb+Gyj0JwX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiCF7hYQDFJ7iZfFuIc0whqlPUrb5gJbYUxDcESqiskN1TNAL55wg+KmOhTb8VpUk
	 /9zSCYWOyK7dKNuVCYzbuMKlBIpesIQ1wqDe0Ac5LaRPZZUNbP8ATRclwuvKseiO3h
	 sr9wY7zH3J6s62Tng2++B0rSi8xfhhWQxw+IlCMxsng8k5fl9HEmc6mtCMODBipFUe
	 d8uzTK8zPrYYH0nKfhzMQrMbMbBq58MxL0MhrbWEjvSxuVsJVFZgyoAgNlGeLPIdWO
	 j/4tCayQOZttxL3FwOoKxfCGfZ456y4zkP0C77Sh+u4w3WFmJ0TdJdQZO7yp/0dyd4
	 b7ZbqzonWr9jA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jan Kara <jack@suse.com>
Subject: [PATCH 01/17] tty: deprecate tty_write_message()
Date: Tue, 21 Nov 2023 10:22:42 +0100
Message-ID: <20231121092258.9334-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_write_message() has only one user: quotas. In particular, there the
use depends on CONFIG_PRINT_QUOTA_WARNING. And that is deprecated and
marked as BROKEN already too.

So make tty_write_message() dependent on that very config option. This
action in fact drops tty_write_message() from the vmlinux binary. Good
riddance.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jan Kara <jack@suse.com>
---
 drivers/tty/tty_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 06414e43e0b5..ee5a90f9adb5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1047,6 +1047,7 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
 	return ret;
 }
 
+#ifdef CONFIG_PRINT_QUOTA_WARNING
 /**
  * tty_write_message - write a message to a certain tty, not just the console.
  * @tty: the destination tty_struct
@@ -1057,6 +1058,8 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
  * needed.
  *
  * We must still hold the BTM and test the CLOSING flag for the moment.
+ *
+ * This function is DEPRECATED, do not use in new code.
  */
 void tty_write_message(struct tty_struct *tty, char *msg)
 {
@@ -1069,6 +1072,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 		tty_write_unlock(tty);
 	}
 }
+#endif
 
 static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_iter *from)
 {
-- 
2.42.1

