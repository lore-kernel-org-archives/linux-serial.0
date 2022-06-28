Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843DEC43334
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 10:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbiF1KA6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344051AbiF1KAS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 06:00:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA482F03B;
        Tue, 28 Jun 2022 02:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 714FEB81D94;
        Tue, 28 Jun 2022 09:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61B3C341CA;
        Tue, 28 Jun 2022 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656410386;
        bh=J71N4/MLBTUM7CmeOPi8uU3hkTppoPhFLwPp334uvFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRypT3SOgIp397meDtplJ0V7X/dhr7yrZ8oTBl0dgnX+3SkJhfuk9Ltf/gsjKkCvW
         lIqZxtHNk2MZ5Ik3fFtokQc4wGvxQKPGRMsi/+uGIvBXcVN+Rrk18IZXiGy8WnHOaU
         EtIbWgqtwW2leZ1BLas+uefpA1tSG+yCOfsNFr5khG+X4Gj6TGs7QvS3BHKtROBdx8
         PMRk472Z1VnVArM7LYh8MFNZwyUcjP4JKrtzACgJJXzowypoSoxf/Zoo5NmOVqN/o8
         g3pBIZQMEt+xLU7aDfhTbRNDPRUCs1AIw1GFEucBTnHSoTb0+ncUWBsvSOEsbCRgtA
         43Dr2r4gawb5g==
Received: by pali.im (Postfix)
        id 0BD2F7AE; Tue, 28 Jun 2022 11:59:42 +0200 (CEST)
Date:   Tue, 28 Jun 2022 11:59:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: mvebu: Apply old baudrate to termios
Message-ID: <20220628095942.rbpl2iocxoqtzxiy@pali>
References: <20220628094155.26297-1-ilpo.jarvinen@linux.intel.com>
 <20220628095136.fhtjjjkj3mre7hwa@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628095136.fhtjjjkj3mre7hwa@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tuesday 28 June 2022 11:51:36 Pali Rohár wrote:
> On Tuesday 28 June 2022 12:41:55 Ilpo Järvinen wrote:
> > A fallback baud rate was derived from old termios but got never applied
> > to (new/current) termios. Old termios is dropped once ->set_termios()
> > call chain completes, only termios persists the values. Encode also the
> > old baud rate into termios.
> > 
> > Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Hello! Could you explain a bit more what is this patch fixing? I have
> not caught it yet. Do you have a test scenario which can demonstrate
> this issue? Because I have tested this driver more deeply (on Mox
> and Espressobin) and I have not seen any remaining issue with reporting
> incorrect baudrate.

Ou, now I see where is the issue. Patch which I tested and which fixes
reporting baudrate is not in kernel tree yet and it looks like I totally
forgot to sent it to ML. I will send it. Sorry for confusion.

> > ---
> >  drivers/tty/serial/mvebu-uart.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> > index 0429c2a54290..12a79018697f 100644
> > --- a/drivers/tty/serial/mvebu-uart.c
> > +++ b/drivers/tty/serial/mvebu-uart.c
> > @@ -592,10 +592,9 @@ static void mvebu_uart_set_termios(struct uart_port *port,
> >  		if (old)
> >  			baud = uart_get_baud_rate(port, old, NULL,
> >  						  min_baud, max_baud);
> > -	} else {
> > -		tty_termios_encode_baud_rate(termios, baud, baud);
> > -		uart_update_timeout(port, termios->c_cflag, baud);
> >  	}
> > +	tty_termios_encode_baud_rate(termios, baud, baud);
> > +	uart_update_timeout(port, termios->c_cflag, baud);
> >  
> >  	/* Only the following flag changes are supported */
> >  	if (old) {
> > 
> > -- 
> > tg: (f287f971e256..) fix/mvebu-apply-old-baud (depends on: tty-next)
