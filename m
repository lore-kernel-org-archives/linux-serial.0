Received: from mx15lb.world4you.com (mx15lb.world4you.com [81.19.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEBC32E14D
	for <linux-serial@vger.kernel.org>; Fri, 17 Oct 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712147; cv=none; b=psprjGo3JlsqwIGb9PZlKp1i1HTBq7/BuaX5oneg16n0s9ywuN05bfGnnkJyNwu014LyMIg1V0saVlF8HfQNXz530Pg9/YVxBFcJYFN39GGQdDxliBbxlfCoR2EQXarXk+yPqC7oRPND+Q5AYxW7yczUYCDhIgiF/FZ8CEwwUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712147; c=relaxed/simple;
	bh=8hWVA7msPwRV8Z4Wwv1Ujc93yK177YSkJ0lbBir+A78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hb4fJ2jmmtEYBoZ7VAAQRsvfIMJpl8p76O/p7TO8MU7hV7+l4GQdktIQgn7ted0XtnAtZYurH7R309Ww9ZDif2K35H/NugtHid5bWzevqdeR3YDcCUU1AJeriWm0eSYgUuAiEKtnsuq+mHioGEMz8faZQRqxMpru4alU4cplpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=i5zcb6DO; arc=none smtp.client-ip=81.19.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="i5zcb6DO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YUyPdeub8VcUJTxYVSI4rSDifr7hGchw7+aD6QRYM8M=; b=i5zcb6DOQbcLQxsjy3FWURFeII
	gXSPZfmDb326/sPFzP7whZVyXtRw8RkfL9Dx9n4oJgfnpCeKOsFHE8LEctygeShikpFfLUfsdfoma
	b1ejtFm/co3j6i0qMJ3cyVDKMbeP2KuR/7K1VvoBmfeHCVupkXzXvsLWwmjhKsf1DMXU=;
Received: from [93.82.65.102] (helo=hornet.engleder.at)
	by mx15lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v9len-000000000dl-3IdL;
	Fri, 17 Oct 2025 16:42:15 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH v2 0/2] serial: add KEBA UART driver
Date: Fri, 17 Oct 2025 16:42:07 +0200
Message-Id: <20251017144209.2662-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

First the serial subsystem is prepared to keep rs485 settings from the
driver if no firmware node exists. This enables drivers to configure a
default rs485 mode, which is set by the serial subsystem.

Second the driver for the KEBA UART is added. This driver supports
multiple rs485 modes and selects RS485 as default mode. This UART is
found in KEBA PLC devices. The auxiliary devices for this driver are
created by the cp500 driver.

v2:
- use BIT() for flag definition (Jiri Slaby)
- use enum for UART mode definition (Jiri Slaby)
- use BIT() for capability flag definition (Jiri Slaby)
- use GENMASK() for capability mask (Jiri Slaby)
- use unsigned int for serial line number (Jiri Slaby)
- use unsigned int for flags (Jiri Slaby)

Gerhard Engleder (2):
  serial: Keep rs485 settings for devices without firmware node
  serial: 8250: add driver for KEBA UART

 drivers/tty/serial/8250/8250_keba.c | 281 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |  13 ++
 drivers/tty/serial/8250/Makefile    |   1 +
 drivers/tty/serial/serial_core.c    |   8 +-
 4 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tty/serial/8250/8250_keba.c

-- 
2.39.5

