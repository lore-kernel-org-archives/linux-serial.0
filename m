Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC6CCA47D
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbiFOKxn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiFOKxm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 06:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15585130A;
        Wed, 15 Jun 2022 03:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83AAE6162D;
        Wed, 15 Jun 2022 10:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BCEC34115;
        Wed, 15 Jun 2022 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655290418;
        bh=xorApPrJYjqRVSP/59nC6A1gHUam/lVIdxd8tViYqNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLzcAJdjue7U4UAgQgf9+RKr6LPQLQ1VcUI/upqTv1jd4xn6ffwn+7ka1a4EDGE8U
         zqx74/OmAxwHanaqgwTA7wUZlgugxFfwkQhE/i3XRtI35ar4o26wDmuNDE1Dgh11mi
         /epAMQstrnhJN4qD2PnkwxCSW90WgW64Lkp7vHmk=
Date:   Wed, 15 Jun 2022 12:53:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     heliang <windhl@126.com>
Cc:     ldewangan@nvidia.com, jirislaby@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, sumit.semwal@linaro.org,
        christian.koenig@amd.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] drivers: tty: serial: Add missing of_node_put() in
 serial-tegra.c
Message-ID: <Yqm6LvDGqaRMaUHa@kroah.com>
References: <20220615104833.3963552-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615104833.3963552-1-windhl@126.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 15, 2022 at 06:48:33PM +0800, heliang wrote:
> In tegra_uart_init(), of_find_matching_node() will return a node
> pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
> 
> Signed-off-by: heliang <windhl@126.com>

We need a real name please, one you sign documents with.

thanks,

greg k-h
