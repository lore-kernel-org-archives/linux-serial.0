Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BAA10A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGBST3C5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531E7C433C9;
	Wed,  6 Dec 2023 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848281;
	bh=kDcj/obqX+Hi8m/kqT3v8vxYxZC41xF3arHR+tQ9eys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGBST3C5fev0tTfqKBcXCSSmiediXRM76ze4uONt5GZWQcCB6hVifuHbmioYvB5Vp
	 8kgZBqCGZsy/SjSIlZXKFIk71KUUxc/LlB0GE70myk0WVBI+hqP/frkIQ0jV0UVsBd
	 P/frzHjXu9fyLVSMIduUQjSW1w/88/yvFa+yVlX+zIc13kCn94HRUXYwl/uf2AoeNT
	 Ij4itpLT3YlHJW1uuCf37jTGQwHZ/vnzeq5/2Suc6ZSdfsEgNSkoa4nsilnsTxsMLH
	 ctiDTTSVV52TL7UJNF5V7364YYJiKfi2XO7T4NWOhQHIBRZqitSYPRxSr7KoaXA1oA
	 GCDJ66oRoxdTA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 21/27] tty: nozomi: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:37:06 +0100
Message-ID: <20231206073712.17776-22-jirislaby@kernel.org>
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
 drivers/tty/nozomi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index b247341bd12f..e28a921c1637 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -783,11 +783,10 @@ static int receive_data(enum port_type index, struct nozomi *dc)
 			tty_insert_flip_char(&port->port, buf[0], TTY_NORMAL);
 			size = 0;
 		} else if (size < RECEIVE_BUF_MAX) {
-			size -= tty_insert_flip_string(&port->port,
-					(char *)buf, size);
+			size -= tty_insert_flip_string(&port->port, buf, size);
 		} else {
-			i = tty_insert_flip_string(&port->port,
-					(char *)buf, RECEIVE_BUF_MAX);
+			i = tty_insert_flip_string(&port->port, buf,
+						   RECEIVE_BUF_MAX);
 			size -= i;
 			offset += i;
 		}
@@ -1584,10 +1583,10 @@ static void ntty_hangup(struct tty_struct *tty)
 static ssize_t ntty_write(struct tty_struct *tty, const u8 *buffer,
 			  size_t count)
 {
-	int rval = -EINVAL;
 	struct nozomi *dc = get_dc_by_tty(tty);
 	struct port *port = tty->driver_data;
 	unsigned long flags;
+	size_t rval;
 
 	if (!dc || !port)
 		return -ENODEV;
-- 
2.43.0

