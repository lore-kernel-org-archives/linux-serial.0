Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DF38F8D
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCwBVh4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B60C433C7;
	Tue, 21 Nov 2023 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558588;
	bh=+1z5LOwL5/wByoEwmaM4FneMWMS5WLPxn2QmVIRN2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCwBVh4J1NFGdlP6wl50zfJ4zCDZKWSbOGRsniuiRrOdOSHf+WWf1affyoNnvUWe4
	 QgZg8OnVuY8re+gqb2uisjjqIp2nWJvggiAtLm4BwhxGhrxTgi3DqLnpCo2NOR0+5N
	 LPUvTWUpWZa0dHh1BwIFOnXbI7Dq6RBomNXPsZ01OGqXEBpJepulMZ+Pwzz0J+Kaz9
	 DvErdNkiHwMxoex9xSshXdJTwommXeYo9pTghjyMDNlhUnXviHlXhkPtbc65nd+Zqt
	 /NY5l9Y8M+SylNq3jF4i0RVW6uiQle2nltPBqAil7ksQQt96ltHknhDYXP2Mw5b233
	 X48R7mABHJ4RA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/17] tty: fix tty_operations types in documentation
Date: Tue, 21 Nov 2023 10:22:44 +0100
Message-ID: <20231121092258.9334-4-jirislaby@kernel.org>
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

Commits 95713967ba52 ("tty: make tty_operations::write()'s count
size_t") and dcaafbe6ee3b ("tty: propagate u8 data to
tty_operations::put_char()") changed types of characters to u8, but
omitted to fix the documentation.

Fix the latter now.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/tty_driver.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 18beff0cec1a..f428c1b784a2 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -72,8 +72,7 @@ struct serial_struct;
  *	is closed for the last time freeing up the resources. This is
  *	actually the second part of shutdown for routines that might sleep.
  *
- * @write: ``ssize_t ()(struct tty_struct *tty, const unsigned char *buf,
- *		    size_t count)``
+ * @write: ``ssize_t ()(struct tty_struct *tty, const u8 *buf, size_t count)``
  *
  *	This routine is called by the kernel to write a series (@count) of
  *	characters (@buf) to the @tty device. The characters may come from
@@ -85,7 +84,7 @@ struct serial_struct;
  *
  *	Optional: Required for writable devices. May not sleep.
  *
- * @put_char: ``int ()(struct tty_struct *tty, unsigned char ch)``
+ * @put_char: ``int ()(struct tty_struct *tty, u8 ch)``
  *
  *	This routine is called by the kernel to write a single character @ch to
  *	the @tty device. If the kernel uses this routine, it must call the
-- 
2.42.1

