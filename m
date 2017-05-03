From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serdev: fix serdev_device_write return value
Date: Wed, 3 May 2017 11:06:23 -0700
Message-ID: <20170503180623.GA21159@kroah.com>
References: <20170502001714.11576-1-robh@kernel.org>
 <20170502092527.GC2973@localhost>
 <CAHp75Vc+pK5cMkO=1dHR-Xx8zhe4RR0Zv5KDvChZE6MUfVQwcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vc+pK5cMkO=1dHR-Xx8zhe4RR0Zv5KDvChZE6MUfVQwcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, May 03, 2017 at 08:44:07PM +0300, Andy Shevchenko wrote:
> On Tue, May 2, 2017 at 12:25 PM, Johan Hovold <johan@kernel.org> wrote:
> > On Mon, May 01, 2017 at 07:17:14PM -0500, Rob Herring wrote:
> 
> >> -     return ret < 0 ? ret : (count ? -ETIMEDOUT : 0);
> >> +     return ret < 0 ? ret : (count ? -ETIMEDOUT : wr_cnt);
> >
> > That's some nasty use of the ternary operator. Ditching it completely
> > would be more readable.
> >
> >         if (ret < 0)
> >                 return ret;
> >
> >         if (count)
> >                 return -ETIMEDOUT;
> >
> >         return wr_count;
> 
> 
> While I agree on the first part, I would go still with one ternary at the end:
> 
>             return count ? -ETIMEDOUT : wr_count;

Ick, no, make it easy to read, we write code for developers first, the
compiler second.  Ditching it completly is a good idea.

thanks,

greg k-h
