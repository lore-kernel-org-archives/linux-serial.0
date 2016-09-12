From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/9] tty: tty_struct dependency clean-ups
Date: Mon, 12 Sep 2016 12:46:55 +0100
Message-ID: <20160912124655.6a698da0@lxorguk.ukuu.org.uk>
References: <20160909223711.26238-1-robh@kernel.org>
        <20160911221424.2d56682a@lxorguk.ukuu.org.uk>
        <CAL_Jsq+tk2_p=pqJz_4iM-xcN5Ecfqhpc_oa0zbBRgS2dOpbOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+tk2_p=pqJz_4iM-xcN5Ecfqhpc_oa0zbBRgS2dOpbOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, 11 Sep 2016 22:05:07 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Sep 11, 2016 at 4:14 PM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
> > On Fri,  9 Sep 2016 17:37:01 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >  
> >> This patch series removes or prepares to remove some of the dependencies
> >> on tty_struct within tty_port drivers. This will allow using tty_ports
> >> directly for so called UART slave devices.  
> >
> > You can create a tty_struct kernel side with the two tiny changes I
> > posted before. Why do you want to do invasive tree wide changes when you
> > can do simple ones ?  
> 
> Well, I don't want to do invasive changes, but I thought the idea was
> to use tty_port struct without a tty_struct.

I posted some tiny patches to break the file/tty requirement in the base
tty code for comment a while ago and they were very tiny for most ldiscs
(n_tty unsurprisingly wouldn't work this way but does anyone need kernel
mode n_tty ?)

Moving termios into the tty_port is IMHO a good thing to do whichever
approach is taken.

> I was planning to keep termios out of tty_port and make clients of
> tty_port carry it if for nothing else not quite understanding all the
> details around the lifetime, init and locking of it. If there's always
> a tty_struct then there's not much point moving it other than which
> struct makes more sense. But that would cause some churn.

The termios lifetime is the lifetime of the port, although it may get
reset at some times.

Alan
