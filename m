Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64FC1FA272;
	Thu, 20 Feb 2025 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050187; cv=none; b=A3Py4MikxNi8U62wG28Wt21+9Mbr1/bmoBgJfZShCPAmuhD2/Fke9Fv+c/xd5PqupkYXsTlOXqnhJEh3YZ9COaqSR9+a1VGotQJt805RdCZo4Y357OE42FVOVRViufFnuZKh18wxogUo/PnJwMYA+VkrOQ1xP4V5NKA1Zfcr4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050187; c=relaxed/simple;
	bh=AR0ChXBcbm1rSLBLYpCqwfLIevhh7gPejHqqQr6M9Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdrgMEoKQdjcDcaxVkcJu6ghvk7KiSyTtAzZOOGNZIs80tiqYZqHk9Krk/nyH98U2JKfRvGh/pBA57N6eIV7K/cY0XEOCKvgMkYfXtY6z3LZVwxwAHMHXyp1HszQNtKm+lJvCRjmumtFSQEAUR8u2aiEzgbY6pM3UITI8qqiBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAadFfb7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAadFfb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F778C4CEDD;
	Thu, 20 Feb 2025 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050186;
	bh=AR0ChXBcbm1rSLBLYpCqwfLIevhh7gPejHqqQr6M9Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAadFfb7i+4FbrIClURZQiXrHSeAx6cAQKuXpmfs1X+YsPFIgSH6s+sWsdhh84ntg
	 5+8f8HmeTwIKnQ9V7vylNmsKRugbO9bxw1SpBUvI1rSXQ7FU0k+aY7WP78dZbmRfnt
	 OIRH+8A/VFL1NUg2z9tjveS6zj6/CXcNPKm7maZcAcbl5kVd8h2zl8n45aRzhnnTKF
	 I/0fJhEqThJuAnzkNQyFLh+TLa+Ger/iuiTdMVCD6XJ+1ZYEVhHdNzPKnotBvvuncR
	 0JjFz7g4rtzhfKwm+DcFjCGORtEHv4vd8geROXm3kh7PPWFCx3J2G7YNPVOmKqEv43
	 erbbCWU8sRpiw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/29] tty: n_tty: drop n_tty_trace()
Date: Thu, 20 Feb 2025 12:15:45 +0100
Message-ID: <20250220111606.138045-9-jirislaby@kernel.org>
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
2.48.1

