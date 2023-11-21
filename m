Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B03B29A
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkyjypYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DF2C433C8;
	Tue, 21 Nov 2023 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558587;
	bh=NJRodWQw+P7zL14JGGfRqGN5XnSMc52Tx2CPIuB6IKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkyjypYt3IQbbl2DgXKlWlx+F+UoQfxwd8yzxqY0lHe6HGCuSS2oSFNfqX0nS0vfq
	 k8B39ggdcyrEdbx3PbFrpLi2043eD+f4YrGXcroBXXw/mv86qoPx/L8OYvI32DH2it
	 gTbTxLv/4+uDEvWTAN79xoW+KA0MdM68GsjAnc3iJtNw0CCeoWx9Dt7TSKnSSGIfwh
	 8IMnaus9PxGkEu3vMi9C7V7sMzUpBstBXg0xDPGzfG99gFRM4Hvhtmtd8jpRPIbKao
	 UVYfeEuYQjaF6c5L/907W8wtaig9AKQbP1K7nJF99oQNhH2q1/4QLjyL0q2mF52PWu
	 PQHM2ZbN5Dnfw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/17] tty: remove unneeded mbz from tiocsti()
Date: Tue, 21 Nov 2023 10:22:43 +0100
Message-ID: <20231121092258.9334-3-jirislaby@kernel.org>
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

'mbz' in tiocsti() is used only to pass TTY_NORMAL to
tty_ldisc_ops::receive_buf(). But that can be achieved easier by simply
passing NULL to ::receive_buf().

So drop this 'mbz'.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ee5a90f9adb5..005d91c63707 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2280,7 +2280,7 @@ static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI)
  */
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
-	char ch, mbz = 0;
+	char ch;
 	struct tty_ldisc *ld;
 
 	if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN))
@@ -2296,7 +2296,7 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 		return -EIO;
 	tty_buffer_lock_exclusive(tty->port);
 	if (ld->ops->receive_buf)
-		ld->ops->receive_buf(tty, &ch, &mbz, 1);
+		ld->ops->receive_buf(tty, &ch, NULL, 1);
 	tty_buffer_unlock_exclusive(tty->port);
 	tty_ldisc_deref(ld);
 	return 0;
-- 
2.42.1

