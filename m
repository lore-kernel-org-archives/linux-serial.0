From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 12/29] ARM: shmobile: r7s72100: Don't define SCIF platform data in an array
Date: Mon, 11 Nov 2013 03:41:15 +0100
Message-ID: <8818606.yov1uvl232@avalon>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1384054421-13357-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <527FD1F8.7040309@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <527FD1F8.7040309@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Hi Sergei,

On Sunday 10 November 2013 22:35:36 Sergei Shtylyov wrote:
> Hello.
> 
> On 10-11-2013 7:33, Laurent Pinchart wrote:
> > The SCIF driver is transitioning to platform resources. Board code will
> > thus need to define an array of resources for each SCIF device. This is
> > incompatible with the macro-based SCIF platform data definition as an
> > array. Rework the macro to define platform data as individual
> > structures.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   arch/arm/mach-shmobile/setup-r7s72100.c | 49
> >   +++++++++++++++------------------ 1 file changed, 22 insertions(+), 27
> >   deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c
> > b/arch/arm/mach-shmobile/setup-r7s72100.c index d4eb509..dbcbb81 100644
> > --- a/arch/arm/mach-shmobile/setup-r7s72100.c
> > +++ b/arch/arm/mach-shmobile/setup-r7s72100.c
> 
> [...]
> 
> > @@ -39,35 +39,30 @@
> 
> [...]
> 
> > -static inline void r7s72100_register_scif(int idx)
> > -{
> > -	platform_device_register_data(&platform_bus, "sh-sci", idx, 
&scif[idx],
> > -				      sizeof(struct plat_sci_port));
> > -}
> > +#define r7s72100_register_scif(index)					       \
> > +	platform_device_register_data(&platform_bus, "sh-sci", index,	       
\
> > +					  &scif##index##_platform_data,	       \
> > +					  sizeof(scif##index##_platform_data))
> 
> Not sure why you changes the indentation here, it was alright before the
> patch.

No reason, that's a mistake, I'll fix it. Thank you for pointing it out.

-- 
Regards,

Laurent Pinchart

