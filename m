From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH 4/5] serial: sh-sci: Add OF support
Date: Fri, 1 Nov 2013 10:47:37 +0100
Message-ID: <CABYn4sxC02bX7XqN8yQ-gYgZEdaHAUohOjyL3pjGYXK9kd8WXg@mail.gmail.com>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1383042599-25151-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:64758 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805Ab3KAJri (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Nov 2013 05:47:38 -0400
In-Reply-To: <1383042599-25151-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Hi Laurent!

> +struct sci_port_info {
> +       unsigned int type;
> +       unsigned int regtype;
> +       unsigned int brr_algo;
> +};
> +
> +static const struct of_device_id of_sci_match[] = {
> +       {
> +               .compatible = "renesas,scif-generic",
> +               .data = (void *)&(const struct sci_port_info) {
> +                       .type = PORT_SCIF,
> +                       .regtype = SCIx_SH4_SCIF_REGTYPE,
> +                       .brr_algo = SCBRR_ALGO_2,
> +               },
> +       }, {
> +               .compatible = "renesas,scifa-generic",
> +               .data = (void *)&(const struct sci_port_info) {
> +                       .type = PORT_SCIFA,
> +                       .regtype = SCIx_SCIFA_REGTYPE,
> +                       .brr_algo = SCBRR_ALGO_4,
> +               },
> +       }, {
> +               .compatible = "renesas,scifb-generic",
> +               .data = (void *)&(const struct sci_port_info) {
> +                       .type = PORT_SCIFB,
> +                       .regtype = SCIx_SCIFB_REGTYPE,
> +                       .brr_algo = SCBRR_ALGO_4,
> +               },
> +       }, {
> +               .compatible = "renesas,hscif-generic",
> +               .data = (void *)&(const struct sci_port_info) {
> +                       .type = PORT_HSCIF,
> +                       .regtype = SCIx_HSCIF_REGTYPE,
> +                       .brr_algo = SCBRR_ALGO_6,
> +               },
> +       }, {
> +               /* Terminator */
> +       },
> +};
> +MODULE_DEVICE_TABLE(of, of_sci_match);

I like this version way better than my initial approach, given that we
only support ARM based ports and we hope the regtype and brr_algo
won't deviate a lot from the given generic settings for new chips -
else the of_sci_match[] array might become a bit bloated. This was the
former reasoning to introduce all the clumsy OF fields.

I'm happy that the sci OF support will finally make it into the
mainline, thanks Laurent!

Bastian
