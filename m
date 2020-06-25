Return-Path: <SRS0=BL42=AG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5408AC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273D72076E
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593079455;
	bh=N3g7Ksra9IIJA7B8GTRquVYJxy1/dbhL3PGmoep0y/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AZJvwUWt1BIPyzhk+TKOc+HYYHuzOC674cQci40CoffejpiPIn1ylAlV+a3cLCAhw
	 TCbC+XiZLyzXIw/gwsj2mGYXgvQX14UDh5Pn9chvqAnEh7o0b3d9X7ZNcz65SXlnXd
	 i1BeeBGQVQ+y0IgG0du+rFw16uyjCi+Ykd8SvlGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbgFYKEO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390025AbgFYKEO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jun 2020 06:04:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8776120702;
        Thu, 25 Jun 2020 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593079454;
        bh=N3g7Ksra9IIJA7B8GTRquVYJxy1/dbhL3PGmoep0y/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrZR2mRISPRewDUMVwxnOooX/hzIpIxSEgyV06dDSG/kbZ86itIUhYqVB2A2tJpjZ
         j9nRSw3OCuJE9hRB3te+yNys3hPTXstwxypdvAV/thYYTMZHyFLnQI1PWlLpyak98X
         lRRqpGpmg+rRdmjzqYR5WPFD3+QpKlNOEA6uW6X4=
Date:   Thu, 25 Jun 2020 12:04:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vabhav Sharma <vabhav.sharma@oss.nxp.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, v.sethi@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: minimum baud rate support
Message-ID: <20200625100410.GA3327034@kroah.com>
References: <1593078545-11272-1-git-send-email-vabhav.sharma@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1593078545-11272-1-git-send-email-vabhav.sharma@oss.nxp.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 25, 2020 at 03:19:05PM +0530, Vabhav Sharma wrote:
> From: Vabhav Sharma <vabhav.sharma@nxp.com>
> 
> The formula for the baud rate is
> baud rate = "baud clock / ((OSR+1) × SBR)
> 
> Algorithm used in function lpuart32_serial_setbrg() only changes
> the SBR. Even with maxmum value put in, OSR stays at 0x7 and the
> lowest baud rate would be ~ 2600 bps
> 
> Update the algorithm to allow driver operation at 1200,2400 or
> 600 bps
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 90298c4..0fd0fa5f 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1925,6 +1925,10 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
>  			tmp_sbr++;
>  		}
>  
> +		if (tmp_sbr > UARTBAUD_SBR_MASK) {
> +			continue;
> +		}

Always use scripts/checkpatch.pl on your patches so you do not get
grumpy emails from maintainers telling you to use scripts/checkpatch.pl
on your patches...

