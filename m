Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305D3B2A3;
	Tue, 21 Nov 2023 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lkgd3ALh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AA5C433B6;
	Tue, 21 Nov 2023 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558611;
	bh=PA6BiikxG3uzO12jc1Xme6+JXf2R8R2PKRHIkH33CJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lkgd3ALh6dk93dgNjaqw6JHJlFb0jSZb+q4FfSbAPgUgud1HxYBjbcmgKV/CDcpmt
	 cjQzjlXKtWivtcuTnsTYYGZhAZnAXKN7KnexLfCnAIj5KOBH3l6jrSPilvG5OPG7xB
	 g1AaPKRNUhn+kTxDy46JntHNCk/Uy90l+aiDPOKLD66fnPqVmKjxpKr3sJ9wpNru/8
	 P23MaZYg0z+UKBvB9ZRn/CAfdgYvjyhvjJgh/kr1rfyxUicCV92g6ulSC2MeT3cnnu
	 /DEUeBCvb8rdnqdLMoTlnSXDJXWjiL8AqvxhsVaEA2zX512fmMyURtmqCt9KgKT1bS
	 AJaC7XUVnWTKQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 15/17] tty: srmcons: make srmcons_do_write() return void
Date: Tue, 21 Nov 2023 10:22:56 +0100
Message-ID: <20231121092258.9334-16-jirislaby@kernel.org>
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

The return value of srmcons_do_write() is ignored as all characters are
pushed. So make srmcons_do_write() to return void.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 8025e2a882ed..32bc098de7da 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -88,7 +88,7 @@ srmcons_receive_chars(struct timer_list *t)
 }
 
 /* called with callback_lock held */
-static int
+static void
 srmcons_do_write(struct tty_port *port, const char *buf, int count)
 {
 	static char str_cr[1] = "\r";
@@ -125,7 +125,6 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 				need_cr = 0;
 		}
 	}
-	return count;
 }
 
 static ssize_t
-- 
2.42.1

