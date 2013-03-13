From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 0/6] TTY: port hangup and close fixes
Date: Wed, 13 Mar 2013 15:50:32 -0400
Message-ID: <1363204232.25976.106.camel@thor.lan>
References: <51361724.4050107@suse.cz>
	 <1362668153-10972-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362668153-10972-1-git-send-email-jhovold@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2013-03-07 at 15:55 +0100, Johan Hovold wrote:
> These patches against 3.9-rc1 fix a few issues with tty-port hangup and
> close.
> 
> The first and fifth patch are essentially clean ups.
> 
> The second and third patch fix the fact that DTR could get raised
> (rather than dropped) at hangup if there are blocked opens. [ Note that
> the second patch has been separated into its own patch and that the
> third patch is new in v3 of this series. ]
> 
> The fourth patch makes sure DTR is dropped also on hangup and that DTR
> is only dropped for initialised ports (where it could have been raised
> in the first place).
> 
> The sixth and final patch, makes sure no tty callbacks are made from
> tty_port_close_start when the port has not been initialised (successfully
> opened). This was previously only done for wait_until_sent but there's
> no reason to call flush_buffer or to honour port drain delay either.
> The latter could cause a failed open to stall for up to two seconds.
> 
> As a side-effect, these patches also fix an issue in USB-serial where we
> could get tty-port callbacks on an uninitialised port after having hung
> up and unregistered a device after disconnect.
> 
> Johan
> 
> 
> v3: 
>  - amend series with fix of DTR sometimes being raised on hang-up
>  - do not lower DTR on hangup if port tty is gone
>  - make sure tty in call to shutdown is refcounted
>  - use cflag-macros throughout

Other than the comments for patch 3/6, this series looks good. Thanks
again for your work on this.

Please cc: me on the USB serial core changes as well, if you don't mind.

Regards,
Peter Hurley
