Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88728C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiGGPME (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiGGPME (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:12:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E21B30F6D
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22299B82230
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DBCC341C0;
        Thu,  7 Jul 2022 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657206719;
        bh=7TqHpPDG2foIm7ZjDg2zqDA1uUUMSdPyldE/wuw3MS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nItF5ZKiQ+9rwkL0U8xBBb2WoamLDES3ByibvRQIYWD8lMvA9WKhau5qELX9ZIQn/
         H57T6k6aOHQOk8nuykNJpPTsmN6/pUMk+hWY/7ZfsprkgJ2cHGf+ClBhGZ2gGZO2yM
         x8bJR2gO6kBqZW+/36+WJ3U1pTnPJZoZc8YrFGws=
Date:   Thu, 7 Jul 2022 17:11:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 7/7] USB: serial: ftdi_sio: Fill c_*speed fields with
 real baudrate
Message-ID: <Ysb3vBoSp2hIY2f8@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-8-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707145354.29705-8-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 04:53:54PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Calculate baudrate value in c_*speed fields to the real value which was set
> to hardware. For this operation add a new set of functions divisor_to_baud
> for each chip and use it for calculating the real baudrate value.
> 
> Each divisor_to_baud function is constructed as an inverse function of
> corresponding baud_to_divisor function.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Tested-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/usb/serial/ftdi_sio.c | 79 +++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 3bf5750e76de..1f78ae695a1b 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1167,6 +1167,23 @@ static u32 ftdi_sio_baud_to_divisor(int baud)
>  	}
>  }
>  
> +static int ftdi_sdio_divisor_to_baud(u32 divisor)
> +{
> +	switch (divisor) {
> +	case ftdi_sio_b300: return 300;
> +	case ftdi_sio_b600: return 600;
> +	case ftdi_sio_b1200: return 1200;
> +	case ftdi_sio_b2400: return 2400;
> +	case ftdi_sio_b4800: return 4800;
> +	case ftdi_sio_b9600: return 9600;
> +	case ftdi_sio_b19200: return 19200;
> +	case ftdi_sio_b38400: return 38400;
> +	case ftdi_sio_b57600: return 57600;
> +	case ftdi_sio_b115200: return 115200;
> +	default: return 9600;
> +	}
> +}
> +
>  static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base)
>  {
>  	unsigned short int divisor;
> @@ -1189,11 +1206,27 @@ static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base)
>  	return divisor;
>  }
>  
> +static int ftdi_232am_divisor_base_to_baud(unsigned short int divisor, int base)
> +{
> +	static const unsigned char divfrac_inv[4] = { 0, 4, 2, 1 };
> +	unsigned int divisor3;
> +	if (divisor == 0)
> +		divisor = 1;
> +	divisor3 = (GENMASK(13, 0) & divisor) << 3;
> +	divisor3 |= divfrac_inv[(divisor >> 14) & 0x3];
> +	return DIV_ROUND_CLOSEST(base, 2 * divisor3);
> +}
> +
>  static unsigned short int ftdi_232am_baud_to_divisor(int baud)
>  {
>  	 return ftdi_232am_baud_base_to_divisor(baud, 48000000);
>  }
>  
> +static int ftdi_232am_divisor_to_baud(unsigned short int divisor)
> +{
> +	return ftdi_232am_divisor_base_to_baud(divisor, 48000000);
> +}
> +
>  static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base)
>  {
>  	static const unsigned char divfrac[8] = { 0, 3, 2, 4, 1, 5, 6, 7 };
> @@ -1212,11 +1245,30 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base)
>  	return divisor;
>  }
>  
> +static int ftdi_232bm_divisor_base_to_baud(u32 divisor, int base)
> +{
> +	static const unsigned char divfrac_inv[8] = { 0, 4, 2, 1, 3, 5, 6, 7 };
> +	u32 divisor3;
> +	/* Deal with special cases for highest baud rates. */
> +	if (divisor == 0)
> +		divisor = 1;		/* 1.0 */
> +	else if (divisor == 1)
> +		divisor = 0x4001;	/* 1.5 */
> +	divisor3 = (GENMASK(13, 0) & divisor) << 3;
> +	divisor3 |= divfrac_inv[(divisor >> 14) & 0x7];
> +	return DIV_ROUND_CLOSEST(base, 2 * divisor3);
> +}

Always run your patches through checkpatch so you do not get grumpy
maintainers telling you to run your patches through checkpatch...

thanks,

greg k-h
