Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953203BE155
	for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 03:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604005; cv=none; b=t4jsf/Yj8vPLKWf6oQibulLxrWddwqWR+ZJT8mtSnSeT5bF6tm7ZQ+CX64XDo386WzYOGjWETLoez0gpk1yoS2tiW6d7WH+6/qlgxS/TOkaw0CZ/GDfNdrmdYBePVWzp6EroWu+sAri8gZ6I3IJmQgBI1Yd0tmhmZfuVY1jFGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604005; c=relaxed/simple;
	bh=k8TPoiMwAjR5GOxMyjwMDX7WGOJ4rF1M+VeIYQvoBuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wu4i3xXjKRoplcuzzR5Z8h7A2SmG9Q5m0NE6ry2yzrPtW4qMWyoMR77KOhRlNjAmR+8zdiUj3+YHfTQse35SHKd6wArT18dgmHaleyLiI/81Xz6qHxkc0tWngVcglHzXoN0aD4/1EkBCulY8CJJF15ZDDvs+eDxCmYuLf8dJd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=CdaTJCv5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="CdaTJCv5"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917d595138fso3123456d6.3
        for <linux-serial@vger.kernel.org>; Fri, 09 Oct 2026 20:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791604000; x=1792208800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9496Z4xJQFpi1+eiTqu1gpT5LZKW67A1SEVUrT0nCjI=;
        b=CdaTJCv5K2w4VqQdCyMp8bT1M3Pt1kh4zC9XkltN1kt0+A7w/KupiwBQEhKJ1NYQRS
         lPeie4y1Q5tabABFfu0rKopRhAzIxYyIDTqeu8ee1M/qLkseDTtLtO/AsxWK13a647K8
         MrXNFZQvF38hf29HMfmz+aPqusM8DqUmEPw4yXcJgm9Am+dUcH/xs/hyRYYemcF4z6Dx
         kc6yYKbNlDUnQXCaI2mvbxa5SPRQdJx1rg2zelyygENubFwOk1IUZaQJC+YxcS3p+z0b
         fzKR+OGlfCoxsoHfgTNZMoO433rC48JS8c39irec9ta+OBivBTydE7UeLE5jFSWpBCZm
         rG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604000; x=1792208800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9496Z4xJQFpi1+eiTqu1gpT5LZKW67A1SEVUrT0nCjI=;
        b=dxJ0ggpLX+ZkLHYTyzc485W6Bifi3elUw57iYs9hhchp4qOkMFvUO8bU8bmBj94j0W
         WdK6SM7xywMDj/7LWRPj8Hu/gJxT79baRxuXpjIPX9F2mqPXhVM+4xqIIhLSCr9lrQWg
         /Ly8Rvq7BzRxDVO917wMaM8nUSiCYF70F02xjhItgCqUOqMJ0gS+2b5By19LBTf0d8S4
         oiynZPzpA/fbR0zp9lvqNwZa69TPrYkBwjMU6Ld0bHwZOUtq/JrQHxXKKzQPQqBP1I8P
         cKWoJECCqoWF7UkEIhdVSE5PplO5k8P5URjrVG5CE2OpNvXLas+tM2aBucvEk4oEFnAO
         2Vjw==
X-Forwarded-Encrypted: i=1; AKwUvBzNTng669QMwWI5XtJbuvCmCh/58QqL3xEfrxIqUacnaYHr9gOk0/vkNNWh/XvIgrkUyC+4v6mS4hG5Vk4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSMPFJlaJMRi5KFTqhBkqDknlY6sNdU8A6ByOsv8lP3VwIJrM9
	cHvG/h26Y2LbVV+LlY3/RxvorkJrrRIreTboQ0DvWroB6yDfHWcuuXt14KBUdXeg+w==
