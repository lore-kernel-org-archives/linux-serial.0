From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] Move uart_register_driver call to device probe for
 pl010 and sh-sci
Date: Fri, 31 Mar 2017 15:27:42 +0200
Message-ID: <20170331132742.GA23739@kroah.com>
References: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
 <20170324164202.GI7909@n2100.armlinux.org.uk>
 <CAMuHMdUkfzJw6W0jQZPChN+Uqb0Ewkn86o0Pzd+9+Wi1-XZRAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUkfzJw6W0jQZPChN+Uqb0Ewkn86o0Pzd+9+Wi1-XZRAw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Sun, Mar 26, 2017 at 11:22:57AM +0200, Geert Uytterhoeven wrote:
> Hi Russell, Sjoerd,
> 
> On Fri, Mar 24, 2017 at 5:42 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Fri, Mar 24, 2017 at 05:26:32PM +0100, Sjoerd Simons wrote:
> >> When testing on a Renesas board with the PL010 serial driver enabled
> >> serial output broke. Turns out the minor device numbers for both
> >> drivers happen to overlap, causing whichever driver happened to be the
> >> second one to register to fail.
> >
> > How the **** has the SH serial driver ended up with overlapping device
> > numbers?
> 
> Interesting...
> 
> > What happened to our maintained list of allocated major/minor device
> > numbers, which is supposed to stop crap like this happening?
> 
> AMBA PL010 has been assigned major 204, minors 16..31,
> SCI has been assigned major 204, minors 8..11.
> 
> Over the years, Renesas SoCs have been gaining more and more serial
> ports, leading to
> 
>     #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
> 
> with CONFIG_SERIAL_SH_SCI_NR_UARTS=20 in shmobile_defconfig and
> multi_v7_defconfig (although the maximum value on any supported SoC is 18).
> 
> But once the value becomes 5 or more, it starts overflowing into the ttyFWx
> and ttyAMx space.
> 
> How to solve this?
> Time for the serial subsystem to switch to dynamic minors, and get rid of the
> what-is-your-serial-port-called-again-on-this-platform
> multi-million-euro question?

Yes, please, we need to do that.  Let's provide a build option for it,
like USB has had for over a decade.  If it's enabled, it's all dynamic,
if not, the "old style" ones are used.  Then we don't accept any new
reservations, making new drivers use the dynamic number, and over a long
time, all should be good.

thanks,

greg k-h
