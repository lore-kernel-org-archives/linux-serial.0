Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09938F92;
	Tue, 21 Nov 2023 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTApM2Yz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4831DC433AD;
	Tue, 21 Nov 2023 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558614;
	bh=jNbLNG352qLl5DsDvu9XIk5DhjEuWNeT8bITasbQfSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTApM2Yz3k5LHdAR4SR/rf/9Gl3mNc2Hvoyj2G8mZC5bTs6jO4B3AkehK6TERw/jE
	 dDjyGKGTipA9BQhnJhEIGUb0+kIsTZIqdO4/YRRp7wqpBIBDT5nWmRyR06iLZtUSKj
	 PDOnO6UOlVtXDmLVy3viFS3QM/97XIKizEL4wNWTLXpSBHU210Fpd8OAWEevVUsKLa
	 xNthtXLGxffbib6PvfmVJ7prxCG1fHdQum+Nr6EtOd8/OGKIQK7sNrbXQFbHPG8xMx
	 jwpECnt8xBCUm7KzirZOLUZKz9cVMN3Nr74msXOp1g5ULl3Ld8u5Vwn+QpaT1wLqc6
	 OHWaHpuGEE9Xg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 16/17] tty: srmcons: switch need_cr to bool
Date: Tue, 21 Nov 2023 10:22:57 +0100
Message-ID: <20231121092258.9334-17-jirislaby@kernel.org>
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

'need_cr' is a flag, so type it properly to be a 'bool'. Move the
declaration into the loop too. That ensures the variable is initialized
properly even if the code was moved somehow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 32bc098de7da..c6b821afbfd3 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -94,17 +94,16 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 	static char str_cr[1] = "\r";
 	size_t c;
 	srmcons_result result;
-	int need_cr;
 
 	while (count > 0) {
-		need_cr = 0;
+		bool need_cr = false;
 		/* 
 		 * Break it up into reasonable size chunks to allow a chance
 		 * for input to get in
 		 */
 		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
 			if (buf[c] == '\n')
-				need_cr = 1;
+				need_cr = true;
 		
 		while (c > 0) {
 			result.as_long = callback_puts(0, buf, c);
@@ -122,7 +121,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 		while (need_cr) {
 			result.as_long = callback_puts(0, str_cr, 1);
 			if (result.bits.c > 0)
-				need_cr = 0;
+				need_cr = false;
 		}
 	}
 }
-- 
2.42.1

