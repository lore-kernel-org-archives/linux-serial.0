Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894C314B6A
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232377; cv=none; b=TCEm6vf37RBW61uaFguCipf2bczSxMH5egV7DiL+RmHlUEm6L9O0ej6K9JCDn7wGe4PtDGIoXTSK5tx5fFhqQG4EaVLKwTwo4fZcyNIbV2xtjLUEFnzeuvaIuoYKhKJbQ0ayGKl7z5ix05S671cJzd8snorH8wWeyTo4B3JN7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232377; c=relaxed/simple;
	bh=fwJrw0LmT6Yk8P2iKlyhm1CqN0Rcz+/VTdLkPAKFBMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7LFA4vPRUS8+X9DbrGR/GcITF8VWfi1rAacQytGp/GSVv/NvvucjzAVAsShzbP3i+M9mu8A9M1/RMqwMtc6asEwK5cMLVtKSRzccMMnYOxAVIF5hzD/KCXNxZuRddvajNIqE3wstBXEGuIYfC94V6jO4GY4eOA8IEYeetqdwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Wt581X3J; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Wt581X3J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DMoXBFLLwCbS1Yqcft2v/0Qbfm90Z15L+dMHKwUSZ+Q=; b=Wt581X3J6s6wl218gFtorri9NX
	YsmE9HtUnnKQN18s7k0u2Q0fzor2pxpwqOb8zslATkTyi9sCHD2M6jHu+udTFW6cRgj55AKrpZjJE
	9gvpHiWDdBX3Wct+fqmLJLcIhB42uT2YP5FDKsruDMR5hAS6F9CzjQJqaoycafDPtkJE=;
Received: from [188.22.5.236] (helo=hornet.engleder.at)
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vBwzY-000000005xV-0cJV;
	Thu, 23 Oct 2025 17:12:41 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lukas@wunner.de,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH v4 0/2] serial: add KEBA UART driver
Date: Thu, 23 Oct 2025 17:12:27 +0200
Message-Id: <20251023151229.11774-1-gerhard@engleder-embedded.com>
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

v4:
- fix spelling, exist -> exists (Lukas Wunner)
- remove duplicate include (Lukas Wunner)
- order includes alphabetically (Lukas Wunner)

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

 drivers/tty/serial/8250/8250_keba.c | 280 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |  13 ++
 drivers/tty/serial/8250/Makefile    |   1 +
 drivers/tty/serial/serial_core.c    |   8 +
 4 files changed, 302 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_keba.c

-- 
2.39.5

