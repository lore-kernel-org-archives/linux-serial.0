Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C910A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyUKuf4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAA1C433B8;
	Wed,  6 Dec 2023 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848292;
	bh=GjPJ3PxqDVQljTDeHhn532jvz4GA2f5RSxQE7O7jAGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyUKuf4M5QjBoDnrYySejo97ocozDjJbUBMa66sWppD1m2v6sYjDWRgA9GVs23dif
	 dwzlWMRN2KkkyHKV/1jLB2oRs6ZPq7KOihYRzdD5oeQ/tQ5rwKId2/x8UBeiXwuTJC
	 qcGnPN+HRoKvH7rOpCmBrUWeoigKcJMIaqQG+oYVyRP/0iZej5gm8dYCFs9TNG/aG5
	 alDEXeQBBh08q/SkEa6rJBZPB2EV1eaq0lkP+XaQ+G2C7DIAQhbI7YbgnybQSqpqEY
	 b7c1gTsssUH4rnqM8fTQuKx563tI/38/fL5Sdl+ZJDJWruEZ7bllPqeHZq6Ppc44QF
	 8TmMFs4R8CH7g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 27/27] tty: xtensa/iss: use u8
Date: Wed,  6 Dec 2023 08:37:12 +0100
Message-ID: <20231206073712.17776-28-jirislaby@kernel.org>
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

Switch character types to u8. To conform to characters in the rest of
the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 7d1f8b398a46..8896e691c051 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -65,7 +65,7 @@ static void rs_poll(struct timer_list *unused)
 	struct tty_port *port = &serial_port;
 	int i = 0;
 	int rd = 1;
-	unsigned char c;
+	u8 c;
 
 	while (simc_poll(0)) {
 		rd = simc_read(0, &c, 1);
-- 
2.43.0

