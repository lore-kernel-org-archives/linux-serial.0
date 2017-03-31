From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: tegra: Map the iir register to default defines
Date: Fri, 31 Mar 2017 15:21:37 +0200
Message-ID: <20170331132137.GA23510@kroah.com>
References: <20170329184806.6577-1-oliver@schinagl.nl>
 <9eed3c8e-a7af-1e1f-659a-a092a89d1679@nvidia.com>
 <0DEBCDAD-C7D3-4DB9-B5F5-408951165662@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0DEBCDAD-C7D3-4DB9-B5F5-408951165662@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Jon Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Jiri Slaby <jslaby@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 30, 2017 at 05:37:41PM +0200, Olliver Schinagl wrote:
> Hey Jon,
> 
> On March 30, 2017 3:42:19 PM CEST, Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> >On 29/03/17 19:48, Olliver Schinagl wrote:
> >> The tegra serial IP seems to be following the common layout and the
> >> interrupt ID's match up nicely. Replace the magic values to match the
> >> common serial_reg defines, with the addition of the Tegra unique End
> >of
> >> Data interrupt.
> >> 
> >> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> >> ---
> >> Note I do not own any tegra hardware and just noticed it while
> >working on my
> >> somewhat related previous patch,
> >> "serial: Do not treat the IIR register as a bitfield"
> >> 
> >> As such, this patch can only be applied after the aforementioned
> >patch or the
> >> iir variable will not have its mask applied yet.
> >
> >Nit-pick. If this is the case, then this should really be part of a
> >patch series so it is obvious to everyone that this should only be
> >applied after the other patch.
> Yes, and it was, but I did not want to have the really big list of names in this much smaller group.

Ok, this is a mess, don't send me patches that need to be applied in a
specific order, yet are not obviously linked together in a single
series.

How do you expect a maintainer to handle this type of stuff?  You need
to make it _OBVIOUS_ as to what I need to do here, otherwise I will get
it wrong.

I'm going to drop all of your patches from my queue and wait for a
resend with the correct order, and ones that work properly, you can do
better than this :)

thanks,

greg k-h
