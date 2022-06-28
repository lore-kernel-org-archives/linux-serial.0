Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E7C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 12:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiF1M65 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiF1M64 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 08:58:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A992FFD1;
        Tue, 28 Jun 2022 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656421135; x=1687957135;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=n6FSyD6TOLlqIp96Exr9r3CAQsHxyx4Hfw4enuNKSZo=;
  b=ZFLAsGDsB9ISipzAXFXW5k+3xhG46inl7Z1ZAz6Ra7K6xZpKO+B7y/rQ
   nraHi34Z/mZbe7sCmatPbcSeLRWcsXFN9buN3aXOXnS0Eq0gWzOQMF9Pj
   F6+48B45bXMs5kSaBAZAf2Iuf0tR7YriYpPaE3hLiaCnPMRTm1zU0bics
   WKBoy0YaQG+iOTWVxAN6yfW/JbcXDjul8MjJ36T4UVGZLIKzLRj4aZBPH
   gVn7JnDUwTbx6tVV2FbcJiWzjIXEdIe3fXAUCQQ+AVnttPzRWlNGPQcAp
   nHAtUVSZT06kSrd+GNUCUrhiwsqufBH9yMqUiDn05HNDiQdBvTKVdmPSA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="368046821"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="368046821"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 05:58:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594786039"
Received: from iannetti-mobl.ger.corp.intel.com ([10.251.216.215])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 05:58:52 -0700
Date:   Tue, 28 Jun 2022 15:58:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Chanho Park <chanho61.park@samsung.com>
cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] tty: serial: samsung_tty: loopback mode support
In-Reply-To: <20220628124050.144398-1-chanho61.park@samsung.com>
Message-ID: <fb89ea18-f381-a514-e4a7-942c3fa27985@linux.intel.com>
References: <CGME20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3@epcas2p4.samsung.com> <20220628124050.144398-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-594435092-1656420383=:1603"
Content-ID: <9283e8d-cf8-a50-794b-145df2a88931@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-594435092-1656420383=:1603
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <4b2b658-3584-6caa-ca7d-473eed3457f@linux.intel.com>

On Tue, 28 Jun 2022, Chanho Park wrote:

> Internal loopback mode can be supported by setting
> UCON register's Loopback Mode bit. The mode & bit can be supported since
> s3c2410 and later SoCs. The prefix of LOOPBACK / BIT(5) naming should be
> also changed to S3C2410_ to avoid confusion.
> 
> We can test it by linux-serial-test program
> with -k option. The tool will set TIOCM_LOOP mode when the option is
> specified.
> -k, --loopback     Use internal hardware loop back
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

You should have included Krzysztof's Reviewed-by when you sent this next 
version so that it won't get lost.

I suspect Greg will again complain that you didn't address his comment 
about the out of the place "-k, --loopback ..." line.


-- 
 i.


> ---
> Changes from v1:
> - Drop TIOCM_LOOP return from s3c24xx_serial_get_mctrl as pointed out by
>   Ilpo. Documentation/driver-api/serial/driver.rst indicates the bit is
>   only for set_mctrl.
> - Change the loopback bit definition from S3C2443_UCON_LOOPBACK to
>   S3C2410_UCON_LOOPBACK because it has been supported since s3c2410.
> - Remove the unnecessary footnote and put a blank line before Signed-off-by
> 
>  drivers/tty/serial/samsung_tty.c | 8 ++++++++
>  include/linux/serial_s3c.h       | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d5ca904def34..03ef4ff506fd 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1012,6 +1012,7 @@ static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
>  static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>  	unsigned int umcon = rd_regl(port, S3C2410_UMCON);
> +	unsigned int ucon = rd_reg(port, S3C2410_UCON);
>  
>  	if (mctrl & TIOCM_RTS)
>  		umcon |= S3C2410_UMCOM_RTS_LOW;
> @@ -1019,6 +1020,13 @@ static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  		umcon &= ~S3C2410_UMCOM_RTS_LOW;
>  
>  	wr_regl(port, S3C2410_UMCON, umcon);
> +
> +	if (mctrl & TIOCM_LOOP)
> +		ucon |= S3C2410_UCON_LOOPBACK;
> +	else
> +		ucon &= ~S3C2410_UCON_LOOPBACK;
> +
> +	wr_regl(port, S3C2410_UCON, ucon);
>  }
>  
>  static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> index dec15f5b3dec..1672cf0810ef 100644
> --- a/include/linux/serial_s3c.h
> +++ b/include/linux/serial_s3c.h
> @@ -83,7 +83,7 @@
>  #define S3C2410_UCON_RXIRQMODE	  (1<<0)
>  #define S3C2410_UCON_RXFIFO_TOI	  (1<<7)
>  #define S3C2443_UCON_RXERR_IRQEN  (1<<6)
> -#define S3C2443_UCON_LOOPBACK	  (1<<5)
> +#define S3C2410_UCON_LOOPBACK	  (1<<5)
>  
>  #define S3C2410_UCON_DEFAULT	  (S3C2410_UCON_TXILEVEL  | \
>  				   S3C2410_UCON_RXILEVEL  | \
> 
--8323329-594435092-1656420383=:1603--
