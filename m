From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: The console log is doubled if earlycon is enabled
Date: Mon, 30 Nov 2015 09:10:34 -0800
Message-ID: <20151130171034.GA14366@kroah.com>
References: <CAK7LNAT5L2uxJ6i-QEYqw9qFLyvADu_E0F5VVTOPqyHbLodTCg@mail.gmail.com>
 <20151128000451.GB22297@kroah.com>
 <CAK7LNARFa8Q1t6RwwQVhTrtXJxnJBQw8QHnbpfNfHouEiGdK0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNARFa8Q1t6RwwQVhTrtXJxnJBQw8QHnbpfNfHouEiGdK0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 30, 2015 at 02:53:49PM +0900, Masahiro Yamada wrote:
> 2015-11-28 9:04 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > On Fri, Nov 27, 2015 at 07:21:06PM +0900, Masahiro Yamada wrote:
> >> Hi,
> >>
> >>
> >> If I add "earlycon" to the kernel parameter, the log message
> >> on the earlycon is also displayed to the regular console.
> >> In other words, the same log messages are displayed twice.
> >>
> >> I noticed this problem on v4.4-rc1.
> >> It has not been fixed in the mainline yet, I think.
> >>
> >> Anybody who has a clue?
> >> (I have not done git-bisect yet.)
> >
> > Can you do 'git bisect'?
> 
> 
> The same problem happened on v4.3.
> (I think I just did not notice the problem before.)
> 
> So, the bad commit is not in the last merge window.

Is it ok for 4.2?  4.1?  Finding out where this started to "fail" would
be good to know...

thanks,

greg k-h
