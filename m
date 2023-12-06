Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438F10A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN4zps1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA71C433C7;
	Wed,  6 Dec 2023 07:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848268;
	bh=0jDTkca+DoCNT4GBW0SaHvJh6RK6c14dHl2xTDM0lig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bN4zps1VD14WaQ7L+ufCWjTlw7qYPRgdosdPmuF09qDmDabVcxBfBql5PfmRlNf04
	 acw8RjjRDLADlERmXTH33hG0KFUYN3Ud+D83B7WzaSZxzwxaPe7lzxamEwECIL6rWo
	 UGQOfo/WgWHqi8mzdueDhb69q7nMF11EQ4D9eCpTqd7++hRMXwxI+QR02HastM8vdi
	 YUjFzsUkoCGYz1Zua5hORZfqrlsKtduoDb0cAwujsSdND7nm88zNemME1jLsGf4+9a
	 cN7gQtcoC5kafJNT2l0VO+eSoxiAR2eSVFfKzIP0HBqRW+YG73/X1RJx9h3zghZPag
	 GC+G1rowjVVEA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	industrypack-devel@lists.sourceforge.net
Subject: [PATCH 13/27] tty: ipoctal: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:36:58 +0100
Message-ID: <20231206073712.17776-14-jirislaby@kernel.org>
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

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: industrypack-devel@lists.sourceforge.net
---
 drivers/ipack/devices/ipoctal.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index da308be6c487..ba2e9e52d72b 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -158,9 +158,7 @@ static int ipoctal_get_icount(struct tty_struct *tty,
 static void ipoctal_irq_rx(struct ipoctal_channel *channel, u8 sr)
 {
 	struct tty_port *port = &channel->tty_port;
-	unsigned char value;
-	unsigned char flag;
-	u8 isr;
+	u8 isr, value, flag;
 
 	do {
 		value = ioread8(&channel->regs->r.rhr);
@@ -202,8 +200,8 @@ static void ipoctal_irq_rx(struct ipoctal_channel *channel, u8 sr)
 
 static void ipoctal_irq_tx(struct ipoctal_channel *channel)
 {
-	unsigned char value;
 	unsigned int *pointer_write = &channel->pointer_write;
+	u8 value;
 
 	if (channel->nb_bytes == 0)
 		return;
@@ -436,11 +434,11 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 	return res;
 }
 
-static inline int ipoctal_copy_write_buffer(struct ipoctal_channel *channel,
-					    const u8 *buf, int count)
+static inline size_t ipoctal_copy_write_buffer(struct ipoctal_channel *channel,
+					       const u8 *buf, size_t count)
 {
 	unsigned long flags;
-	int i;
+	size_t i;
 	unsigned int *pointer_read = &channel->pointer_read;
 
 	/* Copy the bytes from the user buffer to the internal one */
@@ -462,7 +460,7 @@ static ssize_t ipoctal_write_tty(struct tty_struct *tty, const u8 *buf,
 				 size_t count)
 {
 	struct ipoctal_channel *channel = tty->driver_data;
-	unsigned int char_copied;
+	size_t char_copied;
 
 	char_copied = ipoctal_copy_write_buffer(channel, buf, count);
 
-- 
2.43.0

