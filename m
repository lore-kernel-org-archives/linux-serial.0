Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59618C05027
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 13:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjBANGf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 08:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBANGe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 08:06:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A442D4C;
        Wed,  1 Feb 2023 05:06:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9299A61796;
        Wed,  1 Feb 2023 13:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988ACC433EF;
        Wed,  1 Feb 2023 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675256793;
        bh=GnaimmLKefZRjOPzvWP+ABUMPmzcZWg/oE0SlaIO8qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9/871CFxrDT7QczJzo8MWNftedHmkpmn9hia5EiH2mxDCNB3+gr09zIaIRQJ0BUN
         u7Lu5mSTWnwIf0zrI6oeo44lRLY/2XkPNdxp2cEeHVyYAKv6kS7bcv5n3sXsDGYecT
         tJ5whSOP+pagxiKa9ZGxU7HLzk1SqAyp8lUiqYNI=
Date:   Wed, 1 Feb 2023 14:06:29 +0100
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
Subject: Re: [PATCH v2] serial: samsung: fix buffer size for clk_name
Message-ID: <Y9pj1Sx7Nzjkp6pw@kroah.com>
References: <20230116141658.GC8107@altlinux.org>
 <Y8lZNi9pYVFkYvh9@kroah.com>
 <20230201024457.GD446@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201024457.GD446@altlinux.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 01, 2023 at 05:44:57AM +0300, Alexey V. Vissarionov wrote:
> serial: samsung: fix buffer size for clk_name
> 
> Although very unlikely, the 'clk_num' value may be as big as
> 2**32 - 1 (uint32_max), so the buffer should have enough
> space for storing "clk_uart_baud4294967295\0".
> Also, the numbers in clk_name are expected to be unsigned.
> 
> Found by ALT Linux Team (altlinux.org) and Linux Verification
> Center (linuxtesting.org) using SVACE.
> 
> Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
> 
> ---
> 
> On 2023-01-19 15:52:38 +0100, Greg Kroah-Hartman wrote:
> 
>  >> Fixes: 5f5a7a5578c58852 ("serial: samsung: switch to clkdev
>  >> based clock lookup")
>  > Please fix your scripts to use the proper number of SHA1 digits
>  > in a Fixes: line as the documentation asks for.
> 
> Done. Also added the comment to the source regarding the buffer size.
> 
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 0fce856434dafd80..2c701dc7c6a37191 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1407,7 +1407,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
>   *
>   */
>  
> -#define MAX_CLK_NAME_LENGTH 15
> +#define MAX_CLK_NAME_LENGTH 24		/* "clk_uart_baud4294967295\0" */
>  
>  static inline int s3c24xx_serial_getsource(struct uart_port *port)
>  {
> @@ -1457,7 +1457,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>  			!(ourport->cfg->clk_sel & (1 << cnt)))
>  			continue;
>  
> -		sprintf(clkname, "clk_uart_baud%d", cnt);
> +		sprintf(clkname, "clk_uart_baud%u", cnt);

So you bump the size of the buffer and continue to use an "unsafe" call
that could overflow the buffer?  Is this a plan to submit a series of
patches all "fixing" something based on the last change?  :)

As Krzysztof said, this whole thing is not needed at all.  Please fix
your tool to generate valid changes.

thanks,

greg k-h
