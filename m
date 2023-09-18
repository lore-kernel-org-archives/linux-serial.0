Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF9CD13D3
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 08:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbjIRITA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjIRISD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 04:18:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4510FE
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 01:15:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBF5C433C9;
        Mon, 18 Sep 2023 08:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695024934;
        bh=GrPLUcqSbqg173H9fEBQ9RcATliteOW6aotyWZrQMM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JblOenLCb/5YRonUbTEhWcmkzLW8MlIItxmrX9pqliJOKSh16i14VGeSbzwHzlBer
         Dgd0gQI/2x2pdki5jcDRKi55PnL7f4YoA0I0LConQsUDgqK4IpuF05rjY5D434KmlC
         CcVQaDzn624951Zi+yzOxixuRaCMrJXbezmMtMZw=
Date:   Mon, 18 Sep 2023 10:15:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v4] tty/serial: create debugfs interface for UART
 register tracing
Message-ID: <2023091828-cornball-mouse-6b87@gregkh>
References: <515ad583-5692-d4e0-6fee-cd242dd422b1@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <515ad583-5692-d4e0-6fee-cd242dd422b1@foxvalley.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 15, 2023 at 06:01:35PM -0600, Dan Raymond wrote:
> Implement a UART register tracing facility using the debugfs.  This can be
> used as a "serial port sniffer" to monitor UART traffic and line settings
> with timestamps at microsecond granularity.  This can be useful for general
> serial port debugging or to debug the UART driver itself.
> 
> Signed-off-by: Dan Raymond <draymond@foxvalley.net>

Again, please stick with the tracing infrastructure and use that, like
all other kernel subsystems do.  If each driver/subsystem were to create
a tracing interface like this, it would be unmanageable.  So unless
there is some really really good reason to not use the trace
infrastructure, this patch can not be accepted.

thanks,

greg k-h
