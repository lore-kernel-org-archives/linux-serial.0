Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF677C4361B
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D147D6023E
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 15:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343528AbhEQQAf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 12:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241263AbhEQP6V (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 11:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74F1861285;
        Mon, 17 May 2021 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621267023;
        bh=aGe20D3xbdI7lTuWfKMgoLSVElw31QRIhXSxWTD4HpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o800q5TvEyWNKjZH5NrzU6mFR06dE714r4QldoO4YAap8h7rWqHv1Rh/kkm1W05TR
         Iy8PRkJgpKQMnNPgiLNtigTmYJ50MEdxvSPO2BHwV3IHGsAwIN66UI4rhsqDCC1Zyz
         a0uLa3maeQipkwnEa6qlkeoIp8ClexgJx6acgpXo=
Date:   Mon, 17 May 2021 17:57:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org, Stable <stable@vger.kernel.org>,
        Sachi King <nakato@nakato.io>
Subject: Re: [PATCH] serial: 8250_dw: Add device HID for new AMD UART
 controller
Message-ID: <YKKSTU4W3i3Zuydc@kroah.com>
References: <20210512210413.1982933-1-luzmaximilian@gmail.com>
 <CAJZ5v0j=_GuzgXdGj8R-MMAGDkgMx-tP1JwQ1kxb+dWyEi8DCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j=_GuzgXdGj8R-MMAGDkgMx-tP1JwQ1kxb+dWyEi8DCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 17, 2021 at 05:01:15PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 13, 2021 at 12:25 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >
> > Add device HID AMDI0022 to the AMD UART controller driver match table
> > and create a platform device for it. This controller can be found on
> > Microsoft Surface Laptop 4 devices and seems similar enough that we can
> > just copy the existing AMDI0020 entries.
> >
> > Cc: <stable@vger.kernel.org> # 5.10+
> > Tested-by: Sachi King <nakato@nakato.io>
> > Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> or please let me know if this needs to go in through ACPI (I'm
> assuming that it doesn't).

I've already taken it in my tty tree :)

thanks,

greg k-h
