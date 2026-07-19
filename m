Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EA381E97
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477307; cv=none; b=lNNN72F4BZXHnTWZLmffz2UnUAVNeunCbuPBBaVJ72Xiwh10f7RwypN9ja9JL/naqOjO5mjtXlZ+iVrFr5QUzPg1+fFKICTaZutb3KlNwn7cGvJHYTjOGwPGM6WsXrUmefzJKjEo1PtUvSyfZ+Fdq15D/Cwde6KFbHX1D1GSrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477307; c=relaxed/simple;
	bh=mziCgHHnU/wl0EtRGbMHh07Co7AfovVZx/sOCmyHV8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eF5y7l9x5Uc35lhBiTinrVqx1NyqT7WbLunYDF7bdaxOX1Sshk8RN/FQuX7SU8Cxuq1DY3N42eOn3kRYbfs44ZhOdCNaCLROStCwR2mpsForTax9tyuUCxDUV/0VbfRMz+0+VgLos7R9xFHqN40pveoiOY2aSvKaJOYHxrQN3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ays9ZCii; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ays9ZCii"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4955de8797cso1093325e9.3
        for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477304; x=1785082104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IN4Hj7JaG8b++jqQRlTsZ8ObY56xxPIUhNKD/QRpNuQ=;
        b=Ays9ZCiiaOadqGb4deolK2coGSmVRidt1S3VK0iTzYDj5ngHzqzRIDrhJZxiuiCW28
         HTOKUjlhQ/rOm2z8JHP8EF6VLCbuPDO7ZjTjCTF3M7ee7l0SfCAWHu9LU18wZMV2g/Tw
         LvDeCxWVHUxsZLVMRhSIrz7LHW9vyoWkLSpfa28oTsUdioETolXifBA6Uo8Q0cpmhiVE
         PDhW0ya9/YsKfGI9Ba8X4DFKXoeJ1uxn8fanTNgQsRrZ78TEjfxLquYrObCgnQ3ka1RZ
         yV3Tpd40vGulpCLV/fO2fDlAIsqgBjmkMd0Rr4bqnNwyHCbs5iXBPUCDkP22SE7n9nPp
         iwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477304; x=1785082104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IN4Hj7JaG8b++jqQRlTsZ8ObY56xxPIUhNKD/QRpNuQ=;
        b=KKD9TFi6QsYBJQhIP6lY0NT4tfayeG8SdtaErZdo4mWszDt6bEX0Fkd5v8vo+ITG+S
         Ok1fRW/ajdSQC0QNgytgVshuaS/tkX/dY/XbYyCWVVnYN3ZLIyfP//V7eR+xMEtzM/c0
         A8Mb/DBWOOdrr6d0pXGNYWL2/4Zkyiu4CtA07MEVndlFYIVm1Uy/mtreIboBc4RHvsZE
         dWlqDsbZHqDqk2lQbv94H/ynD0Xj8yJEbgjBZ0IiARmsM2m9KYnEcM1s/bRNQYGVuZHc
         v942uCNw8NI7EHOau/0p+r3Xo4+Dedp7rkkLWr3m23fD4zYWZl0I3X++BltqXkWigswn
         HSLg==
X-Forwarded-Encrypted: i=1; AHgh+RoSLv0Od6+E5acREER8tv2gUBAJKEP4PbSF7ULGICg9pIo6tdFwKy9w9nxMkQmOigizdRrCueGwI1OjFNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YflgJ01UqefMuJHuGrqj0P36DLusdv83CaZmqb9LkJsc1siH
	5sD4zupI2WpHrIkSeNedR13x/nCLCcARhxfkHXbMaCdBFKnqlMdoQbry
X-Gm-Gg: AfdE7ckVXLrjsgc4n0hWXsStRlWDFVgST3in0O+z3Mpc+8MFfVLEbrwse0sdMk+nwtm
	YpWzJSTdVjhBf4cFrZqq3iGOqm2OIzXFWitw+/qB5OGjGu/d1brzpaBSpgcpI/thi1Ay9ED2nXd
	J4AJOAbZG2lcAIT1hjxqfOki1wagudZNYLP44MhVkzwIwY9D+BaKmLfJOnS9uFSm15Ia2US9z4/
	7pLBAQZHhdGhIC26pkspz7QbNq6m9p0JJfzfHNXDO46Fh6JzDWJkbUNYrME6lgEwzMUyX9YYkND
	d3u6GsRideZ+IWp05PtRfK/4mGOweEQ9ogK4kLuM1syH5EOA2h1qghmfCvTOehp1hTqCwms0CQk
	HrR7KOBf09u6dm8UiWf2aqP0P5s7ywq73/d0eRzJaJLmRw/xTTkIA4MHbR2B8m6QT7dFCHHEcuK
	a/fRgJO3hT9u3+6ws8Ryhx8YwVJ8WNZcbdJDABsp1SgI279lYfJES0sWqwjXgmjsbY1o6TwNy/1
	V9jINMiUeK6hrbfZz+LTU5AnPhQVJYVsdkiBgAzldc4YB12ZQKYWYeaObi0p/mgo9rkSnuSnGFz
	ugRJiFFEhCF5zgrItYR4
X-Received: by 2002:a05:600c:c097:b0:495:5a91:8027 with SMTP id 5b1f17b1804b1-4955a9182a8mr26079975e9.5.1784477303312;
        Sun, 19 Jul 2026 09:08:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm223826745e9.12.2026.07.19.09.08.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 09:08:22 -0700 (PDT)
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
Subject: [PATCH 0/4] serial: fix console lifetime bugs on failed bind and removal
Date: Sun, 19 Jul 2026 18:08:08 +0200
Message-Id: <20260719160812.35407-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes serial/tty lifetime bugs found while injecting
allocation failures into the UART bind path. The failures were
reproduced on QEMU's raspi1ap (amba-pl011) and mcimx6ul-evk (imx)
machines.

The first three patches fix shared serial/tty error paths: move
fallible port allocations before console registration, clear state
after failed uart_driver registration, and track whether a live cdev
is registered. The final patch fixes the lifetime of the i.MX driver's
private console-port table on probe failure and removal.

The i.MX probe-failure fix spans patches 1 and 4. Serial core must not
return an error while leaving the console registered, and the i.MX
driver must clear its table entry before the failed probe frees the
port.

With all four patches applied, fail-nth sweeps of the console UART bind
path completed on both machines without a KASAN report or oops. Every
failed bind left the console unregistered, and the i.MX unbind/rebind
reproducer also ran cleanly.

This follows up on the discussion here:
https://lore.kernel.org/r/alyjOGyTd19Obemi@MacBook-Pro-von-Karl

Karl Mehltretter (4):
  serial: core: do fallible allocations before the console can be
    registered
  serial: core: clear freed pointers on uart_register_driver() failure
  tty: don't oops in tty_unregister_device() when no cdev is registered
  serial: imx: clear imx_uart_ports[] entry on probe failure and removal

 drivers/tty/serial/imx.c         |  4 ++++
 drivers/tty/serial/serial_core.c | 33 ++++++++++++++++++-------------
 drivers/tty/tty_io.c             |  6 ++++--
 3 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.53.0
