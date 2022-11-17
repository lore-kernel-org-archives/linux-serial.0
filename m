Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443D5C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 17 Nov 2022 00:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiKQA7p (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiKQA7m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Nov 2022 19:59:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021676A75D
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t25so1318322ejb.8
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=457d9iQgit+Z1EJB0nqQekgVdEZwOgAEMvvOEWPkupI=;
        b=Bh70kUdShhAGETdykikAQJOKTnFptoZPW3kSYZE+AGERi5jQgkT24kHTMqNAWR10tU
         BuAeJQu/Oi7S5Fcd6875vVxSldt7DeCbJfaCEzyokpntEoPmNCfgg0zYiuf//Cx60LbX
         eL07Ybiq3UPZ7/QNaNsuVClF+LzfF5L0ZCzFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=457d9iQgit+Z1EJB0nqQekgVdEZwOgAEMvvOEWPkupI=;
        b=UG1kYwoMf/f53pvKkPQk8BQ1ro7xUBE3v7xL7RagCMpEG3QPm1CRtdmesjt0BReRfG
         bN2hzxBjRlGZbwBdzibmE9NnAtmNmPvJP9iamCD3gHQ3Rlfuv6zLfaVL8AAfEgsU+6e9
         hsKYGVhiI1IOehk631/VWv3uT9Hats/1jdsJ/4vJhs1YTcxDOcKgUUAPyl8h1fl+GmT4
         hNP+cEJH02dBhx/kpdon4kd/V9tOyXwix6eGPSAWqXgSaUMnnNeX+bQhjZfmNJuBBbTX
         mHzWfefoA+CvGTis596DXe1PAxFjIa3FpbwyINSvGk8R/gYFSLAc0JmixywVnwkxv81i
         emnA==
X-Gm-Message-State: ANoB5pkRrxNpPg441yM/9dx+YH/nUYddF9UlVbkxPic6jdKfUWFxMlJo
        eyfUYFxm5W3JpS0ERTHTBBzw6p+Pwpw4EulV
X-Google-Smtp-Source: AA0mqf7UL6lPhkiFFpVtwxBT2Hff0fMJq9wG1E60CwRlkBi5W8mUfGg2RaxzDjL05GMj+1NoMHEMDg==
X-Received: by 2002:a17:906:348b:b0:78d:9e04:d8c2 with SMTP id g11-20020a170906348b00b0078d9e04d8c2mr244128ejb.614.1668646779634;
        Wed, 16 Nov 2022 16:59:39 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00779cde476e4sm7446580ejc.62.2022.11.16.16.59.35
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:59:36 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5so146994wmo.1
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:35 -0800 (PST)
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id
 ay18-20020a05600c1e1200b003cf9ad3a20emr110075wmb.151.1668646775488; Wed, 16
 Nov 2022 16:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-37-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-37-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:59:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XhkmOLXnfc0YQyUN-FvNeoF1+=zvp56ttaYvsoKESMdA@mail.gmail.com>
Message-ID: <CAD=FV=XhkmOLXnfc0YQyUN-FvNeoF1+=zvp56ttaYvsoKESMdA@mail.gmail.com>
Subject: Re: [PATCH printk v5 36/40] tty: serial: kgdboc: use
 console_list_lock for list traversal
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 8:22 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> configure_kgdboc() uses the console_lock for console list iteration. Use
> the console_list_lock instead because list synchronization responsibility
> will be removed from the console_lock in a later change.
>
> The SRCU iterator could have been used here, but a later change will
> relocate the locking of the console_list_lock to also provide
> synchronization against register_console().
>
> Note, the console_lock is still needed to serialize the device()
> callback with other console operations.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
