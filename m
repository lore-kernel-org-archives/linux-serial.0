From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Revert "serial: imx: Move imx_port_ucrs_save/restore
 under CONFIG_CONSOLE_POLL"
Date: Wed, 6 Feb 2013 13:36:34 -0800
Message-ID: <20130206213634.GA2673@kroah.com>
References: <1360184403-4891-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:40905 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758539Ab3BFVgi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 16:36:38 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so2219286iak.1
        for <linux-serial@vger.kernel.org>; Wed, 06 Feb 2013 13:36:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360184403-4891-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Feb 06, 2013 at 07:00:02PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>>
> 
> This reverts commit cdc8da3998dcc50cee2f81904c16ebdbd7ec2cee.
> 
> In my attempt to fix a build warning on arm randconfig a build error on 
> imx_v6_v7_defconfig was introduced, so revert it for now.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/tty/serial/imx.c |   42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

You forgot to add a "Reported-by:" line to this patch, I'll go do so...

