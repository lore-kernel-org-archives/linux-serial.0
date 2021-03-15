Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15049C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5EA64EBE
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCOJHY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhCOJHV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:07:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7858C64EB2;
        Mon, 15 Mar 2021 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615799240;
        bh=BzqmnZya8s8zP6U62RedLvc9G4QXu7PSsdi0djOTSyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHMfCZaZIoMv0wsaE1BAv5m8e4kzPMA2EUofx5DsqqCMCU29B+O8EszF+29EAz815
         7FRP7Kx7ny5LcFqUjO2/RoMBQlS8Fvs5Z3PMghgeAqlJnaM/rIdKdGmvYCd2oE74RC
         txivP0qcKAvSAWRlxIaDS6Ec2/Uc0qzlAY0CrbTR9AYr4kzQYTi/P7ArcyBuTPnw3S
         qR8tSMWsrI9tazKxIZp8klb3YBYPBLMIYryw+LnFu+aEGK4mdV6/YBXmjcTt9rF7gw
         gGnpfeXhKDR2uHxGOz0tN7hqAP3/C4TjpEW4dfDMuxBxCBs+GtFsR/Z/NsaDd6/chj
         st4Sz7u9Bu++Q==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lLjCH-0000yi-DL; Mon, 15 Mar 2021 10:07:34 +0100
Date:   Mon, 15 Mar 2021 10:07:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     Charles Yeh <charlesyeh522@gmail.com>,
        =?utf-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YE8j1XdfQNDGLzZR@hovoldconsulting.com>
References: <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
 <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
 <YEH7okblCx8+Odxn@hovoldconsulting.com>
 <ddc0e424-21c2-b8f4-1b00-f589267d2b51@IEEE.org>
 <YEpAaL9QtVMduEpi@hovoldconsulting.com>
 <9d02257d-cca1-116e-634a-6ac952362c5d@IEEE.org>
 <YEtwNzhCmvyKhRto@hovoldconsulting.com>
 <a475110e-2f44-eeca-3cd2-dd946e5abfe7@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a475110e-2f44-eeca-3cd2-dd946e5abfe7@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 12, 2021 at 08:28:04PM -0500, Michael G. Katzmann wrote:
> On 3/12/21 8:44 AM, Johan Hovold wrote:
> 
> 
> Let me try that patch in the right format 8-)

That's better, but we also need a commit message and and Signed-off-by
line from you. Take a look at the general format of the patches I CCed
you on and there's some more information under Documentation/:

	Documentation/process/submitting-patches.rst

The easiest is probably to use git-format-patch and git-send-email to
prevent the patch from being corrupted (e.g. the tabs below have been
replaced by spaces).
 
> --- a/drivers/usb/serial/pl2303.c    2021-03-12 09:30:22.963992109 -0500
> +++ b/drivers/usb/serial/pl2303.c    2021-03-12 20:00:20.003526891 -0500
> @@ -188,6 +188,7 @@
>      unsigned long quirks;
>      unsigned int no_autoxonxoff:1;
>      unsigned int no_divisors:1;
> +    unsigned int alt_divisors:1;
>  };
>  
>  struct pl2303_serial_private {
> @@ -217,10 +218,12 @@
>      [TYPE_TA] = {
>          .name            = "TA",
>          .max_baud_rate        = 6000000,
> +        .alt_divisors        = true,
>      },
>      [TYPE_TB] = {
>          .name            = "TB",
>          .max_baud_rate        = 12000000,
> +        .alt_divisors        = true,

Are you sure that the TB uses the alternate encoding?

Charles, could you help us out here? Which other device types use the
alternate encoding (e.g. HX(A) or TB) if any?

>      },
>      [TYPE_HXD] = {
>          .name            = "HXD",
> @@ -618,6 +621,46 @@
>      return baud;
>  }
>  
> +static speed_t pl2303_encode_baud_rate_divisor_alt(unsigned char buf[4],
> +                                                                speed_t baud)
> +{
> +        unsigned int baseline, mantissa, exponent;
> +
> +        /*
> +         * Apparently, for the TA version the formula is:
> +         *   baudrate = 12M * 32 / (mantissa * 2^exponent)
> +         * where
> +         *   mantissa = buf[10:0]
> +         *   exponent = buf[15:13 16]
> +         */
> +        baseline = 12000000 * 32;
> +        mantissa = baseline / baud;
> +        if (mantissa == 0)
> +                mantissa = 1;   /* Avoid dividing by zero if baud > 32*12M. */
> +        exponent = 0;
> +        while (mantissa >= 2048) {
> +                if (exponent < 15) {
> +                        mantissa >>= 1; /* divide by 2 */
> +                        exponent++;
> +                } else {
> +                        /* Exponent is maxed. Trim mantissa and leave. */
> +                        mantissa = 2047;
> +                        break;
> +                }
> +        }
> +
> +        buf[3] = 0x80;
> +        buf[2] = exponent & 0x01; // LS bit of exponent
> +        buf[1] = (exponent & ~0x01) << 4 | mantissa >> 8; // 3 bits of the exponent and MS 3 bits of the mantissa
> +        buf[0] = mantissa & 0xff; // LS 8 bits of the mantissa

Please avoid c99-style comments, but perhaps the comment at the start of
function is sufficient here.

Looks great otherwise.

> +
> +        /* Calculate and return the exact baud rate. */
> +        baud = (baseline / mantissa) >> exponent;
> +
> +        return baud;
> +}
> +
> +
>  static void pl2303_encode_baud_rate(struct tty_struct *tty,
>                      struct usb_serial_port *port,
>                      u8 buf[4])
> @@ -645,6 +688,8 @@
>  
>      if (baud == baud_sup)
>          baud = pl2303_encode_baud_rate_direct(buf, baud);
> +    else if (spriv->type->alt_divisors)
> +                baud = pl2303_encode_baud_rate_divisor_alt(buf, baud);
>      else
>          baud = pl2303_encode_baud_rate_divisor(buf, baud);

This works too if you don't want to pass in the port to
pl2303_encode_baud_rate_divisor() and hide the device-type differences
there (e.g. to make the logic in pl2303_encode_baud_rate() easier to
follow).

Johan
