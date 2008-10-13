From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB -Serial
Date: Mon, 13 Oct 2008 09:00:28 -0700
Message-ID: <20081013160028.GA13629@kroah.com>
References: <241b8f7b0810130406uf41888ct90bec7b08196eff6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <241b8f7b0810130406uf41888ct90bec7b08196eff6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 13, 2008 at 04:36:10PM +0530, Prabhu Chawandi wrote:
> Hi Greg,
> 
>   In v 2.6.12 , whether routing Kernel debug messages was enabled ?
> 
> Or it was enabled in the later versions?

kernel debug messages through a serial console have been in the kernel
since way before 2.6.12.  USB serial console support for this was added
way back in the 2.5 kernels, maybe even in the 2.4 kernel.

But since you are using a kernel that is 3 1/2 years old, you are not
going to get much, if any support from the community for it, sorry.
Please try upgrading to something more recent, like 2.6.27.

good luck,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
