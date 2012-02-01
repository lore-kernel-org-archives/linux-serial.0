From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 2/4] qcserial: log when an interface has too many
 altsettings
Date: Wed, 1 Feb 2012 14:23:22 -0800
Message-ID: <20120201222322.GA2333@kroah.com>
References: <20120201210723.GB16802@google.com>
 <20120201211116.GA30758@kroah.com>
 <CADyrwZSN6xeibZzgaPCL7qZfpwrTLipkXwQUOTOMZGpg0uRhHw@mail.gmail.com>
 <20120201220232.GB893@kroah.com>
 <CADyrwZQNMpxh5yTBnH68+0KK9r5NFvFMgad1K8qXouWAHY=1Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADyrwZQNMpxh5yTBnH68+0KK9r5NFvFMgad1K8qXouWAHY=1Rg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ttuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 01, 2012 at 05:15:57PM -0500, ttuttle wrote:
> On Wed, Feb 1, 2012 at 17:02, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > As the code properly handles such an error, my point is, if a user sees
> > this new scary message, what are they supposed to do with it?
> 
> The intent was that when we saw it in logs, we'd know to look straight
> at the USB configuration, but okay.
> 
> > So yes, please drop it.
> 
> Alright.
> 
> > Are you going to resend this series based on the comments so far?
> 
> I can, if it's easier for you than just selectively applying the two
> remaining ones.

No problem, I'll just pick the 2 good ones, thanks.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
