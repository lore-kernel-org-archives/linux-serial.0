Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB9C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 15 Apr 2022 09:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351792AbiDOJjO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Apr 2022 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351805AbiDOJjM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Apr 2022 05:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8FAAAB78;
        Fri, 15 Apr 2022 02:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 866A6621CC;
        Fri, 15 Apr 2022 09:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC7DC385A5;
        Fri, 15 Apr 2022 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650015399;
        bh=oSmQpYrhb+dq4itQcQvqK+Xc4SCsDLqJuOTv2GndBj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK9d1J7oJT4dYprURu2gIMYdTkK2CfLMsfvsm/fHIup7X9gsYqqgdpDir+9xi6pRq
         8+grG97Et+a5bqzMdC02OoH3ctzAUTWPlnTRAF6dtKh6J/u3KZICNieDsZqD9a+sXv
         9MUUAuhZB7q4245P1nLWyBj5HYEPJtFVfvGfxtnQ=
Date:   Fri, 15 Apr 2022 11:36:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 00/11] serial: 8250: dw: RZN1 DMA support
Message-ID: <Ylk8pXKgM3LN1rVS@kroah.com>
References: <20220413075141.72777-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413075141.72777-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 13, 2022 at 09:51:30AM +0200, Miquel Raynal wrote:
> Hello,
> 
> Support for the RZN1 DMA engine allows us adapt a little bit the 8250 DW
> UART driver with to bring DMA support for this SoC.
> 
> This short series applies on top of the series bringing RZN1 DMA
> support, currently on its v10, see [1]. Technically speaking, only the DT
> patch needs to be applied after [1]. The other patches can come in at
> any moment, because if no "dmas" property is provided in the DT, DMA
> support will simply be ignored.
> 
> [1] https://lore.kernel.org/dmaengine/20220412193936.63355-1-miquel.raynal@bootlin.com/T/#t

Can you rebase on my tty-next branch please?  This series does not apply
anymore.

thanks,

greg k-h
