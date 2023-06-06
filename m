Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B1C77B7A
	for <linux-serial@archiver.kernel.org>; Tue,  6 Jun 2023 12:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFFMOB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Jun 2023 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjFFMN7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jun 2023 08:13:59 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24B641710;
        Tue,  6 Jun 2023 05:13:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5D36580AE;
        Tue,  6 Jun 2023 12:13:26 +0000 (UTC)
Date:   Tue, 6 Jun 2023 15:13:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_mtk: Simplify clock sequencing and runtime
 PM
Message-ID: <20230606121325.GB14287@atomide.com>
References: <20230606091747.2031168-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606091747.2031168-1-wenst@chromium.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Chen-Yu Tsai <wenst@chromium.org> [230606 09:19]:
> The 8250_mtk driver's runtime PM support has some issues:
> 
> - The bus clock is enabled (through runtime PM callback) later than a
>   register write
> - runtime PM resume callback directly called in probe, but no
>   pm_runtime_set_active() call is present
> - UART PM function calls the callbacks directly, _and_ calls runtime
>   PM API
> - runtime PM callbacks try to do reference counting, adding yet another
>   count between runtime PM and clocks
> 
> This fragile setup worked in a way, but broke recently with runtime PM
> support added to the serial core. The system would hang when the UART
> console was probed and brought up.

Great, looks like a good for Linux next to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
