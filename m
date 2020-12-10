Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB625C4361B
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE0423DB4
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 19:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393619AbgLJTr7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:47:59 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:42608 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390148AbgLJTrw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 14:47:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 3CC7F123B0D;
        Thu, 10 Dec 2020 20:47:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607629622;
        bh=snH8es/pngoy41pPpSJuMprO26ulqiCPUbM8LssoCrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXpoGjkoXzJOXEMF7nmYz302Yn/i9smNfqtMUy8dLMFsK4E4HNzn8T5sFaf7jpFsR
         ZmGf3ItZMdKk/Ef6GWBm4uCLOG9xusllpclmerHg6rWZTKSGNvVrC5etZGO4DQavZy
         Rzm39pxrFWXBsjxh/oG0jQ89RD7Sr/5QEa4pjV1BuKljfje8ULLjBKWwsHIBlPTvVV
         2prJoMMyC9Ma8+Bx7y8/EJunM6Nx0fiRPWLx0L6Wi3woO7XDfMPk+jG7ADcMlZET1Y
         6wiI8Atl9a4AtRReuiyaeYOk2EzePS1cVizIi8YWnuMo5Q6EgUYx7P7NMUX6HEv0Vj
         qwxRm5FgWS3+A==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w2CtiJc9gyjG; Thu, 10 Dec 2020 20:46:29 +0100 (CET)
Received: from dincontrollerdev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 63135123B09;
        Thu, 10 Dec 2020 20:46:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607629589;
        bh=snH8es/pngoy41pPpSJuMprO26ulqiCPUbM8LssoCrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSHS+7OotGppjefGM/Yx2MCEWP1nsiim1onZY2YaG5dK6gjazk0N5dJ4q/pO6Wf2/
         T65sndyUDj5coHfQeYEnrSNfui8AovCbGi8MS480d304RM7lB+hQnHrnrDifLe0mwr
         xBCbz1+Z6sA5PVjYOZDikYi3SZykWB2goLc4Q9f/kaKDRK1Ti0p1o37vwaj5v7Wxlc
         WwgW+LenFBfZimrWiPg1hcfBZQt7auQRX0sT0PoQAIueW9g4HK9CJxraAZS2vDI8oV
         u3Mhx1iBSzq29VGAJE10V6tIe90/9IS7jlTaV8edKbzWxx6p7OxoHkMubpms882oZP
         1DI+xzxxJzQag==
Date:   Thu, 10 Dec 2020 19:46:25 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Serial: silabs si4455 serial driver
Message-ID: <20201210194625.GA17516@dincontrollerdev>
References: <20201210170443.GA17304@dincontrollerdev>
 <X9Jw+srprdT8tquZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9Jw+srprdT8tquZ@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 08:03:22PM +0100, 'Greg Kroah-Hartman' wrote:
> On Thu, Dec 10, 2020 at 05:04:46PM +0000, József Horváth wrote:
> > This is a serial port driver for
> > Silicon Labs Si4455 Sub-GHz transciver.
> > 
> > Signed-off-by: József Horváth <info@ministro.hu>
> > ---
> >  .../bindings/serial/silabs,si4455.yaml        |   53 +
> >  MAINTAINERS                                   |    7 +
> >  drivers/tty/serial/Kconfig                    |    8 +
> >  drivers/tty/serial/Makefile                   |    1 +
> >  drivers/tty/serial/si4455.c                   | 1235 +++++++++++++++++
> >  drivers/tty/serial/si4455_api.h               |   56 +
> 
> First thing, a single .c file should not need a .h file.
> 
> But then I looked at the .h file and see:
> 
> > --- /dev/null
> > +++ b/drivers/tty/serial/si4455_api.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Copyright (C) 2020 József Horváth <info@ministro.hu>
> > + *
> > + */
> > +#ifndef SI4455_API_H_
> > +#define SI4455_API_H_
> > +
> > +struct si4455_iocbuff {
> > +	uint32_t length;
> > +	uint8_t	data[4096];
> 
> If you do have an ioctl, use proper data types.  These are not the
> correct ones (hint, __u32 and __u8).
> 
> > +};
> > +
> > +#define BASE_TTYIOC_PRIVATE		0xA0
> > +/* Set EZConfig.
> > + * After this ioctl call, the driver restarts the si4455,
> > + * then apply the new configuration and patch.
> > + */
> > +#define SI4455_IOC_SEZC		_IOW('T', \
> > +				     BASE_TTYIOC_PRIVATE + 0x01, \
> > +				     struct si4455_iocbuff)
> 
> Why does a serial driver have private ioctls?  Please no, don't do that.

I checked the ioctl.h and serial_core.h, but I not found any similar definition, like BASE_VIDIOC_PRIVATE in videodev2.h.
In this case the name of macro BASE_TTYIOC_PRIVATE means the base value of special ioctl commands owned by this driver.

I can change it to BASE_TTYIOC or SI4455_IOC_BASE

> Implement the basic serial driver first, and then we can talk about
> "custom" configurations and the like, using the correct apis.

Without the SI4455_IOC_SEZC call, the driver can't configure the Si4455 and not working at all.
The cofiguration for interface is provided by user for application.
It contains the base frequency, channel spacing, modulation, and a lot of more stuff, and generated by Silicon Labs Wireless Development Suite.
The generated configuration is in a non public(compressed, encrypted...who knows) format, so without this the driver can't provide configuration parameters to Si4455.

> 
> thanks,
> 
> greg k-h

Üdvözlettel / Best regards:
József Horváth

