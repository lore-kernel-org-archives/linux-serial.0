Return-Path: <SRS0=ZZst=AN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D757EC433DF
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 07:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5D6206BE
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593675368;
	bh=1n77CNPeJ33Kywgw5iC9Ya49YYvivp0h8s4IwclTbf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1It0QjpiksIJBka4QzaSYwK4al5Tmcbf49B+jjbiDoNCKsMAXdJYBc+Ww2vYAuPUX
	 qJqOyFh4dxOSaH4tg65/NOzWmscwhYKdgV0+0WFKUoINHnwq/whcRlkwvhBQD11YO4
	 6tqhoEaeXMIrB8dkT+xQf+ib1GbWNmzTv0ZOSud0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGBHgE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgGBHgD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Jul 2020 03:36:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16A1206BE;
        Thu,  2 Jul 2020 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593675363;
        bh=1n77CNPeJ33Kywgw5iC9Ya49YYvivp0h8s4IwclTbf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKkyx7NdRs71xsCwaGxelmBAxbGoAQjIq8RmaCZiqgqFPOXr1MqVudESyN7L88Ms9
         rZTGOpoQnLPyrJWY7SGzybyYPYxqJbxm6ptrjgt4ejS+OODyTWMVbGSwkA1GGtRyQW
         3N5vEVBfGOwxoLMW/cqh1q8pB7g9lUfbs3ptCgXk=
Date:   Thu, 2 Jul 2020 09:36:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        stable@vger.kernel.org, abhishekpandit@chromium.org,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Revert "serial: 8250: Fix max baud limit in
 generic 8250 port"
Message-ID: <20200702073607.GD1073011@kroah.com>
References: <20200701211337.3027448-1-danielwinkler@google.com>
 <20200701141329.v2.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701141329.v2.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 01, 2020 at 02:13:37PM -0700, Daniel Winkler wrote:
> This reverts commit 7b668c064ec33f3d687c3a413d05e355172e6c92.
> 

I need a reason _why_ to revert this in the changelog text.  Your 0/1
comments would be great to see in here, otherwise I have no idea what is
going on when I look at the kernel changelog in the future.

> Fixes: 7b668c064ec3 ("serial: 8250: Fix max baud limit in generic 8250
> port")

Nit, in the future, this line does not need to be wrapped at all, just
let it go the full length please.

thanks,

greg k-h
