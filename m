Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4893BEB64DC
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jun 2023 06:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbjFNGqL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jun 2023 02:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242599AbjFNGqJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jun 2023 02:46:09 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6BF11A3;
        Tue, 13 Jun 2023 23:46:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F0B048027;
        Wed, 14 Jun 2023 06:46:07 +0000 (UTC)
Date:   Wed, 14 Jun 2023 09:46:06 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix -EPROBE_DEFER handling in init
Message-ID: <20230614064606.GH56720@atomide.com>
References: <18318adb-ab2c-4dcc-9f96-498a13d16b80@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18318adb-ab2c-4dcc-9f96-498a13d16b80@moroto.mountain>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Dan Carpenter <dan.carpenter@linaro.org> [230614 06:36]:
> The -EPROBE_DEFER error path in serial_base_device_init() is a bit
> awkward.  Before the call to device_initialize(dev) then we need to
> manually release all the device resources.  And after the call then we
> need to call put_device() to release the resources.  Doing either one
> wrong will result in a leak or a use after free.
> 
> So let's wait to return -EPROBE_DEFER until after the call to
> device_initialize(dev) so that way callers do not have to handle
> -EPROBE_DEFER as a special case.  Now callers can just use put_device()
> for clean up.
> 
> The second issue with the -EPROBE_DEFER path is that deferring is not
> supposed to be a fatal error, but instead it's normal part of the
> init process and the kernel recovers from it automatically.  That means
> we should not print an error message but just a debug message on this
> path.
> 
> Fixes: 539914240a01 ("serial: core: Fix probing serial_base_bus devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for fixing these issues:

Reviewed-by: Tony Lindgren <tony@atomide.com>
