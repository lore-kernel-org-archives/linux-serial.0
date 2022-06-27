Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F32C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 12:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiF0MtK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiF0MtK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 08:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA31D2ED;
        Mon, 27 Jun 2022 05:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28EEF61170;
        Mon, 27 Jun 2022 12:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FCCC3411D;
        Mon, 27 Jun 2022 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656334148;
        bh=q31zZRCcTxGfAGEYAFGAfqTwac0q01YzEC/8abEgegA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5du0KHNEr1/l9MgRTh3UhzWVPUwvgx7iRCEYAan2MVWQ/0RJh7nvcqvnsIfNR01a
         gDXtlBul3zolDzAIV6YdC4CLbF0Hid94MHhi2/DvKyH+1UiNdV2L2D7oQinp6wH7mc
         9ElCDMHfaq989gBIP290+Me5Q/P3waAv7WSZiQBc=
Date:   Mon, 27 Jun 2022 14:49:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: 8250_dw: Take port lock while accessing LSR
Message-ID: <YrmnQSSZmFo7SJEz@kroah.com>
References: <20220615090651.15340-1-ilpo.jarvinen@linux.intel.com>
 <20220615090651.15340-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615090651.15340-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 15, 2022 at 12:06:50PM +0300, Ilpo Järvinen wrote:
> Accessing LSR requires port lock because it mutates lsr_saved_flags
> in serial_lsr_in().
> 
> Fixes: 197eb5c416ff ("serial: 8250_dw: Use serial_lsr_in() in dw8250_handle_irq()")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 3 +++
>  1 file changed, 3 insertions(+)

Does not apply against my tty-linus branch, you mixed patches up in this
series which is confusing for anyone wanting to apply them.

I've applied the first, but the next two you should resend.

thanks,

greg k-h
