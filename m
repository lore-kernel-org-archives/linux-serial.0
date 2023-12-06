Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B810A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyP9uT8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583B9C433CB;
	Wed,  6 Dec 2023 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848275;
	bh=omxGS8CIFs5M7dlqv12y1t6jFG26IXkN60+x4JAd2q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyP9uT8U/FSUMpRhl+seVa3V0u89PJEz2UC/GoWxJuLZmYd3IyetkvpzjZYP838MQ
	 zl/zeIm0Xdpq3LUfZKSocGVcgFiBB2du6R+vn6bDMITmq8HWV2G+3/vtalpS4+nvJz
	 liMLJ89JXKDw4A4mJxtFdRN48LfOPkLu6Pi5XxWw6AqbgM9oQW3CDPs1reX/hEAgOV
	 Sc/D2/S4fAI4OeXmHGtcXHF7WjOQV4IPWTCw8rF64I7zJuXqkTzg/l+YxuGnuXr53b
	 AoQdeYGFwo7EYQ871WP8HMph/blBA68qHlGIeqWszOzzGEjp+9HTOdrpgybCZA+wI0
	 dxa9bPoNGZpyw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 17/27] tty: moxa: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:37:02 +0100
Message-ID: <20231206073712.17776-18-jirislaby@kernel.org>
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
 drivers/tty/moxa.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index bf3f87ba3a92..ebaada8db929 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -514,7 +514,7 @@ static void MoxaPortLineCtrl(struct moxa_port *, bool, bool);
 static void MoxaPortFlowCtrl(struct moxa_port *, int, int, int, int, int);
 static int MoxaPortLineStatus(struct moxa_port *);
 static void MoxaPortFlushData(struct moxa_port *, int);
-static int MoxaPortWriteData(struct tty_struct *, const unsigned char *, int);
+static ssize_t MoxaPortWriteData(struct tty_struct *, const u8 *, size_t);
 static int MoxaPortReadData(struct moxa_port *);
 static unsigned int MoxaPortTxQueue(struct moxa_port *);
 static int MoxaPortRxQueue(struct moxa_port *);
@@ -1933,10 +1933,10 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *
  *      Function 20:    Write data.
  *      Syntax:
- *      int  MoxaPortWriteData(int port, unsigned char * buffer, int length);
+ *      ssize_t  MoxaPortWriteData(int port, u8 *buffer, size_t length);
  *           int port           : port number (0 - 127)
- *           unsigned char * buffer     : pointer to write data buffer.
- *           int length         : write data length
+ *           u8 *buffer         : pointer to write data buffer.
+ *           size_t length      : write data length
  *
  *           return:    0 - length      : real write data length
  *
@@ -2163,11 +2163,12 @@ static int MoxaPortLineStatus(struct moxa_port *port)
 	return val;
 }
 
-static int MoxaPortWriteData(struct tty_struct *tty, const u8 *buffer, int len)
+static ssize_t MoxaPortWriteData(struct tty_struct *tty, const u8 *buffer,
+				 size_t len)
 {
 	struct moxa_port *port = tty->driver_data;
 	void __iomem *baseAddr, *ofsAddr, *ofs;
-	unsigned int c, total;
+	size_t c, total;
 	u16 head, tail, tx_mask, spage, epage;
 	u16 pageno, pageofs, bufhead;
 
@@ -2224,8 +2225,8 @@ static int MoxaPortWriteData(struct tty_struct *tty, const u8 *buffer, int len)
 static int MoxaPortReadData(struct moxa_port *port)
 {
 	struct tty_struct *tty = port->port.tty;
-	unsigned char *dst;
 	void __iomem *baseAddr, *ofsAddr, *ofs;
+	u8 *dst;
 	unsigned int count, len, total;
 	u16 tail, rx_mask, spage, epage;
 	u16 pageno, pageofs, bufhead, head;
-- 
2.43.0

