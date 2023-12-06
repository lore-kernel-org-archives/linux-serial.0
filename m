Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31910A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3KiKHVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C59C433C9;
	Wed,  6 Dec 2023 07:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848243;
	bh=ZDmoAy6WV6x6U4PKECQB462q+EjbB6bBRjNbii6C7fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3KiKHVniZzYbU8D8vr744J7b2uywgMPYUR+NYQ6DcyhlD3V0fYP1CeaxrUx7VDMO
	 fS4KSaoDurVYT0tzpiK+DFon2qU8eAhP0wJJJpGfaRZ33EkURpLM23eSWl+i8M6JF/
	 a3uFnM1AeZtr1RPKY15XNbbu38HVOhocc8i7MrtK88ecdVVg+LZdDd5SKUC5Ift1vh
	 Ix+RtPFOXck+w782fYIgzP/BYW4ysFeqFSVRnDjcki/zODJJbj+I1V17qElzYC3Dsm
	 etHUSVAkVg/Y98AiK1h9nSgKYNmvvML/4k/bOvTspgTsg0LCsLZVL+eSECn9yFT8qU
	 Pj96PL3xbwoQg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/27] tty: goldfish: use bool for is_write parameter
Date: Wed,  6 Dec 2023 08:36:46 +0100
Message-ID: <20231206073712.17776-2-jirislaby@kernel.org>
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

do_rw_io()'s is_write parameter is boolean, but typed int. Switch to the
former, so that it's obvious. (And the two users too.)

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/goldfish.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index dccf6c6c69c6..7ad7fa66cb27 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -53,7 +53,7 @@ static struct goldfish_tty *goldfish_ttys;
 static void do_rw_io(struct goldfish_tty *qtty,
 		     unsigned long address,
 		     unsigned int count,
-		     int is_write)
+		     bool is_write)
 {
 	unsigned long irq_flags;
 	void __iomem *base = qtty->base;
@@ -76,7 +76,7 @@ static void do_rw_io(struct goldfish_tty *qtty,
 static void goldfish_tty_rw(struct goldfish_tty *qtty,
 			    unsigned long addr,
 			    unsigned int count,
-			    int is_write)
+			    bool is_write)
 {
 	dma_addr_t dma_handle;
 	enum dma_data_direction dma_dir;
@@ -129,7 +129,7 @@ static void goldfish_tty_do_write(int line, const u8 *buf, unsigned int count)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[line];
 
-	goldfish_tty_rw(qtty, (unsigned long)buf, count, 1);
+	goldfish_tty_rw(qtty, (unsigned long)buf, count, true);
 }
 
 static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
@@ -145,7 +145,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 
 	count = tty_prepare_flip_string(&qtty->port, &buf, count);
 
-	goldfish_tty_rw(qtty, (unsigned long)buf, count, 0);
+	goldfish_tty_rw(qtty, (unsigned long)buf, count, false);
 
 	tty_flip_buffer_push(&qtty->port);
 	return IRQ_HANDLED;
-- 
2.43.0

