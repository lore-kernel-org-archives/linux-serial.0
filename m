Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D638F8D
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7pHbyN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED9EC433C7;
	Tue, 21 Nov 2023 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558593;
	bh=diBYhCi9kUrJKVnjd9DDPQZOesiKDAPdnCFzVrk5K90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7pHbyN1kipEeAiP5eyb3QNVHhjVJF4v58x162jD4WQLSJpJoJdWhkVXwS/eqZDFm
	 pkeLgM2theJsap7u7hBHAQfjM2gd01rkFbl7/52L6Oip9jzfbdAICc8Y9wC57tXDsa
	 WgFvqB2CP16SRGTu4N1nfqbXjs55+8aV0y1OpyEFbnIr+UfZsz7BBGetIsx3sG7qR6
	 HVuhnSNBr4Nu7+7YzMkQXyOJMzuvywcxoeqn59A8t4tOZSdTO0yNOfDt8Iae2Rgc9h
	 IhgI6fF+4xPjYCNI09CMuoGcpzu1GPynvo8l3MNuzFJQABnKWiRVPPsU1NVQ7EX5Fe
	 e2tnZt1gM47Zg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/17] tty: amiserial: use bool and rename overrun flag in receive_chars()
Date: Tue, 21 Nov 2023 10:22:47 +0100
Message-ID: <20231121092258.9334-7-jirislaby@kernel.org>
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

'oe' is a yes-no flag, switch it to boolean. And rename to overrun. All
for the code to be more obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/amiserial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index b9580bb9afd3..a80f059f77bf 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -180,7 +180,7 @@ static void receive_chars(struct serial_state *info)
 	int serdatr;
 	unsigned char ch, flag;
 	struct	async_icount *icount;
-	int oe = 0;
+	bool overrun = false;
 
 	icount = &info->icount;
 
@@ -251,11 +251,11 @@ static void receive_chars(struct serial_state *info)
 	     * reported immediately, and doesn't
 	     * affect the current character
 	     */
-	     oe = 1;
+	     overrun = true;
 	  }
 	}
 	tty_insert_flip_char(&info->tport, ch, flag);
-	if (oe == 1)
+	if (overrun)
 		tty_insert_flip_char(&info->tport, 0, TTY_OVERRUN);
 	tty_flip_buffer_push(&info->tport);
 }
-- 
2.42.1

