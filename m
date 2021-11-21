Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EEAC433F5
	for <linux-serial@archiver.kernel.org>; Sun, 21 Nov 2021 10:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhKUKUM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Nov 2021 05:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhKUKUM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Nov 2021 05:20:12 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5436C061574;
        Sun, 21 Nov 2021 02:17:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so63545501edd.0;
        Sun, 21 Nov 2021 02:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2zLchppySdpE8EpBae61HxqhoEyd6PsW/aQFno/ElQ=;
        b=M/2JiZsLVl+92XkV2xqsXEUFr0YX2c6steGdmuTwoyAMq01+2TMb+W9Ry1u85xRgKg
         BiDuaBT+pkJ4ptyJubYohqy3WVW7QOZiFLRM1e9YQbvUVY7r3VBQLUwPyPsumFLE4nBu
         ufUOzVqasjkFIs89/sLBqHotTH0hSCD1xIUaIGTRBsNBAcS7iinKZSB78PSEGz5gtON6
         wfbxlgj5fHJwPNR/DWNn2Gz1hyblfA9+BCZV+IDSkgbWSX3BZYkr2vdBhrA2lnswstyw
         9HcUmJajn6D7gdM1H4NRlMiR/0B6uTkvFAxY4hgn2HINGsUHVMvmEzki61v69/g0yhxH
         ksrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2zLchppySdpE8EpBae61HxqhoEyd6PsW/aQFno/ElQ=;
        b=ejCwokBd6GBEsKsqMExDZtRdLpMTBSlP/WhBCIFLvoqBPFY2Mrp9lkqoHRTY80rIBI
         IevpsgWBXEZwxPtArGfTH+g+xcfTIdFJhUpH1NcyxY1EcpVIcBUZ6noL7ywFYPnU8T2p
         QWO4GqXoTgJ5Di+rBKzADXMSJ7lyet1jhOmnX2SXkB84YjTPsAbW+kPXWbQoFJSHFZrE
         nbJcX6ymSd9ebXvYQAcyUnhHYqJ24exgPwKavLLKCuPuloIafO/9Rd0SaBdSnMmuW59+
         WASrpa0VI3Z+Qu0K10qdIkq9UrcS9Je/kExZ6yibo8eH48htKSzFrwbRVOwGQm4Vdy++
         fXNQ==
X-Gm-Message-State: AOAM531sobXC7arPTZxOZkubt+euF4CEjW7mc4BFqcQBpqQytLXV6VWQ
        e+ToeJFwtWUARY1CWHLICaYPDYSNaqg/1LkalHEFqpUEIyL+Qw==
X-Google-Smtp-Source: ABdhPJxFf6CY6MHmth0JsOkte32L09pdwXMxzhCCXVga143+2rfG+/xmmmEvpCTKDrzcCLOPi2JpTHJl+7CQ9s34+KU=
X-Received: by 2002:a05:6402:26d4:: with SMTP id x20mr49236068edd.119.1637489826225;
 Sun, 21 Nov 2021 02:17:06 -0800 (PST)
MIME-Version: 1.0
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com> <YZdfAdOcH2Bn1K+W@smile.fi.intel.com>
 <633bbad1-7b13-7299-a570-2bf1a87c47a5@accesio.com> <7e83c01f-1aa4-56ef-e28f-9e7421864183@accesio.com>
In-Reply-To: <7e83c01f-1aa4-56ef-e28f-9e7421864183@accesio.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 21 Nov 2021 12:16:29 +0200
Message-ID: <CAHp75VedLLiB=Ujrymq9F1=SG2NRCeempUwqSbX9KHu1ND4x5g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Nov 20, 2021 at 11:46 PM Jay Dolan <jay.dolan@accesio.com> wrote:
> On 11/19/21 6:33 AM, Jay Dolan wrote:
> > On 11/19/21 12:23 AM, Andy Shevchenko wrote:
> >> On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
> >>> On 11/17/21 6:57 AM, Andy Shevchenko wrote:

> >>>> Split Pericom driver to a separate module.
> >>>> While at it, re-enable high baud rates.
> >>>>
> >>>> Jay, can you, please, test this on as many hardware as you have?
> >>>>
> >>>> The series depends on the fix-series:
> >>>> https://lore.kernel.org/linux-serial/20211117145502.43645-1-andriy.shevchenko@linux.intel.com/T/#u
> >>
> >>> I have my current state here:
> >>> https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c
> >>>
> >>>
> >>> * Change port type to UPIO_PORT
> >>> * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
> >>> stick.
> >>
> >> Thanks, I have updated my local tree with these changes.
> >>
> >>> When I'm testing baud rates greater than baud_base I'm seeing strange
> >>> things
> >>> on the scope.
> >>
> >> Can you confirm that there are no issues with the first (fixes) series?
> > Yes. The fixes series has no issues, and was tested up to baud_base for
> > both 14 and 24 MHz crystals.
> >> I have slightly changed your set_divisor() refactoring, it may be that
> >> issue
> >> is there.
> >>
> >>> Maybe I'm just tired, and it's human error. I should be able
> >>> to get back to it and get it done on Saturday.
> >>
> >> Thank you.
>
> Latest code is still here
> https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c
>
> Changes from last update:
> * Avoid divide by zero when initializing delta

Thanks for digging into it. But doesn't it mean that the issue is in
the fix series as I assumed before?

> I retested and verified on the scope that speeds are now being set
> correctly.
>
> I have also confirmed that all of the ACCES four port cards in the
> driver do have the offset fourth port. The item I raised about PCI was a
> misunderstanding that was all on my end.

Good to know that is not relevant.

> Are there any other action items I should be handling?

I think I have to issue two new iterations of each series and collect
your formal Tested-by on the second one.

-- 
With Best Regards,
Andy Shevchenko
