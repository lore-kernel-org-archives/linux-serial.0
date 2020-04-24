Return-Path: <SRS0=qPbX=6I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7063C2BA1A
	for <linux-serial@archiver.kernel.org>; Fri, 24 Apr 2020 05:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C415920774
	for <linux-serial@archiver.kernel.org>; Fri, 24 Apr 2020 05:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587706635;
	bh=UpjdYfWzhaIBWwT8pfBeT5E2eAvIuj0KkNBR5ForkP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=13yqZsXSewiqMQgA21r6Y5Ct//FOkwH7iQniJP9tVXA2BMHKvXDnhQdvm9/bpU6sC
	 NdNOaNexUt7m2I1crfBxme5yc8DlgeO57QDQhP1O4T1BcMeJ2m/btbiTAk4PsEj8+a
	 UccQYaoRIBAxxphTs9y1d5kv4HI3Y7I78uE7JBaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgDXFhP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgDXFhP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Apr 2020 01:37:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C808D2075A;
        Fri, 24 Apr 2020 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587706634;
        bh=UpjdYfWzhaIBWwT8pfBeT5E2eAvIuj0KkNBR5ForkP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xRAZIkUacZko7ajq7cHgKyFBma9mq+G+xqKbHfA9RNyQ85imZkOzVX+M8T8pPEBpX
         HjMiJaSUqzGWbQVIFLn8NU2K1bIYEo3FgiiElxYqvGeI0GunAOkV+dFb52E7hqyOuZ
         mGR5wIQ88ku15rmA65YXFz2L+nTo8+7OdvZoqyLQ=
Date:   Fri, 24 Apr 2020 07:37:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/3] 32-bit access for TX/RX hold registers for
 samsung_tty driver
Message-ID: <20200424053711.GB103562@kroah.com>
References: <20200420013300.17249-1-hyunki00.koo@samsung.com>
 <CGME20200420233607epcas2p305dbd652ab73592a32c17773c1fce329@epcas2p3.samsung.com>
 <20200420233558.11879-1-hyunki00.koo@samsung.com>
 <000a01d619d0$ee167730$ca436590$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01d619d0$ee167730$ca436590$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 24, 2020 at 09:40:18AM +0900, Hyunki Koo wrote:
> On Sat, April 21, 2020 at 08:36:00 AM +0900, Hyunki Koo wrote:
> > 
> > Change in v8:
> > - spit into 3 patch
> >   [1/3] create the new functions with no functional change to the code as-
> > is.
> >   Replace rd_regb/wr_regb with rd_reg/wr_reg for general usage.
> >   [2/3] add the new binding reg-io-width in device tree
> >   [3/3] add the new funtinality of rd_reg / wr_reg and wr_reg_barrier
> >         to support 32-bit access for the TX/RX hold registers UTXH and URXH.
> > 
> > Change in v7:
> > - [1/2] correct build error on running 'make dt_binding_check'
> > Documentation/devicetree/bindings/serial/samsung_uart.yaml:  mapping
> > values are not allowed in this context
> >   in "<unicode string>", line 36, column 13
> >   Documentation/devicetree/bindings/Makefile:12: recipe for target
> > 'Documentation/devicetree/bindings/serial/samsung_uart.example.dts'
> > failed
> >   make[1]: ***
> > [Documentation/devicetree/bindings/serial/samsung_uart.example.dts]
> > Error 1
> >   make[1]: *** Waiting for unfinished jobs....
> >   Makefile:1262: recipe for target 'dt_binding_check' failed
> >   make: *** [dt_binding_check] Error 2
> > - [2/2] add commit message of reviewed by and tested by in commit
> > message
> >   Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >   Tested on Odroid HC1 (Exynos5422):
> >   Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > Change in v6:
> > - [2/2] clean description of reg-io-width
> >   allOf is not needed. Just enum [1, 2] is enough.
> > 
> > Changes in v5:
> > - spit into 2 patch, newly added patch for dt-binding
> >   [1/2] newly added dt-binding and go as first patch in this series.
> >   [2/2] go as second patch in this series.
> > 
> > Changes in v4:
> > - correct variable types and change misleading function name
> > 
> > Changes in v3:
> > - line 2031: remove redundant init value  for ourport->port.iotype
> > 
> > Changes in v2:
> > - line 954 : change rd_regl to rd_reg in for backward compatibility.
> > - line 2031: Add init value for ourport->port.iotype  to UPIO_MEM
> > 
> > 
> > Hyunki Koo (3):
> >   serial: samsung: Replace rd_regb/wr_regb with rd_reg/wr_reg
> >   dt-bindings: serial: Add reg-io-width compatible
> >   tty: samsung_tty: 32-bit access for TX/RX hold registers
> > 
> >  .../devicetree/bindings/serial/samsung_uart.yaml   |  8 +++
> >  drivers/tty/serial/samsung_tty.c                   | 76 ++++++++++++++++++---
> > -
> >  2 files changed, 72 insertions(+), 12 deletions(-)
> > 
> > --
> > 2.15.0.rc1
> 
> Hi Greg KH
> 
> Can I ask is this series patch are acceptable or not?
> Do you think, I have to do any further action  for this patch?
> 

It's been 3 days, give us a chance please...

Also, I need to wait for the dt patch to be reviewed first before I can
take any of this, so that's up to the DT maintainers.

thanks,

greg k-h
