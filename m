Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB44DC43331
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D922227
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 16:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392187AbhALQMs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:12:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387818AbhALQMs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 11:12:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 440E42087D;
        Tue, 12 Jan 2021 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610467927;
        bh=gjilwnvLaoITN9YHzuSjRl6lvEZ8s9/dAZpCd/lhAvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVZtbb9iRp3VQXS3H1G+28LruF9gT+EHzkZiV80lKA6B+sz6uHoL7Zq/MzCFaWNkh
         7mNQspcofW8890yFt6PJNEVNSxGCGb0Frv3hNTVyUZ6vSpYLsN1aGUkZj3U5PQH/cg
         86476VJsutJn7aJe6ABJMyB9zs2c+0Yjpkx9AL0c=
Date:   Tue, 12 Jan 2021 17:13:16 +0100
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] Serial: silabs si4455 serial driver
Message-ID: <X/3KnP3S4siAxTfG@kroah.com>
References: <20210112101831.GA12483@dev>
 <X/15uOstG/7bj2Lm@kroah.com>
 <20210112154322.GA31198@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112154322.GA31198@dev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 12, 2021 at 03:43:22PM +0000, József Horváth wrote:
> On Tue, Jan 12, 2021 at 11:28:08AM +0100, 'Greg Kroah-Hartman' wrote:
> > On Tue, Jan 12, 2021 at 10:18:33AM +0000, Jozsef Horvath wrote:
> > > --- a/include/uapi/linux/serial_core.h
> > > +++ b/include/uapi/linux/serial_core.h
> > > @@ -279,4 +279,7 @@
> > >  /* Freescale LINFlexD UART */
> > >  #define PORT_LINFLEXUART	122
> > >  
> > > +/* Silicon Labs SI4455 */
> > > +#define PORT_SI4455     123
> > 
> > What userspace tool is going to need this value?
> 
> The PORT_SI4455 is defined for using as port type value in struct uart_port.
> I checked other serial drivers under drivers/tty/serial and the port types
> used by serial drivers are defined in two places:
> 
> include/uapi/linux/serial_core.h
> include/uapi/linux/serial.h
> 
> The port type is required by serial_core, and its value goes back to
> user space with TIOCGSERIAL ioctl call.

What is it required for?  Who uses this?

> I can't set port type value to 0(PORT_UNKNOWN).

Why not?

> I think my drivers source is not the best place to defining PORT_SI4455,
>  but I can't find better place then include/uapi/linux/serial_core.h
> 
> Could you please help me where is the correct location for this definition?

I ask as I am trying to figure out why we keep adding these ids, yet no
tool that i know of seems to actually use them.

If you don't have a tool that needs to use a new id, then I would
recommend not adding it, right?

thanks,

greg k-h
