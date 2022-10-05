Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88892C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 Oct 2022 10:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJEKCs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEKCr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Oct 2022 06:02:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D857268
        for <linux-serial@vger.kernel.org>; Wed,  5 Oct 2022 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664964166; x=1696500166;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Mg6WM/dyCvP61SvfgRmIegW7dfrb/YwmuFf8onY6EK8=;
  b=eqdpWJ5UwtpM+XkxJtF8htLd+WTZ4e4IKe3jnF8OGLL1jndbZt8ciT06
   jj3xh6XKEEWeOWVlb/Got9FBfQMMoSnlctp4JfjwtDFhckJjhlWIrBN3v
   W8iqZNz14pkAF03uYHljXKsz+UY6Bidz/q2LdPK5bZ7dAU0dzro+p1ESu
   IBG9dGpFVIMosB6DnInpWfaHVHJQSS/Be72lwZBATkfzTzz4S/f9RjNEC
   Crq6oRYLS64ZE8D4Wq+Ufi6fXF2rC/JZCYQjp6q9XrfChXQ/mXxmQqvX9
   UJnxmf03WXQZTBbaWlyOFUVKkxIFv2nlm+8LoZ41zgLDSL+M0DxxRUfwD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="300723649"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="300723649"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:02:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="601965373"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="601965373"
Received: from mtantera-mobl3.ger.corp.intel.com (HELO refaase-MOBL1.ger.corp.intel.com) ([10.252.39.164])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:02:44 -0700
Date:   Wed, 5 Oct 2022 13:02:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Grant Edwards <grant.b.edwards@gmail.com>
cc:     linux-serial <linux-serial@vger.kernel.org>
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
In-Reply-To: <thi5m6$j7r$1@ciao.gmane.io>
Message-ID: <b2ea1bbe-5ec3-4420-462-b94bf8e5c0d3@linux.intel.com>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se> <YyA9maUOlPIExIUd@kroah.com> <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se> <thi5m6$j7r$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 4 Oct 2022, Grant Edwards wrote:

> On 2022-09-13, Anders Blomdell <anders.blomdell@control.lth.se> wrote:
> > I get incorrect baudrates, my oscilloscope gives:
> >
> > Programmed	Measured
> >
> >    2400		  5208
> >    4800		 13150
> >    9600		 10410
> >   19200		 71420
> >   38400		142000
> >   57600		201600
> > 115200		138800
> 
> I just ran into what I think is the same problem when upgrading from
> 5.10.76 to 5.15.68 (sorry I don't have any intermediate kernel
> versions to test with). This is an oxford quad 950 board that has
> worked flawlessly for many years. Now the baud rates are all wrong.
> 
> $ lspci | grep OX
> 03:00.0 Serial controller: Oxford Semiconductor Ltd OXPCIe954 Quad Native 950 UART
> 
> $ dmesg | grep ttyS
> [    0.265026] 0000:03:00.0: ttyS0 at MMIO 0xf7801000 (irq = 19, base_baud = 15625000) is a 16550A
> [    0.265130] 0000:03:00.0: ttyS1 at MMIO 0xf7801200 (irq = 19, base_baud = 15625000) is a 16550A
> [    0.265231] 0000:03:00.0: ttyS2 at MMIO 0xf7801400 (irq = 19, base_baud = 15625000) is a 16550A
> [    0.265358] 0000:03:00.0: ttyS3 at MMIO 0xf7801600 (irq = 19, base_baud = 15625000) is a 16550A
> 
> The only change I could see in dmesg/setserial output is that the
> baud base changed from 4000000 to 15625000. However, changing the baud
> base back to 4000000 does not make the ports work again
> 
> With the default baud base of 15625000, baud rates look like this:
> 
> Programmed  Measured
>     2400       5398
>     4800      13812
>     9600      10796 
>    19200      74418
>    
> The curious thing is that the buad rate errors are non-linear, so you
> can't just adjust the base baud value to get correct baud rates. The
> algorithm used to calculate the baud divisors seems to be broken.
> 
> I've read through the rest of this thread a couple times, but was
> unable to figure out what to do to fix this problem or if it got fixed
> in more recent kernel versions.
> 
> Did this problem get fixed in more recent kernels?

This series was used to fix the problem:

https://lore.kernel.org/linux-serial/alpine.DEB.2.21.2209201659350.41633@angie.orcam.me.uk/T/#t

Patch 2/3 went only for v5.19+.

-- 
 i.


> Is there something I can do with a 6.15 kernel to get it this board to
> work again?
> 
> --
> Grant
> 

