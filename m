From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Have my PA8800 back online... (serial port missing on v4.14)
Date: Tue, 19 Dec 2017 12:53:04 +0200
Message-ID: <1513680784.7000.170.camel@linux.intel.com>
References: <20171208190644.GA22228@ls3530.fritz.box>
         <1512980798.25007.581.camel@linux.intel.com>
         <43eb21b5-75d9-1142-1307-c2e2d218b362@gmx.de>
         <1513178210.7000.34.camel@linux.intel.com>
         <ebe416dd-aa18-9433-4dd7-67490d5778ee@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <ebe416dd-aa18-9433-4dd7-67490d5778ee@gmx.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>, Frank Scheiner <frank.scheiner@web.de>, linux-parisc@vger.kernel.org, John David Anglin <dave.anglin@bell.net>, linux-serial@vger.kernel.org
Cc: debian-hppa@lists.debian.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2017-12-18 at 21:07 +0100, Helge Deller wrote:
> Hi Andy,
> 
> On 13.12.2017 16:16, Andy Shevchenko wrote:
> > On Tue, 2017-12-12 at 21:11 +0100, Helge Deller wrote:
> > > On 11.12.2017 09:26, Andy Shevchenko wrote:
> > > > 
> > > Thanks for the offer to accept this patch, but maybe we are able
> > > to come up with another patch which simply hides those unsupported
> > > devices (serial port and ATI graphics card device on the Diva
> > > card).
> > > I posted a proposed patch here:
> > > http://www.spinics.net/lists/linux-parisc/msg08187.html
> > 
> > Reading briefly that one I guess it's even better (now I realized
> > you
> > even do not have connectors of those devices outside).
> 
> It's now fixed for parisc by new PCI quirks which
> disable the parisc serial AUX port: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
> mit/?id=bcf3f1752a622f1372d3252d0fea8855d89812e7

Thank you for taking care of this.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
