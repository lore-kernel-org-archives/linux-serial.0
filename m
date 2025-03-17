Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006F22A4D3;
	Mon, 17 Mar 2025 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194886; cv=none; b=jDDyBhMbFKk5crS/TKNdijWzQDdaUSZ6I10hGou+1YIXrkSX5HIn2RgkDzf6DvHXVd0wjeLSq6grRNGmIG5k+FkwkcFqgjVEjK8pewm6rP/M5AFTSO+L8LSNOMKOc8ZEe7uNT+OVpst4Xa9A+mqfD1m2fr7+nmjPifbbCiINlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194886; c=relaxed/simple;
	bh=S+XImMzdVUV9r9EFo8L+yAW5p+vSzmK/coEDq0u0j+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAKCv/rhIFbn7ezJyWKEJ638+TvLvczIlS34DHkr83ru/mtU+RwwaOtuUWsD1RQdIPFSoWjntU3AgiYirhXW1L5OleP6GyDQB2T1x0u+yJ/rYAfi+0YQvudfj4QaxEXBxYl1vLPPEfdD7A0E90a+7fH/1IDTpTcO6NVKxRBsueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsPPor6R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsPPor6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359CFC4CEEE;
	Mon, 17 Mar 2025 07:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194886;
	bh=S+XImMzdVUV9r9EFo8L+yAW5p+vSzmK/coEDq0u0j+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsPPor6Rey9Jc3MQ+L5KkubgT27WjCCTSfPtPGQZ7mSAdQUew6s6pq3hgHi3/Xjqt
	 Nx6ner8er3qNkgVduJu220dadEetCULjyXo4TDkxKcHCr0SCUBWq59rF98kri9vSYh
	 C7EhvDmdIEQXVbye04sLXEtxQPOYhsNuQNebrBvSFO7PgzTk1tadOiJhMs5g3BnigM
	 vu/91xVoWk+ZaJHgcUEqWFTKO8h5NnR2hDEgam2EI51FUZ2tdYypHi5QtePcH4xDc5
	 LvUN7PZvTwmjStxTW+NPQ3ly0uZaqw/DUk6lRl4bmZ0OeJPrCRtffR5JoJfNnXqeuT
	 0V7Po9cO7187A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	David Lin <dtwlin@gmail.com>,
	Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 22/31] tty: staging/greybus: pass tty_driver flags to tty_alloc_driver()
Date: Mon, 17 Mar 2025 08:00:37 +0100
Message-ID: <20250317070046.24386-23-jirislaby@kernel.org>
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

tty_alloc_driver() is supposed to receive tty driver flags.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Acked-by: Johan Hovold <johan@kernel.org>
Cc: David Lin <dtwlin@gmail.com>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Cc: linux-staging@lists.linux.dev
---
 drivers/staging/greybus/uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 8eab94cb06fa..308ed1ca9947 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -948,7 +948,8 @@ static int gb_tty_init(void)
 {
 	int retval = 0;
 
-	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, 0);
+	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, TTY_DRIVER_REAL_RAW |
+					 TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(gb_tty_driver)) {
 		pr_err("Can not allocate tty driver\n");
 		retval = -ENOMEM;
@@ -961,7 +962,6 @@ static int gb_tty_init(void)
 	gb_tty_driver->minor_start = 0;
 	gb_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	gb_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	gb_tty_driver->init_termios = tty_std_termios;
 	gb_tty_driver->init_termios.c_cflag = B9600 | CS8 |
 		CREAD | HUPCL | CLOCAL;
-- 
2.49.0

