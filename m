Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62731192B94;
	Fri, 15 Nov 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668426; cv=none; b=U9CJNJv62CyDkNfM0JxXzXJ7FEmZ9tmuo65tXi6v5NfrW3ZqOetVPW/XihqACFCL1FQqzXIF+KoKO6DZvAZOmr08BYbI8ibXkVImINDioWJBXVKhhYfYJo1/GxSNwP6IAK4EBc7tnSd5daV8ak0tQ6xMzWPANmzXL1H8o7QGZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668426; c=relaxed/simple;
	bh=uv6Tugb0FyVdARW47Hj8ctsIKq72UmaOcD/cqo6KJmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pL+1YuWKZxRYQHCRmDYl5U/9i8RM+TWPpQiM8oNf4pwqURovzM+6MLYyanFa7M/3cM6HJQdD2AoA6wfv52AIc9i+xqJEddY1D4hSMNyFOETt+4/bhy9OrPXckEXe7VDopt1wqFEgnzkVv8rybskkmKqmRksnlXH1OB6vuPJZipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCB0qj0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCB0qj0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1677C4CECF;
	Fri, 15 Nov 2024 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731668425;
	bh=uv6Tugb0FyVdARW47Hj8ctsIKq72UmaOcD/cqo6KJmE=;
	h=From:To:Cc:Subject:Date:From;
	b=UCB0qj0vU80l/6+YptCo9AJ7kOm9CVNs8xnzAkqLLs6aZlbE1uhsFPUk29AANlNB5
	 xEPPq/AUufVz58M8k7r/yjcUzu8uhmZwaEl/9gd2pOUQfVNal8IylkVCGmv1iCuacf
	 k9nJ9QHMcYTVxTwhxL7GtD3cay+mgX0eYskaGzdqyMf14FeYYUDHFUqOYMGNKzcNF9
	 BBtcQ/T+S+/I4N29yRkakaml+k2aGTtkpSPJ+gbxr9C4+Jy3+oVE0nYpnAC/tNAnFa
	 sWv7Re77pGX7M7Oqshd/4iVjVTbyw71+DtG9+oMNuTMSXJ1K/PfscCGnueUEePTTbF
	 E8tPiv1GHqWFA==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kartik Rajput <kkartik@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: amba-pl011: fix build regression
Date: Fri, 15 Nov 2024 11:59:54 +0100
Message-Id: <20241115110021.744332-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_DMA_ENGINE is disabled, the driver now fails to build:

drivers/tty/serial/amba-pl011.c: In function 'pl011_unthrottle_rx':
drivers/tty/serial/amba-pl011.c:1822:16: error: 'struct uart_amba_port' has no member named 'using_rx_dma'
 1822 |         if (uap->using_rx_dma) {
      |                ^~
drivers/tty/serial/amba-pl011.c:1823:20: error: 'struct uart_amba_port' has no member named 'dmacr'
 1823 |                 uap->dmacr |= UART011_RXDMAE;
      |                    ^~
drivers/tty/serial/amba-pl011.c:1824:32: error: 'struct uart_amba_port' has no member named 'dmacr'
 1824 |                 pl011_write(uap->dmacr, uap, REG_DMACR);
      |                                ^~

Add the missing #ifdef check around these field accesses, matching
what other parts of this driver do.

Fixes: 2bcacc1c87ac ("serial: amba-pl011: Fix RX stall when DMA is used")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411140617.nkjeHhsK-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/amba-pl011.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f0db65bb8b6f..214bfbf03a97 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1819,10 +1819,12 @@ static void pl011_unthrottle_rx(struct uart_port *port)
 
 	pl011_write(uap->im, uap, REG_IMSC);
 
+#ifdef CONFIG_DMA_ENGINE
 	if (uap->using_rx_dma) {
 		uap->dmacr |= UART011_RXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
 	}
+#endif
 
 	uart_port_unlock_irqrestore(&uap->port, flags);
 }
-- 
2.39.5