X-Gm-Gg: AYBFou1vesJDpiSCv3ZR+SPmgPw117uiAb9asaeR4Ok0EVrsIlivWwoBp+A+za46sD/
	d0DueZUFBhZ8+DIGxxSiG8oxsO7uhbAfWoO2LSMfOyjQYtcu6JJ1turEnlCiAzCh/BTZU+r4r8d
	+DxJVlc54YhqO3p8FjE6FpUfkWB0RRiXFXNWzofjr3VXcayk+bquQDB8vsl+yzPEH6XtC2POjcs
	yA2LVyxHglyerVO2axoF1RIChIqXpdeDl+clPQ+B4YdFcGIAVhnecCmE0pO01GIkOWKrkQWjZHb
	up9NapFNIoUXGcBHEuNSU4K9/xx35o4Q8/MDcyV2F/cLSUgnxYYGHDnGGijIU9loKjTTPL2RmHE
	UPS0qtpjr6YP/bdJy1lBEEmc43t+rZoAjOLa5HhzLwgbmUKgI/iaIOfCaTqLepug/olMMgNGWsl
	na4n8b0urOmqstESt3sbKaopWG3/hsPrLkb6TY1dT2QHjkifJJ3YFANPsrpuHP69eG+zfUWJryV
	YXNdwUDKm+NYxrVXQDerg==
X-Received: by 2002:a05:6214:4291:b0:919:aba4:22e5 with SMTP id 6a1803df08f44-91b554ec072mr64283936d6.18.1791604000205;
        Fri, 09 Oct 2026 20:46:40 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550e1068sm35475306d6.46.2026.10.09.20.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:46:39 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on uninitialised ports
Date: Fri,  9 Oct 2026 23:46:16 -0400
Message-ID: <20261010034616.3915864-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8ca59f7baee7 ("serial: fix ioctl hangup race") made
uart_set_info() and uart_do_autoconfig() return -EIO when TTY_IO_ERROR
is set, so that they do not run on a port that has been hung up.

However, TTY_IO_ERROR is also set on a port that could not be started,
for example because its type is unknown, and by uart_shutdown(), which
both functions call. As of now, setserial cannot configure a port that
the kernel did not detect, and an autoconfig that follows a port, irq or
type change in the same setserial call fails on any port.

The issue can be reproduced with setserial (busybox) on a port without
a detected UART, for example ttyS3 of a QEMU guest:

    setserial /dev/ttyS3 uart 16550A
    setserial -g /dev/ttyS3

Before commit 8ca59f7baee7 ("serial: fix ioctl hangup race"), the
result is:

    /dev/ttyS3, UART: 16550A, Port: 0x02e8, IRQ: 3

After that commit, the result is:

    setserial: can't set serial info: Input/output error
    /dev/ttyS3, UART: unknown, Port: 0x02e8, IRQ: 3

This patch will check tty_port_active() in these two functions instead.
uart_hangup() clears it under the port mutex, and it stays set on an
open port that could not be started.

Fixes: 8ca59f7baee7 ("serial: fix ioctl hangup race")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Commit 8ca59f7baee7 is in the stable queue for 7.2.

Tested on v7.3-rc6 in QEMU (8250). A TIOCSSERIAL that is held in
copy_from_user() with userfaultfd while the tty is hung up with
TIOCVHANGUP still gets -EIO from uart_set_info() with this patch.

 drivers/tty/serial/serial_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6332ed545c89..81a985424694 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -896,7 +896,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	upf_t old_flags, new_flags;
 	int retval;
 
-	if (!uport || tty_io_error(tty))
+	/*
+	 * TTY_IO_ERROR is also set on a port that could not be started, and
+	 * this is how such a port is configured. Only refuse a hung up port.
+	 */
+	if (!uport || !tty_port_active(port))
 		return -EIO;
 
 	new_port = new_info->port;
@@ -1144,7 +1148,8 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
 	 */
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->mutex) {
 		uport = uart_port_check(state);
-		if (!uport || tty_io_error(tty))
+		/* As in uart_set_info(), only refuse a hung up port. */
+		if (!uport || !tty_port_active(port))
 			return -EIO;
 
 		if (tty_port_users(port) != 1)
-- 
2.53.0

