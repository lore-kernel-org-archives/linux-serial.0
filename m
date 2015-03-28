From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on
 =?iso-8859-1?Q?DT=0D?= properties
Date: Fri, 27 Mar 2015 18:36:04 -0700
Message-ID: <20150328013604.488A0C4091F@trevor.secretlab.ca>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
	<1416872182-6440-6-git-send-email-cernekee@gmail.com>
	<54F3914F.3080905@hurleysoftware.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54F3914F.3080905-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sun, 01 Mar 2015 17:23:11 -0500
, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
 wrote:
> Hi Kevin,
> 
> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
> > If an earlycon (stdout-path) node is being used, check for "big-endian"
> > or "native-endian" properties and pass the appropriate iotype to the
> > driver.
> > 
> > Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
> > big-endian property only really makes sense in the context of 32-bit
> > registers, since 8-bit accesses never require data swapping.
> > 
> > At some point, the of_earlycon code may want to pass in the reg-io-width,
> > reg-offset, and reg-shift parameters too.
> > 
> > Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/of/fdt.c              | 7 ++++++-
> >  drivers/tty/serial/earlycon.c | 4 ++--
> >  include/linux/serial_core.h   | 2 +-
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 658656f..9d21472 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
> >  
> >  	while (match->compatible[0]) {
> >  		unsigned long addr;
> > +		unsigned char iotype = UPIO_MEM;
> > +
> >  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
> >  			match++;
> >  			continue;
> > @@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
> >  		if (!addr)
> >  			return -ENXIO;
> >  
> > -		of_setup_earlycon(addr, match->data);
> > +		if (of_fdt_is_big_endian(fdt, offset))
> > +			iotype = UPIO_MEM32BE;
> > +
> > +		of_setup_earlycon(addr, iotype, match->data);
> 
> I know these got ACKs already but as you point out in the commit log,
> earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
> distinction between early_init_dt_scan_chosen_serial() and
> of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
> taught to properly decode of_serial driver bindings instead of a
> stack of parameters to of_setup_earlycon().
> 
> In fact, this patch allows a mis-defined devicetree to bring up a
> functioning earlycon because the 'big-endian' property is directly
> associated with UPIO_MEM32BE, which will create incompatibility problems
> when DT earlycon is fixed to decode the of_serial DT bindings.

That's a good point. This hasn't been merged yet, so there isn't any
impact on addressing this. I would propose that for consistency, the
earlycon code should always default to 8-bit access. if big-endian
accesses are required, then reg-io-width + big-endian must be specified.

Something like the following would do it and would be future-proof. We
can add support for 16 or 64bit big or little endian access if it ever
became necessary.

static int of_flat_dt_get_iotype(unsigned long node)
{
	int size, width = 1;
	__be32 *prop;
	bool bigendian = false;

	if (of_get_flat_dt_prop(node, "big-endian", NULL));
		bigendian = true;

	prop = of_get_flat_dt_prop(node, "reg-io-width", &size);
	if (prop) {
		if (size != sizeof(u32))
			return -EINVAL;
		width = fdt32_to_cpu(*prop);
	}

	switch (width) {
	case 1:
		return UPIO_MEM; /* big-endian flag has no effect */
	case 4:
		return bigendian ? UPIO_MEM32BE : UPIO_MEM32;
	default:
		return -EINVAL;
	}
}

...

	iotype = of_fdt_get_iotype(fdt, offset);
	if (iotype == UPIO_INVAL)
		/*fail*/

g.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
