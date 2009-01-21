From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/serial/8250_pci.c (add support for '8-port
 RS-232 MIC-3620 from advantech'
Date: Wed, 21 Jan 2009 12:32:15 +0000
Message-ID: <20090121123215.1b3acc4d@lxorguk.ukuu.org.uk>
References: <20090118135359.GA3087@deb-support.de>
	<20090119145101.GA16732@ports.donpac.ru>
	<20090119235122.GE21026@deb-support.de>
	<20090120151216.GB16732@ports.donpac.ru>
	<20090121075212.GA18485@deb-support.de>
	<4976DA3D.7050201@teltonika.lt>
	<4976DF6F.2010509@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57067 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758280AbZAUMcI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Jan 2009 07:32:08 -0500
In-Reply-To: <4976DF6F.2010509@wincor-nixdorf.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Niels de Vos <niels.devos@wincor-nixdorf.com>
Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Michael Bramer <michael@debsupport.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> >>  static struct pci_device_id serial_pci_tbl[] = {
> >> +       {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
> >> +               0x3620, PCI_ANY_ID, 0, 0,
> 
> Why not use PCI_VENDOR_ID_ADVANTECH as PCI_SUBVENDOR_ID too?

The Advantech vendor id is not 0x3620. This confused me as well which is
why I asked for an lspci. Advantech has stuck the device id in the
subvendor bits and '1' in the subdevice (so it should be 1 not
PCI_ANY_ID).

Alan
