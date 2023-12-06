Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4810A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiAJ9ZnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716DFC433C8;
	Wed,  6 Dec 2023 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848246;
	bh=Ukprb5PhFT14ziQTaeRyUiVmJt5daqc4bA2YTTuvN/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiAJ9ZnE/0SeG1sPJvu0yDeIk03vlZgnsyPIvBWLB/dZkKeBDmpFrWHdF+UP1kY7m
	 2VNKVqzoYMUWrSQWfaRGJGJZXCI3nQBk8Qn2995h/XH6urPfqfYrIsPwFcIjxclOoO
	 biA0KnckEXwumf6gSpT8yFSfuCKveraUROgSExoeaDxiqmttgut/FemNlEDDKHAmTA
	 LVs8XrPkktWJ4cNxqj9JJFm779q80TgTtFOYWeUzIVETVHhF+RUAhJkntmgd9+W8uC
	 j/ZKtNJESRei9Fe1qkHqyUWBSwf8HQdXSqDtz59fe7I5LOj71emfG2gxWaMOZlxScx
	 UM+QMEBLnk8pg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/27] tty: switch tty_port::xmit_* to u8
Date: Wed,  6 Dec 2023 08:36:48 +0100
Message-ID: <20231206073712.17776-4-jirislaby@kernel.org>
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

Both xmit_buf and xmit_fifo of struct tty_port should be u8. To conform
to characters in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_port.c   | 2 +-
 include/linux/tty_port.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index ef72d2e4b928..14cca33d2269 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -247,7 +247,7 @@ int tty_port_alloc_xmit_buf(struct tty_port *port)
 	/* We may sleep in get_zeroed_page() */
 	mutex_lock(&port->buf_mutex);
 	if (port->xmit_buf == NULL) {
-		port->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+		port->xmit_buf = (u8 *)get_zeroed_page(GFP_KERNEL);
 		if (port->xmit_buf)
 			kfifo_init(&port->xmit_fifo, port->xmit_buf, PAGE_SIZE);
 	}
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 3276311a7f38..1b861f2100b6 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -114,8 +114,8 @@ struct tty_port {
 	unsigned char		console:1;
 	struct mutex		mutex;
 	struct mutex		buf_mutex;
-	unsigned char		*xmit_buf;
-	DECLARE_KFIFO_PTR(xmit_fifo, unsigned char);
+	u8			*xmit_buf;
+	DECLARE_KFIFO_PTR(xmit_fifo, u8);
 	unsigned int		close_delay;
 	unsigned int		closing_wait;
 	int			drain_delay;
-- 
2.43.0

