From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: Regarding Serial consloe
Date: Fri, 10 Oct 2008 09:26:54 -0700
Message-ID: <20081010162654.GA2498@kroah.com>
References: <241b8f7b0810072221s1c84a45cgb21443fd717d625d@mail.gmail.com> <241b8f7b0810072253l57f0fc0bm8356798972089b10@mail.gmail.com> <241b8f7b0810072256lb3611b3x49966d2d1782789b@mail.gmail.com> <20081008143227.GU5387@cathedrallabs.org> <241b8f7b0810091945w12725f3di4a8bab043d3a1bdc@mail.gmail.com> <241b8f7b0810100258u4a393c96s21d491d62a05e50c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <241b8f7b0810100258u4a393c96s21d491d62a05e50c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Aristeu Rozanski <aris-moeOTchvdi7YtjvyW6yDsg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


A: No.
Q: Should I include quotations after my reply?

On Fri, Oct 10, 2008 at 03:28:56PM +0530, Prabhu Chawandi wrote:
> On 10/10/08, Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Yeah...   I did all the configurations.
> >
> > Still not getting the logs :(
> >
> > I feel I am missing the part where USB- serial  will be registered to
> > the tty layer.
> >
> > or Do I need to insert the code where we will be opening the device
> > and performimg the write/read  operations.

No code needs to be added.

Please let us know what errors you are seeing, what does your kernel log
messages show, and so on.  It should work properly if you tell the boot
command line to use the usb-serial port for console messages.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
