From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
Date: Tue, 11 Nov 2014 03:30:56 +0900
Message-ID: <20141110183056.GA14178@kroah.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com>
 <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
 <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 10, 2014 at 07:05:14AM -0800, Kevin Cernekee wrote:
> On Mon, Nov 10, 2014 at 6:25 AM, Rob Herring <robh@kernel.org> wrote:
> > On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> >> By default, bcm63xx_uart.c uses the standard 8250 device naming and
> >> major/minor numbers.  There are at least two situations where this could
> >> be a problem:
> >>
> >> 1) Multiplatform kernels that need to support some chips that have 8250
> >> UARTs and other chips that have bcm63xx UARTs.
> >>
> >> 2) Some older chips like BCM7125 have a mix of both UART types.
> >>
> >> Add a new Kconfig option to tell the driver whether to register itself
> >> as ttyS or ttyBCM.  By default it will retain the existing "ttyS"
> >> behavior to avoid surprises.
> >
> > While I understand the desire to have stable names, this is the
> > opposite direction we want to go. Per platform tty names complicates
> > having a generic userspace. It is not so bad since most ARM platforms
> > use ttyS or ttyAMA, but just think what the kernel and userspace side
> > would look like if every single platform did this. We can't change
> > everything to ttyS because the other names are already an ABI.
> >
> > This can be solved with a udev rule to create sym links.
> 
> Is it safe to register two console drivers named "ttyS" with the same
> major/minor numbers?

Not at all, think about what you are asking for here.

Is the kernel allowed to register two block devices with the same
major/minor numbers?

greg k-h
