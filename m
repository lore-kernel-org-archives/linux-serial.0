Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599EDC10DCE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3972072A
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583497475;
	bh=/FSzxNHEnCPZySFaU9lI5MLlJSdhT8iNMhpx4383pGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wcbay891Zclh7NR6qYCqClr7SCm68TR3wgrs5YckPiYBxTHF3FEwOzCqf6iWWuQY6
	 9EPsbAcAsxvprh2Kghbe6sDKSovfkz8aKdkA8yd5a4erT7k1Cq/gOvKsxJZ7VySiEV
	 hIS7H0W0Dz9vCD88T8cgSmRsN2U4bjWLQSRa3XoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFMYe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:24:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgCFMYe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 07:24:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADBC42072A;
        Fri,  6 Mar 2020 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583497474;
        bh=/FSzxNHEnCPZySFaU9lI5MLlJSdhT8iNMhpx4383pGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=020cwxwgAROwGjqiUTqmyCxFnLEImYPB3d6xWnMeYAYQZAnUd+1HH6MYu5jUWPBaB
         lcj1hk+zfxybcpWnXL0NUgp0zorIlc7NoYTwav+GzS8p1ik5ql/cJIo0f+PcliY8/N
         +XEMm7+k9exCBE7Dud0/ZNKZnBktX3SYiXV0dT5I=
Date:   Fri, 6 Mar 2020 13:24:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russ Gorby <russ.gorby@intel.com>
Subject: Re: [PATCH] tty: serial: ifx6x60: Convert to GPIO descriptors
Message-ID: <20200306122430.GA3654291@kroah.com>
References: <20200302101117.331005-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302101117.331005-1-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 02, 2020 at 11:11:17AM +0100, Linus Walleij wrote:
> This driver for the Intel MID never seems to have been properly
> integrated upstream: the platform data in <linux/spi/ifx_modem.h>
> is not used anywhere in the kernel and haven't been since it was
> merged into the kernel in 2010.
> 
> There might be out-of-tree users, so I don't want to delete the
> driver, but I will refactor it to use GPIO descriptors, which
> means that out-of-tree users will need to adapt.
> 
> There are several examples in the kernel of how to provide the
> resources necessary for using GPIO descriptors to pass in the
> GPIO lines, for the MID platform in particular, it will suffice
> to inspect the code in files like:
> arch/x86/platform/intel-mid/device_libs/platform_bt.c
> 
> This refactoring transfers all GPIOs in the driver, including
> a hard-coded "PMU reset" in the driver to use GPIO descriptors
> instead.
> 
> The following named GPIO descriptors need to be supplied:
> - reset
> - power
> - mrdy
> - srdy
> - rst_out
> - pmu_reset
> 
> Cc: Russ Gorby <russ.gorby@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/ifx6x60.c  | 170 ++++++++++++----------------------
>  drivers/tty/serial/ifx6x60.h  |  13 ++-
>  include/linux/spi/ifx_modem.h |   5 -
>  3 files changed, 65 insertions(+), 123 deletions(-)

This fails to apply to my tty-next branch, can you rebase and resend?

thanks,

greg k-h
