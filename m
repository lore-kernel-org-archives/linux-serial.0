Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FD10A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfFcnbkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65774C433CC;
	Wed,  6 Dec 2023 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848288;
	bh=3eus7b0hNQLg9OdX0asU6mkvYB2JyWIitlAf+oIxR5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AfFcnbkmDiij/dWO7x1l2NreAxAGYK8c7pNds67o8kla1HnMw7WBsFVng3mNKy9fr
	 8TcwF688b3caLdyzVQ1NUcVlMicbFb8Jeyhp7m5jQD2OWWvcPna8bjA/mMj1QH8v7j
	 Ofbd/oT2evbpvLP6xVFS4TrVrKoew3ZuMjUL3Y6XsMRQi+kp1HgyM0Ddj8magOdams
	 ETYTKjlOdvTIjuVzC9WGjN+E58T/m2facWY7CRD/eMzKNJt0vuFspTcyhr+E7lfPJI
	 Eaq2dzWVUZbt+6U7Fk0777+StnzGCSEfihjlqEEGMZ64TiHnOzljPwlZJ9CQYhh/KA
	 v5UqLRHUmgYcw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 25/27] tty: ttyprintk: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:37:10 +0100
Message-ID: <20231206073712.17776-26-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ttyprintk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 5af804c17a75..4c806a189ee5 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -40,7 +40,7 @@ static struct ttyprintk_port tpk_port;
 
 static int tpk_curr;
 
-static char tpk_buffer[TPK_STR_SIZE + 4];
+static u8 tpk_buffer[TPK_STR_SIZE + 4];
 
 static void tpk_flush(void)
 {
@@ -51,9 +51,9 @@ static void tpk_flush(void)
 	}
 }
 
-static int tpk_printk(const u8 *buf, int count)
+static int tpk_printk(const u8 *buf, size_t count)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < count; i++) {
 		if (tpk_curr >= TPK_STR_SIZE) {
-- 
2.43.0

