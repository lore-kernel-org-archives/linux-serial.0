Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1772C61DA4
	for <linux-serial@archiver.kernel.org>; Fri,  3 Feb 2023 05:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjBCFKr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Feb 2023 00:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBCFKq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Feb 2023 00:10:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686146A4A
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 21:10:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F717B82913
        for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2023 05:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF78C433EF;
        Fri,  3 Feb 2023 05:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675401042;
        bh=/dcOSAX3NZkMRrTLbXFice7su2t52D3f7/bobQv3IeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0GUECC9RkFSU68qr0FFtoA4U0XM7Weba80dkrzpERDUZhi2oWGgV2aSPv7PG/W8XN
         Uqb1IbgZKqg9hRJYduSgZYNyw0f05jZ+9fKhwyfhmIb5XuxXc+Rnh5Ckte6LSi4713
         uuGg+EBOAgQeOqEUirp1mErKn5jZ9je5vl9J0/bQ=
Date:   Fri, 3 Feb 2023 06:10:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, brking@pobox.com,
        mmc@linux.vnet.ibm.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/6] hvcs: Fix hvcs port reference counting
Message-ID: <Y9yXUOMmcHcdeL62@kroah.com>
References: <20230202222804.383229-1-brking@linux.vnet.ibm.com>
 <20230202222804.383229-2-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202222804.383229-2-brking@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 02, 2023 at 04:27:59PM -0600, Brian King wrote:
> The hvcs driver only ever gets two references to the port. One
> at initialization time, and one at install time. Remove the code
> that was trying to do multiple port puts for each open, which
> would result in more puts than gets.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/tty/hvc/hvcs.c | 18 ------------------
>  1 file changed, 18 deletions(-)

I already took this patch (you got an email about it), no need to send
it again.

thanks,

greg k-h
