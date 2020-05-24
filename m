Return-Path: <SRS0=aY4b=7G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF205C433E0
	for <linux-serial@archiver.kernel.org>; Sun, 24 May 2020 10:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A9F207D8
	for <linux-serial@archiver.kernel.org>; Sun, 24 May 2020 10:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YhvL8fVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgEXKBe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 24 May 2020 06:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387416AbgEXKBd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 May 2020 06:01:33 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D1C061A0E
        for <linux-serial@vger.kernel.org>; Sun, 24 May 2020 03:01:32 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id o24so13685137oic.0
        for <linux-serial@vger.kernel.org>; Sun, 24 May 2020 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTajmnohfywFupxs957CWHHjqHcvTI6e5RfNGOZbkGc=;
        b=YhvL8fVdrbh3XfLrAXLRTb2lrsFdJKPZBC6VFogb/a+IDT4r6kXTNEpClNwyN8xzoX
         PovzcKVQCCTTp5jpI9t388nRIm2CpbShnPhMKTsl833/Zg4Q1qitewLWEkU2FdyShT0z
         QvgtbKq2j46QJSYyUHZ80XmbHJUMjmUBIqLlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTajmnohfywFupxs957CWHHjqHcvTI6e5RfNGOZbkGc=;
        b=R4nmgImufp9vutnV/unMml6I5e3s+y2p9XjaxrnOpbzvNHQ9g4opLOd19wJs59bspO
         jDpgnvBxl/IBCtlVztpOzQ0N4SGxuBH2TeIf3Te9Bk9pgGLWZksQ4lfE4zbx8GMlmUSi
         DNt6O/SD21iSqCrQhUr5OUXVWgmAV8BgdTev1yRu4GT6Ev/PcOLR+fIsawkahYNqCBdM
         MfvEl9Ljoy3Hcs9f4OOfP5+AyXHIrvLG4zpXVFQ4O7UNjyLnbDaD9iDzGLVRaIX08Fhd
         bZY9+V1qwiu0F3La6ACxGMBFjQjvIGFlCpNZe1Zj5Rmg/ndAjBdKXY8EtJjpmL7lkKoA
         1qWQ==
X-Gm-Message-State: AOAM530Xyy01ELXf3W4GmTj3IqkF/6To58iqCZr1tU+m4Mp9LU/6QvKK
        IuaQby+AsReZh2RkhajV9nSpiCTOgocQ4bDAvklP+Q==
X-Google-Smtp-Source: ABdhPJyYQjQntruCcmBuzCOoJjVws8Uf/VrPmrDFHKD1uZxz3ratl/o/oUQNoQUQQuBO/mmCLqEaCqSuIRxVr4LZk2s=
X-Received: by 2002:aca:4b91:: with SMTP id y139mr7314961oia.128.1590314491735;
 Sun, 24 May 2020 03:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
 <20200430161438.17640-2-alpernebiyasak@gmail.com> <20200513053529.GL413@jagdpanzerIV.localdomain>
In-Reply-To: <20200513053529.GL413@jagdpanzerIV.localdomain>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sun, 24 May 2020 12:01:20 +0200
Message-ID: <CAKMK7uHO43-O+bPkJMhuv5HNh-PS7+wm6==n-7VQfRu2zq8xvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] printk: Add function to set console to
 preferred console's driver
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 13, 2020 at 7:35 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (20/04/30 19:14), Alper Nebi Yasak wrote:
> [..]
> > +int update_console_to_preferred(void)
> > +{
> > +     struct console_cmdline *c = NULL;
> > +     struct console *con = NULL;
> > +     struct console *tmp = NULL;
> > +
> > +     if (preferred_console >= 0)
> > +             c = &console_cmdline[preferred_console];
> > +
> > +     if (!c || !c->name[0])
> > +             return 0;
> > +
> > +     for_each_console(con) {
> > +             if (!con->next || !(con->next->flags & CON_ENABLED))
> > +                     continue;
> > +             if (strcmp(c->name, con->next->name) != 0)
> > +                     continue;
>
> This matches the consoles by exact name. Consoles can have aliases,
> but matching by alias is rather complex and it has some side effects.
>
> Let me Cc more people on this. VT has a console takeover logic,
> I wonder if we can extend the takeover code somehow.
>
> Daniel, any thoughts?

Apologies for late reply, but nope, no thoughts. I have some ideas for
the locking in the console subsystem, but that's just to untangle it
from gpu drivers as much as possible. Otherwise I'm trying to stay
away from it as far as I can :-)

Cheers, Daniel

>
> https://lore.kernel.org/lkml/20200430161438.17640-1-alpernebiyasak@gmail.com
>
>         -ss



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
