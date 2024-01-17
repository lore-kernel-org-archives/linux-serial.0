Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765A1E87F;
	Wed, 17 Jan 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531159; cv=none; b=UHX+Up9ZHkPNO5qvwD2v48Hn8XW4lesJnqq2ldPqYXt57zy0iGLBv6YzeFXXExHJOWCHHlJMfeecLDS53w2vym8ky6qRXTof45UUdRuRjR3XaION9CVgZcLKQxgcdBU/p7XVJm0U3aeODiPsbxdaQsOMz7bBLZltdMU32hN541E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531159; c=relaxed/simple;
	bh=osbcnZu5DA0h+pun1zmNRcRDKQbP5ZHhVwCWHvGY9JI=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=XN0MCqVdoXc/9jkl34pxQVJvbxNFhBzvQloqEm3gH725mM2nUpguAnMjYXpx7JF6sxQinuYmd3pSQt7PedKHGrtTjGdB2jK2SCGQmfM8Uph7pkV744oWEJueCkiDpxJKTOR+nQ2f+n1rFWP4SAKJUdb8yjgyM0PNv9v9KmKvFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=yaP5tAWL; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="yaP5tAWL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=mv9W9rcFdDnbUlSuNTZsrKNr62wFAUWK1exqxnohL/s=; b=yaP5tAWLQNAMXbWmQGvs1Hm9EF
	XE/PhE2/CeOsxWxCWOmv8JZQ2vfS6weWdNxi0aPn3mfRacmypKPGZLy0LTFpJw3t0f2E3oYdljVHz
	yBzSIZFY7gkVKfwPNHUyhfeN7bOQw4JANbFrChVhbFq97HEEqU5mqhWteTYWdY9KEBPo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEYz-000155-Ka; Wed, 17 Jan 2024 17:39:14 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 17 Jan 2024 17:38:47 -0500
Message-Id: <20240117223856.2303475-10-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 09/18] serial: max310x: simplify probe() and remove() error handling
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify error handling and only call uart_remove_one_port() if line bit
is set, instead of having to manually set s->p[i].port.dev to NULL.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index d6219077d23c..9ef146f09d5b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1395,10 +1395,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
-		if (ret) {
-			s->p[i].port.dev = NULL;
+		if (ret)
 			goto out_uart;
-		}
+
 		set_bit(line, max310x_lines);
 
 		/* Go to suspend mode */
@@ -1433,10 +1432,8 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
-		if (s->p[i].port.dev) {
+		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
 			uart_remove_one_port(&max310x_uart, &s->p[i].port);
-			clear_bit(s->p[i].port.line, max310x_lines);
-		}
 	}
 
 out_clk:
@@ -1454,8 +1451,10 @@ static void max310x_remove(struct device *dev)
 		cancel_work_sync(&s->p[i].tx_work);
 		cancel_work_sync(&s->p[i].md_work);
 		cancel_work_sync(&s->p[i].rs_work);
-		uart_remove_one_port(&max310x_uart, &s->p[i].port);
-		clear_bit(s->p[i].port.line, max310x_lines);
+
+		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
+			uart_remove_one_port(&max310x_uart, &s->p[i].port);
+
 		s->devtype->power(&s->p[i].port, 0);
 	}
 
-- 
2.39.2

