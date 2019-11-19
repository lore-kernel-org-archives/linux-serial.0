Return-Path: <SRS0=/Db/=ZL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37337C432C0
	for <linux-serial@archiver.kernel.org>; Tue, 19 Nov 2019 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7A6208A1
	for <linux-serial@archiver.kernel.org>; Tue, 19 Nov 2019 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L6FBVkXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSSqe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:46:34 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38989 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSSqe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Nov 2019 13:46:34 -0500
Received: by mail-il1-f193.google.com with SMTP id a7so20647401ild.6
        for <linux-serial@vger.kernel.org>; Tue, 19 Nov 2019 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZdR1c5xAjrcpt6k2LBUSqAjpQzIBxubylJThYRgFBE=;
        b=L6FBVkXkS9Lg0FONzzG9hSkFSxQa9J7lBbUZRc/EXQE7pE8kE9txR3N4Lgs7mEXZ0Y
         6nRS0VxRkuKqfauh+0CTEEcMam80kvujQvhaM1IeIlyXOJXxt73QSEtZzeiHfnD4Alfv
         hrz5pRd+VZWXCTUta1KrJhk55M6r90yG4PuO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZdR1c5xAjrcpt6k2LBUSqAjpQzIBxubylJThYRgFBE=;
        b=RDq8Fyba0WRyKEKeTclIq+ZVR7RH50hdN6w9Wmxx5p6J4i6avJ7DvWqSu48Hy/anCx
         3dxEzjSU7UmFJIX/ktRBvEn6droaN0EohZ/8NCUm0uLmxcdj5y/E1j8Uzr78pkGWZXUh
         Bb8CTs500VaCcjUQRGHfAGdQopgDGJxO+Uq2Sqr4VuoQVe2Q90kDmj8w75MmffZTFgT6
         hinPIQT+llhfA+JASXSfTTITZYGawii18+jEsv3H3cz7amwmrIzlwPnogNqqPUhHQlm1
         qhs1J+i5hnWKpaX7GAz4EbESZgoMGWJpaRjepP0GO8fW4rHciTrtF1blM5T1epBN7mL7
         Rsiw==
X-Gm-Message-State: APjAAAVwXigtVuxxJXhyrebDtQIrnAy70hqkUfly2tGKEmy5edlA3UUz
        xyr5GftET1OhnYptXmvsdTgtWaYsyJbG5xqNFiEj1g==
X-Google-Smtp-Source: APXvYqxpaPhEUPZcyFWL1XfVoSnMpdSgE+bUUgNdJlcna13niZEPrPAFCpe8qysRTit/EvetJ+W1TmkHxSIVbOcVkoI=
X-Received: by 2002:a92:5fc2:: with SMTP id i63mr22116131ill.218.1574189193304;
 Tue, 19 Nov 2019 10:46:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
 <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz> <20191115043356.GA220831@google.com>
 <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com> <20191119003457.GA208047@google.com>
In-Reply-To: <20191119003457.GA208047@google.com>
From:   Jonathan Richardson <jonathan.richardson@broadcom.com>
Date:   Tue, 19 Nov 2019 10:46:22 -0800
Message-ID: <CAHrpVsV2Y4ZNRSJ58J0f_E0=aC8VfwvO56mfcdkXxCsJbAF3qA@mail.gmail.com>
Subject: Re: console output duplicated when registering additional consoles
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, sergey.senozhatsky@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > Thanks. It also needs to be cleared when the second console driver is
> > registered (of the same type, boot or normal)
>
> The second 'normal' console can be, for instance, netcon - it's sort
> of OK to have CON_PRINTBUFFER tty and CON_PRINTBUFFER netcon consoles.

OK I missed that case.

>
> Maybe
>
> > not just when a normal con replaces a bootconsole. A simple way of
> > avoiding the problem I'm seeing is to not even set the CON_PRINTBUFFER
> > flag on my consoles.
>
> This is up to the console driver to decide.
>
> > It skips the replay and the output on all consoles looks fine. The flag
> > is only used by register_console(), although I don't think that is the
> > intended usage? There are no console drivers that do this.
>
> Not sure I'm following. There are consoles that want all logbuf messages
> once those consoles are available.

I meant mine would be the only driver that didn't set CON_PRINTBUFFER.
Thanks for clarifying why it would be set. I guess what I didn't
understand is why are all the consoles updated (potentially) when a
new console is registered. As I mentioned before I can not set
CON_PRINTBUFFER to avoid the issue but it's probably not what I want.
I would possibly lose some of the log I guess if there was something
in the buffer during registration of the new console. So I tried the
patch but the issue remains as I originally described.

Thanks,
Jon
