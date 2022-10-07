Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89048C433FE
	for <linux-serial@archiver.kernel.org>; Fri,  7 Oct 2022 11:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJGLe2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Oct 2022 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJGLe2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Oct 2022 07:34:28 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E56D0CD8
        for <linux-serial@vger.kernel.org>; Fri,  7 Oct 2022 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665142465; x=1696678465;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l2K7nGYVWt28o43ZKNwJyveq1AoUokbsCpcDflZDZZU=;
  b=Wf2L6dCrFRm2E4N+7FJ7w+pyOFp19XdE/TOClGvI8pz1kQToWgQhV57K
   12vqEORRUWDfs3hzZYNgvA8YafhTkKm+oOdsyXhCP5+/tAKB9zwu5S8za
   ezJcMzIqBqD+r7xC579NPQEENABAC85U59FOYfgzK1+UHnCB6TUZpPExS
   rgE1c5bukGVam+4vfyJffywYzphw63LECvvbKGRE8KuAT/lFQ9PTWZUri
   i0v/9G677qkGuOg/ye/bCDXM783OF+7N6nTQyExvK8YEl0vCtRjnnRv5P
   O4xvp46kmEOd9swyV3LI8KkC/zFosxXf7pC/7KuN8XhGGgXRyADLN3R/1
   g==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661810400"; 
   d="scan'208";a="26618452"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Oct 2022 13:34:22 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 07 Oct 2022 13:34:22 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 07 Oct 2022 13:34:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665142462; x=1696678462;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l2K7nGYVWt28o43ZKNwJyveq1AoUokbsCpcDflZDZZU=;
  b=iR5DhFvSRrG/4v0i36QRLEpTqnkB2NXSXe3vDbqbTvO1vwbmLsRXrff3
   pfCvumXwnmPzTTNuJ/6qLVzhVe7SzRWLdoWXQ1jpEsoE3B5fZ2yKQI/GU
   Qh4551/anXC0Lc9ezGc5Nhd9pzuzNAczsT7EyNgY8m/WCtFwmYGA4tv8V
   0H9wiLnJRNH6ctP/acxvvqS13G8ferY8agKVLCJfFr8Gr1quSGQ4Z0hot
   V9RzMmh3aArizekHdL6xyJ25EBMGFayh0KZiMWZV5vsBKDEU6ce/Kim/p
   bbugGMt71/17ePYODVl8fW1hrRBAQ7YQC4CdYbi9P0NSoSTwYeUOynopL
   A==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661810400"; 
   d="scan'208";a="26618451"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Oct 2022 13:34:22 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 03B80280056;
        Fri,  7 Oct 2022 13:34:22 +0200 (CEST)
Message-ID: <07a4612c38cc9ab1bcaf01e5daf0ec1c53db7755.camel@ew.tq-group.com>
Subject: Re: [PATCH v2] serial: Deassert Transmit Enable on probe in
 driver-specific way
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial@vger.kernel.org,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        David Laight <David.Laight@aculab.com>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Peter Hung <hpeter+linux_kernel@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        "Codrin.Ciubotariu@microchip.com" <Codrin.Ciubotariu@microchip.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dario Binacchi <dariobin@libero.it>,
        Bich Hemon <bich.hemon@st.com>, Marek Vasut <marex@denx.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 07 Oct 2022 13:34:19 +0200
In-Reply-To: <20220922163042.GA12887@wunner.de>
References: <e688f63bc28827b0e8c9d8e2319e688aee412d24.1663733425.git.lukas@wunner.de>
         <Yyx0p4d5vcjt2XNB@kroah.com> <20220922154353.GA3559@wunner.de>
         <YyyIIIpPZD1gOToi@kroah.com> <20220922163042.GA12887@wunner.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2022-09-22 at 18:30 +0200, Lukas Wunner wrote:
> On Thu, Sep 22, 2022 at 06:06:56PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Sep 22, 2022 at 05:43:53PM +0200, Lukas Wunner wrote:
> > > On Thu, Sep 22, 2022 at 04:43:51PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Sep 21, 2022 at 06:39:33AM +0200, Lukas Wunner wrote:
> > > > > When a UART port is newly registered, uart_configure_port() seeks to
> > > > > deassert RS485 Transmit Enable by setting the RTS bit in port->mctrl.
> > > > > However a number of UART drivers interpret a set RTS bit as *assertion*
> > > > > instead of deassertion:  Affected drivers include those using
> > > > > serial8250_em485_config() (except 8250_bcm2835aux.c) and some using
> > > > > mctrl_gpio (e.g. imx.c).
> > > > > 
> > > > > Since the interpretation of the RTS bit is driver-specific, it is not
> > > > > suitable as a means to centrally deassert Transmit Enable in the serial
> > > > > core.  Instead, the serial core must call on drivers to deassert it in
> > > > > their driver-specific way.  One way to achieve that is to call
> > > > > ->rs485_config().  It implicitly deasserts Transmit Enable.
> > > > > 
> > > > > So amend uart_configure_port() and uart_resume_port() to invoke
> > > > > uart_rs485_config().  That allows removing calls to uart_rs485_config()
> > > > > from drivers' ->probe() hooks and declaring the function static.
> > > [...]
> > > > This message never made it to lore.kernel.org, so I can't seem to apply
> > > > it using `b4`.
> > > > 
> > > > Can you resend it so that it does make it to the public archives?
> > > 
> > > Yes, both v1 and v2 didn't make it to the mailing list archive.
> > > My suspicion is that the Cc: line was probably too long.
> > > 
> > > I resent as v3 with only you in To: and the mailing list in Cc: and
> > > this time it went through:
> > > 
> > > https://lore.kernel.org/linux-serial/2de36eba3fbe11278d5002e4e501afe0ceaca039.1663860626.git.lukas@wunner.de/
> > > 
> > > On the bright side, v2 contained an embarrassing checkpatch issue
> > > (superfluous newline) and resending as v3 provided a welcome
> > > opportunity to fix that. :)
> > 
> > v3 did not have a changelog :(
> > 
> > v4?
> 
> Well, the changelog is above.  (Only the superfluous newline was removed
> in v3 vis-à-vis v2.)
> 
> Here's a v4 with full changelog:
> 
> https://lore.kernel.org/linux-serial/2de36eba3fbe11278d5002e4e501afe0ceaca039.1663863805.git.lukas@wunner.de/

Hi Lukas,

I've noticed that this patch (well, the version that was applied to
tty.git) also changed the setting of the DTR flag in the MCR register.
Without your patch, I can see that the values passed to
serial8250_out_MCR() alternate between 0x03 and 0x01 when switching
between tx and rx, but with your patch, the values become 0x02 and
0x00.

I'm not sure if setups RS485 exist where the DTR flag is relevant, but
as this was not mentioned in the commit message, I suspect that the
change might have been unintended.

