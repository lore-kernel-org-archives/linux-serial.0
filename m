Return-Path: <SRS0=tu6m=3G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC3AC33CB1
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jan 2020 05:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FFC2072E
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jan 2020 05:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQqWLK8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgAQF3i (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:29:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33100 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgAQF3i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jan 2020 00:29:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so25182844lji.0;
        Thu, 16 Jan 2020 21:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=u2ShXKy2k7kn6Z4PvqU+3uG8mylbjCNEvUcCrTSLmls=;
        b=TQqWLK8Cc6iaeyBH1scBvbFDtlYg42Cb7phaV2BVFQXqvwbvwkryR7ZbDpvfRr53tq
         vO+fXctNG4FvcDYeHZZdx2qq71ErHCPEeDOKNqE7+CIb50ZIfamdUOJjvDZsSPZkcTFV
         tj5YP6R+ZgN+3YmptTYaf1DFDuK30n06RCiKWePqaJ+hFzFOT8Ic9iSA3akbGVss3jlR
         +XzmB6JUlEDtLwoqxZ1rSJvn7WQ/YsKzPEfF6bJE+E/pexGQdm2KMZMxI2nmVrxuqPk8
         3BnVorZ1e3Z8V62Ju9DyS+8SuQxMg4DXb9yBu+WdGDDVzwBlmisnA4RnKTpS91+u3rAc
         HIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version;
        bh=u2ShXKy2k7kn6Z4PvqU+3uG8mylbjCNEvUcCrTSLmls=;
        b=erO+KBMCyjf8AwdwOYGM4wrJoeKi4J4vuydLY/fckpFErJGpurIuk+Pk1DCe9Sj7IH
         afHXx8GOl85VBkDJtXJeeHaXRYLMg72k5wj+FDEnpCjyv0aZOrJTGULWssEke/x9Y9aV
         VDaP974QHFWi2SSER7Drs8GmRciXg0TpvBlQNmJUx5Oe8dll3muklk+SHHqojpiBk2uA
         0wqw+4ko+u1mnL9JG53BWbH2AJRUznJIA8qoH+nAi43aHuKLWaPNMT1x0ullPqANgbwM
         i6moCx5yt7fozAJSFSz4ypUkLDxcceJkPlftWg1USM2926wnKDnCA+VST0zMYpT1P8dY
         pLNA==
X-Gm-Message-State: APjAAAVfatBPNj+zuuxNpCjwhQPhO1kmND2e+nm0WJ3cTpPA4TAjf/JI
        ap2xVAJryraI0WCRgMDRero=
X-Google-Smtp-Source: APXvYqxA5uYD4sYpItoBgbNFyociuqkAECSQWyzhlWPFkgrSZ0cqkqzWXbUYREpwQssy8/98MEbuOw==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr4590317ljh.187.1579238975166;
        Thu, 16 Jan 2020 21:29:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b22sm14345507lji.99.2020.01.16.21.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 21:29:34 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        linux-serial@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] usb: gadget: serial: fix Tx stall after buffer overflow
Date:   Fri, 17 Jan 2020 08:29:33 +0300
Message-ID: <87pnfi8xc2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Symptom: application opens /dev/ttyGS0 and starts sending (writing) to
it while either USB cable is not connected, or nobody listens on the
other side of the cable. If driver circular buffer overflows before
connection is established, no data will be written to the USB layer
until/unless /dev/ttyGS0 is closed and re-opened again by the
application (the latter besides having no means of being notified about
the event of establishing of the connection.)

Fix: on open and/or connect, kick Tx to flush circular buffer data to
USB layer.

NOTE: current version of the driver leaks data from one connection to
another through its internal circular buffer. It might be a good idea
to clear the buffer on open/close/connect/disconnect, in which case
the problem this patch solves would have been fixed in a different
manner. However, not only that's a more dramatic change, but to do it
right TTY-layer buffers are to be considered as well.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

 drivers/usb/gadget/function/u_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index f986e5c..d333cda 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -563,6 +563,8 @@ static int gs_start_io(struct gs_port *port)
 
        /* unblock any pending writes into our circular buffer */
        if (started) {
+               pr_debug("gs_start_tx: ttyGS%d\n", port->port_num);
+               gs_start_tx(port);
                tty_wakeup(port->port.tty);
        } else {
                gs_free_requests(ep, head, &port->read_allocated);
-- 
2.10.0.1.g57b01a3
