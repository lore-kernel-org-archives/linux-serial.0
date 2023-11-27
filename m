Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AA1EA90;
	Mon, 27 Nov 2023 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfiiKcF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66801C433CA;
	Mon, 27 Nov 2023 12:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701088645;
	bh=YEcN7xVfBtrK+FblMlBykMvweHvzn9kzb4wK1dvK3OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfiiKcF7wg6jSD089smxUC6qcRrqWjYR9e97Uxy/bWCbylV6UdyFen/ls5Q0t33OB
	 VEXTl9ShFBx2CFvV8VoRjmlN3TNC/O/5r1fufng6Bx07DQbqeuGR5u0K+CFWfsgeZD
	 o6jQwXWxWB9bUcpxKGVQyAQ/TdkOJ7PKEQniLAlBZQC1EGDPAQwiALmdcNelwwhM9g
	 c2oRKnN6jFwX7ctFqnqnT45gLXnyoTifbPJaV0gxafnlJnLXXmxMREZFhLQi9H/zAa
	 r03By8tvaykNobPbwXuGiDzHN7rYY4EtVSUtx8tMIlKcv4plPWLbg/FuGLQzOsFLUp
	 5nFj0HnYGqqSg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 5/5] tty: srmcons: remove 'str_cr' and use string directly
Date: Mon, 27 Nov 2023 13:37:13 +0100
Message-ID: <20231127123713.14504-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231127123713.14504-1-jirislaby@kernel.org>
References: <20231127123713.14504-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'str_cr' contains a single character: \r. There is no need to declare it
as array. Instead, pass the character (as a string) to callback_puts()
directly. This ensures the string is in proper .rodata (const) section
and makes the code more obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---

Notes:
    [v2]
      pass "\r" directly to callback_puts() as Richard suggests
      spell correct \r in the commit log as Ilpo noticed

 arch/alpha/kernel/srmcons.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index c6b821afbfd3..42deea53beab 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -91,7 +91,6 @@ srmcons_receive_chars(struct timer_list *t)
 static void
 srmcons_do_write(struct tty_port *port, const char *buf, int count)
 {
-	static char str_cr[1] = "\r";
 	size_t c;
 	srmcons_result result;
 
@@ -119,7 +118,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 		}
 
 		while (need_cr) {
-			result.as_long = callback_puts(0, str_cr, 1);
+			result.as_long = callback_puts(0, "\r", 1);
 			if (result.bits.c > 0)
 				need_cr = false;
 		}
-- 
2.42.1

