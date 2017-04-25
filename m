From: Rich Felker <dalias@libc.org>
Subject: Re: Commit 18e8cf159177 broke qemu-system-sh4 serial input.
Date: Mon, 24 Apr 2017 21:23:43 -0400
Message-ID: <20170425012343.GS17319@brightrain.aerifal.cx>
References: <41d6bb75-5be0-c563-0569-ea37aab58f1e@landley.net>
 <CAMuHMdWtBHTBCNo2-oO2Zv7O8McypcaEMh+_8DD+D1T7GTxAzw@mail.gmail.com>
 <f27afb36-f75c-0a03-dca2-8f318265f520@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f27afb36-f75c-0a03-dca2-8f318265f520@physik.fu-berlin.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Landley <rob@landley.net>, Linux-sh list <linux-sh@vger.kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 21, 2017 at 09:50:39AM +0200, John Paul Adrian Glaubitz wrote:
> On 04/21/2017 09:26 AM, Geert Uytterhoeven wrote:
> > Does anyone have access to real hardware to try?
> > Adrian: does it work on your LANDISK, which also has SH7751R?
> 
> I can give it a try but that will take a few days since I am currently
> not at home where my LANDISK boxes are. I also had issues with the
> IDE driver in the past but Sato-san gave me some tips regarding it.
> 
> However, Rich also has a LANDISK device that I donated for him, so if his
> hardware is currently ready to use, he could give it a try.

Presently my LANDISK is in storage along with lots of other stuff due
to fire, but as far as I know it was not damaged. However I never got
directions for how to install a new kernel and point the bootloader at
it. It'll probably be another couple months before I get to moving
back in and unpacking everything from storage, but if you or anyone
else can get me the info between now and then on how to install new
kernel rather than just dd'ing a whole disk image, I'll follow up as
soon as I can.

Rich
