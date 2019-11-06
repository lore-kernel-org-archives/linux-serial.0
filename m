Return-Path: <SRS0=yeGP=Y6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A1AC5DF62
	for <linux-serial@archiver.kernel.org>; Wed,  6 Nov 2019 12:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347B8217F5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Nov 2019 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573042564;
	bh=7Qk21Xo/YMeoOVp/OL+OM/VRZzgjMrMsp3w0H5S702s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NJPb5QYz4yMKZu3i2vcWR5/f52Ik8Oj6XkI45gujDYzQN8W9qMgY04lmQaL6SVgEL
	 JZgBIlW/Bby4sB4qFestGbv2Cc/EhmYLQ3nGALK9UQXZCavbfdhTW3n7SGhHyibj/x
	 T6rZzSpphSIHfEsvwSXwIUNdl5ikqwnuCU+yL46Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfKFMQD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfKFMQD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Nov 2019 07:16:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2DF20869;
        Wed,  6 Nov 2019 12:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573042562;
        bh=7Qk21Xo/YMeoOVp/OL+OM/VRZzgjMrMsp3w0H5S702s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gd51ptMxvpSIMJUu6wIUs8HOaULo3C6lPjgN3I3PyH+aNcqzhCXgUEaO1qnBlj811
         JipS6HXEdvO3+yrOCVvl5FoyFFo/yBHWDngRcgaiQ4PZ/OjRcKr4juhtZd5YOMMM3U
         ClLnZvPKjkugl3hVzBujOA1NtTCfMS+Gl5dtOQ+w=
Date:   Wed, 6 Nov 2019 13:16:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org
Subject: Re: [PATCH v4 1/2] tty: serial: qcom_geni_serial: IRQ cleanup
Message-ID: <20191106121600.GA3105139@kroah.com>
References: <1572947835-30600-1-git-send-email-akashast@codeaurora.org>
 <20191105171705.GB2815774@kroah.com>
 <5dc21b1d.1c69fb81.8f924.e6e1@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc21b1d.1c69fb81.8f924.e6e1@mx.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 05, 2019 at 05:00:12PM -0800, Stephen Boyd wrote:
> Quoting Greg KH (2019-11-05 09:17:05)
> > On Tue, Nov 05, 2019 at 03:27:15PM +0530, Akash Asthana wrote:
> > > @@ -1307,7 +1307,21 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
> > >       port->handle_rx = console ? handle_rx_console : handle_rx_uart;
> > >       if (!console)
> > >               device_create_file(uport->dev, &dev_attr_loopback);
> > > -     return uart_add_one_port(drv, uport);
> > > +
> > > +     ret = uart_add_one_port(drv, uport);
> > > +     if (ret)
> > > +             return ret;
> > 
> > What is going to remove the sysfs file you just created above (in a racy
> > way, it's broken and needs to be fixed, but that's a different issue
> > here...)?
> > 
> > 
> > > +
> > > +     irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
> > > +     ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
> > > +                     IRQF_TRIGGER_HIGH, port->name, uport);
> > > +     if (ret) {
> > > +             dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
> > > +             uart_remove_one_port(drv, uport);
> > > +             return ret;
> > 
> > Does this remove the sysfs file?
> > 
> 
> The loopback file isn't documented. It isn't removed when the driver is
> removed either. Can we just remove the whole thing? It would be nicer if
> that sort of thing was supported in the tty layer somehow. Is it?

I don't know what that file does, so yes, please delete it :)

And as for support in the tty layer itself, if you figure out what it
does, sure, we can add support if needed.

thanks,

greg k-h
