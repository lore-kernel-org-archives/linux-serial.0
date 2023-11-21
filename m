Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947D38FB1;
	Tue, 21 Nov 2023 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUk3Q4Mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84493C43391;
	Tue, 21 Nov 2023 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558616;
	bh=1JqdGOcikIPraOhThJZ+ThwFEn9EMyadPHMefXFawKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUk3Q4MvpshxkULe4lihbL6fp+6TMQE2/jtMr44SuJZ4LsOSpjitlpSNDxWxryXBy
	 S4leJUUt9h8blyDWxlpADZz2Wa0wuUJ9jQgyrSGrVywVDWmEVOnkpshjg6JGNkjJHm
	 mpS9NIvi0zMTNdFEKoE3pwQDZB0ALDHfKHvkCn+GfJMRcZL5KJCchRW4i/yQxfNU06
	 Y2E2OixT655d+J+FJ2V6EPCdHDqgbA0kE+Uz375JLkTXB1C8nlvuvqpsWdYfrV+NWM
	 fGnS0Mar/blbmEdtbwmgaSi5clQ4DxA6E4GEV/V4WvTOKnfbYsgw4N+U9nY89rJ6Wc
	 euopvwHEcIOJg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 17/17] tty: srmcons: make 'str_cr' const and non-array
Date: Tue, 21 Nov 2023 10:22:58 +0100
Message-ID: <20231121092258.9334-18-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'str_cr' contains a single character: \n. There is no need to declare it
as array. Declare it as a variable, make it const and pass a pointer to
it to callback_puts().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index c6b821afbfd3..a6cff61706b5 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -91,7 +91,7 @@ srmcons_receive_chars(struct timer_list *t)
 static void
 srmcons_do_write(struct tty_port *port, const char *buf, int count)
 {
-	static char str_cr[1] = "\r";
+	static const char str_cr = '\r';
 	size_t c;
 	srmcons_result result;
 
@@ -119,7 +119,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 		}
 
 		while (need_cr) {
-			result.as_long = callback_puts(0, str_cr, 1);
+			result.as_long = callback_puts(0, &str_cr, 1);
 			if (result.bits.c > 0)
 				need_cr = false;
 		}
-- 
2.42.1

