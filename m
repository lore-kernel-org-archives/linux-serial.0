Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E6C4708E
	for <linux-serial@archiver.kernel.org>; Tue,  6 Dec 2022 15:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiLFPFC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiLFPEk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Dec 2022 10:04:40 -0500
X-Greylist: delayed 412 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 06:58:56 PST
Received: from smtp-out-03.comm2000.it (smtp-out-03.comm2000.it [212.97.32.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F05628715
        for <linux-serial@vger.kernel.org>; Tue,  6 Dec 2022 06:58:55 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-03.comm2000.it (Postfix) with ESMTPSA id 88521B43547;
        Tue,  6 Dec 2022 15:52:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1670338322;
        bh=AH0lJQg4LZFijVvXwpG3wKnwdJDssHQBputnWnmGOqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SnF/eRgWSZYZjwwv5dPDLyC03bYXf+Y/uBVUgjVb6eGjSU2Z4doe73h488olnQt/R
         89M4+8vo0qYkiWkVlsgJRucC51ZVb7kX5W/UgYCXaQzBR2FiIdOa0HVDQa/CqLx99L
         kh5jVy1BegNdl/BcbIWdrEQzxL4/54VU/wnIKmlHjI0L0Xr8kqOnFbK0hVT0IVmDF1
         s/oWJ4HTw0TvsoYpOU2b1j3lUWMQaP8xKF6Hm87d7zbX3pLhNK/UMDzVOia99ooNTw
         I3ZXoV8+4qPf02cwZK3HWdw9X75W86gClvnXXqIngnXySXb5vNyGlGU+DiNc8WLTkR
         zg2wciUTFv/Lw==
Date:   Tue, 6 Dec 2022 15:51:16 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        max.krummenacher@toradex.com
Subject: Re: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Message-ID: <Y49W5DuvGcqh0PFw@francesco-nb.int.toradex.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929085318.5268-1-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello all,

On Thu, Sep 29, 2022 at 04:53:18PM +0800, Sherry Sun wrote:
> This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.
> 
> commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration")
> causes the lpuart console cannot work any more. Since the console is
> registered in the uart_add_one_port(), the driver cannot identify the
> console port before call uart_add_one_port(), which causes all the uart
> ports including the console port will be global reset.
> So need to revert this patch to avoid breaking the lpuart console.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

What's the status/plan on this?

From what I can tell the commit this patch is reverting introduced a
regression (that was backported to stable kernel), it should have a
Fixes tag and probably a cc:stable.

See also https://github.com/Freescale/linux-fslc/commit/a682d463667a418d3f7277dbbe06cd6347e76761

Francesco

