Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6475C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 23 May 2022 12:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiEWMKk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 08:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiEWMKk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 08:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3F35DED;
        Mon, 23 May 2022 05:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0021B612FC;
        Mon, 23 May 2022 12:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF245C385A9;
        Mon, 23 May 2022 12:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653307838;
        bh=lBPchX/uMDZs5nmazywffKCr1QG3UlkRSzoLoU/mwFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2EL/keWEbc/7ewgZUW2ThW8q5nsSVwgSmB4WDUMJGwMPkPK99ThG+YeOYB+80tLq
         abrpovdkaqqqj/OSeSaFrDLZ5YRBIMe4vfEyMn+StVqqvixJnMX6NufcC6Vziu9hMJ
         YJqeLBYAJMvBauRyHLubKa83NQK+s4qrrQUj0UIM=
Date:   Mon, 23 May 2022 14:10:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, jirislaby@kernel.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
Subject: Re: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right
 FEATURE_SEL"
Message-ID: <Yot5uls/3vLzZu7I@kroah.com>
References: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
 <YnpeYGbo7JJK0lDk@sirena.org.uk>
 <b13b019f-f766-60df-3764-d375f64ea7d3@collabora.com>
 <YnphFjs4E4EYafT4@sirena.org.uk>
 <63169e65-cbfa-d495-754f-023dc8befa42@collabora.com>
 <d91977d2-ebc6-de6e-5eeb-61c25ba0cc64@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91977d2-ebc6-de6e-5eeb-61c25ba0cc64@collabora.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 23, 2022 at 12:17:06PM +0200, AngeloGioacchino Del Regno wrote:
> Il 10/05/22 17:29, AngeloGioacchino Del Regno ha scritto:
> > Il 10/05/22 14:56, Mark Brown ha scritto:
> > > On Tue, May 10, 2022 at 02:46:28PM +0200, AngeloGioacchino Del Regno wrote:
> > > 
> > > > Sorry for missing this tag, and also I'm sorry for the noise.
> > > 
> > > Hey, if nobody broke anything all this testing stuff wouldn't be worth
> > > it!
> > 
> > 
> > Haha! That's true :-)
> > 
> > Thank you!
> 
> 
> Hello Mark, Greg
> 
> I've just noticed that v5.18 was released, but without this revert.

What is "this revert"?

> Can you schedule this for backport on v5.18?

I need more context here, sorry.

greg k-h
