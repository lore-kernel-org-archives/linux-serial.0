Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB9FC83F2F
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 18:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbjHaS6d (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjHaS6c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 14:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3564DE64
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 11:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C862A62605
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 18:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5413C433C7;
        Thu, 31 Aug 2023 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693508309;
        bh=mrF9gA3YxoAgh9fMMulj1XAQQtvpIB1GWI0dGbyuNY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sqxcd3960XrvC1d3ZRNP5ECQ5t5XLc95TgE5vymgG5nmJ2Njck/TbJqgjuX+6GQ5y
         3cQbqrAE7k8MSWo60yHtk3niXu0OU300OwHkQwOdlVedSIER/1Zkb9YmM5zGFAbJ5s
         Gf9JW790vZ4eLSIUd9JzN2becuvJ4KluEPepKqSs=
Date:   Thu, 31 Aug 2023 20:58:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v3] tty/serial: create debugfs interface for UART
 register tracing
Message-ID: <2023083101-among-unrented-c0a7@gregkh>
References: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
 <ZPDXHy6L7nTRx63l@smile.fi.intel.com>
 <af06008a-f4d4-1c30-294a-b7af2d4cbc86@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af06008a-f4d4-1c30-294a-b7af2d4cbc86@foxvalley.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 31, 2023 at 12:33:33PM -0600, Dan Raymond wrote:
> On 8/31/2023 12:08 PM, Andy Shevchenko wrote:
> > Warning: This email is from an unusual correspondent.
> > Warning: Make sure this is someone you trust.
> > 
> > On Thu, Aug 24, 2023 at 02:59:01PM -0600, Dan Raymond wrote:
> >> Implement a UART register tracing facility using the debugfs.  This can be
> >> used as a "serial port sniffer" to monitor UART traffic and line settings
> >> with timestamps at microsecond granularity.  This can be useful for general
> >> serial port debugging or to debug the UART driver itself.
> > 
> >>  drivers/tty/serial/8250/8250_debug.c | 530 +++++++++++++++++++++++++++
> > 
> > My gosh. Why trace points and trace events can't be used for that?
> > 
> 
> I don't understand your post.  Are you saying there is already a way to
> trace UART register reads/writes without this patch?  Can you elaborate?

By adding trace points and trace events, instead of a custom api like
you did.  I asked you to look into this already :)

thanks,

greg k-h
