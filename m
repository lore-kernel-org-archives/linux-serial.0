Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D1C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE37B610CB
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhESJNP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 05:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344696AbhESJNG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 05:13:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D68860FE4;
        Wed, 19 May 2021 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621415507;
        bh=F6pKKwIPBcGczYtJtMS3QwrOVGxIOQ49Ne5ddiNdoQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPWTM2Jajqu2pS1nhf07dzYZsb28GkWZ8eHPPpoITbmcmJRkJu/qEIVsXgFdzxVIk
         nDnFdHx/AkdE1ykcy7Xg6RF4Qs6QyRICAWII2boOl50TuyrMPWEPy9NRD/NOI2LV9b
         DWVXT0wpwvsUWjNdjjEMzBDYONjxxyoIPBnU+kcnjLIBbV966Q2HJA2FE/GIh94Re+
         umILgRMr/4kJ9qUhvdutmEFS8/Omjso2O2LTL2eEw5OWPOE3/cHoAkQi6DICpKWYCy
         9Fm08M7qdnJLsqAHHZ0tD1kOjNnxUlgx7Jev4zU25qrH2NL+RZ+fck8/CxT7hn/toH
         EotcbMHlvti1Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljIF0-0002ST-QX; Wed, 19 May 2021 11:11:46 +0200
Date:   Wed, 19 May 2021 11:11:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 29/35] USB: serial: digi_acceleport, simplify
 digi_chars_in_buffer
Message-ID: <YKTWUmYkC/qfrLh0@hovoldconsulting.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-30-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505091928.22010-30-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 05, 2021 at 11:19:22AM +0200, Jiri Slaby wrote:
> "if"'s true branch in digi_chars_in_buffer returns. So there is no need
> for "else" and indented code. Remove this else and shift the code to the
> left.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: linux-usb@vger.kernel.org
> ---
>  drivers/usb/serial/digi_acceleport.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
> index 19ee8191647c..0c4d611621c2 100644
> --- a/drivers/usb/serial/digi_acceleport.c
> +++ b/drivers/usb/serial/digi_acceleport.c
> @@ -1050,12 +1050,11 @@ static unsigned int digi_chars_in_buffer(struct tty_struct *tty)
>  			priv->dp_port_num, port->bulk_out_size - 2);
>  		/* return(port->bulk_out_size - 2); */
>  		return 256;
> -	} else {
> -		dev_dbg(&port->dev, "digi_chars_in_buffer: port=%d, chars=%d\n",
> -			priv->dp_port_num, priv->dp_out_buf_len);
> -		return priv->dp_out_buf_len;
>  	}
>  
> +	dev_dbg(&port->dev, "digi_chars_in_buffer: port=%d, chars=%d\n",
> +		priv->dp_port_num, priv->dp_out_buf_len);
> +	return priv->dp_out_buf_len;
>  }

This doesn't look like much of an improvement so I'm dropping this one.

If we want to clean this up we should use a common exit path for both
branches. I'll send a couple of patches to address this and a related
issue.

Johan
