Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AB1C54EE9
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 14:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiIVOPT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiIVOPS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 10:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612113DC2;
        Thu, 22 Sep 2022 07:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CEF0634FB;
        Thu, 22 Sep 2022 14:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D136C433C1;
        Thu, 22 Sep 2022 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663856116;
        bh=tl/32hl140pijmlck7q2wJ41zq0TYCte/Mh0P254N+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxGA49KR1iDZvATG+lu+ezRBJqwTIA3dF6v+6KPcbAmbDMlqIqMrDE9YA9B0tgmGl
         mhNCFfRRXVcBbYcTmn6CjwEClE6Ssm/rzSeHgQsZrO3hFKoAdvqf8pv/Lm+7qruYmJ
         O6OA278VMJR/M396ADaQ223QW4K48q9tT7oC2lQU=
Date:   Thu, 22 Sep 2022 16:15:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Johan Hovold <johan@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 00/10] tty: TX helpers
Message-ID: <Yyxt8iv+ERbyXBR4@kroah.com>
References: <20220920052049.20507-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920052049.20507-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 20, 2022 at 07:20:40AM +0200, Jiri Slaby wrote:
> This series introduces uart_port_tx() + uart_port_tx_limited() TX
> helpers. See PATCH 8/10 for the details. Comments welcome.
> 
> First the series performs simple cleanups, so that the later patches are
> easier to follow.
> 
> Then it switches drivers to use them. First, to uart_port_tx() in 9/10
> and then uart_port_tx_limited() in 10/10.
> 
> The diffstat of patches 9+10 is as follows:
>  26 files changed, 145 insertions(+), 740 deletions(-)
> which appears to be nice.

I've queued up the first 7 patches here, as they were the preparation /
cleanup patches and deserved to go in no matter what.

thanks,

greg k-h
