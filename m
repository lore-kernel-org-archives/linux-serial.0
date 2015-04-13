From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V4 0/5] Add big-endian MMIO support to serial8250
Date: Mon, 13 Apr 2015 19:09:12 +0200
Message-ID: <20150413170912.GA802@kroah.com>
References: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
 <CAL_Jsq+-Yr3oB2=7X2a9XDU_-b+08WfJRJUqVsCHAaQEQxQ1Mg@mail.gmail.com>
 <5527DE27.8060700@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5527DE27.8060700@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Florian Fainelli <f.fainelli@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 10, 2015 at 10:28:55AM -0400, Peter Hurley wrote:
> On 04/10/2015 09:52 AM, Rob Herring wrote:
> > On Thu, Apr 9, 2015 at 3:05 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> >> V3->V4:
> >>
> >> Rebase on Linus' head of tree
> >>
> >> Tweak documentation per Grant's request
> >>
> >> Drop the of_earlycon patches in favor of Peter's series
> > 
> > Are there conflicts with Peter's stuff?
> 
> No.
> 
> It adds the required pieces so that a trivial patch on top of 
> both series will enable mmio32be for earlycon.
> 
> > The series looks good to me.
> 
> Same.
> 
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
