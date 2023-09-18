Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E38C46CA1
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 08:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbjIRIUF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbjIRITY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 04:19:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1DE8E
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 01:16:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C31C433C7;
        Mon, 18 Sep 2023 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695025007;
        bh=kZr7GhKsgcAaXdhVQCPEqnHGT6LANWzrAkYrHnS83w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LP5bv1OQyaKrnpqFuhkQea8NOtyeqRQtiLXg9DVxnmWm/lMFMsBrpyACL1FpAyzqK
         rKBOnTzebu011o9yt7AxAU4Cc9+EXJhYpC8QXntmGTIwrj/8B2IA+DgY1qiud8UEcO
         dGBEojdfEUy4IMUKP7Cx2x2cvWYeb99MFzANVs3k=
Date:   Mon, 18 Sep 2023 10:16:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v1] tty/serial: port I/O tracing on x86
Message-ID: <2023091814-savage-grandma-1c01@gregkh>
References: <ec734abb-6d3c-69ec-c3e5-cb21b8829264@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec734abb-6d3c-69ec-c3e5-cb21b8829264@foxvalley.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 15, 2023 at 07:16:44PM -0600, Dan Raymond wrote:
> Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
> available on x86 via CONFIG_MMIOTRACE but that relies on page faults
> so it doesn't work with port I/O.  This feature uses tracepoints in a
> similar manner as CONFIG_TRACE_MMIO_ACCESS.
> 
> Signed-off-by: Dan Raymond <draymond@foxvalley.net>
> ---
>  arch/x86/include/asm/shared/io.h | 11 +++++++
>  arch/x86/lib/Makefile            |  1 +
>  arch/x86/lib/trace_portio.c      | 18 ++++++++++++
>  include/trace/events/portio.h    | 49 ++++++++++++++++++++++++++++++++

The x86 maintainers and developers need to see this if you wish to have
it accepted.  Please resend it and cc: them (use
scripts/get_maintainer.pl on your patch.)

thanks,

greg k-h
