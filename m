Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971AC07E95
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 12:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7901F61CBB
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 12:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhGGMz1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jul 2021 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhGGMz1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jul 2021 08:55:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2E2C061574;
        Wed,  7 Jul 2021 05:52:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso1561165pjp.5;
        Wed, 07 Jul 2021 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYB6y4B7ttXJD3mqpNqkRqzcO9CmDNYO1GY2p2ckyxU=;
        b=Ark4QFeQHfTkcPVm6YpE+D3m4DlXkOnE6Omlb4vpjElS1l4UTbKggPwUGb9uqqUWQC
         +Pdb2iyS8Ot7XzqM5ioj4RNUotyUY+UO2PEAF8YmR9g9ZCfjZ0oj/8g8hRIQpIPGEqnB
         uPzp5AMsad8AArxf0+/iMFFLJ6wcXZNZDy5WrRG2pEmi/Zzoxa2vY7S3tXgIxfN5EYB9
         2atrtdbQJxTUvd/AA1kEM+5lVJ8LsXmGPzpWvQL9UAV4DdAOnxOEBse5xhVej3q9n8uA
         WgGi8cGFVCxENnf09xHjjVh6qHS56/fDRHQH0bA2XD3EjWTysjTNPWQmkcFfVG463SKT
         H88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYB6y4B7ttXJD3mqpNqkRqzcO9CmDNYO1GY2p2ckyxU=;
        b=VHyeTefVS0AmdO+wlboxOhGXvNJ+vx+xqj+FBkAuz5tCPJPbIpxDxePRMn3B1Wd8l1
         dKf4441348UfHt2BqgqbII4LbHLVa28PmDsHH1ZOcV0b1T+Fe06qH+8OrEDO5pJnP952
         3lxIjjtA8K6IJsCvZj3xRIEIlBPzIuVwKPAwI1+zr9Z4DwG/ot81weZwidNOF6btgSfi
         PXFTyzOtUFUyUyubqdPKTXYiG9A/P0j7FgTaDBH8ZFb1c22allTj2QeDAmXyVFvV53qX
         1XW5PZ0HYU/6KBFT8qJaivL5LBdpnrP3WPk+LHGu2+9GOoJWLfdTPOzM0yzK9VcdKjXw
         AaGA==
X-Gm-Message-State: AOAM533aePJP9LuMX78aipLSce1HymnPBompJ1LFVClGs7SH24b6goEB
        AUOFuWePvZsNqliVHvm9fA0RvC5o5HU8BaxlXog=
X-Google-Smtp-Source: ABdhPJxzPNL1Sb6yz54q3TfE3RQvCI3igey4qf7fPE97SG/jPpG9giKdufmNdwrHNmCrovED/Eu4NZe/nvdD5/9cO9A=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr5986234pja.181.1625662365935;
 Wed, 07 Jul 2021 05:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com> <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org>
In-Reply-To: <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Jul 2021 15:52:07 +0300
Message-ID: <CAHp75Vceenv5ctk6f_eEtXBVzodXHhnpuudaniLM9A1edqYrXA@mail.gmail.com>
Subject: Re: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Zheyu Ma <zheyuma97@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 7, 2021 at 10:50 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 05. 07. 21, 14:53, Zheyu Ma wrote:

> So how it comes an interrupt came before
> neo_param() in jsm_tty_open was called?

If IRQ is shared we have a special debug feature to test shared IRQs
on freeing IRQ stage (*).
But it doesn't matter, the IRQ handler must survive at any stage after
the action has been listed.

*) I believe we have quite a lot of drivers that will fail that test...

-- 
With Best Regards,
Andy Shevchenko
