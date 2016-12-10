From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: potential NULL dereference
Date: Sat, 10 Dec 2016 15:10:42 +0100
Message-ID: <20161210141042.GA19758@kroah.com>
References: <1481322636-30847-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481322636-30847-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

On Sat, Dec 10, 2016 at 01:30:36AM +0300, Alexey Khoroshilov wrote:
> tty_port_tty_get() might return a tty which is NULL
> if the port is not associated with a tty
> (e.g. due to close or hangup).
> But lpuart_start_rx_dma() dereferences tty without any check.

Are you sure that tty could ever be NULL here?  This function is only
called in places that seem to have a valid tty, with the maybe exception
of the resume call path.  Can you audit this a bit better to be sure one
way or the other please?

thanks,

greg k-h
