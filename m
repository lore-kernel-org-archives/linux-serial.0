From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] tty: Fix low_latency BUG
Date: Mon, 24 Feb 2014 14:02:05 +0100
Message-ID: <20140224130205.GD16073@suse.cz>
References: <1393072281-5814-1-git-send-email-peter@hurleysoftware.com>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393072281-5814-1-git-send-email-peter@hurleysoftware.com>
Sender: stable-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Beat Bolli <bbolli@ewanet.ch>, Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Felipe Balbi <balbi@ti.com>, Grant Edwards <grant.b.edwards@gmail.com>, Stanislaw Gruszka <sgruszka@redhat.com>, Hal Murray <murray+fedora@ip-64-139-1-69.sjc.megapath.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Feb 22, 2014 at 07:31:21AM -0500, Peter Hurley wrote:
> --- a/drivers/tty/ipwireless/tty.c
> +++ b/drivers/tty/ipwireless/tty.c
> @@ -176,9 +176,6 @@ void ipwireless_tty_received(struct ipw_tty *tty, unsigned char *data,
>  				": %d chars not inserted to flip buffer!\n",
>  				length - work);
>  
> -	/*
> -	 * This may sleep if ->low_latency is set
> -	 */

This is a no-op change for the ipwireless driver itself, nevertheless
here goes the maintainer's

Acked-by: David Sterba <dsterba@suse.cz>

>  	if (work)
>  		tty_flip_buffer_push(&tty->port);
>  }
