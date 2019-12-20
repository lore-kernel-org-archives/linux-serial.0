Return-Path: <SRS0=hqmf=2K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C279C2D0D2
	for <linux-serial@archiver.kernel.org>; Fri, 20 Dec 2019 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4511B2082E
	for <linux-serial@archiver.kernel.org>; Fri, 20 Dec 2019 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576865308;
	bh=+XL7ZInXX1HHmOCI5izumvXTe4GPIdZh/XmifK4Czh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OPLXxlnEBVXFInb3dheQURJDTczElywDCA1v4ffEsvcKbqSaNSqfElp1/iYKD2jnu
	 e2rqOH7B2aRy0cCo4IidrkK9yyaQpSDGOL44GI7hjTkKtHs4rVP9FjcTz0UANJUDom
	 xhXjp/6ndzHiUUCnlo7CF8wDYJa3dOX1nkvw4OtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTSI1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:08:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39866 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfLTSIY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Dec 2019 13:08:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so7702116lfb.6
        for <linux-serial@vger.kernel.org>; Fri, 20 Dec 2019 10:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXVFal7Vfx9p/0v6Lfo4AszqTDh48OL14YxtwAoozRw=;
        b=S8tRDL7EKj2cfmNGSzq9/Y7J88woUCjBT1gnU/MsJm+oNAd2FtQMXWc8JR9T4yMk6Z
         W/xJKyur9rwEu0sOZYuzVaJXfvy7UqJxeCkSdc9eWrH/bJ+gd7vrM+qCYygBZmCZWcfC
         QiCG2fO9+1AooB6euumc03SFYpbbHQeUB6w1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXVFal7Vfx9p/0v6Lfo4AszqTDh48OL14YxtwAoozRw=;
        b=krvCXmViAnX95wmM3EIdnJqRLHO0aeoAC0n6/eJpcl1brzUYl40KVj9qanFCugH6+T
         QH3nxdgRV3mv/a2Pee5ATTYWYmjDGLySZ+pTdHbZwE7s+L4jKGeFSiVuv6j+yNepQ/uO
         IlR8JMUEWoF8NtGV+kp8YX0ApdOi/17Z0SSrvMKMsvi4qHT1hU84fLwIcxTBprkUyggl
         kbm4aY96mrD9FLByQ9PR3feEPBWs6sk+jayCVjnTv+0S/QSraryxBpNu5OA23dEww386
         ts5GZ7BY1gW6dbTRcsmD+C9hR2r13DyN+v+GQzYxxGLueBBBSCvj3OMKPRy8v1rGT5VM
         CxFQ==
X-Gm-Message-State: APjAAAWC2eWgIKbSQoNzD0MZl3bKxk+sr3fCRlpoZLafTxaT9AH+LBlC
        aVISeAtiHzxq5Qad7FeCQERq8tUj2Oo=
X-Google-Smtp-Source: APXvYqyJ0jBb30dBUCVeLiol0p8IjFHpG5whRjqaqQxbvrpihV69zNxkuXrXTuheAApb9HMC/uaw0Q==
X-Received: by 2002:a19:be93:: with SMTP id o141mr10372628lff.181.1576865300956;
        Fri, 20 Dec 2019 10:08:20 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h81sm4366379lfd.83.2019.12.20.10.08.19
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:08:19 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id a13so10890506ljm.10
        for <linux-serial@vger.kernel.org>; Fri, 20 Dec 2019 10:08:19 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr10813815ljn.48.1576865299304;
 Fri, 20 Dec 2019 10:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20191220070747.GA2190169@kroah.com>
In-Reply-To: <20191220070747.GA2190169@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Dec 2019 10:08:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
Message-ID: <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc3
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 19, 2019 at 11:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> The last tty core fix should resolve a long-standing bug with a race
> at port creation time that some people would see, and Sudip finally
> tracked down.

Hmm, looks good. But it makes me wonder if we should now try to remove
the second call to tty_port_link_device()?

Now we have a number of helpers that do that tty_port_link_device()
call for the driver (eg tty_port_register_device_attr_serdev(),
tty_port_register_device_attr(), and the just added
uart_add_one_port()).

But we also have drivers doing it by hand, and presumably we now have
drivers that do it through multiple paths? I guess it's harmless, but
it feels a bit odd. No?

            Linus
