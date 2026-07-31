Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA754322FB
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521937; cv=none; b=syGemzCEh5wSqkruwESO0TWrYlVedJ0SPn2TxBg1VgDkHtvs2h59dvCIL3cjta+3PSG4XQGTo4809g3+P2+mrEdO4GE6hTL/pjnQv2Z3L/YHChrOra/blYi/VZqBqPtS+sKgwxbR1mQp2jkZ6E3mrO5xcmRVFEbpOS7h9fAa324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521937; c=relaxed/simple;
	bh=f2WgAKIx0zZc7BGy0VsUPDEiddYh46CfX4wE+IV1Le0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VU2WlJ7eRa2koTslHNVLmyUyXaT8i8UtOGQIlnoM0XkgWhMc/5kzbNxtBsxzE5q9b4nULGiIGCRIAQrucCvlwO3cPj5Jbb/J0pP1+E/JC5eulDaLqf+IOWNIumh/6DtPwpMP5tIAU2wDnGAilTWcKIdkIIEqPPwhKOy2ystE468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRIxqODN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRIxqODN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4728c12ba97so802171f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521934; x=1786126734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ou5GQthySEEBs7kf/0E67tbXvLbnV4y0XvYiP2W//3Q=;
        b=PRIxqODNBNx0ccr1QEaEoeiTolyTSzYdGj1uB2+6REPqpTrU+bplor9zLzJUmXBa1Y
         yzSC4jFuIJAAHtReF8pB8iQwPaMhQuqQC7YbyAigqSVm3pTAALmTzYsdCbW1CSOamYUj
         J2WnZskgvCSDV0zmps95mnOmq6hy0U6Sm9OrvMvLT/UrbSW5/4QTQa+yB011LSlfqRzK
         yxsmMiSpJf48nzHuMHwctWuJaG78evF9JsKN+ffwsFdesAbp+/s4sv/mlQ9u69I+gHRr
         2LQPXT7nuye31Vem/9crmbXsdZAvccKvhF/MJgD1EF/XR/5Wew0EUCOJLvGrXVWRbGVB
         F7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521934; x=1786126734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ou5GQthySEEBs7kf/0E67tbXvLbnV4y0XvYiP2W//3Q=;
        b=iy22eRPcAfRQqXlGcfp5OQjgWcnN0QlXXIC/0z0wP9ZmuA1gjpv5p5iuKZsrONsjFM
         9cEkTj1dYpUeRs0+ll1xuVGww0NxJvQWI7Nexh4QZrKFDI5ncl4tKKYLq5YRg+6JYhy6
         nv9aEIZg4o4cJHrhMFH5POcUDgUKWUCSRZMj/pqIppZDbulArSZPyyHY5dZafWChTfiI
         W0IealOCFLqKgvoy8MjR56cOMiYrzDH6WZ2kYc9q8fkws7nixF7pwCyjdKMGG5y21KtC
         wMgGzyxnIEOGdBHmZYWTkEkotIMP2ry7wM9QIMqv3bZMD1UFJkg+T65obYG3JFCn0r4t
         OMww==
X-Forwarded-Encrypted: i=1; AHgh+RpsHQmFojgr2Z7XuJKQ8hWXyzj3K4/v/45ZdA8NaZOcyqGFx0HOpxh33dcY+ywXSwE30P1QYr2JpP+Mb1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6UMtn3kx8Nw54RFRrjVe23/KGvZc46RDEgoPA2brpZYUcHuZU
	IwnyEzpbsv31vvykb1M/kMTpi309aRGjH1x85lxTLAlpWaf45VwUSvym
X-Gm-Gg: AR+sD10Ld8sH731KqDAqhcDbHHM6Gm6CdMnYmAARcZwUz+Q+v7RLydAKAThIl87D2rp
	bFvgzNcJQcRcefd42WpN0M5eA3iRuXclC/nQbOYOZlCjh9xzaFxQfmPVhAHoW0iiwDAE1GU+rDZ
	qcRyZN9HqcLmMJEgfDuMwsuuqeSSchDyNmM43y8c5YSZmoygdmHzC8ez+w20M1ta5EMlulIICAv
	W35HOrTzzbIxwROK0GLA//GPqiMjsYjHMEZH1SXyAmf3sMz/alZ/LuZodHZ2pkw7kFzYmxAJ1L1
	qhggP/l7a7KkQrji1WcCbJdDqOf9UCMLtNTnHLVLh8A9nGuwaangCV5rJ3FHRqYmGNlLr9nptVU
	nM3EA1UNTGgs5ZQCtjmANjpzF1FxTXOdOAmn7ntKLniEd4qg942QNRZxAt8gxgvcNWe5+K2/HAv
	/hh3KouQYid5rOMwJCecYSCxurFR/qGLVsWIjLVP0yVyUezWHaAVqr+83l15CL+ZRoo/aBuefxv
	C89MdVdD89xQGa0rEcvst55xzuTxfl0KCA8jPf/0nu1wa3x6yTNgdCmqqgUjLqnoegR1SqMZ+TP
	ecjf67+zGvgKSFoA4HyXs8ALOe/lFzsivDv2n1b86Y7l8e+pBd1HtRa6hWBKGj1HM03r8lLZzDv
	dXII=
X-Received: by 2002:a05:6000:29d7:b0:475:3a97:8e3c with SMTP id ffacd0b85a97d-47fd72b08demr1120224f8f.18.1785521933729;
        Fri, 31 Jul 2026 11:18:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm7293694f8f.4.2026.07.31.11.18.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:18:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] serial: core: clear freed pointers on uart_register_driver() failure
Date: Fri, 31 Jul 2026 20:18:41 +0200
Message-Id: <20260731181844.11330-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260731181844.11330-1-kmehltretter@gmail.com>
References: <20260731181844.11330-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_register_driver() leaves drv->state pointing to freed memory when
tty_alloc_driver() fails. If tty_register_driver() fails, drv->tty_driver
also retains a pointer after its reference is dropped.

Drivers that use drv->state as an "already registered" flag can then skip
registration on the next probe and pass the freed state to
uart_add_one_port().

This issue was found with failslab on QEMU's raspi1ap board by
failing registration and binding the PL011 port again.

Clear both pointers on their failure paths, as uart_unregister_driver()
already does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 9e845abfc8a8 ("serial: fix NULL pointer dereference")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 03ee3d038f4e..234976fb2a87 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2777,8 +2777,10 @@ int uart_register_driver(struct uart_driver *drv)
 	for (i = 0; i < drv->nr; i++)
 		tty_port_destroy(&drv->state[i].port);
 	tty_driver_kref_put(normal);
+	drv->tty_driver = NULL;
 out_kfree:
 	kfree(drv->state);
+	drv->state = NULL;
 out:
 	return retval;
 }
-- 
2.53.0
