From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 0/4] TTY: port hangup and close fixes
Date: Wed, 20 Feb 2013 20:53:03 -0500
Message-ID: <1361411583.3456.10.camel@thor.lan>
References: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
	 <1361376172-31860-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:52134 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab3BUBxI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Feb 2013 20:53:08 -0500
In-Reply-To: <1361376172-31860-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, 2013-02-20 at 17:02 +0100, Johan Hovold wrote:
> These patches against tty-next fix a few issues with tty-port hangup and
> close.
> 
> The first and third patch are essentially clean ups.
> 
> The second patch makes sure DTR is dropped also on hangup and that DTR
> is only dropped for initialised ports (where is could have been raised
> in the first place).
> 
> The fourth and final patch, make sure no tty callbacks are made from
> tty_port_close_start when the port has not been initialised (successfully
> opened). This was previously only done for wait_until_sent but there's
> no reason to call flush_buffer or to honour port drain delay either.
> The latter could cause a failed open to stall for up to two seconds.
> 
> As a side-effect, this patches also fix an issue in USB-serial where we
> could get tty-port callbacks on an uninitialised port after having hung
> up and unregistered a device after disconnect.
> 
> Johan

Looks good to me. No further objections :)

> Changes since RFC-series:
>  - fix up the two driver relying on tty_port_close_start directly but
>    that did not manage DTR themselves
> 
> 
> Johan Hovold (4):
>   TTY: clean up port shutdown
>   TTY: fix DTR not being dropped on hang up
>   TTY: clean up port drain-delay handling
>   TTY: fix close of uninitialised ports
> 
>  drivers/tty/mxser.c    |  4 +++
>  drivers/tty/n_gsm.c    |  4 +++
>  drivers/tty/tty_port.c | 71 ++++++++++++++++++++++++++++++--------------------
>  3 files changed, 51 insertions(+), 28 deletions(-)
> 


