From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 4/5] serial: sh-sci: Add OF support
Date: Mon, 04 Nov 2013 01:58:21 +0100
Message-ID: <1449714.Sp0o1f9lVb@avalon>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1383042599-25151-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CABYn4sxC02bX7XqN8yQ-gYgZEdaHAUohOjyL3pjGYXK9kd8WXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CABYn4sxC02bX7XqN8yQ-gYgZEdaHAUohOjyL3pjGYXK9kd8WXg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Hi Bastian,

On Friday 01 November 2013 10:47:37 Bastian Hecht wrote:
> Hi Laurent!
> 
> > +struct sci_port_info {
> > +       unsigned int type;
> > +       unsigned int regtype;
> > +       unsigned int brr_algo;
> > +};
> > +
> > +static const struct of_device_id of_sci_match[] = {
> > +       {
> > +               .compatible = "renesas,scif-generic",
> > +               .data = (void *)&(const struct sci_port_info) {
> > +                       .type = PORT_SCIF,
> > +                       .regtype = SCIx_SH4_SCIF_REGTYPE,
> > +                       .brr_algo = SCBRR_ALGO_2,
> > +               },
> > +       }, {
> > +               .compatible = "renesas,scifa-generic",
> > +               .data = (void *)&(const struct sci_port_info) {
> > +                       .type = PORT_SCIFA,
> > +                       .regtype = SCIx_SCIFA_REGTYPE,
> > +                       .brr_algo = SCBRR_ALGO_4,
> > +               },
> > +       }, {
> > +               .compatible = "renesas,scifb-generic",
> > +               .data = (void *)&(const struct sci_port_info) {
> > +                       .type = PORT_SCIFB,
> > +                       .regtype = SCIx_SCIFB_REGTYPE,
> > +                       .brr_algo = SCBRR_ALGO_4,
> > +               },
> > +       }, {
> > +               .compatible = "renesas,hscif-generic",
> > +               .data = (void *)&(const struct sci_port_info) {
> > +                       .type = PORT_HSCIF,
> > +                       .regtype = SCIx_HSCIF_REGTYPE,
> > +                       .brr_algo = SCBRR_ALGO_6,
> > +               },
> > +       }, {
> > +               /* Terminator */
> > +       },
> > +};
> > +MODULE_DEVICE_TABLE(of, of_sci_match);
> 
> I like this version way better than my initial approach,

Thank you.

> given that we only support ARM based ports and we hope the regtype and
> brr_algo won't deviate a lot from the given generic settings for new chips

Hopefully :-) I'm trying to simplify the baud rate algorithms mess, I should 
be able to post patches soon, but I need to test them on hardware first. Would 
you have a sh7780, sh7785 or sh7786 board by any chance ?

> - else the of_sci_match[] array might become a bit bloated. This was the
> former reasoning to introduce all the clumsy OF fields.
> 
> I'm happy that the sci OF support will finally make it into the mainline,
> thanks Laurent!

You're welcome.

-- 
Regards,

Laurent Pinchart

