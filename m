Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D6C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 17:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40BF2067C
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597683698;
	bh=yO4PoRr63jcQQ0ftSvdUnNxZtL/3FxKQFScT69SJ/Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fWGCJy465LA1ZeOkxWjQB3ZtN6LfU+1JxKPbX3D1dmt+iG29FdsNXJeTE0v3APei+
	 ZToxxg0ZNd4BQTHLC+1XJHCUcvD8h4MI7yzNHaCQXqqJ+Kv1AMDDKcMLaTIx+Rvd0B
	 ZFGLVufxTr3CMNQHnK5FPmutPCSIiQrBNZ5taMJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgHQRB3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389145AbgHQRAp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 13:00:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27BB6206FA;
        Mon, 17 Aug 2020 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597683619;
        bh=yO4PoRr63jcQQ0ftSvdUnNxZtL/3FxKQFScT69SJ/Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaBS2/oFgSG5MSTySuwiK+6hhB4ljDcZc/hzpBllKv/U/U90KubJudAXLBhcMZHzJ
         CsdvGlepjVndFjiJ9HREJmTXrjzYGpwhVMYj3uQW5Mer5L/0ugBxwqwcrbkxekaF/c
         ZsPo+DMRLZCrLgA9rCYcobXP1cFqwoddmkMkZo9A=
Date:   Mon, 17 Aug 2020 19:00:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: fix earlycon dependency
Message-ID: <20200817170038.GA725471@kroah.com>
References: <20200817165059.957748-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817165059.957748-1-ztong0001@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 17, 2020 at 12:50:59PM -0400, Tong Zhang wrote:
> parse_options() in drivers/tty/serial/earlycon.c calls
> uart_parse_earlycon() in drivers/tty/serial/serial_core.c
> therefore selecting SERIAL_EARLYCON should automatically
> select SERIAL_CORE, otherwise will result in symbol not
> found error during linking if SERIAL_CORE is not configured
> as builtin

We can handle lines 72 characters long :)

> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

What broke to cause this to be needed?

Can you provide a "Fixes:" tag for this?

> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 8a0352eb337c..42e844314cbb 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -8,6 +8,7 @@ menu "Serial drivers"
>  
>  config SERIAL_EARLYCON
>  	bool
> +	select SERIAL_CORE

Are you _sure_ about this?  This feels odd...

thanks,

greg k-h
