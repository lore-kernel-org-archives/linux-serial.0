Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB23B2A3
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIeSXUZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06674C43391;
	Tue, 21 Nov 2023 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558605;
	bh=422VxiK87dzWUOJytz3EHqN1a+RdqnMf/xYBks1K7os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIeSXUZT5Zd5gFDKfkN2dEKBartK8soImgPbg3Uw3mVQJGUDkMXZjRr1FVhiWsEBf
	 mI01vMF8t9qicENnYiI8BcFj0H5r9gHIPA6fM3DLtQTboflHR77aRN8HXEWwBiduvJ
	 EwhIrWEMWNmKMAy476pHRxEUgq/PNfx3VwHRkuYdplHm7VmlqcCuGr6eJq8i6Mg9v3
	 XAPHv9sA7Gi7FqPgIusC9aKm3YX1piTyGc+IqlITUw3N3u4DGEBlNG15EUpkBsGS4j
	 tP6mb8x8tSnUy84ZCeDHhxXkUFHFS0MV7FPHmCc9fb604bzuiQr998K6BHVcQiipxh
	 cOAWxcm3u32cA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/17] tty: nozomi: remove unused debugging DUMP()
Date: Tue, 21 Nov 2023 10:22:53 +0100
Message-ID: <20231121092258.9334-13-jirislaby@kernel.org>
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

DUMP()'s only use is commented out. Remove the macro completely along
with this unused use.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/nozomi.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 02cd40147b3a..b247341bd12f 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -65,24 +65,8 @@ do {							\
 #define DBG3(args...) DBG_(0x04, ##args)
 #define DBG4(args...) DBG_(0x08, ##args)
 
-/* TODO: rewrite to optimize macros... */
-
 #define TMP_BUF_MAX 256
 
-#define DUMP(buf__, len__)						\
-	do {								\
-		char tbuf[TMP_BUF_MAX] = {0};				\
-		if (len__ > 1) {					\
-			u32 data_len = min_t(u32, len__, TMP_BUF_MAX);	\
-			strscpy(tbuf, buf__, data_len);			\
-			if (tbuf[data_len - 2] == '\r')			\
-				tbuf[data_len - 2] = 'r';		\
-			DBG1("SENDING: '%s' (%d+n)", tbuf, len__);	\
-		} else {						\
-			DBG1("SENDING: '%s' (%d)", tbuf, len__);	\
-		}							\
-	} while (0)
-
 /*    Defines */
 #define NOZOMI_NAME		"nozomi"
 #define NOZOMI_NAME_TTY		"nozomi_tty"
@@ -754,8 +738,6 @@ static int send_data(enum port_type index, struct nozomi *dc)
 		return 0;
 	}
 
-	/* DUMP(buf, size); */
-
 	/* Write length + data */
 	write_mem32(addr, (u32 *) &size, 4);
 	write_mem32(addr + 4, (u32 *) dc->send_buf, size);
-- 
2.42.1

