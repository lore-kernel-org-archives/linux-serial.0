Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1F4C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Feb 2022 21:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiB1VWg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiB1VWf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Feb 2022 16:22:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AB1107D22;
        Mon, 28 Feb 2022 13:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ED03B81677;
        Mon, 28 Feb 2022 21:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AECC340F1;
        Mon, 28 Feb 2022 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646083314;
        bh=V+xFj8FOhP9mS0Y/ZN938c7a+qfRt25LEtVSf8sSyT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwV9zWR5dGsrXkUCfsWbV0kPJKZMThpJ6Lc0b5cxYaeqxlrMC6Xh9Y2uZ1XV/jEsl
         kwVG/VE17VvWJtjhWSyNYEhUjIdNzPwvU6r2fM545pdkxCVQMxg6nV7NtvWAiUH+6z
         cxJwQeW7+BzOhHceerE2kKHZCaQ6VxhL0cT8F7lI=
Date:   Mon, 28 Feb 2022 22:21:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Message-ID: <Yh087tJhakKHs88e@kroah.com>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
 <29b34655-f820-39c9-4363-878481cd3f63@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29b34655-f820-39c9-4363-878481cd3f63@baylibre.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 28, 2022 at 03:13:48PM +0100, Neil Armstrong wrote:
> Hi,
> 
> On 28/02/2022 14:55, Yu Tu wrote:
> > Describes the calculation of the UART baud rate clock using a clock
> > frame. Forgot to add in Kconfig kernel test Robot compilation error
> > due to COMMON_CLK dependency.
> > 
> > Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
> 
> As I already replied on V2 of this patch, you're invited to apply these fixes directly
> on the next version of your "Use CCF to describe the UART baud rate clock" patchset
> and not as a separate patch.

No, this is broken in linux-next now as the path listed here is in my
tree right now.

I need a fix for it, or I can revert the original.

thanks,

greg k-h
