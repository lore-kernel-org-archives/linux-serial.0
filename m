Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B29CCA483
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiGGPJu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiGGPJt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516824F25
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7BF562347
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70E9C341CD;
        Thu,  7 Jul 2022 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657206588;
        bh=KFjVYm1ymUM3IoOjXLNeiDeGtvrA2++P9AY87eChzFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AqyDkKkW2C0zxRZweNUEefYmF8d5Mo9Uy37EFLAsPH85eBpPi8Hk1mmp9y8Rfm0P/
         KjvzmpNwSUhxJdYPVTkqo9lrnwbBXguZFQSaQq4iL3k/euJVJ2qKfOkrd4m2bnxF5V
         XJo62/RnqMHJU2ivHe+m3KOYpWXFl8ceGunrbIU4=
Date:   Thu, 7 Jul 2022 17:09:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 3/7] USB: serial: ftdi_sio: Extract SIO divisor code to
 function
Message-ID: <Ysb3ORyUAPEOntqK@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-4-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707145354.29705-4-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 04:53:50PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> As a code cleanup for future changes, extract divisor code for SIO chip
> into new function ftdi_sio_baud_to_divisor().
> 
> No functional change.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Tested-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/usb/serial/ftdi_sio.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 717b97f4e094..45a4eeb1fc70 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1150,6 +1150,23 @@ static struct usb_serial_driver * const serial_drivers[] = {
>   * ***************************************************************************
>   */
>  
> +static u32 ftdi_sio_baud_to_divisor(int baud)
> +{
> +	switch (baud) {
> +	case 300: return ftdi_sio_b300;
> +	case 600: return ftdi_sio_b600;
> +	case 1200: return ftdi_sio_b1200;
> +	case 2400: return ftdi_sio_b2400;
> +	case 4800: return ftdi_sio_b4800;
> +	case 9600: return ftdi_sio_b9600;
> +	case 19200: return ftdi_sio_b19200;
> +	case 38400: return ftdi_sio_b38400;
> +	case 57600: return ftdi_sio_b57600;
> +	case 115200: return ftdi_sio_b115200;
> +	default: return -1;

Why not just return 9600 as a default here like the original code did?

And returning a negative number for a u32 is not a good idea for the
obvious reasons you found when you tried to test for it...

thanks,

greg k-h
