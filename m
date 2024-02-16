Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489491B80C
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070425; cv=none; b=Ep2fsCje4GTsqI7VW3eC2HlgfwQxYIDNFkuIbk4AaQ6msipFUwCgXYtx4ZKgQAZIvBsv1/aS/fsKNqYDVBuRS+OsniXm+ugz11eMbMMTWUrJI5mlNlJT6xKou7jhjxtA8A5J9nBn6QxQOrqCgkpvypQ9dZupZgwm8+qXLnmMwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070425; c=relaxed/simple;
	bh=Cqm/EG5qUaoDNuzdzJISKoEg77NshXhbERW32TZKJ+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nOi4vwR/RCU5bu2E7IfcYFPZxaSiVHkH6237gIo/TR5KV7OaHAjzjnMBjMkKCNmZ7DkTzj2GjmTgKNB5hZSVdXfEVxwVX+XzsETHU6T8t1AlR9PMZv9+GjFx9NwnnH1Y/PxjR9HTQeFlqwkcul9R/8xrj/WIEs+2aThJ2LUvTtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLs8DZNW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLs8DZNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708070422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fl5VQYwK1CPmD5XbTx/mJNWpRykw1CcLoDo4tp9HhvY=;
	b=DLs8DZNWG4KjDbi0qZqo+5EVYbaQz2BkLC253xVz0fNlDOdeC5tOKGtT6rFouhKSJjNoQw
	zFzaX5ZDZhgDHLYhP0W3bX2X/t84KX65UDkjBIUeszTeRpCNBIQekHaSp2tQozoJmXKa17
	gCgZXnbtc459u8qGbrbT6kUISw+kw38=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-dHoX9QBsPieVG3zBKMi4-g-1; Fri, 16 Feb 2024 03:00:18 -0500
X-MC-Unique: dHoX9QBsPieVG3zBKMi4-g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78732ea0f74so173610685a.0
        for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 00:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070418; x=1708675218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fl5VQYwK1CPmD5XbTx/mJNWpRykw1CcLoDo4tp9HhvY=;
        b=odDB9QFx/ogQX3pFvBB/tyBZT6wkM0drXeRRGGYMJe0mFC5hos5OsFWoaz4MjqM/gk
         FPVI6xooqalfKcDova9xuVG7hU1KyiUlCbaZCLN5/ch5efsa5wA8yg8RcWFWxnkkhSgj
         LXn9z1GJYMdP1oB6grO0fIAXV5zlJNLL41OdAK71ayplX0ZBQLWrld09gPpBIKuF7mC1
         uHhqTGpOaZnfKTkPdUe4z5uZOOlo8MO+xc+zi8AAEoV5eYPyfDud10kTUK/Mr8xoNY1G
         XgJzEHBmCpj0iZo55ivSE1W3zk/Dv+ntDLQMmjrxfIZ7n4uLDJ+qCM8+sZ77rFFZIxsf
         GEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjBQdRbL/MAWLlcN0m0xqpzzgD7EgE+zFYVTX2ANUiLcBtRGh7y/pV5HJNB2Tm3w0OiwX/DZ/uCQhS71e5RM6eG94eGam3LzkzrUAJ
X-Gm-Message-State: AOJu0YzJ1RIaicJjVbRi62FGRTCzBnaS9nCD5+LMkIaWYH7VSSDd0qO8
	Jw3uE1XK6+HIqIw6Q/VOKypSSuGRQEKGuUDDiG4CZ8AFeoQtb0tRIJZiMVJ1zq7LNfiLZIYVRVT
	/3VGOy1TlaxG7+GOB5uFAUt1qNm/S39gpm9MZHr6EumlLSugRinQcfjAqfpRESA==
X-Received: by 2002:a05:620a:1a95:b0:787:27f1:b8b7 with SMTP id bl21-20020a05620a1a9500b0078727f1b8b7mr5106190qkb.60.1708070417903;
        Fri, 16 Feb 2024 00:00:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoFFLTl1vSEz2qmS9/UufhOWkiwxQFz5Zp8e7I64XzmrAOC80+oyQmmO0O2zGb46017TZ2Ow==
