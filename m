Return-Path: <SRS0=J/Eu=AI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE3C433E1
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 14:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE5821883
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593267154;
	bh=Mm9Jr0Y6Toy3xKZiWCZpBQOjWvs88DP6/BkXW7NSloI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gb9rGItaYMNoXxyRi5AHJqbb+FpA+ReFbBuxn2UCav/B4VMAa/Y6MF3tcZOH44t4m
	 GdBv+SVYwVTZOIOaWXylaf1dypv9IHxDlLk4io3pmL7CT+O8WYg7LGSYopyP1BZWgN
	 eJx0AeuUmDWkmDpIA/OIOnoQjXcnKad3Cj6BPNzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgF0OMa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Jun 2020 10:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgF0OMa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Jun 2020 10:12:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB4C2184D;
        Sat, 27 Jun 2020 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593267149;
        bh=Mm9Jr0Y6Toy3xKZiWCZpBQOjWvs88DP6/BkXW7NSloI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfrrfsmELqDgVdyohdtQg5RGnq/X72CkFtYXD+vVAHqE8bU22zy+qL2STz3ewIsSp
         a82+ne6RpaLkVeJ5rbGMc/Yhr/6tyXaN6oAKecHhJLWOK+X4sw/UL9jgy/NSwDNSEn
         EEzmq/TNa+IF7b03gev789SKgOHxnvk12u9q00r8=
Date:   Sat, 27 Jun 2020 16:12:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sean.wang@mediatek.com
Cc:     robh+dt@kernel.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, robert.jarzmik@free.fr,
        arnd@arndb.de, p.zabel@pengutronix.de, joel@jms.id.au,
        david@lechnology.com, jan.kiszka@siemens.com,
        heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com,
        matthias.bgg@gmail.com, tthayer@opensource.altera.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v4] tty: serial: don't do termios for BTIF
Message-ID: <20200627141222.GC1901451@kroah.com>
References: <78efa2b1e2599deff4d838b05b4054ec5ac2976a.1592595601.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78efa2b1e2599deff4d838b05b4054ec5ac2976a.1592595601.git.sean.wang@mediatek.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 20, 2020 at 03:59:14AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Bluetooth Interface (BTIF) is designed dedicatedly for MediaTek SOC with
> BT in order to be instead of the UART interface between BT module and Host
> CPU, and not exported to user space to access.
> 
> As the UART design, BTIF will be an APB slave and can transmit or receive
> data by MCU access, but doesn't provide termios function like baudrate and
> flow control setup.
> 
> Even LCR on offset 0xC that is just a FAKELCR
> a. If FAKELCR[7] is equaled to 1, RBR(0x00), THR(0x00), IER(0x04)
>    will not be readable/writable.
> 
> b. If FAKELCR is equaled to 0xBF, RBR(0x00), THR(0x00), IER(0x04),
>    IIR(0x08), and LSR(0x14) will not be readable/writable.
> 
> So adding a new capability 'UART_CAP_NTIO' for the unusual unsupported
> case.
> 
> The bluetooth driver would use BTIF device as a serdev. So the termios
> still function would be called in kernelspace from ttyport_open in
> drivers/tty/serdev/serdev-ttyprt.c.
> 
> Fixes: 1c16ae65e250 ("serial: 8250: of: Add new port type for MediaTek BTIF controller on MT7622/23 SoC")
> Cc: Steven Liu <steven.liu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> --
> v1->v2:
> no change on termios->c_cflag and refine commit message
> 
> v2->v3:
> change the naming from NMOD to NTIO as TIO is a well established prefix
> for termios IOCTLs.
> 
> v3->v4:
> 1. remove appropriate tag
> 2. add the explanation why the termios is required even when the connection
>    isn't exported to userspace.
> ---
>  drivers/tty/serial/8250/8250.h      | 1 +
>  drivers/tty/serial/8250/8250_port.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 52bb21205bb6..0d9d3bfe48af 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -82,6 +82,7 @@ struct serial8250_config {
>  #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
>  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>  					 */
> +#define UART_CAP_NTIO	(1 << 18)	/* UART doesn't do termios */

Naming is hard.  I will never remember what "NTIO" is, how about we make
it explicit:
	define UART_CAP_IGNORE_TERMIOS

And the _CAP_ name is getting out of hand, this isn't a "capability",
it's a "quirk for this port" but that's a battle to worry about later...

thanks,

greg k-h
