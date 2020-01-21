Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C0C33CAA
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 04:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E339E217F4
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 04:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noViLvlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAUEmW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jan 2020 23:42:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44341 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgAUEmW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jan 2020 23:42:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so1257448ljj.11;
        Mon, 20 Jan 2020 20:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2+nfQUYGVaekGpmnUGcutcQk8+vMcpZCRQ8NpRjWv1Y=;
        b=noViLvlGrTAtMtIPO2L0fo4syKVdnISwsqbgoEna2KTTMWrguxPRJRndyBNtRQqZZm
         4B4MLRKd8J+OT5mM0Hmwd3AXZZGDg36nDvnQEbytSAKCXY5ZKAbmQhav8Lw+mG6iaot1
         5J0447W2DF+tzQExOj7W2Q0WsA2eNSRJl68412rXaE79nEYTtxwnyUYTuq55e0XYiIxz
         Qwdy0LO3Xa9/Re5q5ByTz0/fgyQhCPhh0A9dERQB3IQ4hnl0rLB25Ws+UUrjRHrBP47c
         beO30zu5qLRGALZAzw6Hs0GktVu0tdJUdDi8RT6g92CR6CKeS1OfVFb86rZFGpfIMRcT
         hD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=2+nfQUYGVaekGpmnUGcutcQk8+vMcpZCRQ8NpRjWv1Y=;
        b=iBzCxithe3ut230XjJXyRRx08I9ZETWYDOZsZq15sW3iCxrL1S5BmHP0CeZnPwjJTa
         11RANiM8oZX1ttisnoxR81Hs7Ao9RpSEPwQgDLv4lxlnC/TffKI3oaw3RglLp4clS2qE
         QLqqIdq3AX5mqAbd3PzNUoPipBjQtZwkMVazfkjTKqfFMSGSUqZaJBgDk0LkrZ/Hby5Q
         +C6A3/JgWDvds+yQl8bu9xRU5r0eYa4r79I8rMuYXSSBT0eAJ2AvO6bI0cLGVw3NHwsf
         pAmXrbEmKzXoSZB718WUrmGnFQK11Y2nKRoZYcYFIAnHZw44CSx6Hg+99N0nDLnZDncV
         upbA==
X-Gm-Message-State: APjAAAXknMT8dDMGxqV6/b17rCuRFp6zJvIVXAlKS+2D01pd5+Fgx/H5
        z2+2ibNzKOuLmwrmRGKBQuMrJG58
X-Google-Smtp-Source: APXvYqzB+Hm3nrbmSWT3Mg0odYWLwYaap2ij46Ij2PbfQ8l5+xOdBwkoYKptqEVa05IUlNfIWwXKbw==
X-Received: by 2002:a2e:854b:: with SMTP id u11mr15444179ljj.90.1579581739475;
        Mon, 20 Jan 2020 20:42:19 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 126sm5521802lfm.38.2020.01.20.20.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 20:42:18 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2] usb: gadget: serial: fix Tx stall after buffer overflow
References: <87pnfi8xc2.fsf@osv.gnss.ru>
Date:   Tue, 21 Jan 2020 07:42:16 +0300
In-Reply-To: <87pnfi8xc2.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        17 Jan 2020 08:29:33 +0300")
Message-ID: <87a76hh13r.fsf@osv.gnss.ru>
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

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

Changes in v2:

- Add comment to document why tty_wakeup() is kept in place
- Don't add debug print
- Remove NOTE from description

 drivers/usb/gadget/function/u_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index f986e5c..8167d37 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -561,8 +561,10 @@ static int gs_start_io(struct gs_port *port)
 	port->n_read = 0;
 	started = gs_start_rx(port);
 
-	/* unblock any pending writes into our circular buffer */
 	if (started) {
+		gs_start_tx(port);
+		/* Unblock any pending writes into our circular buffer, in case
+		 * we didn't in gs_start_tx() */
 		tty_wakeup(port->port.tty);
 	} else {
 		gs_free_requests(ep, head, &port->read_allocated);
-- 
2.10.0.1.g57b01a3
