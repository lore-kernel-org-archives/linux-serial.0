Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AF221B8F2;
	Mon, 17 Mar 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194863; cv=none; b=mnhAu+lBDYqS4mcJ/uhcVl59lCCsZl1A9C+zeR/i7zouom1za2pEecFMCLxM/sKXTuYlXtxJWNnFVJwCc5QAsY4m6OTzW9Ksucv7iDQnJShvlfIwtW6VyuQBh3JQ570tf2Eo8jepC5rNSkTXVmPp59FcnjpGkp8Y72bc7hH6MS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194863; c=relaxed/simple;
	bh=xo2wzApT4f3g3LzK5ghtUL4J3vTwfxNmaE8vc3xfEFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHdasw9tWxF5ftQlPi+NgdPjoAUbPuAPpOhtQjlWAXpK8QcVZvtwUbJf2B3d+QHB40IBsrJej2t8LHQyVK1z2DJGaBb9mgk7KeKJvoOLzVdUp24+IYkorCeCkmvvaqgxwTe85qXaL0TYUaIPmxaA0ZPDWlBENJDHh0670aTepsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqTl+ami; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqTl+ami"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E91C4CEEE;
	Mon, 17 Mar 2025 07:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194862;
	bh=xo2wzApT4f3g3LzK5ghtUL4J3vTwfxNmaE8vc3xfEFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqTl+amiZOiGgcodN2pDz+OcgY6Ao+U2tHSEonSbjdL0h4H8LKjxj9rzeRLdeNaL9
	 zPj/GPqwaWVnp41HCS4jiMr2t/ql7PQfc0Mu+U1g0PcuXmx7BehoRO8JmyoAzU0nsW
	 d7Be27+uS4vmGNnt3FtqxhSDq0sdVkfxpt80t9/U5EaxfEEPIXcICxA+f2gd2MP+kU
	 c5L4NbYHdBccLGX0gjK3pmUDSZ+vdsNrAlcap59A9XKog0vRaeeqtHQBVmaD/9+GmQ
	 6fiZfs3dynxVJn9b+vKxt/Uiz6Q9Y0V5ahCej54etfFdDMcub4g1tWoXQci9nY68xF
	 4fqsAC47Tu27g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 08/31] tty: n_tty: drop n_tty_trace()
Date: Mon, 17 Mar 2025 08:00:23 +0100
Message-ID: <20250317070046.24386-9-jirislaby@kernel.org>
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

This n_tty_trace() is an always disabled debugging macro. It comes from
commit 32f13521ca68 ("n_tty: Line copy to user buffer in canonical
mode").

Drop it as it is dead for over a decade.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5d172edbb03c..43ba740792d9 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -81,14 +81,6 @@
 #define ECHO_BLOCK		256
 #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
 
-
-#undef N_TTY_TRACE
-#ifdef N_TTY_TRACE
-# define n_tty_trace(f, args...)	trace_printk(f, ##args)
-#else
-# define n_tty_trace(f, args...)	no_printk(f, ##args)
-#endif
-
 struct n_tty_data {
 	/* producer-published */
 	size_t read_head;
@@ -2026,9 +2018,6 @@ static bool canon_copy_from_read_buf(const struct tty_struct *tty, u8 **kbp,
 	tail = MASK(ldata->read_tail);
 	size = min_t(size_t, tail + n, N_TTY_BUF_SIZE);
 
-	n_tty_trace("%s: nr:%zu tail:%zu n:%zu size:%zu\n",
-		    __func__, *nr, tail, n, size);
-
 	eol = find_next_bit(ldata->read_flags, size, tail);
 	more = n - (size - tail);
 	if (eol == N_TTY_BUF_SIZE && more) {
@@ -2046,9 +2035,6 @@ static bool canon_copy_from_read_buf(const struct tty_struct *tty, u8 **kbp,
 	if (!found || read_buf(ldata, eol) != __DISABLED_CHAR)
 		n = c;
 
-	n_tty_trace("%s: eol:%zu found:%d n:%zu c:%zu tail:%zu more:%zu\n",
-		    __func__, eol, found, n, c, tail, more);
-
 	tty_copy(tty, *kbp, tail, n);
 	*kbp += n;
 	*nr -= n;
-- 
2.49.0

