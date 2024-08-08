Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59618C32B;
	Thu,  8 Aug 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113359; cv=none; b=QVaOeuuhKD4hyVDwWQboz1lFJHymDjdXj8tRORvJgJgZ5dKV/ndwV/wcxuaCCZXgYjba5fpySoVqsJKzF5ukFGdZpLh3M1nbP7PUy3vEdVM9IfajKxBjPW1I/Nnje4rY3lWd0qhrB2u3d1xYpKSccBMVvqBdOQpOocFMwNZztqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113359; c=relaxed/simple;
	bh=snzCKqe+A40N2hgIp+p7f4DkpzeZjbNgpbd31jwyFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5XcCuM5ebldhYm8pVFfsjGX7AEvL1HB7rGpyzX4cnCm/XXA7ek+h9wWBfutycGJADC7NVRRHerOjBKqN2CdNoutrisy/tjWIwZN7EfK8xM9/OtZ1PhkC6shhwObmVGHaMeOIGPiLH0Hz5YN3Knv97dQbk+DpZrfVLS0crqnwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG6MnsmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG6MnsmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F031C4AF0D;
	Thu,  8 Aug 2024 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113359;
	bh=snzCKqe+A40N2hgIp+p7f4DkpzeZjbNgpbd31jwyFAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mG6MnsmAG2rzatOz9brZuHPFBX3y9cKapmapNTGdOD+vkmmiLh5BsZH7tEhAZJIhI
	 5jjYKmnlJEflr+ioskHQ+CYDt6SKdKjAlXiYzSIDB4vUpOYAXnJuY5e5LNCHT3NCr6
	 0+kS6M8/WMsDezl+LQ8JmfUg5AKN9rDsppvk/0AwwnmrPKYbu0ZymSS+54wBe4A8H7
	 0GjKUtOwndkAjzDW9jdVlGmoXEEL3fo8sc0bRlO3YajmHdgZ/ox0XVLzMct1Gj2NtF
	 i1ppb95KmfbpDqUVXa/V26uAYwUz5iotcD7XmYbAExg0wQAvOYHCxBcuAfzQNmkkwT
	 0Odev3/CYVNsw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 03/11] mxser: remove doubled sets of close times
Date: Thu,  8 Aug 2024 12:35:39 +0200
Message-ID: <20240808103549.429349-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808103549.429349-1-jirislaby@kernel.org>
References: <20240808103549.429349-1-jirislaby@kernel.org>
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

