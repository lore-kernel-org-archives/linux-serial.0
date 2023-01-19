Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1FBC678DC
	for <linux-serial@archiver.kernel.org>; Fri, 20 Jan 2023 05:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjATFLr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjATFLM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Jan 2023 00:11:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C072C14;
        Thu, 19 Jan 2023 20:59:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BA15B824B4;
        Thu, 19 Jan 2023 14:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C65C433EF;
        Thu, 19 Jan 2023 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674139966;
        bh=pFEkGzZclr313dDw7QOuP7VKAbnZdzWUSenn71Hk3OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGjAcHMA3ALVP/Ub8bSHSnMxeSb+mrRUeNLQ3ks/BKM3BYvdkxeTiID7Q+T0ihS9F
         Et0IullpHEj/1/lCzFmzmEGHj1eVINAd2ExZ/4rD4/aqGBGmo89xe5cZlAmcDJQJ/8
         lUMJaZ4yl+PuT1dqIzpA+u0OqzSHKFCEGR1P9FAg=
Date:   Thu, 19 Jan 2023 15:52:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] serial: samsung: fix buffer size for clk_name
Message-ID: <Y8lZNi9pYVFkYvh9@kroah.com>
References: <20230116141658.GC8107@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116141658.GC8107@altlinux.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 16, 2023 at 05:16:58PM +0300, Alexey V. Vissarionov wrote:
> Although very unlikely, the 'clk_num' value may be as big as
> 2**32 - 1 (uint32_max), so the buffer should have enough
> space for storing "clk_uart_baud4294967295\0".
> Also, the numbers in clk_name are expected to be unsigned.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5f5a7a5578c58852 ("serial: samsung: switch to clkdev based clock lookup")

Please fix your scripts to use the proper number of SHA1 digits in a
Fixes: line as the documentation asks for.

thanks,

greg k-h
