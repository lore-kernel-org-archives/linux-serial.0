Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FE12B143;
	Thu, 27 Aug 2026 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787795210; cv=none; b=Q8y9ou/LUurstA9mxcsFujyzM34o9gno2r7SbgchAc7yom7tQYKW+d7G1/v9gdDMWhMp8v3ZSDQiyA86/3movqDLd3fsMH/UTx44Io9aoqQHatZTtn1kGnYL0IyRy+LyM9gTzbbUOykXLaYmu+1AisUgPL1GweMiGl1T8ntKS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787795210; c=relaxed/simple;
	bh=6Q9zM4LjJojpFm6GIqV/BmfVLxyyiRZ7U9D80ZR497I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+st86gd+/cD4uw9WBqo2J8KpO31xlXoGfro+/e6mBnygtVfq5gLpPGoX3fDONTq2uP/CAEI8gA/Lyy/OoAX/dMhTTC9DZ2LccLraRFNM3ml+zQJJXSHW3BMmNPzP0+FiosjZLVY/JXzAvMt2YSyDX4WjK8YVyVY4FEJPKO5ExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xl2pn9G0; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xl2pn9G0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1Q
	c/idtSr7BuSqFdXfOifykOQFjgd44HOZpCOEjG5kk=; b=Xl2pn9G0BL0ToiX8XP
	1wESuo+tWDjGcyLVJfO7qXIAFf3gbn66xLNK+uwJY8V9LIAVACpf8E9+CRxVzmOO
	Gtd4hSG3raH0EdnoyUnGjWM/Aq3HoGkQzAZL/NpmtMj17IrnRVGg08EPG7MWMV5h
	6Wc/y9H7Bi2KvD55wsJ0qASs0=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHHpa3lo9qyKQXDw--.51271S2;
	Thu, 27 Aug 2026 09:45:27 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	pjw@kernel.org,
	samuel.holland@sifive.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] serial: sifive: fix off-by-one in console port bounds check
Date: Thu, 27 Aug 2026 09:45:24 +0800
Message-Id: <20260827014524.19375-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHHpa3lo9qyKQXDw--.51271S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gw17GFy7uFy8GrW8CFy3Jwb_yoW8JryfpF
	WqkFs0vr18Ga47Z34j9a15ZFWY9an3tFZ2gFW7X34fZws5tr9Y9r1Sya1qka1xAr4kCrWU
	Xr1DArZxCFnrA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYeHDUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC8xdR-GqPlrfoNwAA3S

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

sifive_serial_console_ports[] is sized SIFIVE_SERIAL_MAX_PORTS (8), so
valid indices are 0..7. The bounds check in sifive_serial_probe() uses
"id > SIFIVE_SERIAL_MAX_PORTS", which lets id == 8 pass and causes an
out-of-bounds write in __ssp_add_console_port() through
sifive_serial_console_ports[ssp->port.line].

Fix the check to use >= instead, matching the check already used in
sifive_serial_console_setup().

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 drivers/tty/serial/sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 110d676..5d76f04 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -999,7 +999,7 @@ static int sifive_serial_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_SERIAL_SIFIVE_CONSOLE
-	if (id > SIFIVE_SERIAL_MAX_PORTS) {
+	if (id >= SIFIVE_SERIAL_MAX_PORTS) {
 		dev_err(&pdev->dev, "too many UARTs (%d)\n", id);
 		return -EINVAL;
 	}
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

