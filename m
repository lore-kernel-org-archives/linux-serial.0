Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB93C4332B
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 09:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306ED2070A
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 09:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDyAodiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgCXJEF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:04:05 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44972 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXJEF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 05:04:05 -0400
Received: by mail-lf1-f43.google.com with SMTP id j188so8681572lfj.11
        for <linux-serial@vger.kernel.org>; Tue, 24 Mar 2020 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:lines:user-agent:date:message-id:mime-version;
        bh=xQoLhNRAgfnd2RAKmenPsbPLyV2wUC5/TslRZvGkElI=;
        b=KDyAodiCKb6sj7fPN42zcdwIo1RgUiIt1AK81Yy5sRoCLiP+glUEsrmLtD6IlYj9s7
         QxGj3FvtxXLg5CWFYLzYUBp3t2Utdh4TUFkB1j6kYu4Hzu95yZOYZFWt35YJ/ZqKN+Wo
         Tysl8x2mKx0gCaaSyVfugCCQJYiAboEigTqx+wKOyfxzD1TPy4k3UmJepivWiCRxTiaY
         r26Kd6CtMETESMadaAWanBI205ju8yw2CSOTobBUJoI5K2zFXtfe/N4BukWkBkc0nkOX
         MHh3z8iNk7xnNkH7i3LKd9IC9yvY/PG4/0txSN1qyjpa3C5LBJon6DrfmLL0dim8RWL0
         X32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:lines:user-agent:date
         :message-id:mime-version;
        bh=xQoLhNRAgfnd2RAKmenPsbPLyV2wUC5/TslRZvGkElI=;
        b=qwC3lWBJ4EG8JB4kVY3tNbGeIKbAwGO3WjCsHNYQ5vYr0krCWiHOwwziI98+BPJPzD
         t0hV5FLPMx4P2Focv4miB76WCKkC60r8NwkWAxWCJK7+GgQk0fJxtzCq6TeJmhTNCdOd
         BcTEh2ZSPQkZdYGxmmrQGOoR7PtYgonMintU8boS79Ku4h2N0K0GDwkOOVd0Ic1RTF1m
         5BiKzzbXgmpl9VEpDWUVrNeDC03PvcxcVf4quRxJQvhr7OxSSVKa0m1orsPXdE7QjblR
         PX1oC5iCggl/nrFolhs8YVrlWsGVmZYg5ZSz7eNeyzgFY5dM1mD/4I3WbZ7MVUaG+Xmr
         FIsQ==
X-Gm-Message-State: ANhLgQ0PiU2wH5bLbrfLj77+S/sbad9AAoyjZHnh/50HVCyeJ+AfCvP4
        R6/dZQofEBSdgXxAITxCL6kOAjJ0
X-Google-Smtp-Source: ADFU+vt3GBeqgs4Eql6putP3hiZoI7/gSqTSDyXowaThLPpNUq/ybW0MRnbYkRV/SHSdhT3gxEJS5w==
X-Received: by 2002:a19:cb8e:: with SMTP id b136mr879070lfg.67.1585040643559;
        Tue, 24 Mar 2020 02:04:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 24sm6223137ljv.105.2020.03.24.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 02:04:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Serial console and interrupts latency.
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Date:   Tue, 24 Mar 2020 12:04:01 +0300
Message-ID: <87lfnq15vi.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

[Extended CC list to try to get some attention]

I was investigating random serial overruns on my embedded board and
figured it strongly correlates with serial output (to another serial
port) from kernel printk() calls, that forced me to dig into the kernel
sources, and now I'm very confused.

I'm reading drivers/tty/serial/8250/8250_port.c, and
serial8250_console_write() function in particular (being on tty-next
branch).

What I see is that it locks interrupts

3141:		spin_lock_irqsave(&port->lock, flags);

and then calls wait_for_xmitr() both indirectly here:

3159:	uart_console_write(port, s, count, serial8250_console_putchar);

and then directly as well:

3165:	wait_for_xmitr(up, BOTH_EMPTY);

before re-enabling interrupts at:

3179:		spin_unlock_irqrestore(&port->lock, flags);

Now, wait_for_xmitr(), even according to comments, could busy-wait for
up to 10+1000 milliseconds, and in this case this huge delay will happen
at interrupts disabled?

Does it mean any serial console output out of printk() could cause 10
milliseconds or even 1 second interrupts latency? Somehow I can't
believe it.

What do I miss?

Thanks,
-- Sergey
