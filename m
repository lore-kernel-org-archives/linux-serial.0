From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: hci_ldsic nested locking problem
Date: Thu, 20 Mar 2014 16:42:16 +0000
Message-ID: <1395333736.22077.32.camel@acox1-desk.ger.corp.intel.com>
References: <20140320163435.GH32692@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140320163435.GH32692-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Muralidharan Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 2014-03-20 at 11:34 -0500, Felipe Balbi wrote:
> Hi,
> 
> when 8250 driver calls uart_write_wakeup(), the tty port lock is already
> taken. hci_ldisc.c's implementation of ->write_wakeup() calls
> tty->ops->write() to actually send the characters, but that call will
> try to acquire the same port lock again.
> 
> Looking at other line disciplines that looks like a bug in hci_ldisc.c.
> Am I correct to assume that ->write_wakeup() is supposed to *just*
> wakeup the bottom half so we handle ->write() in another context ?
> 
> Is it legal to call tty->ops->write() from within ->write_wakeup() ?

It isn't because you might send all the bytes and go

	write
		write_wakeup
			write
				write wakeup
					...

and recurse

Alan
