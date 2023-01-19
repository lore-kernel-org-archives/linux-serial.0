Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C2C46467
	for <linux-serial@archiver.kernel.org>; Thu, 19 Jan 2023 16:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjASQ56 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjASQ5t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Jan 2023 11:57:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A1BB754
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 08:57:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F4A361CE5
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 16:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E84CC433EF;
        Thu, 19 Jan 2023 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674147466;
        bh=Y9vJMvIiWCosmY/YA/fZMG4a9V1ACyCXjX+DOe5LIjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZQUlMx5m1xZlgfNJJTJoN7vnu+JTcur91GaHj9wULXb8l3OoTVe8PqcIK0dXiWTc
         7zZ/RlCk1ZOPUyV/ItucpZ1I25ukn1QGyFnbth+e8NPamBZh+4iIE0abdLUH4Wd+6/
         feMV8idMIfOhFUMcA7kv3MIhos2/5uSzeEU1su50=
Date:   Thu, 19 Jan 2023 17:57:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <mrhowel@g.clemson.edu>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com,
        darren.beeson@sealevel.com
Subject: Re: [PATCH v2] serial: exar: Add support for Sealevel 7xxxC serial
 cards
Message-ID: <Y8l2iFHi66NFaGGX@kroah.com>
References: <alpine.DEB.2.21.2301191117110.21493@tstest-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2301191117110.21493@tstest-VirtualBox>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 19, 2023 at 11:23:51AM -0500, Matthew Howell wrote:
> 
> Add support for Sealevel 7xxxC serial cards.
> 
> This patch:
> * Adds IDs to recognize 7xxxC cards from Sealevel Systems.
> * Updates exar_pci_probe() to set nr_ports to last two bytes of primary
> dev ID for these cards.
> 
> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> 
> Moved "This patch..." above signed-off line.
> 
> Let me know if I need to make any more changes.

These lines need to go below the --- line, as the documentation asks,
otherwise they will show up in the changelog.

Also you need to list what changed in v2, again the documentation has
examples.

v3 please?

thanks,

greg k-h
