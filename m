Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4629821B195;
	Mon, 17 Mar 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194857; cv=none; b=lLyMrpNh5heSxY+KuXecfKkCW2EOVLJYll+zYb0HCG6iNGkk1bwqkOVqV01aHOVYuMNL9hEGKXRqZzqJ7P9k74ih2ECHagYg/xene83enFQtBS0bjMaJPwzfLoqNPqEt0zBxwBMrt3rME5xmwu8jzpBHorSrGLGkUYqhBeoGIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194857; c=relaxed/simple;
	bh=ExrbFzyWjpREuCHAXalh4ZjQecemvlF9HftqJVK5gFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpgMok6wqsY/oSH87cT5XHBzqtR40lups/0SES5rooEHGXbT3Df3ciaTld5UTUI2Dw3PGWVrJHRgFw8Kr2DoHTppL5ZyNKUEAUv+qsqK3AtQ7Cr5vWqnzhqGkGcAVHXNUv0p9gdru114FTonvrBEIVA/ZboKKTdSBRSOwZvstW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhqEEzlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhqEEzlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71F0C4CEE3;
	Mon, 17 Mar 2025 07:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194856;
	bh=ExrbFzyWjpREuCHAXalh4ZjQecemvlF9HftqJVK5gFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhqEEzlLWdYzZqLxMXvpceAu8PysyUY8dmQShzWJOiSJOV0uI8oDr/hspLqF5u3Bo
	 NwLuuplOjZlbvUshUeMT+Jcng8MhHdc/fFfwi/RHDjF2ZVXOdT03Pv2RdRIsH+Q7l1
	 Gmh/NlBJ9nO63274U5psivykXDZH3ST4UxjM3DXtvDSkdbiJmEsoL6qMNdQptv+6/x
	 YDdJjTJcc9BRktl9DDNmuSp1n331NCFbcKpYFch8CkXXUcfbNz7yBvnOk0K0BAQpX8
	 ApAsAFlnCI4myabJZs3m2UeuZ1fdK+0u+Ufs6Klm4j3V/AImn9iVrpLZ+9qpEiZFmy
	 cO8gVqNpgOSQQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 04/31] tty: move N_TTY_BUF_SIZE to n_tty
Date: Mon, 17 Mar 2025 08:00:19 +0100
Message-ID: <20250317070046.24386-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
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
2.49.0

