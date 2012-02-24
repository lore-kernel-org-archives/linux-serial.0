From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial/amba-pl011: Return early in deadlock work-around
 if there is no tty
Date: Fri, 24 Feb 2012 13:47:43 -0800
Message-ID: <20120224214743.GA25330@kroah.com>
References: <1329718024-23623-1-git-send-email-kalle.vahlman@movial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42929 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab2BXVzq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Feb 2012 16:55:46 -0500
Received: by pbcun15 with SMTP id un15so3097855pbc.19
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2012 13:55:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329718024-23623-1-git-send-email-kalle.vahlman@movial.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kalle Vahlman <kalle.vahlman@movial.com>
Cc: linux-serial@vger.kernel.org, stable@kernel.org

On Mon, Feb 20, 2012 at 08:07:04AM +0200, Kalle Vahlman wrote:
> The first amba port does not always have an attached tty, which will
> result in a crash if the work-around is activated.
> 
> This seems to be the case for example on Snowball which has no modem
> hw, which seems to be the main use-case for this work-around.
> ---
>  drivers/tty/serial/amba-pl011.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

Can you re-read Documentation/SubmittingPatches and resend this patch
with the needed information so that I can apply it (hint, you forgot a
signed-off-by: line...)

thanks,

greg k-h
