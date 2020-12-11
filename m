Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC424C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6493023F33
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392359AbgLKImF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389954AbgLKIlu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 03:41:50 -0500
Date:   Fri, 11 Dec 2020 09:42:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607676070;
        bh=JpsfdBPPI6DnsxCU6r5Mn2z+4P04rLXRyh5h0HI21Yk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5bnG0yHSsMvuz//SwtnAchp35ncvxvmE17p2o8k8CYmYe2g1trKvePYcKMJdL3uc
         O71iB4B/bNE3TBxW7HTAnsOB58jTh0SXtVWqGyNhAAl0+k6ZXN/UawjkGsCcvA1puM
         RCBMxke/sR/ci2WUCW8Qi73nDvZYGPm3VR/niWEs=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     LakshmiPraveen.Kopparthi@microchip.com
Cc:     linux-serial@vger.kernel.org, Woojung.Huh@microchip.com,
        Sundararaman.H@microchip.com, Kumaravel.Thiagarajan@microchip.com,
        GaneshKumar.Gurumurthy@microchip.com,
        Muthukumar.Veeramani@microchip.com
Subject: Re: TIOCSERCONFIG ioctl does not respect UPF_FIXED_TYPE flag
Message-ID: <X9Mw7lNRo+rEpyFP@kroah.com>
References: <DM6PR11MB2586CF444FFBF203D0709A5093CA0@DM6PR11MB2586.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2586CF444FFBF203D0709A5093CA0@DM6PR11MB2586.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 11, 2020 at 08:21:23AM +0000, LakshmiPraveen.Kopparthi@microchip.com wrote:
> Hi,

Hi,

Please don't send email in html format, the mailing lists reject it :(

>     We are working on a patch to add the serial support for our device. In that process, it appears TIOCSERCONFIG ioctl does not respect the UPF_FIXED_TYPE flag.  uart_do_autoconfig gets called which passes UART_CONFIG_TYPE flag to config_port call.
> 
> The same problem seems be to reported some time back to the maintainers which can be found in the link  - https://www.spinics.net/lists/linux-serial/msg29169.html. But the patch didn't make it through to the mainline kernel. Could you please let us know the resolution of that thread? Is it rejected/accepted?

That patch was from 2018, I can't remember what I reviewed last week :)

If it's not in the kernel tree today, then no, it was not accepted.  If
you need something like this, please test that patch and resend it with
your signed-off-by and we will be glad to review it.

thanks,

greg k-h
