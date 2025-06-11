Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B27272E5A;
	Wed, 11 Jun 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636250; cv=none; b=P8sVxIu4K8EyVJk7qOd68pwCHfwOWzZcT0wxVawkwZyCHrZ8psVnVj3FrSUEW4qnjBG43htGXK3APXsSyqMbRWHcJ+cIjUwdgU58gpSoCL1NhRy3XMy2MIf33k1WuEwXnT2sHboQprxZCDkSuA1N5zfB8dupsSb0kdNiq1mJuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636250; c=relaxed/simple;
	bh=5iZ1B5ZkaY5ZLX/qDcX1g+zAgRyPtiYm0Fa29q1Y75c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgxBjiPRcstUgdPBMjkQsWWTT3qeIG8KijbQTK3EqkZnvBBd1s/+KB4vZWWj+D5vfPPBwUJIqjcpUhuVdE+U7k2s5DGZspwMeiyM6+SoVJ/UQk3mcwJqVND9unY2opEDulEdwNait6xIA9RNV4cUGXmttofbpCjV8eKqgxXyDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtVAmJRo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtVAmJRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B278C4CEF2;
	Wed, 11 Jun 2025 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636250;
	bh=5iZ1B5ZkaY5ZLX/qDcX1g+zAgRyPtiYm0Fa29q1Y75c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtVAmJRolfNj5x09ChZgJSMCbHzPtttsgnXsR95rt1SWJIV8U/We3OY8S19l0JjXV
	 yJJrn74vXcmn7tf96eGQdl3AnvMw3U2GoSYE9H0fpBc984cZ6puMFhNqhIksf16OQi
	 BoG7RqRZydtm7T3dWCGs9fz4bPvMPT2B1941Lil7YfiwT0owo0s5KO3O8gF5lUZQvB
	 K4TzhwL5585but1APU8zyoKqZT9R4AcsoGoz1A9AkEno5XMtiv5WrgTGJREPf3c02v
	 c0jGmLXZutbryYcZNliGB2IUHNNOypnJ82lVkwOvolovG0zIdOZ5ys1RsFEywf/+Df
	 xIZsrlBjvyeVQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 26/33] serial: 8250: drop unused frac from serial8250_do_get_divisor()
Date: Wed, 11 Jun 2025 12:03:12 +0200
Message-ID: <20250611100319.186924-27-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'frac' is not used in the generic implementation of get_divisor. Drop it
from there. (Only some port->get_divisor() compute that and receive it
then to port->set_divisor()).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2af89038e50e..6363915a1787 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2481,9 +2481,7 @@ static void serial8250_flush_buffer(struct uart_port *port)
 		serial8250_tx_dma_flush(up);
 }
 
-static unsigned int serial8250_do_get_divisor(struct uart_port *port,
-					      unsigned int baud,
-					      unsigned int *frac)
+static unsigned int serial8250_do_get_divisor(struct uart_port *port, unsigned int baud)
 {
 	upf_t magic_multiplier = port->flags & UPF_MAGIC_MULTIPLIER;
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2544,7 +2542,7 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
 	if (port->get_divisor)
 		return port->get_divisor(port, baud, frac);
 
-	return serial8250_do_get_divisor(port, baud, frac);
+	return serial8250_do_get_divisor(port, baud);
 }
 
 static unsigned char serial8250_compute_lcr(struct uart_8250_port *up, tcflag_t c_cflag)
-- 
2.49.0

