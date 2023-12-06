Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106C10A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk3CXAAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D095FC433C8;
	Wed,  6 Dec 2023 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848276;
	bh=nSSljLNGQ9Y7kzHEyEQQ1fA1Oeo2vcVP/kZE9IDY3b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hk3CXAABBif2+4UBFwiraoU/6ilEnlUlJ1NpyRGjMu3AjUqIhRjtyDnpTnRGClPIL
	 mGkK2tCq/Gi9AiM49mtR2h+Gbs/sSpjRUJgONSl95tImyu3undV+YU6prjWlh33wu+
	 LcCnpUXxpct1fvqbQF84yXA2qHYCrvgmHKbsRB5cH0RlACrRDqnOQp9IzXPAWtTITZ
	 SaLvrTgmDd4B1A8lj2OB2ruRE4bc2EsXnBN0O4CZ09oosSjG2zL4F3ktYlDlzLwJ/J
	 OP4r+OftN+Cw+iWGhEcNeR+pc829wKtQa9RMcmx//odpUS1GeuhEDVVRD13McQObJS
	 vVZ7uHjlYVh9g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 18/27] tty: mxser: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:37:03 +0100
Message-ID: <20231206073712.17776-19-jirislaby@kernel.org>
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
---
 drivers/tty/mxser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6ce7f259968f..458bb1280ebf 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -264,7 +264,7 @@ struct mxser_port {
 	u8 rx_low_water;
 	int type;		/* UART type */
 
-	unsigned char x_char;	/* xon/xoff character */
+	u8 x_char;		/* xon/xoff character */
 	u8 IER;			/* Interrupt Enable Register */
 	u8 MCR;			/* Modem control register */
 	u8 FCR;			/* FIFO control register */
@@ -905,7 +905,7 @@ static ssize_t mxser_write(struct tty_struct *tty, const u8 *buf, size_t count)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
-	int written;
+	size_t written;
 	bool is_empty;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1521,7 +1521,7 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 			if (++ignored > 100)
 				break;
 		} else {
-			char flag = 0;
+			u8 flag = 0;
 			if (status & UART_LSR_BRK_ERROR_BITS) {
 				if (status & UART_LSR_BI) {
 					flag = TTY_BREAK;
@@ -1585,7 +1585,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 
 	count = port->xmit_fifo_size;
 	do {
-		unsigned char c;
+		u8 c;
 
 		if (!kfifo_get(&port->port.xmit_fifo, &c))
 			break;
-- 
2.43.0

