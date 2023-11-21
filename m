Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35D3B2A3;
	Tue, 21 Nov 2023 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCcVQCue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841C4C433AB;
	Tue, 21 Nov 2023 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558607;
	bh=A+gwjfR1YZFEn//O7QquhnOOdPgWP51q1cNT1xEbGz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCcVQCueYuWyDY4P/DEB7ksJqQttXRDIPuOZ7d1S9t+TY1NrMTLU+chfM1S6vlv+p
	 WBd57pcx7EOKaym2OQcNLU7UHsd+qb/aAAsDtIkFG6hIChg838AvK6hstPgL1gFiLN
	 FiXQmY6zoCqEKQPuyPESrYNhXJ6NsQb1ojKzz50bJUjUKJxAXZW0fYqvLaFHkEjCBp
	 LSTeR5/RUtifDRKwQmwM+896CIvlaUn8mg8TS0FPcDdLxOxd+K9Lo7jqqeytBxSkHY
	 qaJn/aoW6NRZPIMKquDInl67DpFnQFfRKdSx15MeAGPSiwYZxY8lvB2AnsUOJ8XAyb
	 +0Nmw/Pstmt6Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 13/17] tty: srmcons: use 'buf' directly in srmcons_do_write()
Date: Tue, 21 Nov 2023 10:22:54 +0100
Message-ID: <20231121092258.9334-14-jirislaby@kernel.org>
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

There is no need to have a separate iterator ('cur') through 'buf' in
srmcons_do_write(). 'buf' can be used directly which simplifies the code
a bit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index d6139dbae4ac..b68c5af083cd 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -94,24 +94,23 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 	static char str_cr[1] = "\r";
 	long c, remaining = count;
 	srmcons_result result;
-	char *cur;
 	int need_cr;
 
-	for (cur = (char *)buf; remaining > 0; ) {
+	while (remaining > 0) {
 		need_cr = 0;
 		/* 
 		 * Break it up into reasonable size chunks to allow a chance
 		 * for input to get in
 		 */
 		for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
-			if (cur[c] == '\n')
+			if (buf[c] == '\n')
 				need_cr = 1;
 		
 		while (c > 0) {
-			result.as_long = callback_puts(0, cur, c);
+			result.as_long = callback_puts(0, buf, c);
 			c -= result.bits.c;
 			remaining -= result.bits.c;
-			cur += result.bits.c;
+			buf += result.bits.c;
 
 			/*
 			 * Check for pending input iff a tty port was provided
-- 
2.42.1

