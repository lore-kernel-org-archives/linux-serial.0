Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F72C4321A
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14ED223131
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 15:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405400AbhALPou (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:44:50 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:50358 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405331AbhALPou (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id D345411FFAC;
        Tue, 12 Jan 2021 16:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610466246;
        bh=3TX/Z1vZrcZZBHoWafk0q6dH5DN3BAFkYepRrsCGr/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8cbdjLQ89rbUgkVk9z8PkgZbbgYAW9vl0Dv86mTiCWcGPv/Dj+pjOqBi3NB0fTuF
         /n//kQ/AnGo4DFvJBiCXlFTTcVcY0M6ri8+lXudkIgazZncXR/wCs52vhF3FiRnFPY
         zO0b9jEl/fYuA+3fHGjCjvlaFThBs4uNzCxvQo/IDgNKOGx9OUF1YOYW+No0MDJCue
         mLLCwlYmW3h2VjEdg7C39pTjCXrAPGd/dO4PMag3xn1jteZQG4qBroUMhkgmkBaIXO
         tNdZHqgbBRsRGbNKs2cfhBfau/50277SpWg/XbEylRhYYRW4XrfEYuV51ljaH+JI88
         gvjowQCXU4XxQ==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qA9P9RacV8pr; Tue, 12 Jan 2021 16:43:25 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 8D76A11FFA8;
        Tue, 12 Jan 2021 16:43:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610466205;
        bh=3TX/Z1vZrcZZBHoWafk0q6dH5DN3BAFkYepRrsCGr/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvX6vEAsQW6sv3luqhPCO4dntvcSBoApIDmmhuOe/X2Pvd6adOcnL0p1V3hKnFxiL
         YPXVKqXdWwEiJYsLD3S6qFcl9ZB8Hu24tkuo0PHJMWXSWuyBR2iZEXt1r3KWXwF3nY
         Id4VIat0lElQKqr+9FZEGYgqLvYdNNC3LAzAsxqDvI0y3f96PoOZAzeercRqasHNgO
         WExnH9NWMoZx6SUTg+Jez5Dw1kZWPFHfTyl87RXAxAgvf1GxirDaPLmRoi94XaajOA
         ME9ddlIBh6AoNcM6CQQ4syNI75sZorCwDCKj9GVavBUsP9CPp3i2exlbO7E6/T3oyj
         pZ4MF8hrdKdOg==
Date:   Tue, 12 Jan 2021 15:43:22 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] Serial: silabs si4455 serial driver
Message-ID: <20210112154322.GA31198@dev>
References: <20210112101831.GA12483@dev>
 <X/15uOstG/7bj2Lm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/15uOstG/7bj2Lm@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 12, 2021 at 11:28:08AM +0100, 'Greg Kroah-Hartman' wrote:
> On Tue, Jan 12, 2021 at 10:18:33AM +0000, Jozsef Horvath wrote:
> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -279,4 +279,7 @@
> >  /* Freescale LINFlexD UART */
> >  #define PORT_LINFLEXUART	122
> >  
> > +/* Silicon Labs SI4455 */
> > +#define PORT_SI4455     123
> 
> What userspace tool is going to need this value?

The PORT_SI4455 is defined for using as port type value in struct uart_port.
I checked other serial drivers under drivers/tty/serial and the port types
used by serial drivers are defined in two places:

include/uapi/linux/serial_core.h
include/uapi/linux/serial.h

The port type is required by serial_core, and its value goes back to
user space with TIOCGSERIAL ioctl call.

I can't set port type value to 0(PORT_UNKNOWN).
I think my drivers source is not the best place to defining PORT_SI4455,
 but I can't find better place then include/uapi/linux/serial_core.h

Could you please help me where is the correct location for this definition?


> 
> thanks,
> 
> greg k-h

Üdvözlettel / Best regards:
József Horváth

