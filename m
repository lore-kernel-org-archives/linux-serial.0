Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C8FC43334
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jun 2022 09:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbiFQJpG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Jun 2022 05:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiFQJpE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jun 2022 05:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0D663D7;
        Fri, 17 Jun 2022 02:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A545C61B94;
        Fri, 17 Jun 2022 09:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF937C3411B;
        Fri, 17 Jun 2022 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655459103;
        bh=28LBqy3HcvKdeZQsGUI6OYkekuDfqo0DvEihQHEpnfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDb+il7dGJcEAQDvlZJrn1W1F+OLuJILTcq+Z4+VUFUnAPaCQntEqhskIEyWFWN41
         pw+Y3BFrePp9FnrkoN6FGsmJmXd5IHbprKJGQblGJVkp4+mWGy9an1pcjVdUof5Rf4
         Su7RPo9YqC4bkQL8hVx10eao+LqVxsUkfoOtt0EU=
Date:   Fri, 17 Jun 2022 11:45:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update DW 8250 UART maintainership
Message-ID: <YqxNHJ5mGA1tJamh@kroah.com>
References: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 17, 2022 at 12:39:29PM +0300, Ilpo Järvinen wrote:
> Add myself as maintainer for DW 8250 UART and up it to Supported.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Obviously I need an ack from Andy too.  And thanks for doing this and
all the work you have already done so far, it's appreciated.

greg k-h
