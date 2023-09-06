Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F0EB8FD5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Sep 2023 14:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbjIFOBa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjIFOB3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Sep 2023 10:01:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627810C6
        for <linux-serial@vger.kernel.org>; Wed,  6 Sep 2023 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694008886; x=1725544886;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HehAqIRVk+DthOcEBMdupV2ScEPTcWDssFB57eWMMTc=;
  b=AcQB0JTlmEpOqauJlWggGeX0NcXAkfjjaRTameGmytLphIMLEvHGnpAQ
   byy3Z1THSvD2YzuWrBmQN2WbJZF/53sR3nu9wyIEpAJ+x1igjbCatAZUi
   FnOqqfxJK7mdOfVZ63KitNQ4s1g3zaE3df4BmXVpqD42QQsYhyTagWG86
   Qq32ZCx31MMNo3/hzSY3wZEypyz3I6r3Xnk5Dyg0uwbO+Anwdw1KIXhaq
   n0qKFDlJzsgckNIyx0f0sS9z8wDnT6ds/9p8YBXUD/oiGfc+P7vjSDH2T
   icxVjSpkCLsUy9Bcg1+3f4nxMpav5VtMfnhLMebJM0wcU3Whpy1mzsp42
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="408073610"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="408073610"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="1072398423"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="1072398423"
Received: from swegrzyn-mobl.ger.corp.intel.com ([10.252.60.192])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:01:11 -0700
Date:   Wed, 6 Sep 2023 17:01:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial <linux-serial@vger.kernel.org>,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH V4 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
In-Reply-To: <1b3f5094-0b14-5a22-8654-a64eb8b7666d@sealevel.com>
Message-ID: <2553da9-7e57-ddd7-770-159e19faa918@linux.intel.com>
References: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com> <aab7aca7-33d5-732c-764d-246e474b747@linux.intel.com> <1b3f5094-0b14-5a22-8654-a64eb8b7666d@sealevel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1469032536-1694008873=:1906"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1469032536-1694008873=:1906
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 6 Sep 2023, Matthew Howell wrote:

> On Wed, 6 Sep 2023, Ilpo Järvinen wrote:
> > On Tue, 5 Sep 2023, Matthew Howell wrote:
> > 
> > > From: Matthew Howell <matthew.howell@sealevel.com
> > >
> > > Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the
> > > current implementation of 8250_exar uses RTS for the auto-RS485-Enable
> > > mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on
> > > Sealevel cards.
> > >
> > > Link: https://lore.kernel.org/all/b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com/
> > >
> > > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > > ---
> > > Fixed style issues from previous submission.
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > > index 3886f78ecbbf..20d2e7148be5 100644
> > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > @@ -78,6 +78,9 @@
> > >
> > >  #define UART_EXAR_RS485_DLY(x)       ((x) << 4)
> > >
> > > +#define UART_EXAR_DLD                                0x02 /* Divisor Fractional */
> > > +#define UART_EXAR_DLD_485_POLARITY   0x80 /* RS-485 Enable Signal Polarity */
> > > +
> > >  /*
> > >   * IOT2040 MPIO wiring semantics:
> > >   *
> > > @@ -439,6 +442,34 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
> > >       return 0;
> > >  }
> > >
> > > +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> > > +                             struct serial_rs485 *rs485)
> > > +{
> > > +     u8 __iomem *p = port->membase;
> > > +     u8 old_lcr;
> > > +
> > > +     generic_rs485_config(port, termios, rs485);
> > > +
> > > +     if (rs485->flags & SER_RS485_ENABLED) {
> > > +             /* Set EFR[4]=1 to enable enhanced feature registers */
> > > +             writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
> > 
> > You should split these to 3 lines to make it easier to follow what's the
> > actual operation taking place here:
> >                 efr = readb(...);
> >                 efr |= UART_EFR_ECB;
> >                 writeb(...);
> > 
> > ...I'm sorry I didn't realize this last time I looked.
> 
> Ok. Will fix in next submission. 
> 
> > > +
> > > +             /* Set MCR to use DTR as Auto-RS485 Enable signal */
> > > +             writeb(UART_MCR_OUT1, p + UART_MCR);
> > > +
> > > +             /* Store original LCR and set LCR[7]=1 to enable access to DLD register */
> > 
> > I guess "store original LCR" path is pretty obvious and can be dropped.
> 
> Ok. I can drop that part of the comment if it is clear otherwise.
>  
> > > +             old_lcr = readb(p + UART_LCR);
> > > +             writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
> > > +
> > > +             /* Set DLD[7]=1 for inverted RS485 Enable logic */
> > > +             writeb(readb(p + UART_EXAR_DLD) | UART_EXAR_DLD_485_POLARITY, p + UART_EXAR_DLD);
> > 
> > Split this as well.
> > 
> > > +             writeb(old_lcr, p + UART_LCR);
> > > +    }
> > 
> > This function should also disable RS-485 if SER_RS485_ENABLED is set but
> > currently it does nothing?
> > 
> > --
> >  i.
> 
> That's what I would have thought as well, but I have electrically verified 
> disabling SER_RS485_ENABLED disables RS485 on the Sealevel cards I have 
> tested. I did this by monitoring the serial signal while a program 
> alternates setting and unsetting SER_RS485_ENABLED and verifying the card 
> is tri-stating when SER_RS485_ENABLED is set and fails to tri-state when 
> SER_RS485_ENABLED is not set.
> 
> I do not know where disabling RS485 is happening in the driver since 
> generic_rs485_config() does not handle this either, but I left it alone 
> since it appears to be working without being handled in the 
> ..._rs485_config() functions.

