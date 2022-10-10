Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55274C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 10 Oct 2022 07:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiJJHKW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Oct 2022 03:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiJJHJl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Oct 2022 03:09:41 -0400
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D011815
        for <linux-serial@vger.kernel.org>; Mon, 10 Oct 2022 00:06:15 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by gw.atmark-techno.com (Postfix) with ESMTPS id EBFFA60109
        for <linux-serial@vger.kernel.org>; Mon, 10 Oct 2022 16:06:09 +0900 (JST)
Received: by mail-pg1-f197.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so5924277pgl.8
        for <linux-serial@vger.kernel.org>; Mon, 10 Oct 2022 00:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IgE0ag6icu39lDWLleAsDr5Zb9nBOutjsMecAkOD4M=;
        b=5xs1DtTiuuqqOoB9bjBlZ7xOcOAxDFsjX4JxXcY7QlgbyOWLMH2DClS0aTgGLKZsDC
         VWGESEbed+e/zQGSfbIEotPpvlJrE7UCb1HZeC05bX5Ad5J7hnB9lypo4wstaWnpS5+z
         RUEqqSyJofazaGA7yVLUKRKoMOUtgoy/LZyOGdgZ71qFiIO76/6ablVYXzAI7iNzF0xn
         NzHpkD/Kid6OFfvG/lSd8zCOkoPjKkFOaMofVzNGsPUmPZCpVbvgrZDlr9ybhFkL2Qrz
         N5A2WYObNN7gQl+I2AexrsmGyoYco6jiHsNqvUiR5p19Gb35wOVFbjMJK3zQcEtkOiMG
         dMIQ==
X-Gm-Message-State: ACrzQf3bjfCO2OBZPFe+seGXQ3RdfO4zPMwk6wahVTj0b71F+XeQsnJH
        RBLLQLFatP+5SvuPDGDCAouY3gBIcPZcV9sPU+09j5yNJsnWgOTa+JDlVuu0Di+8viLWcxJmsd+
        FTNuK/r+KtCF2KDjwtVKMHYdOyAsb
X-Received: by 2002:a63:ed58:0:b0:439:b3a:4f01 with SMTP id m24-20020a63ed58000000b004390b3a4f01mr15458091pgk.327.1665385568961;
        Mon, 10 Oct 2022 00:06:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4UN7oKeQP7gCTCfMCPDB0BKSJLNi7zrjXS6PxaiaZ75jY8Gcci5Ah/mYLQFYnDVe4vX1gimg==
X-Received: by 2002:a63:ed58:0:b0:439:b3a:4f01 with SMTP id m24-20020a63ed58000000b004390b3a4f01mr15458073pgk.327.1665385568678;
        Mon, 10 Oct 2022 00:06:08 -0700 (PDT)
Received: from pc-zest.atmarktech (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b00562bc93f1c9sm5925705pfp.213.2022.10.10.00.06.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2022 00:06:08 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1ohmrW-0080RB-1e;
        Mon, 10 Oct 2022 16:06:06 +0900
Date:   Mon, 10 Oct 2022 16:05:56 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] serial: Deassert Transmit Enable on probe in
 driver-specific way
Message-ID: <Y0PEVDSYGWA+kYwF@atmark-techno.com>
References: <2de36eba3fbe11278d5002e4e501afe0ceaca039.1663863805.git.lukas@wunner.de>
 <Y0O46rcQap99fZVC@atmark-techno.com>
 <Y0O9z3dg5K6qQrRm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0O9z3dg5K6qQrRm@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg Kroah-Hartman wrote on Mon, Oct 10, 2022 at 08:38:07AM +0200:
> > Thanks for this fix!
> > We also noticed rs485 DE was initially wrong last week and I noticed
> > this when I was about to send a patch that just inverted the
> > SER_RS485_RTS_AFTER_SEND check in uart_configure_port, but after reading
> > the commit message here it's a lot more complicated than that depending
> > on the serial driver...
> > (fixing commit 2dd8a74fddd2 ("serial: core: Initialize rs485 RTS
> > polarity already on probe"), but it's actually the same problem in the
> > opposite direction)
> > 
> > 
> > Unfortunately you've marked this for v4.14+ stable, but it doesn't even
> > apply to 5.19.14 due to (at least) commit d8fcd9cfbde5 ("serial: core:
> > move sanitizing of RS485 delays into own function"), so it hasn't been
> > picked up yet; since quite a bit of code was cleaned up/moved one will
> > need to pay a bit attention when doing that.
> > 
> > What would you like to do for stable branches?
> > Would you be able to send a patch that applies on older 5.10 and 5.15
> > where commit d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart
> > open") has been backported?
> > 
> > If that sounds too complicated we could probably just revert a handful
> > of serial_core/rs485 commits, but going forward sounds more future-proof
> > to me.
> > 
> > Thanks!
> > (nothing below, leaving quote for stable@)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Yes, it does not apply. I've just added stable@ in cc so you're aware
that 5.10 and 5.15 still have a problem with the serial code (and in
case you have an opinion between trying to backport this big patch or
reverting a bunch of older ones)

The quote is just context.

I can try to backport it and send it properly if Lukas doesn't have
time, but it doesn't hurt to discuss first.

Thanks,
-- 
Dominique
