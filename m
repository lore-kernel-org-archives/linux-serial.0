Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9DF1E52D;
	Mon, 27 Nov 2023 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS+1TflW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA21C433CA;
	Mon, 27 Nov 2023 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701088638;
	bh=7xwl2go0dypemlRQx0VO0egjtxiAuAu5+0HRC11KHFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NS+1TflWMGnme8u2dnnmKXzu3p5uLGRFpki3eE/ZTF+zo6R980UPkMsFL6QQq9/KF
	 TLK9TlUGuZRV8BlcoITBHrf6fOtkxgl2sSoM2XmI9U4WJ8i2bsMXV5bNa3DF56cUaS
	 h/j/ux80f6jrAq5/VjiMw08iTXFyNsnbWvAWtiwFBdL6uOpgfrnJLfjQIHv8DAe20g
	 RThm7zSjfd0BnD0xnYDBQsXjm9xKlfM9Y1sItz7p+KqXQvY68v/4E+rs12Mm328q/u
	 9xFCVvd1PLXAp8xuqtpPxOow2ZGee81kN1I0BFY2oNf77/BRuEz5Hv4xlnhdgXbbTz
	 0Tunq2OROve3Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 2/5] tty: srmcons: make srmcons_do_write() return void
Date: Mon, 27 Nov 2023 13:37:10 +0100
Message-ID: <20231127123713.14504-2-jirislaby@kernel.org>
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

The return value of srmcons_do_write() is ignored as all characters are
pushed. So make srmcons_do_write() to return void.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---

Notes:
    [v2] reordered so that it makes sense

 arch/alpha/kernel/srmcons.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index b68c5af083cd..de896fa9829e 100644
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

