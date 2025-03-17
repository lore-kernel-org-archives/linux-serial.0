Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37521C16E;
	Mon, 17 Mar 2025 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194861; cv=none; b=Q40AGFU+gmKvT3ru3i2Ry5TOr2xcuaoAoqBNOwFM8Vd8RTXBtpJfY9v44mBQxbzFDyQYkrPdixzSVZH8u698w0YAAiX8eH3XtcSQ61G0a76Yn8CLmR7xt8D0bBniULUMEa7/wliAZKyLX1nJlGKgxlQZ5xlq3PT647HWDpq8p8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194861; c=relaxed/simple;
	bh=plurQo8sBiuqrUN+GnUsQOZRDBrXhR0tlCQG5LFRAKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzuBARsWUr6AIVkXTLi3gFnGjzzPts0MkRbhHJb6ooH1oFsJjreezQ3mgN7n8OtjwPr903g4ztnB4rSiciMro8yOgZqlwOBbmcyifdxIA2JVIkfO0rJIiS19XujLMTBsynplC4TvN9a8zjbIccu1R5lgnltN6CEG/MBkQPY1YBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRoKbbPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRoKbbPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38704C4CEE3;
	Mon, 17 Mar 2025 07:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194861;
	bh=plurQo8sBiuqrUN+GnUsQOZRDBrXhR0tlCQG5LFRAKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRoKbbPnALW504MG+5RnseH4/paOqI1lY//iK62PklHZzWqqqAxnVtl0+Jsl26D5y
	 cWv7MkfEcIbZ0IrRfOVVaHDsIeDRZH7jWQ//oRciU41/P2azZRhHC1qyt3P9swm0nM
	 RqwOE/MzIopMWBIlLXuvyrjjspvvCOAlsz3pT5j6TgTM+VcbTR/SYUWdsK9PE4Jy90
	 K1Cp9CfeL+Tb2c23uWYthbJijn9HHhRoNaUpe4UqwcvtgLSmVv8rIh4roKxxtFwAKG
	 nFaaSX5K51yahXchwMK7ka+3d6itkslVCvJtqxKzDkY9Jzh02Ya2v8YCvVCsPkTmo2
	 I6QQTVYTmzYRw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 07/31] tty: n_tty: clean up process_output_block()
Date: Mon, 17 Mar 2025 08:00:22 +0100
Message-ID: <20250317070046.24386-8-jirislaby@kernel.org>
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

* Use guard(mutex), which results in:
  - the function can return directly when "space == 0".
  - "i" can now be "unsigned" as it is no longer abused to hold a retval
    from tty->ops->write(). Note the compared-to "nr" is already
    "unsigned".
* The end label is now dubbed "do_write" as that is what happens there.
  Unlike the uncertain "break_out" name.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index df52aae5f71a..5d172edbb03c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -519,17 +519,15 @@ static ssize_t process_output_block(struct tty_struct *tty,
 				    const u8 *buf, unsigned int nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	unsigned int space;
-	int i;
+	unsigned int space, i;
 	const u8 *cp;
 
-	mutex_lock(&ldata->output_lock);
+	guard(mutex)(&ldata->output_lock);
 
 	space = tty_write_room(tty);
-	if (space == 0) {
-		mutex_unlock(&ldata->output_lock);
+	if (space == 0)
 		return 0;
-	}
+
 	if (nr > space)
 		nr = space;
 
@@ -541,18 +539,18 @@ static ssize_t process_output_block(struct tty_struct *tty,
 			if (O_ONLRET(tty))
 				ldata->column = 0;
 			if (O_ONLCR(tty))
-				goto break_out;
+				goto do_write;
 			ldata->canon_column = ldata->column;
 			break;
 		case '\r':
 			if (O_ONOCR(tty) && ldata->column == 0)
-				goto break_out;
+				goto do_write;
 			if (O_OCRNL(tty))
-				goto break_out;
+				goto do_write;
 			ldata->canon_column = ldata->column = 0;
 			break;
 		case '\t':
-			goto break_out;
+			goto do_write;
 		case '\b':
 			if (ldata->column > 0)
 				ldata->column--;
@@ -560,18 +558,15 @@ static ssize_t process_output_block(struct tty_struct *tty,
 		default:
 			if (!iscntrl(c)) {
 				if (O_OLCUC(tty))
-					goto break_out;
+					goto do_write;
 				if (!is_continuation(c, tty))
 					ldata->column++;
 			}
 			break;
 		}
 	}
-break_out:
-	i = tty->ops->write(tty, buf, i);
-
-	mutex_unlock(&ldata->output_lock);
-	return i;
+do_write:
+	return tty->ops->write(tty, buf, i);
 }
 
 static int n_tty_process_echo_ops(struct tty_struct *tty, size_t *tail,
-- 
2.49.0

