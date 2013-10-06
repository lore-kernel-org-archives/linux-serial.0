From: Takashi YOSHII <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH 4/6] ARM: shmobile: emev2: Define SMU clock DT bindings
Date: Mon, 7 Oct 2013 02:16:52 +0900
Message-ID: <20131007021652.ced3167a4d03eec809d0b6ee@ops.dti.ne.jp>
References: <52410F86.4040301@renesas.com>
	<20130924131331.0e9a5f830f531655b2ea0ebe@ops.dti.ne.jp>
	<20130924045215.GE3619@verge.net.au>
	<21574726.tiJa6Opb1k@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21574726.tiJa6Opb1k@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

> > > Device tree clock binding document for EMMA Mobile EV2 SMU.
> > > Following nodes are defined to describe clock tree.
> > > - renesas,emev2-smu
> > > - renesas,emev2-smu-clkdiv
> > > - renesas,emev2-smu-gclk
> > 
> > I realise this has been entirely consistent in the past and
> > even as recently as Linus' pre v3.12-rc2 master branch.
> > However, after some recent discussion we are now trying to make our
> > compatibility strings consistently of the form renesas,<unit>-<soc>.
> > 
> > With this in mind I believe the strings should be:
> > 
> > - renesas,smu-emev2
> > - renesas,smu-clkdiv-emev2
> > - renesas,smu-gclk-emev2
> > 
> > To be honest I am not quite sure about the "-clkdiv" and "-gclk"
> > bits and I would appreciate some review from others.
> 
> I don't have access to the EMEV2 datasheet so my ability to comment on this is 
> somehow limited. However, given that the clock hardware is very SoC-specific, 
> it might make sense to keep the names proposed by Yoshii-san. This would be 
> consistent with the other clock bindings.

Just for explanation:
EM/EV2(there is "/" according to its Users Manual) might be a little difficult
 one for general discussion. It stands for "EMMA Mobile EV2", and is a SoC of
"EMMA Mobile" series, they say. So, possibly, the string was
 emmamobile-smu or emmamobile-smu-ev2 if it is EV2 specific variant.

But, EMEV2 is the only SoC known in EMMA Mobile series, and no document found
 to tell if some other one(if any. there used to be, they say) has SMU or not. 
That's why I choose "emev2-smu". This is <unit> part, and no <soc> portion.

> > > +++ b/Documentation/devicetree/bindings/clock/emev2-clock.txt
...
> > > +Example of provider:
> > > +
> > > +usia_u0_sclkdiv: usia_u0_sclkdiv {
> > > +	compatible = "renesas,emev2-smu-clkdiv";
> > > +	reg = <0x610 0>;
> 
> Is the registers space really 0 bytes long ?

Both those are address. as
> > +- reg: Byte offset from SMU base and Bit position in the register

The outer unit (smu) does
> > > +	#address-cells = <2>;
> > > +	#size-cells = <0>;
and no "ranges".
These clock node is defined not as memory-mapped.

Looks strange? I think so.
This _was introduced_ to comply ePAPR that requires the node name to consist
of generic name and @address to make it unique.
So, the first version was like this.
| usia_u0_sclkdiv: clock@610,0 {
| 	compatible = "renesas,emev2-smu-clkdiv";
| 	reg = <0x610 0>;

But later, I trashed it for the consistency with clock nodes without <reg>, say
> > > +	c32ki: c32ki {
> > > +		compatible = "fixed-clock";

I am still not sure what the clock nodes should be. But, I think what we are
 discussing is out of the scope of current ePAPR, which does not give the answer.

> > > +
> 
> There's an extra blank line at the end of the file.
Oops. Thank you.
/yoshii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
