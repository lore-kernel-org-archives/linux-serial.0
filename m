Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A38FA3740
	for <linux-serial@archiver.kernel.org>; Sat, 29 Oct 2022 06:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ2G7M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Oct 2022 02:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJ2G7M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Oct 2022 02:59:12 -0400
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C181688
        for <linux-serial@vger.kernel.org>; Fri, 28 Oct 2022 23:59:11 -0700 (PDT)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id D38C66013C
        for <linux-serial@vger.kernel.org>; Sat, 29 Oct 2022 15:59:09 +0900 (JST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 301E76013D
        for <linux-serial@vger.kernel.org>; Sat, 29 Oct 2022 15:59:09 +0900 (JST)
Received: by mail-pg1-f198.google.com with SMTP id x16-20020a63b210000000b0045f5c1e18d0so3527338pge.0
        for <linux-serial@vger.kernel.org>; Fri, 28 Oct 2022 23:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F/e3an+HkL6s8uZYrMNfU7hm7ZeC4VHKbQWbFreALk=;
        b=rZ6JiPcI5HKFDieLedpTeveMjteOAiQVNNWsOuYOCSu42lMfC50OXmd3Sd9Mh+h+GU
         OAvY1PL8AqOU6RUqrnPkuJTU0u+0NxJkXo8szJrLtUBqEe5Xro6WuCBHtXUuhMRx38Xb
         jxh6YnU8+LhIObsi2+nRKHucOM6l8+StN/F/cdfhUlVqOo5Zq04kVEHfg0py3ArNCOtS
         YyB/63ndZLVK8jR4AV8FmER6XSIl+9EqBt9gnMyBSJsHHI9je3v69MHn2TyPPqGggz1t
         egxMO2WlwIVZt87JKOmUtKwZVp3qfUcj91wcSQ7E6B/1l/JtOhyFXi+w9zvXxcVngc0e
         kyaQ==
X-Gm-Message-State: ACrzQf3kP8l/DNGcQf9bnB52HU1JWT7bVwfqiLIpm+94vhLC9bCim9n6
        iKgmldPbTGwVUKwi87EOrfxnzefwDI21zjqxp9FtZAZgFd5dTWtD1NiSSThwunkD+1Qg0ssBIuk
        l5eIrCxVYPwbAzCWyqUdI/94MNg+c
X-Received: by 2002:a17:90a:ce89:b0:213:167c:81e1 with SMTP id g9-20020a17090ace8900b00213167c81e1mr20705680pju.38.1667026748215;
        Fri, 28 Oct 2022 23:59:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7YaSV9vrd5tee16XR/CS30ja/JOgXjwptpxXCf0g5s4Z5wS7VTmgf5FDPF3+eoOR1Q9ZBC4A==
X-Received: by 2002:a17:90a:ce89:b0:213:167c:81e1 with SMTP id g9-20020a17090ace8900b00213167c81e1mr20705662pju.38.1667026747927;
        Fri, 28 Oct 2022 23:59:07 -0700 (PDT)
Received: from pc-zest.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b00186b06963f9sm558705plg.180.2022.10.28.23.59.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Oct 2022 23:59:07 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1oofo9-008u42-28;
        Sat, 29 Oct 2022 15:59:05 +0900
Date:   Sat, 29 Oct 2022 15:58:55 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial@vger.kernel.org,
        Daisuke Mizobuchi <mizo@atmark-techno.com>
Subject: Re: [PATCH 5.10 v2 1/2] serial: core: move RS485 configuration tasks
 from drivers into core
Message-ID: <Y1zPL0Y6bmqvvhMw@atmark-techno.com>
References: <20221017051737.51727-1-dominique.martinet@atmark-techno.com>
 <Y1lmM7Qu1yscuaIU@kroah.com>
 <Y1nPFe6IaRI7j6fE@atmark-techno.com>
 <4ff347e8-1ef4-e006-01db-3d420213f6e3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ff347e8-1ef4-e006-01db-3d420213f6e3@gmx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Lino Sanfilippo wrote on Fri, Oct 28, 2022 at 10:06:51AM +0200:
> > I'd really appreciate if Lino could take a look and confirm we didn't
> > botch this too much -- we've tested the 5.10 version and it looks ok,
> > but this is different enough from the original patch to warrant a check
> > from the author.
>
> However the part Lukas authored (patch 2) seems to be the one that has been adjusted
> a lot, so maybe you rather/also want to have his ack?

Gah, sorry -- I'm juggling with too many things at once here and got the
two patches mixed up.

Yes, I meant Lukas here for patch 2/2, sorry. Promoted him to To.
And thank you Lino for having a look and pointing it out!

-- 
Dominique


