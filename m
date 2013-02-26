From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 0/4] TTY: port hangup and close fixes
Date: Tue, 26 Feb 2013 06:56:21 -0500
Message-ID: <1361879781.3235.0.camel@thor.lan>
References: <1361877272-6074-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:42723 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3BZL40 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2013 06:56:26 -0500
In-Reply-To: <1361877272-6074-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 2013-02-26 at 12:14 +0100, Johan Hovold wrote:
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
> As a side-effect, these patches also fix an issue in USB-serial where we could
> get tty-port callbacks on an uninitialised port after having hung up and
> unregistered a device after disconnect.
> 
> Johan
> 
> 
> v2:
>  - reuse tty reference from hangup and close in shutdown. Both call sites
>    guarantee tty is either NULL or has a kref.

Great, thank you.

Peter


