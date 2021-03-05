Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF7C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB9965017
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCEKRz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 05:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhCEKRx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 05:17:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0F0A64F5B;
        Fri,  5 Mar 2021 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614939472;
        bh=Q99OUDVwugO76Y8/5sQpyC2yeh8JaKwhwvwsQwPpdqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yoj8XHzg0B5+TNWALZqqHw9CnJgS7ZS07tOtdRCy+/7QJSH5rXfy302Doxf3QqEbG
         yzqO8fIV+97xRnU03+5IOsJ27sDqii2fo6XDfDabCaZwZQEximU6C0qNs2MxUQaXfK
         w3JhZcOpO9OgCZ0Dd6akaAKSEtkYQWHwdfbBTPISywWHPx8HSROFWdH1WS3OOktX+K
         49h34KzKEv8sG6pUTML5Y1Es4XZWf+EkFSNcc1qRL+utxee10cXiJbHTsuQcLsPcGS
         sMGHPVeJ3UY0g7vIi8NoupwuofMtb2GLduXe3sU46O3jlkUcQobljzpO9YWuKiY1zT
         3zXBR8Ch8X/kA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lI7X4-0001KO-GI; Fri, 05 Mar 2021 11:18:07 +0100
Date:   Fri, 5 Mar 2021 11:18:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 44/44] tty: make everyone's write_room return >= 0
Message-ID: <YEIFXiFx5/gLmGfQ@hovoldconsulting.com>
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-44-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-44-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 02, 2021 at 07:22:14AM +0100, Jiri Slaby wrote:
> The tty line disciplines don't expect tty_operations::write_room to
> return negative values. Fix the five drivers which violate this.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 2 +-
>  drivers/tty/ipwireless/tty.c      | 4 ++--
>  drivers/tty/n_gsm.c               | 2 +-
>  drivers/tty/vcc.c                 | 2 +-
>  drivers/usb/serial/mos7720.c      | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 701dfb32b129..bb3d39307d93 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -1042,7 +1042,7 @@ static int mos7720_write_room(struct tty_struct *tty)
>  
>  	mos7720_port = usb_get_serial_port_data(port);
>  	if (mos7720_port == NULL)
> -		return -ENODEV;
> +		return 0;

This test is bogus and could just be removed, but that's for another
patch.

>  
>  	/* FIXME: Locking */
>  	for (i = 0; i < NUM_URBS; ++i) {

Johan
