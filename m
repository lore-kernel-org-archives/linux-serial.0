Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDE1F4634;
	Thu, 20 Feb 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050180; cv=none; b=BNuu257nxa3r0gAT6DNA6myTxt2ZJng4jxb9t8IT2pckRF+bFN9eDhQrf75MjLTYdw6SLxItx+VOQCD/uXQusHO0Yvc8XIp0ee16jttOOE1e0PhlOnJv0zPSFNdSp86k+LQGS5eu6HJVnqdgJottBGq4wQe1bgtnhIwE8CCmTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050180; c=relaxed/simple;
	bh=Btl4Wi7mK+kiPs2bUGrutftCJDQt5We7naJQDWbQjIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipSOBEPxH8Aw9MSw2XWcwYMEt1sZQ/V+43HtpUpA72ggWirYr16CU4SuPe6UgvreWdugnzyE2Ywa4YFcdrioUT4OQySBKiCaOmOMIyiwr1FoRqLizE0LvJxZ86A9oiWH9f/OG921gBSDdB+WfcKvlbcSm3FtSGSKK/QNforKKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toRVaWyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toRVaWyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35059C4CEE4;
	Thu, 20 Feb 2025 11:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050180;
	bh=Btl4Wi7mK+kiPs2bUGrutftCJDQt5We7naJQDWbQjIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toRVaWyTR6X40q3FbwQq0DUyhVtsV1Wz3lz8RT9CmJcsmwGbfww4InppAWQfTVdW8
	 ToXu/Q55jo/0wUfQr48a63C/6ZAjVUtVAvfRKjBRB8r3/sf/+pVMOk7/bJBVa6XQG1
	 2Pz+4fdpdTtijIqIf0J2iIGelKqhvvWWW/sBt3wc13uRrH9lcQpJEEhDsFLinpEleq
	 cyFsNH59WSV60LpdowW5N2oilopLsqCHGDqizRjwmeUXXVYtxoVNtJki4AfR/pF9Az
	 fCe6FgkTYiSdoLnCp2D3YoB+zH8kHT7TNvUqBNLUKadAVMokInx+WNZ7HxSMO/CBhh
	 mLmnAy6w/XGrA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/29] tty: move N_TTY_BUF_SIZE to n_tty
Date: Thu, 20 Feb 2025 12:15:41 +0100
Message-ID: <20250220111606.138045-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"N_TTY_BUF_SIZE" is private to n_tty and shall not be exposed to the
world. Definitely not in tty.h somewhere in the middle of "struct
tty_struct".

This is a remnant of moving "read_flags" to "struct n_tty_data" in
commit 3fe780b379fa ("TTY: move ldisc data from tty_struct: bitmaps").
But some cleanup was needed first (in previous patches).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 2 ++
 include/linux/tty.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5e9ca4376d68..2c5995019dd1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -56,6 +56,8 @@
  */
 #define WAKEUP_CHARS 256
 
+#define N_TTY_BUF_SIZE 4096
+
 /*
  * This defines the low- and high-watermarks for throttling and
  * unthrottling the TTY driver.  These watermarks are used for
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 6bb4fb3845f0..0a46e4054dec 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -239,7 +239,6 @@ struct tty_struct {
 
 	struct list_head tty_files;
 
-#define N_TTY_BUF_SIZE 4096
 	struct work_struct SAK_work;
 } __randomize_layout;
 
-- 
2.48.1

