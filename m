Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39538F95
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFn/ZE2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EF8C433CC;
	Tue, 21 Nov 2023 09:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558591;
	bh=Qlx9viffecoULgm507HOr5Qx31VBXtpcn9Bhu0b34Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFn/ZE2n+WBA7LzQvXL2q7Gw+jjgjE6FrzYMD4rVEbwMWYrBxPRttH5nRe3UCpSHd
	 C2lKTTJ9INTa+OueAOy/ivf9zQaB/8xWw+2b+cVZmw9xDKU9D4IvDmiaGi3XM9mkuB
	 /YXvL1iYbUUxCqQFNZAq33TKIWGw161dxWdCt3PCTL5H9CQkyDlMivh1As723X0cN1
	 vDTjQ9VE84Vn5e3/2rV3GTcr+kPqvohyxr+izf7e+kwmu93pqFbkpB3GsdOmcV7BS+
	 mwlXNnndw+09YmvSx2Y1Oj1pU+IJv9PaNpUpeHilEJ+2rg9JTal6QfuquBrr4pjhCI
	 KnZ3/mApPmwgA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/17] tty: amiserial: return from receive_chars() without goto
Date: Tue, 21 Nov 2023 10:22:46 +0100
Message-ID: <20231121092258.9334-6-jirislaby@kernel.org>
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

The 'out' label is just before 'return'. So return immediately and drop
both the label and the return. This makes the code more straightforward.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/amiserial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 785558c65ae8..b9580bb9afd3 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -230,7 +230,7 @@ static void receive_chars(struct serial_state *info)
 	   * should be ignored.
 	   */
 	  if (status & info->ignore_status_mask)
-	    goto out;
+		  return;
 
 	  status &= info->read_status_mask;
 
@@ -258,8 +258,6 @@ static void receive_chars(struct serial_state *info)
 	if (oe == 1)
 		tty_insert_flip_char(&info->tport, 0, TTY_OVERRUN);
 	tty_flip_buffer_push(&info->tport);
-out:
-	return;
 }
 
 static void transmit_chars(struct serial_state *info)
-- 
2.42.1

