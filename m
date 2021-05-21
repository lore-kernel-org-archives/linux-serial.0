Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9030C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C2961175
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhEULQ6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhEULQ6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 07:16:58 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B8C061574;
        Fri, 21 May 2021 04:15:33 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h9so19352737oih.4;
        Fri, 21 May 2021 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fF9cIbv0XdEChYVnnZY9YghC2MQwePrRjdawL10glgw=;
        b=NB+K+bgtxnXkCQh6yXA+8mHsA2jFJsgLRgtRs6B7tlWXKGEgl2rHdi/q+OmWfigQ21
         CFU1p0/bJ6VHXtvtUWE/IFgq3SbNR8fnVa1hZnRLyAYo3lzkM20Ir1KbQ9Jr0V7PBBXL
         bPGY7bxE/bkj9A4ok3UdoEXNWB/+DkxK7QKHpazik9fVCE7TvLyjBUvfPUQT3xruqzJB
         cEz6hCUqSzt1jNyg/kgGDHsWrKn+qVOYdORXefaytw/zUdYAbNh4sb0A1bIHVvnV1DTa
         FOLcxVwz5dfK3VLmrIgOXoYJf5KeWxzfzAlqCT3aSGMEtD+3BAQVsMUa+ZF2XrrmYn2h
         l7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fF9cIbv0XdEChYVnnZY9YghC2MQwePrRjdawL10glgw=;
        b=qIpeBtp5dIcHmOTf2qeX8NCiysHhj6puk+/A86nhIhUdjo3fkhJ0d5M6kcQ9UylJa5
         LLGloeeb4CiU47Lyv+GFfYsAn+mSFDdkD3wSkECwdfohmWqKZ/JN3/Bm2LQRcsKdsvOV
         JpuJbU3IhgqHRFT6C8TySN/j28hEmvh1xj3rNHkqMbmcTRUvctRN7nvm0aKlJwVLr577
         neZnObEDVXzXcBHdp8ceBrlWSpoyfaNzgfVyDIY8rFc0L9IiginvBlIY0APlhJ2gnNwG
         L1jPsyYx7PlNlnhJZJ50ymNQoKQCx38UR9tkhdfTtdEd8cSL4M5FGuvDu7ms34ik51Lq
         1AOg==
X-Gm-Message-State: AOAM533K0PkbR/uLj1GC+x5YYdzg/0pqgS2c93Ta8SJa0Z+CPRUmhhNr
        kADoZoit2ov2G+xyjXuzRxx7oGpQKgi5+nOg+6rvXdbVOJwsl5U=
X-Google-Smtp-Source: ABdhPJzcE3nuvX+HfI8wMyL9k3Bfzzu7uyOzU124rppj95sBqX+4MdcjdCs4RtgItYWMYxd7JIO2ErgZ4MkC9+lFiDk=
X-Received: by 2002:a54:4f91:: with SMTP id g17mr1797744oiy.15.1621595733354;
 Fri, 21 May 2021 04:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <1621577323-1541-1-git-send-email-zheyuma97@gmail.com> <YKdYZF8zDGl0hxeX@kroah.com>
In-Reply-To: <YKdYZF8zDGl0hxeX@kroah.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 21 May 2021 19:15:21 +0800
Message-ID: <CAMhUBjkeXn=Yf+dsdKo5_H1Tko3Qhfr+y=9b47XtHA04k2smXg@mail.gmail.com>
Subject: Re: [PATCH v2] serial: rp2: use 'request_firmware' instead of 'request_firmware_nowait'
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cernekee@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 21, 2021 at 2:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 21, 2021 at 06:08:43AM +0000, Zheyu Ma wrote:
> > In 'rp2_probe', the driver registers 'rp2_uart_interrupt' then calls
> > 'rp2_fw_cb' through 'request_firmware_nowait'. In 'rp2_fw_cb', if the
> > firmware don't exists, function just return without initializing ports
> > of 'rp2_card'. But now the interrupt handler function has been
> > registered, and when an interrupt comes, 'rp2_uart_interrupt' may access
> > those ports then causing NULL pointer dereference or other bugs.
> >
> > Because the driver does some initialization work in 'rp2_fw_cb', in
> > order to make the driver ready to handle interrupts, 'request_firmware'
> > should be used instead of asynchronous 'request_firmware_nowait'.
>
> You just now slowed down the probe function.  Are you _sure_ this is ok?

Sorry, I'm not an expert in the field, but from my point of view, the
previous function 'rp2_fw_cb' does some initialization work that is
not suitable for asynchronous execution. Because after these initial
work, the driver can work normally (including preparing to handle
interrupts).

> Do you have this hardware to test this?  If so, what is the init time
> before and after this change?

To be honest, I don't have real hardware, I tested it with QEMU. I
made a total of 5 attempts. Before this change, the average boot time
required by kernel is 6.382s, the time required for insmoding this
module is 0.139s; After this change, the average boot time required by
kernel is 6.426s, the time required for insmoding this module is
0.160s. This change really slowed down the probe function.

Thank you for your patient comments.

Zheyu Ma
