Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69DC14533F;
	Fri, 26 Apr 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132129; cv=none; b=WWhMHRqQHVS7o/onLywucVsOPEUW8t14tQDKSla1uBlKabwFUz2pJTMuik/ahb1g+B8e51wB4CxL09UDXlsgBfhKze4ZmLXDQxC8JUFfcpCqTc2eUYrqxjV0t8fJ3bmUma9zPdnsDC/Q0+d3l2B2gGfsxQAgBWKtI7r6/MFvsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132129; c=relaxed/simple;
	bh=/SN/zjSnuky3OM1kz6zYORox+mvKrXnMtsKEX2ub648=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dJJnq4s0RUWdDg/5iOgKlLIw8XnCfXPaeG4zN5Mi3DSPsP91PtNp6jcZd+Qz/HflkdAYeTC8AoWSVxFDrykVDJfrQM9WrrxkKhL3eITEmVl2IEX6OuyGF4FXJRhv08atW6hmbNKUHjF8wKKZVHjt8pXC5QP2tNXZEYcXUmKJThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bTqjKFnl; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bTqjKFnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6MWsS
	mdYALQgj2DpgEGwlSeW/uW9ibfcAZbE4CpfAhE=; b=bTqjKFnlbpEgmyGJD3kez
	tEyy0qG8mJmp4HY0TM6auVKvLRAhvE3bp+WTpY4CLNP/NvHvxYjbxDX78/zN+Va8
	Wouq83fnBygu0yRrLYx0dMftaFio5GXshrbyX6CsxB2BT8Zclkr87AK9EwGKj4j8
	n15ny4dZl0VkbN0rNBj1AU=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3f2tGlCtmh+bjBQ--.51640S2;
	Fri, 26 Apr 2024 19:47:19 +0800 (CST)
From: lumingyindetect@126.com
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Date: Fri, 26 Apr 2024 12:47:16 +0100
Message-Id: <20240426114716.1275085-1-lumingyindetect@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f2tGlCtmh+bjBQ--.51640S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw45Zr15XFW8CF45tw43Jrb_yoW8Aw1DpF
	s0kF9IyFyFqFy2gw1UAr4qqr1rAFZ7Xa47CrZrK3sI9FZFyFn3tFn3t34SyF18XrZ5tFy2
	va1jyF45Aa4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bbJ5rUUUUU=
X-CM-SenderInfo: poxpx0hj1l0vphwhu3a6rslhhfrp/1tbiEAfM9mVLbFgvQQABsY

From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>

In the execution logic of the lpss8250_probe() function, the function may directly return via a return statement at either line 347 or line 351.
Unlike lines 357 or 361, where the return statement is used directly without releasing the dynamically allocated memory region pointed to by the variable pdev, causing a memory leak of the variable pdev.
In the lpss8250_probe() function, I added a label named "free_irq_vectors" to release the dynamically allocated memory region pointed to by the variable pdev, and replaced the two return statements mentioned above with goto statements to this label.

Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67

Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index c3cd6cb9ac80..fa9fd4dc86c7 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -344,11 +344,11 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	uart.port.mapbase = pci_resource_start(pdev, 0);
 	uart.port.membase = pcim_iomap(pdev, 0, 0);
 	if (!uart.port.membase)
-		return -ENOMEM;
+		goto free_irq_vectors;
 
 	ret = lpss->board->setup(lpss, &uart.port);
 	if (ret)
-		return ret;
+		goto free_irq_vectors;
 
 	dw8250_setup_port(&uart.port);
 
@@ -367,6 +367,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_exit:
 	lpss->board->exit(lpss);
+free_irq_vectors:
 	pci_free_irq_vectors(pdev);
 	return ret;
 }
-- 
2.25.1

