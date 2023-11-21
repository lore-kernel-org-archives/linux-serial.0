Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E93B2B3;
	Tue, 21 Nov 2023 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz76iEME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B03C433A9;
	Tue, 21 Nov 2023 09:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558609;
	bh=yT8k5oROMwqMcM21ujTXVO6pmxLHQflyqFgQxsTik/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cz76iEMEWa2wZDM8a7P/JAxgC86aIOrdBrehYNup2d1+hTJGyIr97bk405j66mQNf
	 Lc82FOLTgK3QmTisWpcx/FtuOrg+i38nQWH12pXlEveToSPpAZCc6hg2UZSPe6CeCc
	 K+FRLykFfguYlWGgQ+hphLflfXsuYa1MQkckcOufp8t13ITwe+0ePlCH6fBcOkm5xJ
	 2ADFc9i2KtcVu2P740mGhe/XGTV6O3IAKVH3LODupbyNsXL835Vbjo1bcUD+eErE4V
	 p8KnOjwTZdcjrZrgbuV7BZvxKs+1czEcHwsvsQMzFtE1KjNhsAwZy8HsejS4TfeX/N
	 1CXNNHV3YMy3A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 14/17] tty: srmcons: use 'count' directly in srmcons_do_write()
Date: Tue, 21 Nov 2023 10:22:55 +0100
Message-ID: <20231121092258.9334-15-jirislaby@kernel.org>
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

Similarly to 'buf' in the previous patch, there is no need to have a
separate counter ('remaining') in srmcons_do_write(). 'count' can be
used directly which simplifies the code a bit.

Note that the type of the current count ('c') is changed from 'long' to
'size_t' so that:
1) it is prepared for the upcoming change of 'count's type, and
2) is unsigned.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index b68c5af083cd..8025e2a882ed 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -92,24 +92,24 @@ static int
 srmcons_do_write(struct tty_port *port, const char *buf, int count)
 {
 	static char str_cr[1] = "\r";
-	long c, remaining = count;
+	size_t c;
 	srmcons_result result;
 	int need_cr;
 
-	while (remaining > 0) {
+	while (count > 0) {
 		need_cr = 0;
 		/* 
 		 * Break it up into reasonable size chunks to allow a chance
 		 * for input to get in
 		 */
-		for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
+		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
 			if (buf[c] == '\n')
 				need_cr = 1;
 		
 		while (c > 0) {
 			result.as_long = callback_puts(0, buf, c);
 			c -= result.bits.c;
-			remaining -= result.bits.c;
+			count -= result.bits.c;
 			buf += result.bits.c;
 
 			/*
-- 
2.42.1

