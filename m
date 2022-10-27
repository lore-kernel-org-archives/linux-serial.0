Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA3C38A2D
	for <linux-serial@archiver.kernel.org>; Thu, 27 Oct 2022 00:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiJ0AWA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 20:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiJ0AV7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 20:21:59 -0400
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401638C462
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 17:21:56 -0700 (PDT)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id D36EB600F6
        for <linux-serial@vger.kernel.org>; Thu, 27 Oct 2022 09:21:55 +0900 (JST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by gw.atmark-techno.com (Postfix) with ESMTPS id D94C4600F6
        for <linux-serial@vger.kernel.org>; Thu, 27 Oct 2022 09:21:54 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id b2-20020a170902d50200b001866035cb0aso11175176plg.8
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 17:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3MAXWAYZ9njFYeSK2wb8W58ukiSVlbgeipHRg6/XSI=;
        b=XP2fl+6Pyf76cg7X4+37/DcIFcgTq+ctYtA98EEJqqtN5uogz4OtTkae+WmuGdJ3B2
         XxGLIcbmrlh08KWlDMxZGV84kPRjCLtXQ4/+PIC4A00WAoN2LSHmqU1RTeVibkg8ceHm
         gCz0dDrs90gfgsGQSXvuah72Yuau3k7/u5OyTOsZ7o+2024dCz4m2cbIa+Z5cv19id6l
         /lOnukIJe/zwgDYPUx3+0lILV+pVtQT9t3Xppad8WkdvQX0XkCjxel8ugniekx/0FB+N
         vz9y2m2Qxg8buDqPLLnHdEhsbCOsWqlj0zUvdy/qESPUfFvl8MLXN99yrYHh7OFAiadv
         WX2g==
X-Gm-Message-State: ACrzQf1A8tuctZRhS0cZxq+UA+T2EcsRX/lqLt3AKB0w5fWaXs9Eljbg
        5PEaMV+q/IJ8qDFvR6k2rLXiK2B1MjttkHUyDlEvllSffKkG7PhoeDXyu5o5A0BH3LlpRShJ7Yz
        CmyRKzCq0KRFXYcDA6YKJTGp3u49l
X-Received: by 2002:a17:902:d4ce:b0:186:c8b9:c301 with SMTP id o14-20020a170902d4ce00b00186c8b9c301mr9715902plg.27.1666830113964;
        Wed, 26 Oct 2022 17:21:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6N4/aQSVoFzd1G2K7+143BFzYuHhWpdNKnui7L9HzUFlMABvSsO1BhS5xcZfuns9b/0nzkkg==
X-Received: by 2002:a17:902:d4ce:b0:186:c8b9:c301 with SMTP id o14-20020a170902d4ce00b00186c8b9c301mr9715882plg.27.1666830113749;
        Wed, 26 Oct 2022 17:21:53 -0700 (PDT)
Received: from pc-zest.atmarktech (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id t11-20020aa7946b000000b0052d4cb47339sm1706669pfq.151.2022.10.26.17.21.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2022 17:21:52 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1onqed-002g2D-1p;
        Thu, 27 Oct 2022 09:21:51 +0900
Date:   Thu, 27 Oct 2022 09:21:41 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Daisuke Mizobuchi <mizo@atmark-techno.com>
Subject: Re: [PATCH 5.10 v2 1/2] serial: core: move RS485 configuration tasks
 from drivers into core
Message-ID: <Y1nPFe6IaRI7j6fE@atmark-techno.com>
References: <20221017051737.51727-1-dominique.martinet@atmark-techno.com>
 <Y1lmM7Qu1yscuaIU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1lmM7Qu1yscuaIU@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg Kroah-Hartman wrote on Wed, Oct 26, 2022 at 06:54:11PM +0200:
> On Mon, Oct 17, 2022 at 02:17:36PM +0900, Dominique Martinet wrote:
> > From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> > 
> > Several drivers that support setting the RS485 configuration via userspace
> > implement one or more of the following tasks:
> > 
> > - in case of an invalid RTS configuration (both RTS after send and RTS on
> >   send set or both unset) fall back to enable RTS on send and disable RTS
> >   after send
> > 
> > - nullify the padding field of the returned serial_rs485 struct
> > 
> > - copy the configuration into the uart port struct
> > 
> > - limit RTS delays to 100 ms
> > 
> > Move these tasks into the serial core to make them generic and to provide
> > a consistent behaviour among all drivers.
> > 
> > Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> > Link: https://lore.kernel.org/r/20220410104642.32195-2-LinoSanfilippo@gmx.de
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > [ Upstream commit 0ed12afa5655512ee418047fb3546d229df20aa1 ]
> > Signed-off-by: Daisuke Mizobuchi <mizo@atmark-techno.com>
> > Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> > ---
> > Follow-up of https://lkml.kernel.org/r/20221017013807.34614-1-dominique.martinet@atmark-techno.com
> 
> I need a 5.15.y version of this series before I can take the 5.10.y
> version.

Thanks for the probing, I did not know about this rule (but it makes
sense); I've just sent a 5.15 version:
https://lkml.kernel.org/r/20221027001943.637449-1-dominique.martinet@atmark-techno.com

I'd really appreciate if Lino could take a look and confirm we didn't
botch this too much -- we've tested the 5.10 version and it looks ok,
but this is different enough from the original patch to warrant a check
from the author.

Thanks!
-- 
Dominique


