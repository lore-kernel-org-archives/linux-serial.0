Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F8CC67871
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 01:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiJYBPu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiJYBPW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Oct 2022 21:15:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4569663F27
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:33:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q9so8948932ejd.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SwjrQKeWuL/UTLvlOb5w0Oe0RoidZXir5S4vG79BLUw=;
        b=YZugDW7tObAfGv7/nl7dpBqM1o0NuLh7r/vtflD7JeJ1NM5xmB+ff2CqU4zkDJSYNk
         6JMgIHIw0iVHvEW4jiJj00OGLmvSa6ZQurr+pmhK/mlshehc8TpxfKJ4Jr+zQgQE0wKm
         MICKDbypklPHTCv8GzN6dFChYHG/NDT3w22XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwjrQKeWuL/UTLvlOb5w0Oe0RoidZXir5S4vG79BLUw=;
        b=1SsdwkYzMk5wvzXoY+ZEB64k0ANI+kHx1UitwwDvwH7/GlCEsR9QdS6cwdVNWBXDGE
         gtE+TYEWqg0BnnescYkNUHReP8u9ilLirrs2LIYnswVkfSjfnCiU+wBgMwUd2hI7tzfy
         76ONGc/w82y0HMXiwLMp7f0zFPK+vyaIYzvDlmVno7cPRVCF4kWC0lZXU5HfQnyYlI/N
         1MVlCzliuuN5UIh/X+2ZawjM3vXCXAvvf4swCRAUFD7exjl0P8wsIj5ve1kO8+tWtWV8
         w8iVedoG42eEWOSiEljbsG+HbEMIH+T3RGO8ItAwMDKM+4SRFsGNr+B52L1/aFdCzWE/
         H0sQ==
X-Gm-Message-State: ACrzQf3JPUa+GNfE0GgGUmtcBhliavQ79CvdV9ahbZC9lvFTP8ouWmvc
        WhuOE2dSnJWdovoBJjukjOUGzJby9SftNVuf
X-Google-Smtp-Source: AMsMyM4jIXbgKKLQsLjIKeKfMyNqS8W3sVcYWbWQXhZmzKfvuTtsLdBvUx5JnDx5oIj08DH0tG3YFA==
X-Received: by 2002:a17:907:2d0b:b0:78e:674:6b32 with SMTP id gs11-20020a1709072d0b00b0078e06746b32mr29440251ejc.226.1666658010379;
        Mon, 24 Oct 2022 17:33:30 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id kz5-20020a17090777c500b0077e6be40e4asm536426ejc.175.2022.10.24.17.33.28
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:33:28 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id z14so4957150wrn.7
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:33:28 -0700 (PDT)
X-Received: by 2002:a5d:51cb:0:b0:236:6a62:4bc8 with SMTP id
 n11-20020a5d51cb000000b002366a624bc8mr7153865wrv.583.1666658008254; Mon, 24
 Oct 2022 17:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-22-john.ogness@linutronix.de> <Y1K2JP6LIf8H2Ub5@alley>
In-Reply-To: <Y1K2JP6LIf8H2Ub5@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:33:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VfgdY9qabAzOxu4Rs5UjCRCHMMh=zidX3oq25_tuQD-w@mail.gmail.com>
Message-ID: <CAD=FV=VfgdY9qabAzOxu4Rs5UjCRCHMMh=zidX3oq25_tuQD-w@mail.gmail.com>
Subject: Re: [PATCH printk v2 21/38] serial: kgdboc: use srcu console list iterator
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
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

On Fri, Oct 21, 2022 at 8:09 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2022-10-19 17:01:43, John Ogness wrote:
> > Use srcu console list iteration for safe console list traversal.
> >
> > Note that configure_kgdboc() still requires the console_lock in
> > order to ensure that no console is in its write() callback when
> > its direct() callback is called. Add comments to clarify this.
>
> s/direct()/device()/
>
> Do you know about such requirements or is it just
> a conservative approach, please?
>
> I ask because the comment in the code says "may assume".
>
>
> Anyway, this would deserve a comment why the SRCU list iteration is
> needed even when console_lock() is needed as well.
>
> The reason is that further patches are going to synchronize
> console_list manipulation with another lock and console_lock()
> will be used only to serialize accessing con->write() callbacks.

I had the same concern. I'll note that at the end of the series the
documentation for console_lock() still says:

 * Acquires a lock which guarantees that the caller has
 * exclusive access to the console system.

That seems to imply (at least to me) that if you're holding
console_lock() there's no need to hold the SRCU lock.

-Doug
