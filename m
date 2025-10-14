Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFF30171E
	for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2025 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471787; cv=none; b=U6jI3iGRatGSWw+vVBv4F1hWnjEyK+upKhVJuCo0Z1Dj58XmlvI+61dX3U4y3MUeBJI/dbqf5R7EJGa9wO4ZbcuL3Q8RhkzpMO+yltdidXnCZancn7jXi9v01LDqaPrgpgaJ6Rm9YPYR8D2g8f47my1XLJwW2zsRJPnHjJmZcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471787; c=relaxed/simple;
	bh=MVHFDesUqEZT28ey5aKLtBWReC5jwSrnKqyWjqEAnjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MSTJYpFlHT2AYudjUUIi16pgwU/ZbeJBd+W/e+I/7RvjVom4J8AfVmlZKqHu6iMrvHb2QKMk5il3fEA8w8mrz/Ube5k+ynsBltakFZtLyUcRoq54Ai8TCije3xY8pkqF+TiUeK9rbxtYM1B/TZisBDtfWl52aBhE1X7SxSNoqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=uUMUW2Ne; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="uUMUW2Ne"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f+NmwgbNTZSEs+xSnwius+D7KLarZlBER4f2beKnd4c=; b=uUMUW2NecwqIGHoOruqZ2par0x
	XBPtubPsfISayxRrI1aoxuPmcIWbJ3JN9FyEmSJfJQSH8URGX5l6nIFzgvFKvPIpBfE9NEcRK/ZVs
	j4cnYjALBMIDLVvZwTNtYHsv3F8fwZMtdmM+4ycy+1bLEv2twy/XaLedqL8SVjvsRdFo=;
Received: from [93.82.65.102] (helo=hornet.engleder.at)
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v8kUV-000000008Dg-0xAl;
	Tue, 14 Oct 2025 21:15:23 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH 0/2] serial: add KEBA UART driver
Date: Tue, 14 Oct 2025 21:15:13 +0200
Message-Id: <20251014191515.75888-1-gerhard@engleder-embedded.com>
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
multiple rs485 mode and selects RS485 as default mode. This UART is
found in KEBA PLC devices. The auxiliary devices for this driver are
created by the cp500 driver.

Gerhard Engleder (2):
  serial: Keep rs485 settings for devices without firmware node
  serial: 8250: add driver for KEBA UART

 drivers/tty/serial/8250/8250_keba.c | 279 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |  13 ++
 drivers/tty/serial/8250/Makefile    |   1 +
 drivers/tty/serial/serial_core.c    |   8 +-
 4 files changed, 300 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tty/serial/8250/8250_keba.c

-- 
2.39.5

