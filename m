Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A12BC77B7A
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jun 2023 10:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjFJK0N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jun 2023 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFJK0M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jun 2023 06:26:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52535B8;
        Sat, 10 Jun 2023 03:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50764614C5;
        Sat, 10 Jun 2023 10:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1093CC433EF;
        Sat, 10 Jun 2023 10:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686392770;
        bh=nB2v+wNogxRDFx75EaOLKTain6XzdZBKWNiyoeWgOIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP47NAeTyrivQK0aPC01L0Hwn7icb59q+K63RFEmpZW0VO0b+KuMG78tzbpI0LouS
         cyGW+ugiDwxj+ycMJ7R/hkdSezmSOrteVfbmB5CykaMLFCu/1zpGXL9STy9bEDoVnf
         kyX3rlSwC+RwtXg6zqd4otB55WCR0vypSLu9ppLObkCluxnks+ZjmCeXKQDUPdD2FD
         gxLiqyqldCTWNu2Cmy/dHYUjXvJ/GTrwQnXcDibBECZCwubxHrg3LEu66QVm72y2Lc
         zosGGGQIBjgpXvwkHJpwhjdxxdCG/Q7OS37zVUeRE52mhaDIhQ9FYn6FUqFRntAQZb
         3ONSsWM9C0n7w==
Date:   Sat, 10 Jun 2023 12:26:07 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
Message-ID: <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Christophe,

On Fri, Jun 09, 2023 at 06:45:38AM +0200, Christophe JAILLET wrote:
> If clk_get_rate() fails, the clk that has just been allocated needs to be
> freed.
> 
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

As this is a fix, can you cc the stable kernel

Cc: <stable@vger.kernel.org> # v3.3+

> ---
>  drivers/tty/serial/samsung_tty.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 2a7520ad3abd..dd751e7010e3 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1459,8 +1459,10 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>  			continue;
>  
>  		rate = clk_get_rate(clk);
> -		if (!rate)
> +		if (!rate) {
> +			clk_put(clk);
>  			continue;

could you also print an error here?

In any case:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi

> +		}
>  
>  		if (ourport->info->has_divslot) {
>  			unsigned long div = rate / req_baud;
> -- 
> 2.34.1
> 
