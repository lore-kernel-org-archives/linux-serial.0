Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E2233D9E
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499033; cv=none; b=fPUkCc8YsbkSxRd/dCAVBzVB0HW5/WKLCN7ct9v1oHKKsw5dvzN2lbWHZexI3MMllDNGxEKu6jabK/iRgaa8/RO1784I4lgw73hEOcCO8hxE2cYqdtvwAJgoWMIzw9xeI7s6OsDjVI1QDno3XjkoecjzlCJ4qGiHTKdwK1t2luk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499033; c=relaxed/simple;
	bh=WKG4aYWvJjBpvDHeWFwlKSa+4vrtqttZ1i+2fGHy390=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IWBYJ7w69iuXH8X8CiH7LShC0qZXaoCwRtlqow8yRNYItwtQhm0/CVKGuteM5qLEszVTBmdgjzxOzm3uvhKJDhseoBa/7QZKMilNEUU6AsSawh3sgTBgFsLUv4Vbh8uc57xSWlruR1wMjUTj8w34tN+4E1rhEv+8tILXnxSLTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqmh9wOq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqmh9wOq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so65467795e9.1
        for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784499030; x=1785103830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvinVPUoJhsV28WHeBTxSrSEvMvTNBW/BR+fiFjpbyw=;
        b=Zqmh9wOqwswtCaok+JlxkCnZuHy0FaHAGJhZWDuh0GGeAoCjYYFusPqcedsEsh7aC3
         FkWT7SW/I7uG2+97nx67UMma6wdw/jecMmQlpxBlu74pOXjWNizU33/A7k9Bw8FWyIVN
         gQSGeYTajuBvkcv4UWLgpv591jDAzwBeNpZgMAm+NKsdlzeQGpLT0dELtV52wF8nueOY
         Um+CQ135Mt+2BBShuJM2dJWSZYDBky1B6UHVzxuVUeDrFXTSgcRswgBJg4KQQQS6Ma+u
         2Z7cbPBdcsh8Uy0DM97oMYG+G2UAk5DlXRl9pRHMmhY78kUyxsmAGJXX0iGoYwlMPo0E
         7ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499030; x=1785103830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvinVPUoJhsV28WHeBTxSrSEvMvTNBW/BR+fiFjpbyw=;
        b=gvYIppuVNMYUkrERzz6KJVQQtWUmNHJs+yd2VrgxUBX3PCZRlXhCLrFVB5U1Bt4d2u
         FL7lw/eVKDQgOiKMYaorgqEOkZ6nUi8AnDzdPf5bCrCo9zkQ5PSnFlSdk5z76z8vqm2F
         2E/2SHjQVfoZLWtwMrCAiL1SYDUnd7WyV00Amqcdqi/pfiiiMF0SbeEt5ODuIiRL8g0I
         6pn7fhr1TvQqbkRnoOXH2gDuSGHQlt7RGurhPEUEnw1xj2Gw9584tlTuiLhRWSVdO8y9
         kj6k3z2MhyV7mb2tbTTPu4vsdb4sNh58BJsCWGpvT6fP9JK4vnrnhRc4ddBkxVngg/7N
         bIIg==
X-Forwarded-Encrypted: i=1; AHgh+RoEDvyJolXbT6o4kfucnPHtLIGNZn2T/5ZSHjhIkOJUFUVORd7JFni+792XfoRG0CbSObrJK1h+qh/Z8tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIQeRa7ub6W3tOzOe0tF5c69rIPk/ckF1WPcx/1SfHjIanVYN
	Fgrub+lSPduJuRdwiacoDLry7Vm9Jc/oyrbmMbZ7XBJ6d5iYxLyFBvSq
X-Gm-Gg: AfdE7clcbspnR2KejGvA+GQYyVNQyAhf3IHm/eFXpdc5zCm8ho3Yq6q4PHP9GaqmQ4m
	Ty3GPUX7HRZEwCJrNotzy6uoGZA1iQLUg02ZXD13CWOMyzf0kXFKFIea04hMd7F6MM7kKzVNQ6w
	o9g3v4NCG5h7kJP5zQQy9aYL42YLzTiDrOmb4m546rOWAeBDvrtsx4SlkrfDCFafSULayuBGQo9
	jSytfdl9N7US7ZBHVGe9tHlPmWdtTFkL9GY65Gx7xe/u0ZG7itOgo5xEvw9z0Fb06joQ0wjz4Yt
	l/8yzUGs93+ZlVyXdQ0l2KCZgEjzJF9Y6ySqP/wdjFLReNwJF6TuHj84tFg6A4bMwBOduj3oowd
	seGKv0h351xjdNn2a9kqHg7bsOI8FvnQ9AFkHvwS+8+hqDtcMgrkTj6XXXFOe0/LzEZwpp5FNpo
	2GaWLOt0Lh8YkVxgBkHWrkFcWK6rtmRsP7Z2AFdp9F72EOHxTU6DxsPiBYegXWD30cenf95O6Ln
	d3/wUefuKV7cxZBv21Hr07975qKTNBK5yo8bX126oOLdSyC0D0crBEU12t2T2l8tm/aQ7U3N8or
	znKpJMIj0MJ2AFdJxgWYdQru
X-Received: by 2002:a05:600c:c117:b0:495:4b1d:915f with SMTP id 5b1f17b1804b1-4954b1d91ffmr117504925e9.23.1784499030391;
        Sun, 19 Jul 2026 15:10:30 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm114492445e9.12.2026.07.19.15.10.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 15:10:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] serial: fix console lifetime bugs on failed bind and removal
Date: Mon, 20 Jul 2026 00:10:10 +0200
Message-Id: <20260719221014.44354-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three serial/tty bind-error bugs and an i.MX console
port-table lifetime bug. The fixes were found with failslab fail-nth sweeps
and sysfs bind/unbind sequences under KASAN on QEMU's raspi1ap and
mcimx6ul-evk machines.

Patches 1-3 fix shared serial/tty core code. Patch 1 moves fallible serial
core allocations before console registration; patch 2 clears serial-core
pointers after uart_driver registration fails; and patch 3 makes a non-NULL
tty cdev slot mean that the cdev is live.

Patch 4 clears i.MX's devm-allocated port-table entry on probe failure and
removal. It keeps the entry valid through console unregistration and
serializes the table updates against sibling probes.

Backporting note: the probe-failure half of patch 4 relies on patch 1, which
ensures that uart_add_one_port() cannot fail after registering the console.
For complete coverage, patches 1 and 4 should be backported together.

Validation for patch 4 includes reproducing the sibling-probe race under
KASAN with and without the fix, a sequential unbind/rebind regression, and
the same test with CONFIG_PROVE_LOCKING=y. The fixed kernel keeps the
console unregistered and survives an explicit printk in each applicable run.

Changes in v2:
- Patch 4: serialize port registration and removal with imx_uart_ports[]
  updates to close the reported sibling-probe race.
- Patches 1-3 are unchanged.

v1: https://lore.kernel.org/r/20260719160812.35407-1-kmehltretter@gmail.com

Karl Mehltretter (4):
  serial: core: do fallible allocations before the console can be
    registered
  serial: core: clear freed pointers on uart_register_driver() failure
  tty: don't oops in tty_unregister_device() when no cdev is registered
  serial: imx: serialize imx_uart_ports[] lifetime

 drivers/tty/serial/imx.c         | 21 ++++++++++++++++++--
 drivers/tty/serial/serial_core.c | 33 ++++++++++++++++++--------------
 drivers/tty/tty_io.c             |  6 ++++--
 3 files changed, 42 insertions(+), 18 deletions(-)

-- 
2.53.0
