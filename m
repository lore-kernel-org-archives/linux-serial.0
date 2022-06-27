Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7ECCA481
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 11:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbiF0Ly0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiF0Lwp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 07:52:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382BDED1;
        Mon, 27 Jun 2022 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656330370; x=1687866370;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=038ViQj4OdJMOtsCH8E05gcJKrV6mUvMiaaLGQCFo14=;
  b=MvkWEbVLP4mP0s/WkY4CK3hUeVibF9JQOL1q//3tHt7oe0kp0XhjemPe
   uhldW23mIg8276oH2EvSTE0xtBRz++DwKc+/dcUzjRFcecnJ9dMd625zH
   6IgQeT62GkxAjWQst3gGQCKoZ0a3+FNTaDCt3KDGxi5VZf6bwclut4tfe
   GIBFG+qb2ToII8wlRzONuJ3uL8fPMtLKl+/rMn4cMffJNwCvD+mgFs9kf
   kZ8qDr38+9wvwU6ubU/uBi6VyP6t5cLVZBDHA8ArOXgpIJC88oX4SN6Og
   F+eEUxAgr3EDoBEcL55V/fFpVf+1VMQYAfUKxXbSxgBbn+WRX/Tjz4AQU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="278973156"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="278973156"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 04:46:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="646396113"
Received: from gretavix-mobl3.amr.corp.intel.com ([10.249.43.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 04:46:07 -0700
Date:   Mon, 27 Jun 2022 14:46:07 +0300 (EEST)
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
Subject: Re: [PATCH] tty: serial: samsung_tty: loopback mode support
In-Reply-To: <20220627032353.8868-1-chanho61.park@samsung.com>
Message-ID: <ab327a8f-f520-ad85-c0fc-1e505647164c@linux.intel.com>
References: <CGME20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0@epcas2p2.samsung.com> <20220627032353.8868-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 27 Jun 2022, Chanho Park wrote:

> Internal loopback mode can be supported by setting
> S3C2443_UCON_LOOPBACK bit. The mode & bit can be supported since
> s3c2410 and later SoCs.

In that case, why is the  LOOPBACK define named 2443 and not 2410???

The change looks fine otherwise.

I note though that many of the current drivers won't return TOICM_LOOP 
from ->get_mctrl() but I don't think it's exactly wrong to return it 
either. Perhaps lack of returning it is due to 
Documentation/driver-api/serial/driver.rst not including TOICM_LOOP in 
get_mctrl's list of information but only in set_mctrl's one.

-- 
 i.

> We can test it by linux-serial-test program[1]
> with -k option. It will set TIOCM_LOOP mode during test.
> 
> -k, --loopback     Use internal hardware loop back
> 
> [1]: https://github.com/cbrake/linux-serial-test
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d5ca904def34..d7d035cd95c0 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1002,16 +1002,22 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
>  static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
>  {
>  	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
> +	unsigned int ucon = rd_reg(port, S3C2410_UCON);
> +	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR;
>  
>  	if (umstat & S3C2410_UMSTAT_CTS)
> -		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
> -	else
> -		return TIOCM_CAR | TIOCM_DSR;
> +		mctrl |= TIOCM_CTS;
> +
> +	if (ucon & S3C2443_UCON_LOOPBACK)
> +		mctrl |= TIOCM_LOOP;
> +
> +	return mctrl;
>  }
>  
>  static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>  	unsigned int umcon = rd_regl(port, S3C2410_UMCON);
> +	unsigned int ucon = rd_reg(port, S3C2410_UCON);
>  
>  	if (mctrl & TIOCM_RTS)
>  		umcon |= S3C2410_UMCOM_RTS_LOW;
> @@ -1019,6 +1025,13 @@ static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  		umcon &= ~S3C2410_UMCOM_RTS_LOW;
>  
>  	wr_regl(port, S3C2410_UMCON, umcon);
> +
> +	if (mctrl & TIOCM_LOOP)
> +		ucon |= S3C2443_UCON_LOOPBACK;
> +	else
> +		ucon &= ~S3C2443_UCON_LOOPBACK;
> +
> +	wr_regl(port, S3C2410_UCON, ucon);
>  }
>  
>  static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
> 

