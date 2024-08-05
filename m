Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B615B96C;
	Mon,  5 Aug 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853264; cv=none; b=ciDLuO7tXsgCERMM7c56BCp6j1kVywLQCDkV5KrFoQwUnF2dB2fJ5ABQRDOp/RYE/OXrAo1RQk6x3AR9MVj1arN4RXSEmsKWOs92opph7t3SD/o57iH5F8hHrhes6FDivnVXkZ2UZ4e3G5zr28HIB4c380CHp8QCKLT6CgXjBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853264; c=relaxed/simple;
	bh=snzCKqe+A40N2hgIp+p7f4DkpzeZjbNgpbd31jwyFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppYmKEEM8i75JHmBcxSZ2HmxHBNKSKpUs+IM+c+U8Dzn9fNmcBWf6mIAQ8VjNgm2sxTRFqVBEv4vzNhALIlHw9RgA0p9SwctPYd2+ekudWdQHy36L9ByIlE3fVQ0MQRkz3W8HYmcs0Z8yiue/n8Gtmk8MGpfLD2gWNAwMVBG6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1v92u9V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1v92u9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4866C4AF0F;
	Mon,  5 Aug 2024 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853263;
	bh=snzCKqe+A40N2hgIp+p7f4DkpzeZjbNgpbd31jwyFAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1v92u9VwlFuC9eFlsUaFWPADJR/odGYP1Od8gvaZuoVNmfS/QJy9jdISQ7wq9lbi
	 /JmMBTBaTqoUM387NAduBK+a3K7HRBaYDgQG5LGu9q8aeqsjXnlW0cdHi8kwRbEv/l
	 P26HRt4FhZl9mtkYN+u/aMHsBlUw/b+80d11MHqgNFADTNDLt4YW7pIxZ+Q2iVx7wh
	 ns0Iv7zu97AARFcrsKyMULH864Abc/N3bOnumOY3i5PRDKfvDQDCUfp8UjzFyE8Eim
	 pxY6G5yS4j5eaJmnR+dW+/HkzGRfBa65R/K4UqCwq3wApSjfn5Qhb7An7U+IqKoI3L
	 7AeXUYS6x0DtA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/13] mxser: remove doubled sets of close times
Date: Mon,  5 Aug 2024 12:20:40 +0200
Message-ID: <20240805102046.307511-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_port::close_delay and ::closing_wait are set in tty_port_init() few
lines above already, no need to reset them (to the same values).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/mxser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 9a9a67b5afa0..6cfef88a18e3 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1770,8 +1770,6 @@ static void mxser_initbrd(struct mxser_board *brd, bool high_baud)
 
 		mxser_process_txrx_fifo(info);
 
-		info->port.close_delay = 5 * HZ / 10;
-		info->port.closing_wait = 30 * HZ;
 		spin_lock_init(&info->slock);
 
 		/* before set INT ISR, disable all int */
-- 
2.46.0

