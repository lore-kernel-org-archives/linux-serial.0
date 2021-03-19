Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9812FC433DB
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 10:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A2E64F42
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 10:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCSKKB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCSKJu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 06:09:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DF5C06174A;
        Fri, 19 Mar 2021 03:09:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n11so3342720pgm.12;
        Fri, 19 Mar 2021 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7eEFmk9MSK3QRwRt7VI4+hJ+cCCmRn4xXTpfKaNrLNU=;
        b=Vea1pmxxDjGZcOstSTMUz1HhtMaMOnNUsKKB49S2Bo5pub6A0ZqtiRhOCYuC3qhBFB
         cCzATfNAq9F3q0TRKv4NqEI4nsdh5pCzXbkzTi9eYm0tHGKcZm7eC4vnxuZTBITPpijF
         z06XClibv2jntDrNBi8JjA0XUUGGTWR70bKxDiNU2p7if737OeNwEaCgU8q+2m1ASex6
         jsYuGmudSMc/ZHw2ApaR1ktsJl+kFNftbuUKnRJgQ9LoJ9OZdvsFHnzxmidrhmQ3xNCA
         oLelXoNI66VDDDySzeiALvriQ00qpbKSXDa8H3TMSa4MmBZG91n05LDCVlib47hDTCCv
         IHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7eEFmk9MSK3QRwRt7VI4+hJ+cCCmRn4xXTpfKaNrLNU=;
        b=g4XazUk040WvpaaYXRyCde5wz0D4DMDE8tsFZuCFmtT3uG4fuIX3qrNl0Lfx1oKSbJ
         nTYnJGcRJkOs+m0Si0j/cySO/CdivirZkPx5AJ+uDmHhYPfzcthyiPXbusb5LC/BvWuK
         ZQ5bJFf2B4xKUj0sBQCq0MvjMn+4lilSrC+Yxj0Bj1uxFwelYB40cL1Tsdhb/EgtGjg1
         TRAaMUfErPtuRhJB6g7aTbWwQdQ/w7PR8ECxhT/0FheEo5awNqoc5tCWNVlgtUH+EerC
         L3XSukFRzW/N9ljYifrYmEyiCN/CQ1ejLmP2BTu3Cpfytgr3WA/onhYqEpLTVyeM2t5+
         W5FA==
X-Gm-Message-State: AOAM533g50qaTVbnx7RSL6DF8kBUJIKC8T7n11XcgHzZEqRhj7RQPiw6
        WWVZrt5TseKEdwpRqPuRIzx9kWqV8C+gwP/GZ1s=
X-Google-Smtp-Source: ABdhPJwR7y4VE7GZgNbQ8KNJelhtQMIiMJ+SrEb906R5xLTAORIST/gPb0UA+qNUGutiLvFigCXohX5CWxJwqkRegNU=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr10555184pgq.203.1616148590170;
 Fri, 19 Mar 2021 03:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
 <YFB0OcBg3Vj555eA@hovoldconsulting.com> <CAHp75VfcbC63t_eZeBOA0NY28BtGBD0YyLR6nSNuKAnKhXTSzA@mail.gmail.com>
 <4771468d968a44789518bc547acf5f93@hisilicon.com> <YFRcYCMQrPXUG6ZU@hovoldconsulting.com>
In-Reply-To: <YFRcYCMQrPXUG6ZU@hovoldconsulting.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 12:09:34 +0200
Message-ID: <CAHp75VfAEj1X9-aOUxFYW52F2FeTxetPHA0KenAjCB49KXbx3A@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
To:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?B?RGXDoWssIEltcmU=?= <imre.deak@gmail.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 19, 2021 at 10:09 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Mar 19, 2021 at 06:36:39AM +0000, Song Bao Hua (Barry Song) wrote=
:
> >
> >
> > > -----Original Message-----
> > > From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> > > Sent: Tuesday, March 16, 2021 10:41 PM
> > > To: Johan Hovold <johan@kernel.org>; Finn Thain <fthain@telegraphics.=
com.au>;
> > > Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Greg
> > > Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@ker=
nel.org>;
> > > linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>; Linux =
Samsung
> > > SOC <linux-samsung-soc@vger.kernel.org>; open list:SERIAL DRIVERS
> > > <linux-serial@vger.kernel.org>; Linux Kernel Mailing List
> > > <linux-kernel@vger.kernel.org>; Hector Martin <marcan@marcan.st>; Arn=
d
> > > Bergmann <arnd@kernel.org>
> > > Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags =
in
> > > interrupt handlers
> > >
> > > On Tue, Mar 16, 2021 at 11:02 AM Johan Hovold <johan@kernel.org> wrot=
e:
> > > >
> > > > On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote=
:
> > > > > Since interrupt handler is called with disabled local interrupts,=
 there
> > > > > is no need to use the spinlock primitives disabling interrupts as=
 well.
> > > >
> > > > This isn't generally true due to "threadirqs" and that can lead to
> > > > deadlocks if the console code is called from hard irq context.
> > > >
> > > > Now, this is *not* the case for this particular driver since it doe=
sn't
> > > > even bother to take the port lock in console_write(). That should
> > > > probably be fixed instead.
> > > >
> > > > See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.
> > >
> > > Finn, Barry, something to check I think?
> >
> > My understanding is that spin_lock_irqsave can't protect the context
> > the console_write() is called in hardirq for threaded_irq case mainly
> > for preempt-rt scenarios as spin_lock_irqsave doesn't disable irq in
> > that case at all.
>
> Forced threaded interrupts have so far run with interrupts enabled and
> spin_lock_irqsave() would suffice on non-RT. This is about to change
> though so that drivers don't need to worry about "threadirqs":
>
>         https://lore.kernel.org/r/20210317143859.513307808@linutronix.de
>
> > See:
> > https://www.kernel.org/doc/html/latest/locking/locktypes.html
> > spinlock_t and PREEMPT_RT
> > On a PREEMPT_RT kernel spinlock_t is mapped to a separate implementatio=
n
> > based on rt_mutex which changes the semantics:
> > Preemption is not disabled.
> > The hard interrupt related suffixes for spin_lock / spin_unlock operati=
ons
> > (_irq, _irqsave / _irqrestore) do not affect the CPU=E2=80=99s interrup=
t disabled
> > state.
> >
> > So if console_write() can interrupt our code in hardirq, we should
> > move to raw_spin_lock_irqsave for this driver.
>
> No, no. RT handles this by deferring console writes apparently.
>
> > I think it is almost always wrong to call spin_lock_irqsave in hardirq.
>
> Again, no. It's even been a requirement due to "threadirqs" in some
> cases (e.g. hrtimers) up until now (or rather until the above patch is
> in mainline).

By the way, a good question Imre (Cc'ed) and I have discussed is the
in-kernel documentation, i.e.
https://www.kernel.org/doc/html/latest/kernel-hacking/locking.html.
Should it be adjusted to reality?

--=20
With Best Regards,
Andy Shevchenko