Okay, I guess it's something in generic_rs485_config() then. I've no 
objection in case it's working as is.

...I was badly mislead by the name of generic_rs485_config() btw. I 
thought it was something in core based on its name (although I also 
couldn't recall when that function would have been added to the core) but 
instead it's static inside exar and it would be better to name it so that 
it's obvious it refers to exar rather than "generic".

-- 
 i.


> 
> > 
> > > +
> > > +     return 0;
> > > + }
> > > +
> > >  static const struct serial_rs485 generic_rs485_supported = {
> > >       .flags = SER_RS485_ENABLED,
> > >  };
> > > @@ -744,6 +775,16 @@ static int __maybe_unused exar_resume(struct device *dev)
> > >       return 0;
> > >  }
> > >
> > > +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> > > +                struct uart_8250_port *port, int idx)
> > > +{
> > > +     int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> > > +
> > > +     port->port.rs485_config = sealevel_rs485_config;
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
> > >
> > >  static const struct exar8250_board pbn_fastcom335_2 = {
> > > @@ -809,6 +850,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
> > >       .exit           = pci_xr17v35x_exit,
> > >  };
> > >
> > > +static const struct exar8250_board pbn_sealevel = {
> > > +     .setup          = pci_sealevel_setup,
> > > +     .exit           = pci_xr17v35x_exit,
> > > +};
> > > +
> > > +static const struct exar8250_board pbn_sealevel_16 = {
> > > +     .num_ports      = 16,
> > > +    .setup           = pci_sealevel_setup,
> > > +     .exit           = pci_xr17v35x_exit,
> > > +};
> > > +
> > >  #define CONNECT_DEVICE(devid, sdevid, bd) {                          \
> > >       PCI_DEVICE_SUB(                                                 \
> > >               PCI_VENDOR_ID_EXAR,                                     \
> > > @@ -838,6 +890,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
> > >               (kernel_ulong_t)&bd                     \
> > >       }
> > >
> > > +#define SEALEVEL_DEVICE(devid, bd) {                 \
> > > +     PCI_DEVICE_SUB(                                 \
> > > +             PCI_VENDOR_ID_EXAR,                     \
> > > +             PCI_DEVICE_ID_EXAR_##devid,             \
> > > +             PCI_VENDOR_ID_SEALEVEL,                 \
> > > +             PCI_ANY_ID), 0, 0,      \
> > > +             (kernel_ulong_t)&bd                     \
> > > +     }
> > > +
> > >  static const struct pci_device_id exar_pci_tbl[] = {
> > >       EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
> > >       EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
> > > @@ -860,6 +921,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
> > >       CONNECT_DEVICE(XR17C154, UART_4_485, pbn_connect),
> > >       CONNECT_DEVICE(XR17C158, UART_8_485, pbn_connect),
> > >
> > > +     SEALEVEL_DEVICE(XR17V352, pbn_sealevel),
> > > +     SEALEVEL_DEVICE(XR17V354, pbn_sealevel),
> > > +     SEALEVEL_DEVICE(XR17V358, pbn_sealevel),
> > > +     SEALEVEL_DEVICE(XR17V4358, pbn_sealevel_16),
> > > +     SEALEVEL_DEVICE(XR17V8358, pbn_sealevel_16),
> > > +
> > >       IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
> > >
> > >       /* USRobotics USR298x-OEM PCI Modems */
> > >
> > 
--8323329-1469032536-1694008873=:1906--
