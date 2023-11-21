Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243738F8D
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYppKh38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFA3C433C9;
	Tue, 21 Nov 2023 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558590;
	bh=131jdbssfnDrqOL8OgWBRRcAPmpb2PV4AyWqcy2u3A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYppKh38XoX0kAAQw2WPG9pAy188CbWJOXxJ1ZtNdOPKvgwfuEy85TF2RZWr72FTU
	 4nRtAMeODipvZbRUv+HFTZWJ3kDlvitbs3xpatF0EcXEUss1NwVP6FfMKw0B64C5g7
	 rgSH7qnfp65Gl4/8DLS7OS0sFfuM7BS1eHOZcW5wq80B1k4dZNoo097XbAxxZHUlO/
	 ED+rg3jkIkuAcOkMR/q1iw3pZ58EIyDe6yC5fhXgvq6Z1euq2M5H440ssSGAp50MwD
	 r45GjpPUmEAfTh13uP57RYKgJv32MhpMd5okdD9oHXewEcnbZ6cbHgrLxBdSVwgoZ2
	 8x8j14L0gGnOw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/17] tty: move locking docs out of Returns for functions in tty.h
Date: Tue, 21 Nov 2023 10:22:45 +0100
Message-ID: <20231121092258.9334-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Both tty_kref_get() and tty_get_baud_rate() note about locking in their
Return kernel-doc clause. Extract this info into a separate "Locking"
paragraph -- the same as we do for other tty functions.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/tty.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 4b6340ac2af2..7625fc98fef3 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -393,8 +393,10 @@ extern const struct class tty_class;
  * tty_kref_get - get a tty reference
  * @tty: tty device
  *
- * Returns: a new reference to a tty object. The caller must hold sufficient
- * locks/counts to ensure that their existing reference cannot go away
+ * Returns: a new reference to a tty object
+ *
+ * Locking: The caller must hold sufficient locks/counts to ensure that their
+ * existing reference cannot go away.
  */
 static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 {
@@ -436,10 +438,10 @@ void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
  * tty_get_baud_rate - get tty bit rates
  * @tty: tty to query
  *
- * Returns: the baud rate as an integer for this terminal. The termios lock
- * must be held by the caller and the terminal bit flags may be updated.
+ * Returns: the baud rate as an integer for this terminal
  *
- * Locking: none
+ * Locking: The termios lock must be held by the caller and the terminal bit
+ * flags may be updated.
  */
 static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 {
-- 
2.42.1

