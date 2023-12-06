Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FD18039
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL6ucZU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5ECC433CC;
	Wed,  6 Dec 2023 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848250;
	bh=u9EjvpmA/k15aGau/VQXmyusQFY9F3J8wdpXN/I2/ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LL6ucZU0/1heQ0wtiiECIS8sQO8rX13FC58jP68PEEYIyH9Oo+WW7zD+2bm05Dr7a
	 wT1doNSNwBPJWffwR2c7zOtdvvJqFxkoYL1ZTMMQyfz3vny07pVMfhNMIKq8tAbHC2
	 46zA5SZ4ohBYWcb8Fq/1r81fSaja2U5e0gH4hEVGBWcqT7Ize8FdQ1gsFxdxYEfZtR
	 2iRsEYfvyWUt7UbfLXJRoLFA8PlFQDQ5CocPyn++fNNw6NDMQHq0ADmDzrNOpgWNov
	 OBKW1BNmgOy8MQU/eDdbfYETb6vg4tVOQTtHIw6+thpQkCeHmF28mbIMvs4VV5UwLg
	 z8ncy9qaCYGCg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/27] tty: core: the rest to u8
Date: Wed,  6 Dec 2023 08:36:50 +0100
Message-ID: <20231206073712.17776-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are still last minor users in the tty core that still reference
characters by the 'char' type. Switch them to u8.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 10 +++++-----
 include/linux/tty.h  |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6a502110da61..f3ca2105b66d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -852,9 +852,9 @@ static ssize_t iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
 {
 	void *cookie = NULL;
 	unsigned long offset = 0;
-	char kernel_buf[64];
 	ssize_t retval = 0;
 	size_t copied, count = iov_iter_count(to);
+	u8 kernel_buf[64];
 
 	do {
 		ssize_t size = min(count, sizeof(kernel_buf));
@@ -995,7 +995,7 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
 
 	/* write_buf/write_cnt is protected by the atomic_write_lock mutex */
 	if (tty->write_cnt < chunk) {
-		unsigned char *buf_chunk;
+		u8 *buf_chunk;
 
 		if (chunk < 1024)
 			chunk = 1024;
@@ -2278,10 +2278,10 @@ static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI)
  *  * Called functions take tty_ldiscs_lock
  *  * current->signal->tty check is safe without locks
  */
-static int tiocsti(struct tty_struct *tty, char __user *p)
+static int tiocsti(struct tty_struct *tty, u8 __user *p)
 {
-	char ch;
 	struct tty_ldisc *ld;
+	u8 ch;
 
 	if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN))
 		return -EIO;
@@ -3142,7 +3142,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
  *
  * Return: the number of characters successfully output.
  */
-int tty_put_char(struct tty_struct *tty, unsigned char ch)
+int tty_put_char(struct tty_struct *tty, u8 ch)
 {
 	if (tty->ops->put_char)
 		return tty->ops->put_char(tty, ch);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index d3bedcc08738..cc08f7e1c122 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -242,7 +242,7 @@ struct tty_struct {
 	void *driver_data;
 	spinlock_t files_lock;
 	int write_cnt;
-	unsigned char *write_buf;
+	u8 *write_buf;
 
 	struct list_head tty_files;
 
@@ -411,7 +411,7 @@ void stop_tty(struct tty_struct *tty);
 void start_tty(struct tty_struct *tty);
 void tty_write_message(struct tty_struct *tty, char *msg);
 int tty_send_xchar(struct tty_struct *tty, u8 ch);
-int tty_put_char(struct tty_struct *tty, unsigned char c);
+int tty_put_char(struct tty_struct *tty, u8 c);
 unsigned int tty_chars_in_buffer(struct tty_struct *tty);
 unsigned int tty_write_room(struct tty_struct *tty);
 void tty_driver_flush_buffer(struct tty_struct *tty);
-- 
2.43.0