X-Received: by 2002:a05:620a:1a95:b0:787:27f1:b8b7 with SMTP id bl21-20020a05620a1a9500b0078727f1b8b7mr5106134qkb.60.1708070417447;
        Fri, 16 Feb 2024 00:00:17 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b00787346f1edasm1300756qkb.54.2024.02.16.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:00:16 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Leonardo Bras <leobras@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v2 0/4] Fix force_irqthread + fast triggered edge-type IRQs
Date: Fri, 16 Feb 2024 04:59:42 -0300
Message-ID: <20240216075948.131372-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

v1 patchset subject was "Fix serial console for PREEMPT_RT".

While dealing with a bug that breaks the serial console from qemu (8250)
after printing a lot of data, I found some issues on this driver on 
PREEMPT_RT kernel due to it enabling force_irqthreads, ending up causing 
the IRQ to be disabled and the serial console to go down.

I found out 8250 driver get an IRQ request for every tx byte, but the
handler is able to deal with sending multiple bytes per "thread wake up".

If the thread don't get to run that often, and end up handling many irqs at
once, it will cause few changes in threads_handled to be noticed, meaning 
only a few runs of note_interrupt will not increment irqs_unhandled, which 
leads to disabling the IRQ. 

For serial8250, to trigger IRQ disabling it's only needed a fast printing 
of ~300kBytes.

In order to fix this, I propose that we subtract the number of threads 
handled since the last note_interrupt from irqs_unhandled:
(irqs_unhandled -= threads_handled - threads_handled_last)

So this way irqs_unhandled actually reflects how many of those irqs 
actually haven't been handled.

This work is divided in:
Patch #1: Simple change in SPURIOUS_DEFERRED bit (31 -> 0), so we can 
acuratelly measure how many IRQs have been handled even when the 
threads_handled & threads_handled_last are close to overflow.

Patch #2: Subtract the diff from irqs_unhandled on note_interrupt.

Patch #3: Implement IRQ_HANDLED_MANY in order to let the handler return how 
many interruptions have been handled in a single run, and increment 
threads_handled accordingly.

Patch #4: Change serial8250 driver to use IRQ_HANDLED_MANY interface, 
so it can inform how many IRQs have been handled, and help set the correct 
number of irqs_unhandled, thus avoiding IRQ disabled for normal usage.

Changes since RFCv1:
- Implemented a way of better counting threaded_irqs handled, instead of 
  only zeroing irqs_unhandled.
- Rebased on top of linux-rt/v6.8-rc4-rt4-rebase, so I don't need to fix 
  the sleep while atomic issue in serial8250 mainline.
- Better description of what we are actually fixing
- Changed patchset title from "Fix serial console for PREEMPT_RT"
- Link: https://lore.kernel.org/all/20240116073701.2356171-1-leobras@redhat.com/

Leonardo Bras (4):
  irq: Move spurious_deferred bit from BIT(31) to BIT(0)
  irq/spurious: Account for multiple handles in note_interrupt
  irq: Introduce IRQ_HANDLED_MANY
  tty/serial8250: Make use of IRQ_HANDLED_MANY interface

 include/linux/irqdesc.h             | 11 +++++-
 include/linux/irqreturn.h           | 23 +++++++++++-
 include/linux/serial_8250.h         |  2 +-
 drivers/tty/serial/8250/8250_core.c | 13 ++++---
 drivers/tty/serial/8250/8250_port.c | 16 +++++----
 kernel/irq/chip.c                   | 10 ++++--
 kernel/irq/handle.c                 |  3 ++
 kernel/irq/manage.c                 |  8 +++--
 kernel/irq/spurious.c               | 55 ++++++++++++++++++-----------
 9 files changed, 102 insertions(+), 39 deletions(-)


base-commit: 63d966ad6fecb66769e56fe2285de1e3b448f2ff
-- 
2.43.2

