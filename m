Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80EBC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C5C65011
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhCPJli (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhCPJlO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Mar 2021 05:41:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933FAC06174A;
        Tue, 16 Mar 2021 02:41:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ha17so9559614pjb.2;
        Tue, 16 Mar 2021 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWsgzNHBmSFzmgfMUIgNEjy4VDqIaNU2SVRo/jg0d5k=;
        b=FUjMUNH2UJER+BIC1s/zqmXPyt9FdzWbApAZEYZ2loBl6y4Fm52FF8XKIIAi1nOVXL
         Ctd3YhmifwqQXKW0k9lpxITsPuPeTFFTcmoQqQnvzDFQhVwkMBrf+DZPAdk5Zd5+TIIv
         wgVGKG2Gd05O6afK2zt+GHrTmr9eHRxkP56XZ/edYIg1RSmy3ZVgINfPD1hGYsPvGgYP
         4eSbFA6YjyLi1SLMszXlQmGoytMMaH9Qjk8CqeTfCmjsZSZKy0V5evjhCDTXNsTu2cy/
         VJdc5Ry7Rv/2QVJCLyTKENpi+VWCnV7POGMKXTNzBdhzC5CAsBvoDbPLxuqHgV48+nua
         tfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWsgzNHBmSFzmgfMUIgNEjy4VDqIaNU2SVRo/jg0d5k=;
        b=sMjUzjeawDEnXQp119TLtfHEcF5PIHnNm/miEO5lSMMenzWvJ3Q61HLvcTDbsbyaYL
         lhfAeEs8RR36CArSSne7ZOyDarjYOYiCCrleJ8Ao9BLtC+bObhZ2TWMCQTcq9yMyLrpO
         3GY8u2Zgf/m+RX1lu/usO4K/bpkw4iABmfcfz/Rz1LIfgrWxsHr2Tu2GqR16jTNeBK3S
         V22df96lLI8jjr0k5UOTWMgQAkEJ8l8sZjmDLNdFqUFI9XgufOwfrE7IACCbbrO81wJE
         cTyCXZbBGPytIpdEJTheH12ZEP2DkMstmySlCDKJIUTsL8icI6zXU+qFTjRqn7r/Lhmp
         4kRA==
X-Gm-Message-State: AOAM533z/pWBdIt3iKV4fPtf2ANwGyvnhsjSDVBbVD+qdMyVtHCwMeYX
        Q1vqRCaaxbRN6O6s0mz0OptCFpzNl3F6n0rxMpsq8FRz29h2Mg==
X-Google-Smtp-Source: ABdhPJwok/lbNgZz/ECDiA9AlOZaJkUAwDTgC3x5B7ogt15ycGrugVCd4mp242t636AUkmfYjwe5vuVRgngmGPn1nxk=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr4104940pjb.129.1615887673725;
 Tue, 16 Mar 2021 02:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com> <YFB0OcBg3Vj555eA@hovoldconsulting.com>
In-Reply-To: <YFB0OcBg3Vj555eA@hovoldconsulting.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Mar 2021 11:40:57 +0200
Message-ID: <CAHp75VfcbC63t_eZeBOA0NY28BtGBD0YyLR6nSNuKAnKhXTSzA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
To:     Johan Hovold <johan@kernel.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 16, 2021 at 11:02 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
> > Since interrupt handler is called with disabled local interrupts, there
> > is no need to use the spinlock primitives disabling interrupts as well.
>
> This isn't generally true due to "threadirqs" and that can lead to
> deadlocks if the console code is called from hard irq context.
>
> Now, this is *not* the case for this particular driver since it doesn't
> even bother to take the port lock in console_write(). That should
> probably be fixed instead.
>
> See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.

Finn, Barry, something to check I think?

--
With Best Regards,
Andy Shevchenko
