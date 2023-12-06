Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624E16429
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6IQRDqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B3CC433C9;
	Wed,  6 Dec 2023 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848261;
	bh=18JyKq4qj/ln/rCT3pVsLeqjsPFlBw+nKU0XPRGVwY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6IQRDqkaYUoPif/d7W9DRIcT9jGBoIc5ICU9urWmi2ZRus2ETMngmAZsTHKOW0To
	 rLG45RiEQcK1kwmt6j8cYToPebcY32H8QRWMylgVKvixxlqgv/RjnmOpPPRMpM9Pam
	 clpS7FkXgElpDEbUkhIQnwF1oJ9lr5zwiPDIrWzPzGNOOsES30u4YDSCJVdsLnYy1f
	 NvbtSPIITiYZisvRQV7jG+tbbo9cpITSVwJI0bKLQJZX/G8VH1xB+Am3COfhw0Uc+E
	 PhzQSdXnEErWlY1yMEY5+Scs3I8k6cOkD5p1NIkmv4DN7y44EoylEGfPKc/kUCvl3c
	 QwIsT15zKSayA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/27] tty: ehv_bytechan: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:36:55 +0100
Message-ID: <20231206073712.17776-11-jirislaby@kernel.org>
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
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/ehv_bytechan.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index cc9f4338da60..69508d7a4135 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -49,7 +49,7 @@ struct ehv_bc_data {
 	unsigned int tx_irq;
 
 	spinlock_t lock;	/* lock for transmit buffer */
-	unsigned char buf[BUF_SIZE];	/* transmit circular buffer */
+	u8 buf[BUF_SIZE];	/* transmit circular buffer */
 	unsigned int head;	/* circular buffer head */
 	unsigned int tail;	/* circular buffer tail */
 
@@ -138,9 +138,9 @@ static int find_console_handle(void)
 
 static unsigned int local_ev_byte_channel_send(unsigned int handle,
 					       unsigned int *count,
-					       const char *p)
+					       const u8 *p)
 {
-	char buffer[EV_BYTE_CHANNEL_MAX_BYTES];
+	u8 buffer[EV_BYTE_CHANNEL_MAX_BYTES];
 	unsigned int c = *count;
 
 	/*
@@ -166,7 +166,7 @@ static unsigned int local_ev_byte_channel_send(unsigned int handle,
  * has been sent, or if some error has occurred.
  *
  */
-static void byte_channel_spin_send(const char data)
+static void byte_channel_spin_send(const u8 data)
 {
 	int ret, count;
 
@@ -474,8 +474,7 @@ static ssize_t ehv_bc_tty_write(struct tty_struct *ttys, const u8 *s,
 {
 	struct ehv_bc_data *bc = ttys->driver_data;
 	unsigned long flags;
-	unsigned int len;
-	unsigned int written = 0;
+	size_t len, written = 0;
 
 	while (1) {
 		spin_lock_irqsave(&bc->lock, flags);
-- 
2.43.0

