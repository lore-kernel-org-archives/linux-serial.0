Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023910A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMB/hg4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE21DC43397;
	Wed,  6 Dec 2023 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848279;
	bh=l5iN5w+Qmzs518Y0sHzrhIhEOFTWt8IKcNzWere7ujs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMB/hg4vc99E3LPXhipYInLEwv756k+4acAyRvlgOyp7K+2MwUqdj5ijXC5Jd2FTk
	 LolnDSwT7/SLuC54yJ1USxMMKpYHWOGU0fQH1cdfeFA3EoHVwsJkfsQeY4QnsQYryN
	 Cj40z6Ejac+7sDp+EV4NiWA/egZ+50VfPkRt3ealLf6ZsuYewnNT1cKIrI8CVZo5PR
	 S6+Cmrvqg+PZ4qVVVGri5UpQ41POlA0ciY6AvR+uL4knwJ8KfKiWsFyjAsaf6dqvM5
	 TiFb244I5413Jk6p0Iz7SyXz78awwr4AKWiQo5EFFSqSx9Cu0oygGrPpz8Du1IGxFK
	 UDXpeVs+OCBcg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 20/27] tty: n_hdlc: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:37:05 +0100
Message-ID: <20231206073712.17776-21-jirislaby@kernel.org>
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

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Note u8 is already both passed in and expected on output.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_hdlc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index a670419efe79..1615f074ab86 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -109,8 +109,8 @@
 
 struct n_hdlc_buf {
 	struct list_head  list_item;
-	int		  count;
-	char		  buf[];
+	size_t		  count;
+	u8		  buf[];
 };
 
 struct n_hdlc_buf_list {
@@ -263,9 +263,9 @@ static int n_hdlc_tty_open(struct tty_struct *tty)
  */
 static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 {
-	register int actual;
 	unsigned long flags;
 	struct n_hdlc_buf *tbuf;
+	ssize_t actual;
 
 check_again:
 
@@ -281,7 +281,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 
 	tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 	while (tbuf) {
-		pr_debug("sending frame %p, count=%d\n", tbuf, tbuf->count);
+		pr_debug("sending frame %p, count=%zu\n", tbuf, tbuf->count);
 
 		/* Send the next block of data to device */
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -521,9 +521,9 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 				const u8 *data, size_t count)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
-	int error = 0;
 	DECLARE_WAITQUEUE(wait, current);
 	struct n_hdlc_buf *tbuf;
+	ssize_t error = 0;
 
 	pr_debug("%s() called count=%zd\n", __func__, count);
 
-- 
2.43.0

