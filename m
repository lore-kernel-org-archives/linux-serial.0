Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397C1FCD06;
	Thu, 20 Feb 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050191; cv=none; b=pBnxc9gCSUQ1lReYsYncOUVCdrIpF2pcNlcRKW2L79pKCXvOSXr09KQ8ERJxXfLxAurKHJi1hUSj3MVQwDuX1C8n+8lR2vRHSXzW7anu+AqnNgrWRClImZL3yWuky6EujnjK5ZE7h+bVl/sib0KZrnt/TP20Ky6je2yjipPtDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050191; c=relaxed/simple;
	bh=eZR2IzG2EDLv4boMcni4nYVHvs/shsHiMBi5yS6eQcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMNaUo2Bloqb0c8HBQpG9kz1HbIKVkxeIDsAiCX7C8BuFY8SOEU2ilRKvepmHBx76XMYcaxGjG042QVWei7XGa/RY8WvYfb0PBOMT+9bOWAqgFb5A5UehFyQUvWpF4R1rYdfe8/nhwIAB3M7+hy06bqmDTkNjKxgiAsyExEzluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3B1U8uD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3B1U8uD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6E1C4CED1;
	Thu, 20 Feb 2025 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050191;
	bh=eZR2IzG2EDLv4boMcni4nYVHvs/shsHiMBi5yS6eQcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3B1U8uDDGHLFJNG/zVu/sfqQOJrVA/t9h1RlntwMVx9EzM+2Rt7MhqUpqYYypfPZ
	 hbg/M0LmAA2fKtaGFnEpVosywX4+PfaH3thdfN3R4ZRn9MJXJ/g8nKK8/wHF0/WPIb
	 RikdIP5hvo199kzKpmIT1EGhIitVHsKdnllsCOWKKed1Q0QbJOHedBYrchLG4KqgDf
	 JFYrQIk2d9fzwrcO5RQAlg8vvZqI9hfg752ry/Yjq6xYSN8ZR75C6E4wGyy34c6xQm
	 iTYVYz3hw3f1X8V7QkfvZsiIs1Y8qJOJpBgSaAK7sj9k4qQxqCQOj0+7rgSXMTgksa
	 tiKer8JtZmClw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/29] tty: n_tty: move more_to_be_read to the end of n_tty_read()
Date: Thu, 20 Feb 2025 12:15:48 +0100
Message-ID: <20250220111606.138045-12-jirislaby@kernel.org>
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

n_tty_read() contains "we need more data" handling deep in that
function. And there is also a label (more_to_be_read) as we handle this
situation from two places.

It makes more sense to have all "return"s accumulated at the end of
functions. And "goto" from multiple places there. Therefore, do this
with the "more_to_be_read" label in n_tty_read().

After this and the previous changes, n_tty_read() is now much more
easier to follow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0e3eb18490f0..6af3f3a0b531 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2281,21 +2281,8 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 				nr--;
 			}
 
-			/*
-			 * Copy data, and if there is more to be had
-			 * and we have nothing more to wait for, then
-			 * let's mark us for retries.
-			 *
-			 * NOTE! We return here with both the termios_sem
-			 * and atomic_read_lock still held, the retries
-			 * will release them when done.
-			 */
-			if (copy_from_read_buf(tty, &kb, &nr) && kb - kbuf >= minimum) {
-more_to_be_read:
-				remove_wait_queue(&tty->read_wait, &wait);
-				*cookie = cookie;
-				return kb - kbuf;
-			}
+			if (copy_from_read_buf(tty, &kb, &nr) && kb - kbuf >= minimum)
+				goto more_to_be_read;
 		}
 
 		n_tty_check_unthrottle(tty);
@@ -2322,6 +2309,18 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 		retval = kb - kbuf;
 
 	return retval;
+more_to_be_read:
+	/*
+	 * There is more to be had and we have nothing more to wait for, so
+	 * let's mark us for retries.
+	 *
+	 * NOTE! We return here with both the termios_sem and atomic_read_lock
+	 * still held, the retries will release them when done.
+	 */
+	remove_wait_queue(&tty->read_wait, &wait);
+	*cookie = cookie;
+
+	return kb - kbuf;
 }
 
 /**
-- 
2.48.1

