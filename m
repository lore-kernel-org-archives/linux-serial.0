From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 0/4] tty: port hangup and close issues
Date: Wed, 13 Feb 2013 19:05:32 +0100
Message-ID: <20130213180532.GA725@localhost>
References: <20130213142513.GA21078@localhost>
 <1360776446-31371-1-git-send-email-jhovold@gmail.com>
 <20130213173630.63e29b47@www.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130213173630.63e29b47-+KEw/ACL1GZE/aiTQr5FLb0Ud+EcFu5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 13, 2013 at 05:36:30PM +0000, Alan Cox wrote:
> > [ Note that this closing of an uninitialised port seems to be a bug in
> >   itself, which these patches aim to fix. ]
> 
> You don't want to be cc'ing me on these - not my problem any more.
> 
> (but you might want to fix the fact you reference port->tty without the
> lock or refcounts 8))

Thanks. :) Removing you from Cc.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
