From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] OF: Add helper for matching against linux,stdout-path
Date: Thu, 15 Nov 2012 09:04:53 +0100
Message-ID: <20121115080453.GW10369@pengutronix.de>
References: <1351849734-9836-1-git-send-email-s.hauer@pengutronix.de>
 <1351849734-9836-2-git-send-email-s.hauer@pengutronix.de>
 <CACxGe6uW+XN6RDnP+8QFXaCYqqPZO4dZM_aynR6AVMYZT=KuMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40932 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992717Ab2KOIFD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 03:05:03 -0500
Content-Disposition: inline
In-Reply-To: <CACxGe6uW+XN6RDnP+8QFXaCYqqPZO4dZM_aynR6AVMYZT=KuMg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Wed, Nov 14, 2012 at 08:49:54PM +0000, Grant Likely wrote:
> > +int of_device_is_stdout_path(struct device_node *dn)
> > +{
> > +       const char *name;
> > +
> > +       name = of_get_property(of_chosen, "linux,stdout-path", NULL);
> > +       if (name == NULL)
> > +               return 0;
> > +
> > +       if (dn == of_find_node_by_path(name))
> 
> need to of_node_put() the return value of of_find_node_by_path()
> 
> > +               return 1;
> > +
> > +       return 0;
> > +}
> 
> Hi Sascha,
> 
> I'm fine with the helper, but there really is no need for a completely
> separate .c file. Just put it in drivers/of/base.c.

Agreed.

Thanks,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
