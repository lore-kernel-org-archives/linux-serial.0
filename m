Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795F18039
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9lyJr8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622C2C433D9;
	Wed,  6 Dec 2023 07:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848252;
	bh=1JMsbibgL+koo57Qg90X/yljRQK0lCI9j2/54D8BLQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9lyJr8gR2xeB12ZCu6+xxyLMvX+7v9xLxohJzx8unyb4QSgkyZ1v9cWggNjMYQmi
	 MVUoc+TiWLlvN5oonNBGV3GwvFR8PQwdBq0rF17Sx28cA6pNod2GfHsBmNqWANmRsd
	 d+YvHDv128K3cNACr7QtrDJJCBDrkU+LqW0PX/J+XSWIXkfIVvN4ILlB/j/Bzhk3VN
	 CkHL6OI97iBsiNOMR6j3bOivNyBgLZSzz6vzVB5C935C5xjvMdDhwqtn42bJ+m+yDW
	 CPOF4oZPxi2/3cdyhHy+3IXSNn1rhVh1uqskK2oluKbvDFmaSWGV8A9yfTvaZjCjzw
	 /6m6SlV2YS9ag==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/27] tty: ami: use u8 for characters and flag
Date: Wed,  6 Dec 2023 08:36:51 +0100
Message-ID: <20231206073712.17776-7-jirislaby@kernel.org>
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

Switch character types to u8. To conform to characters in the rest of
the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/amiserial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index a30dc054ffbf..7716ce0d35bc 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -81,7 +81,7 @@ struct serial_state {
 	int			quot;
 	int			IER; 	/* Interrupt Enable Register */
 	int			MCR; 	/* Modem control register */
-	int			x_char;	/* xon/xoff character */
+	u8			x_char;	/* xon/xoff character */
 };
 
 static struct tty_driver *serial_driver;
@@ -178,7 +178,7 @@ static void receive_chars(struct serial_state *info)
 {
         int status;
 	int serdatr;
-	unsigned char ch, flag;
+	u8 ch, flag;
 	struct	async_icount *icount;
 	bool overrun = false;
 
-- 
2.43.0

