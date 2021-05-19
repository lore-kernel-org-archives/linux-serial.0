Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F3C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11120611AE
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbhESJJP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 05:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237196AbhESJJP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 05:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42E0610CB;
        Wed, 19 May 2021 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621415275;
        bh=bZK3hm/bg/CBnl2ZxqH/c+W9ibTH1S+LBnaaWX6kEsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J87icpHOkDItxssUPenGLlbITZAAeLkUklDl6Iqyc78G1VKIPjDuvADJS8B+D7rii
         PIlvv5cc1cs0lnu0YoAlMitEZUL0Ox4Od4nIJTrFKGgqnkgMu6GXhvdOeAGv1N41TW
         1OE9dUXyDE5NcpoilmJzrhbSo9N3F39PnU4tO1kgrSnev/40keMSQY6fkJyRdsPUP3
         a5Yctc+TE1XToPBAMYYO935oK42i4MtCZJ3IgWEs6cgbKtIVHRtsIRPxEbuACq0TtD
         huf1ADFWJA9BxTeXVr4KVNKmcvpOylvQtoffVD6eygFqjmNlF6BlFOiv6SeSMPeFH3
         raFpTG1g4tTqg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljIBG-0002R5-Ux; Wed, 19 May 2021 11:07:55 +0200
Date:   Wed, 19 May 2021 11:07:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 23/35] USB: serial: make usb_serial_driver::write_room
 return uint
Message-ID: <YKTVaiinpCOy9xX8@hovoldconsulting.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-24-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505091928.22010-24-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 05, 2021 at 11:19:16AM +0200, Jiri Slaby wrote:
> Line disciplines expect a positive value or zero returned from
> tty->ops->write_room (invoked by tty_write_room). Both of them were
> switched in the previous patch. So now, switch also
> usb_serial_driver::write_room and all its users.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: linux-usb@vger.kernel.org
> ---
>  drivers/usb/serial/cyberjack.c        | 4 ++--
>  drivers/usb/serial/cypress_m8.c       | 8 ++++----
>  drivers/usb/serial/digi_acceleport.c  | 8 ++++----
>  drivers/usb/serial/garmin_gps.c       | 2 +-
>  drivers/usb/serial/generic.c          | 6 +++---
>  drivers/usb/serial/io_edgeport.c      | 6 +++---
>  drivers/usb/serial/io_ti.c            | 6 +++---
>  drivers/usb/serial/ir-usb.c           | 6 +++---
>  drivers/usb/serial/keyspan.c          | 4 ++--
>  drivers/usb/serial/kobil_sct.c        | 4 ++--
>  drivers/usb/serial/mos7720.c          | 6 +++---
>  drivers/usb/serial/mos7840.c          | 7 +++----
>  drivers/usb/serial/opticon.c          | 2 +-
>  drivers/usb/serial/oti6858.c          | 6 +++---
>  drivers/usb/serial/quatech2.c         | 4 ++--
>  drivers/usb/serial/sierra.c           | 2 +-
>  drivers/usb/serial/ti_usb_3410_5052.c | 8 ++++----
>  drivers/usb/serial/usb-wwan.h         | 2 +-
>  drivers/usb/serial/usb_wwan.c         | 6 +++---
>  include/linux/usb/serial.h            | 4 ++--
>  20 files changed, 50 insertions(+), 51 deletions(-)
 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 6ee83886e2c9..d9cc7f840d48 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -1033,11 +1033,11 @@ static void mos7720_break(struct tty_struct *tty, int break_state)
>   *	If successful, we return the amount of room that we have for this port
>   *	Otherwise we return a negative error number.
>   */
> -static int mos7720_write_room(struct tty_struct *tty)
> +static unsigned int mos7720_write_room(struct tty_struct *tty)
>  {
>  	struct usb_serial_port *port = tty->driver_data;
>  	struct moschip_port *mos7720_port;
> -	int room = 0;
> +	unsigned int room = 0;
>  	int i;
>  
>  	mos7720_port = usb_get_serial_port_data(port);
> @@ -1051,7 +1051,7 @@ static int mos7720_write_room(struct tty_struct *tty)
>  			room += URB_TRANSFER_BUFFER_SIZE;
>  	}
>  
> -	dev_dbg(&port->dev, "%s - returns %d\n", __func__, room);
> +	dev_dbg(&port->dev, "%s - returns %u\n", __func__, room);
>  	return room;
>  }
>  
> diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
> index 28e4093794e0..f25d4ba43b9a 100644
> --- a/drivers/usb/serial/mos7840.c
> +++ b/drivers/usb/serial/mos7840.c
> @@ -815,15 +815,14 @@ static void mos7840_break(struct tty_struct *tty, int break_state)
>   *	this function is called by the tty driver when it wants to know how many
>   *	bytes of data we can accept for a specific port.
>   *	If successful, we return the amount of room that we have for this port
> - *	Otherwise we return a negative error number.

This is arguably an unrelated change, and you're not removing these
outdated comments consistently (e.g. mos7720 above) so I've dropped this
bit for now.

Will send a follow up patch to clean it up all these instances instead.

>   *****************************************************************************/
>  
> -static int mos7840_write_room(struct tty_struct *tty)
> +static unsigned int mos7840_write_room(struct tty_struct *tty)
>  {
>  	struct usb_serial_port *port = tty->driver_data;
>  	struct moschip_port *mos7840_port = usb_get_serial_port_data(port);
>  	int i;
> -	int room = 0;
> +	unsigned int room = 0;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&mos7840_port->pool_lock, flags);

Now applied with an amended commit message.

Johan
