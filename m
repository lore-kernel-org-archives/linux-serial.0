Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E959C4332D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 15:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3FE2072D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 15:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOzWhlDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCTPPw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:15:52 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33795 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTPPw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 11:15:52 -0400
Received: by mail-lj1-f179.google.com with SMTP id s13so6820119ljm.1
        for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2020 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=KfWFAUngwoUScWWxlij3hsoEi07IvFJ4HPy43v95Idk=;
        b=bOzWhlDjCwh3RvmI15RDxpfTPskSLWKzFaukzxGwASBMn94CkwDnAH6r2EBxwC1NL6
         EdA0IzXeTq2dVft0kJdjzulqvSQoyxEbiWRC3h3ui61+QTuYRyZTCJ3BT6CxCpHW7VeF
         wLbeX1GPXZOX44HXNHaIWIX7I5GUqC/g3tckpTCTmdUkcVKir4ivSIBm47uRdBX6AERo
         MofEAVqOb9TMo9AHQZb6G9j2ZoQMggSH4tzkvUecOX9xXW6ZSLhJQm8d+ISYDCrQ8QDN
         js9N6RfsXDxvVZ8BxmzEbFHZXozN7HtQA75R4suESLPA1nPGmn+2SxviDIwTp/DJPlsu
         RR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=KfWFAUngwoUScWWxlij3hsoEi07IvFJ4HPy43v95Idk=;
        b=mUOX+1C8uZPoaXvQCMwv6KajVsgsHVF5pXprEvlWw3fT8USyc2lF6tRIrebjq+3x0m
         lOF7HLULlUOKbo9FTswDWvPQ6cpdXHOyDN9vSKXyCIzjd8Kin4E/CknWXtiWLjBTCJUy
         yuAGQ8t2lDSyCZGjdbirLI3I7R43qnfnO4zJbrkLBupv6PIqLVK7mhvONNqHdNJWRFCM
         pWedde+n67Ah3BVOs0Yz2+Lt4WBuku7wiAgv5Av3V5Nyvt9M7BkLdQgswWU64Ufi1NZh
         0mrbqMcOC5CR0m8J95wKCUxwmyD/fQkWWpAyktfR94iFstpor1CbrpWmC18r/QHQZRkN
         wRiQ==
X-Gm-Message-State: ANhLgQ02Iu9CevQgIlonYB6s4Et3/+GGtyEulN/WpTd5YL1AfWTU4U9Q
        FYHOfRF9Tm6aPqhZVmch8SpdjbiM
X-Google-Smtp-Source: ADFU+vuwM6GhJCXNWW00UAPYUmIBYhz8UvQWqaNpkRceKQxYIF03YtJDFwR8BrTwcA+uxXZrks5rSg==
X-Received: by 2002:a2e:7a0d:: with SMTP id v13mr5548221ljc.173.1584717349981;
        Fri, 20 Mar 2020 08:15:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a10sm3460857ljb.23.2020.03.20.08.15.47
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:15:48 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Subject: Serial console and interrupts latency.
Date:   Fri, 20 Mar 2020 18:15:46 +0300
Message-ID: <87k13ff465.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

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
