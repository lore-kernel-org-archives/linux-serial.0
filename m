Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC81C11F66
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE6E61D5D
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 13:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhF2NRV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232487AbhF2NRU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Jun 2021 09:17:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EF2B61D5D;
        Tue, 29 Jun 2021 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624972493;
        bh=DO025SKb+VEs0Eqlb7EEbyLJkhVsdGH2nOLagnB7ls4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFfFr5uQSgSl4CHUmb6b0zI3skWp2FFGTuWEnLkGwm/7cgCgMPUT+1QPJH2G8pWjX
         F+dXre2v7J8EU9JhQzU5o6lhV7Fuz8zs1YPwPevJH1bQ0lHUhbKZDSvWCvkATOBGwB
         9H60pQLVmyxpz1vScjk7NUds80FuykyjKQ9Rn1cI=
Date:   Tue, 29 Jun 2021 15:14:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bing Fan <hptsfb@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm pl011 serial: support multi-irq request
Message-ID: <YNscy0UkPr7JaTp1@kroah.com>
References: <1624930164-18411-1-git-send-email-hptsfb@gmail.com>
 <YNq7Uwj/yJi7NvE8@kroah.com>
 <d2ba9f70-2ace-d796-8ce8-fd56d73d145b@gmail.com>
 <YNsPfvcjH3Z6gSUw@kroah.com>
 <8e3133f8-a528-70fb-d539-9508a6cdcd3a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e3133f8-a528-70fb-d539-9508a6cdcd3a@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 29, 2021 at 08:31:00PM +0800, Bing Fan wrote:
> hello,
> 
> 
> 在 6/29/2021 20:18, Greg KH 写道:
> > On Tue, Jun 29, 2021 at 07:32:36PM +0800, Bing Fan wrote:
> > > hello, replied as below. and new patch is at the bottom.
> > Please submit this properly as the documentation says to do so, I can't
> > take an attachment :(
> Ok.
> > > > > + struct amba_device *amba_dev = (struct amba_device *)uap->port.dev;
> > > > Are you sure you can just cast this like this? Did you test this?
> > > Yes, i have tested and applied in my project. The function
> > > pl011_probe calls pl011_setup_port with &amba_dev->dev and uap
> > > params; and pl011_setup_port set uap->port.dev to the address of
> > > amba_dev->dev; the two structs' relationship is:     struct
> > > amba_device {         struct device dev;         ……     }; When
> > > pointer(uap->port.dev) points to amba_dev->dev address, the momery
> > > actully stores content of struct amba_device; so the cast assignment
> > > can be forced to amba_dev.
> > That is now how this should work, use the correct container_of() cast
> > instead. That will always work no matter where struct device is in the
> > structure. You got lucky here :)
> 
> changed to "struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);"
> 
> 
> > > > > + + if (!amba_dev) + return -1;
> > > > Do not make up error numbers, return a specific -ERR* value.
> > > changed to "return -ENODEV"
> > So this changed the logic of this function, is that ok?
> 
> No, just sanity check.

If it can never happen, no need to check for it.

> > > > And how can this happen?
> > > The function pl011_setup_port isn't called, event pl011_probe isn't
> > > called.
> > And how can that ever happen?
> 
> If there is no pl011 device.

How can that happen here?

thanks,

greg k-h
