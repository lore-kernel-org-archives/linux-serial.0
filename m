Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5328CEE49AB
	for <linux-serial@archiver.kernel.org>; Wed, 23 Aug 2023 07:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHWHG4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Aug 2023 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjHWHGz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Aug 2023 03:06:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB19CE3
        for <linux-serial@vger.kernel.org>; Wed, 23 Aug 2023 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692774413; x=1724310413;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fZ8tLDyRiRIwBFLXGpEbmxb/jpv4CThMvGcQu+4Ez7I=;
  b=T53xm+JMtTUibG5av4RhwOtPapnZHJBRl98j4ULVYEI8DChBgp+8aBOv
   t22q7/rdR+gKUEDo4k6U3JPrBzWgsKZwSrwO2GtJvcWIPgUow2vgq+uqW
   uLba34zittrMaHUQKUOENLeKh9axHnwI41PRWsIWjZz5yWu+pxZnlg/xK
   CGAeaCoA6Kw6jw1cmh5CqweFN6iVB8o4vse3zl+yuMS244nL3YT+C/4ac
   FbuDkP61E6JJr4Pk0V7ovJm0E7+j8pkd5PjfXR9X2q2QNizqEuSof49pQ
   dxyO+Ap8WLl6KSYvBSH1hRkMYj96gilRbY8FeIPNPXRuqL2A/fGGLVgMs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="371502127"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="371502127"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="730108046"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="730108046"
Received: from amangalo-mobl4.ger.corp.intel.com ([10.252.55.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:06:50 -0700
Date:   Wed, 23 Aug 2023 10:06:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com
Subject: Re: [PATCH 2/2] serial: exar: Add RS-485 Support for Sealevel XR17V35X
 based cards
In-Reply-To: <fa478ca-d6e-859-e68a-374f405f3a58@sealevel.com>
Message-ID: <40b2ef32-62cd-6022-8eb1-b7c78f42d43c@linux.intel.com>
References: <766dab31-6982-67d9-ead9-30f61648d7a2@sealevel.com> <bd7f9d51-7cf4-d3f5-d2d7-3c822656f67d@linux.intel.com> <fa478ca-d6e-859-e68a-374f405f3a58@sealevel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-587514827-1692774412=:1805"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-587514827-1692774412=:1805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 22 Aug 2023, Matthew Howell wrote:
> On Tue, 22 Aug 2023, Ilpo Järvinen wrote:
> > On Mon, 21 Aug 2023, Matthew Howell wrote:
> > 
> > Thanks for the patch.
> > 
> > > From: Matthew Howell <matthew.howell@sealevel.com>
> > >
> > > Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the
> > > current implementation of 8250_exar uses RTS for the auto-RS485-Enable
> > > mode of the XR17V35X UARTs.
> > >
> > > sealevel_rs485_config(): Configures XR17V35X registers for Auto-RS485
> > > Enable using DTR.
> > > pci_sealevel_startup(): Calls pci_xr17v35x_setup(), then sets
> > > rs485_config to sealevel_rs485_config().
> > 
> > The changelog doesn't read well as is. The logical flow breaks when you
> > jump to describe functions.
> > 
> > > signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > 
> > Start with capital S.
> > 
> > > ---
> > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > > index 018cbaaf238c..246cfb3cc3f8 100644
> > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > @@ -390,6 +390,8 @@ static void __xr17v35x_unregister_gpio(struct platform_device *pdev)
> > >       platform_device_unregister(pdev);
> > >  }
> > >
> > > +
> > > +
> > 
> > Please remove this extra change.
> > 
> > >  static const struct property_entry exar_gpio_properties[] = {
> > >       PROPERTY_ENTRY_U32("exar,first-pin", 0),
> > >       PROPERTY_ENTRY_U32("ngpios", 16),
> > > @@ -439,6 +441,35 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
> > >       return 0;
> > >  }
> > >
> > > +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> > > +                             struct serial_rs485 *rs485)
> > > +{
> > > +     bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
> > 
> > No need for !!() if assigning to bool.
> > 
> 
> I just did it that way because generic_rs485_config() does it the same and
> I assumed there was a reason for doing it that way. Are you sure !!() 
> isn't needed here for some reason?

Implicit conversion to bool handles it just fine without those (and as 
always, sure there are many examples in the kernel with those but it 
doesn't mean we should keep adding more).

Although now that I look more into the surrounding code, it seems that 
is_rs485 only used in the if condition so having a local bool for that 
seems a bit overkill and the if condition could have that check.

> > > +     u8 __iomem *p = port->membase;
> > > +     u8 old_lcr;
> > > +    generic_rs485_config(port, termios, rs485);
> > 
> > Use tab to indent. Leave one empty line after declarations.
> > 
> > > +
> > > +     if (is_rs485) {
> > > +             // Set EFR[4]=1 to enable enhanced feature registers
> > > +             writeb(readb(p + UART_XR_EFR) | 0x10, p + 0x09);
> > > +
> > > +             // Set MCR to use DTR as Auto-RS485 Enable signal
> > > +             writeb(0x04, p + UART_MCR);
> > > +
> > > +             // Store original LCR and set LCR[7]=1 to enable access to DLD register
> > > +             old_lcr = readb(p + UART_LCR);
> > > +             writeb(old_lcr | 0x80, p + UART_LCR);
> > > +
> > > +             // Set DLD[7]=1 for inverted RS485 Enable logic
> > > +             writeb(readb(p + 0x02) | 0x80, p + 0x02);
> > 
> > Please don't use numeric literals. You should add defines (or use existing
> > ones) with proper names in all these cases.
> > 
> > If the names for the defines are good enough, the comments become
> > redundant and can be removed so please check that too after naming things
> > properly.
> > 
> > > +
> > > +             // Reset LCR to orginal value
> > 
> > Unnecessary (very obvious) comment, please drop it.
> > 
> > > +             writeb(old_lcr, p + UART_LCR);
> > > +    }
> > > +
> > > +     return 0;
> > > + }
> > > +
> > >  static const struct serial_rs485 generic_rs485_supported = {
> > >       .flags = SER_RS485_ENABLED,
> > >  };
> > > @@ -744,6 +775,19 @@ static int __maybe_unused exar_resume(struct device *dev)
> > >       return 0;
> > >  }
> > >
> > > +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> > > +                                                       struct uart_8250_port *port, int idx)
> > > +{
> > > +     int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> > > +
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     port->port.rs485_config = sealevel_rs485_config;
> > 
> > Do you need to setup .rs485_supported too? (I'm not sure how the init
> > works with this driver whether the default one gets used by some logic
> > or not).
> > 
> > --
> >  i.
> 
> I don't believe so since .rs485_supported is assigned in 
> pci_xr17v35x_setup(). If I assigned .rs485_supported here I would just use 
> the same code as pci_xr17v35x_setup(), which seems like needless 
> duplication to me.

Okay, thanks for checking.

> Will fix the various small issues and resubmit within the next few days.

-- 
 i.

--8323329-587514827-1692774412=:1805--
