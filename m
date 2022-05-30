Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB064C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 16:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiE3QXt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiE3QXr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 12:23:47 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008F46EC61;
        Mon, 30 May 2022 09:23:45 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ff90e0937aso114802037b3.4;
        Mon, 30 May 2022 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=46VWBOlr2Q10J4uNUqOsDzjv71tB9nOR1aoShrrJj8s=;
        b=nlDWdy0+JaFCCiuSIOpaGeqEdor2THCNTBsbFPbf9JXiXmkKQe3b04tEM1EJOJxTRQ
         pDc1VKCy2Kbna1ERFcqUqrGJyyeQyBu20dhuTsOsPbersNCsrA6k3s1TaYrb7FWVru0m
         Mz0VR8KHR03wiDr7p+Lv86M7vK48dQza/Ar91KfKzu2E8GjQWHtVcTxANeP8MlKGUGPO
         l5lkM80nEWf69C+OkMpf3JxhR9pJHb/F1wazE4WNFptNOodYMQnpRILrxIiay2mJA549
         S4sAmU1RSPl+QOInyWXxG4+18l8W2b1gBfXZ12rpNlzwmcgw43/Kq1/2Vu9BXMItdVPu
         8nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=46VWBOlr2Q10J4uNUqOsDzjv71tB9nOR1aoShrrJj8s=;
        b=l5OWuvqhLYOBic/RoBXWqSQedfmh8EycR+Ft4hLUTpjbX3TEEpVL5UtOnk34UkDRYN
         51Vdb5QI9QEfZYrQYtHb8pNXHMKp8AuFZCB//Q2gBXJEyONp5Wu5qr3ee18GJC2ImEUF
         KCNEuXhvubl3SmM9dXfh7+WSOqoY3BsZOAOki7inlFHMel08fMyVLISu0fM4T6yFw8Jt
         ntUWLasydm+KvRGVmszibZpjh25ZymqHF+v0m0ub7g4+a+YT2rfXfGK518aiNhm9LiRg
         6GbQOExjdt2yuMkBcxu4vq8uLFnQTy4Hs+eIko1ypLqxkbc3Iuk6LsSUTwE3PZYvIZwp
         qjcg==
X-Gm-Message-State: AOAM5338COd3j5OD1g+9sPELSiZuhT36cnkQVWpWJv+6T25d8rLcaY+L
        dfjH2wkanCdlElYxZdd+ijui47alFWGA4p6jj8s=
X-Google-Smtp-Source: ABdhPJyBWZGb6qcnhQo0AdDGYSN+rv+xHTzIU1WYuoAMkg6AwUlUA2xV2ay5hlfUeZWZQbV+FX+Jd3GqM4T5+gZieew=
X-Received: by 2002:a81:99c6:0:b0:300:5ac0:3295 with SMTP id
 q189-20020a8199c6000000b003005ac03295mr28647428ywg.14.1653927825222; Mon, 30
 May 2022 09:23:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7aa7:0:0:0:0 with HTTP; Mon, 30 May 2022 09:23:44
 -0700 (PDT)
In-Reply-To: <CAHp75VeQzY+Pfru4LSgv+fqya-2F7G21TjaVsybCqQBSD8NeUw@mail.gmail.com>
References: <20220527222709.1AC8837401F1@freecalypso.org> <CAHp75VeQzY+Pfru4LSgv+fqya-2F7G21TjaVsybCqQBSD8NeUw@mail.gmail.com>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Mon, 30 May 2022 08:23:44 -0800
Message-ID: <CA+uuBqbP8BkXCgVn9vmTb-3PoCtp1NS1eLKq2T49jwM6_=DH4A@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: add port flag to suppress raising DTR & RTS on open
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Andy Shevchenko wrote:

> Which version of POSIX and SUS standards are in consideration?

I admit my ignorance - but I've always been told that the behaviour
of always unconditionally asserting both DTR & RTS on serial port open
is mandated by both POSIX and SUS, which is why all Unix-style OSes
have been following this behaviour up until 2021-04, when FreeBSD 13.0
became the world's first Unix-style OS to provide an *option* for
users to opt out (on a per-serial-device basis) of this standards-
mandated behaviour.

> Is it only the USB class of devices that are affected or do we have
> examples on other buses?

In my own use case, it is only USB: my hw device is one where a
USB-serial chip (FT2232D in my case) and the circuit that repurposes
DTR & RTS outputs from one of the UARTs (FT2232D Channel B in my case)
are inseparably integrated on the same PCB, with a custom USB VID:PID
identifying the device as a whole.  However, I have been told that in
order to be acceptable into Linux mainline, the proposed solution has
to work for all similarly affected parties and not just my device,
hence I am also considering a "generic" case where a custom hw device
would have an old-fashioned RS-232 electrical interface and could be
connected to "any" serial port.

> Logically I would put them otherwise, first to check a custom flag and
> then the existence of the callback.

I can make this change in the next version of my patch series, once I
get a clarification from Greg as to the correct way to denote the
chain of authorship and revision.

M~
