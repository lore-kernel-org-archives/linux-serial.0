Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2913C27C76
	for <linux-serial@archiver.kernel.org>; Wed, 25 Jan 2023 12:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjAYMYH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Jan 2023 07:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjAYMYG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Jan 2023 07:24:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9FF77B;
        Wed, 25 Jan 2023 04:24:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53056B819AA;
        Wed, 25 Jan 2023 12:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDDDC433D2;
        Wed, 25 Jan 2023 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674649443;
        bh=YXyoT+OAcyP/O85pLpfSt/lO9KRCLwnIbjwX7ykOwBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Owgm524FmlhfX7U8gd6XDaBWfOR1yiy8Gy1krkZ3lhkO8/kUYxdUbUTJOjzyMVNt9
         ISphhqmAoY4n+6CTc9A6H1myewoI4CQDSFIhEFgR0Ldzs7SotTjjLcgennzXE+SS50
         3QeXoujpfmmIP1TPDJ2fwi9rbGWQb+uhp2nUtAqk=
Date:   Wed, 25 Jan 2023 13:24:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        quic_vnivarth@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com
Subject: Re: [PATCH V2] Serial: core: Add compat ioctl support
Message-ID: <Y9EfYCBngFAG+RBw@kroah.com>
References: <20230125113418.7221-1-quic_vdadhani@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125113418.7221-1-quic_vdadhani@quicinc.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 25, 2023 at 05:04:18PM +0530, Viken Dadhaniya wrote:
> Current serial core driver doesn't support compat_ioctl
> due to which 32-bit application is not able to send
> ioctls to driver on a 64-bit platform.
> 
> Added compat_ioctl support in serial core to handle
> ioctls from 32-bit applications on a 64-bit platform.
> 
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  drivers/tty/serial/serial_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index b9fbbee598b8..ad4c3a5a3d29 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1601,6 +1601,12 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>  	return ret;
>  }
>  
> +static long
> +uart_compat_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
> +{
> +	return (long)uart_ioctl(tty, cmd, arg);

How does this "fix" your out-of-tree driver at all?  What command is
being sent that has this incorrect that this simple "pass through" is
going to solve?

Can you point us at the out-of-tree code please?

thanks,

greg k-h
