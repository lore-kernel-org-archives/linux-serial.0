Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D42C08CC
	for <linux-serial@vger.kernel.org>; Mon, 20 Oct 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987903; cv=none; b=YkuENZdhf+P5nGvxDtaxiqPLZRIWe8L6vcMtKVNTNqC+6GeliFDaLqBmbDcrs6VjqXZicOpQ4hAhOYi8kibj3iUcVaCu2z7TfVuNHxqX+Y4mUluDjnvaO1h+S3u3ndGGPGQ5Z5fCxOjTfptxCjgqb6jhVEf1qrJvV3he4Jms/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987903; c=relaxed/simple;
	bh=bULOnpnU9odajzT/pTskQvD7WnIz/T8c/HBAUhEq77k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdInO6hz1o2+MUNW+Q5/gOgteDhUhOi6mWNNz+k4l3rf7ZkdQfKBlBFwTuD0Z40VjBQ9R84xp8oBNE1ax2u7Ib+7VJYHPaBSvtumNkl4LxRYIqXNGtTlGSvXGb07CasJesL4/+OHD7/TgamPlXAiEl9RDTI9qj0ojeveqv9IUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=uXynDYIu; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="uXynDYIu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1qBeGVtBWioXE0VeFA5W70CeGXqnameAAlmPKJ0VKJg=; b=uXynDYIuX8xrOahQZOXDcU8P2V
	B77KTlFmiWsUt3KzfFCMxqnL/QpMBak/ElvkKmtkp7GeuX0SgNfypl7ZIFpmfyuRm2ewAEY6VuVVt
	fsGgukAJUZwtzB9bSxwm+RQ5/VNUZFgvgMIM5HrvOlcqPiaU+DUza4XW8kqlFl+1aVig=;
Received: from [178.191.104.35] (helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAvDj-000000004Ir-2R9d;
	Mon, 20 Oct 2025 21:07:03 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lukas@wunner.de,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH v3 0/2] serial: add KEBA UART driver
Date: Mon, 20 Oct 2025 21:06:56 +0200
Message-Id: <20251020190658.30655-1-gerhard@engleder-embedded.com>
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

v3:
- add info to commit why device tree / ACPI is not possible (Lukas Wunner)
- separate if and comment for change in uart_get_rs485_mode() (Lukas Wunner)

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
 drivers/tty/serial/serial_core.c    |   8 +
 4 files changed, 303 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_keba.c

-- 
2.39.5

