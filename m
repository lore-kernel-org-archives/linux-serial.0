Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13802C2BB55
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 17:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C9C2076D
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587058648;
	bh=c6RjcLo9mHi0Qj+iI/ymrQ+8S7krFiwa/crVExYtMzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ARmKrx8cA+GMrqoH+0rJIjyRnCrU/N2WHlKJRrAMpK/A/Vku2NaYQToqYbxZsDM6Z
	 lWik9gbCZdZrq27XuYo0RMrgbIXrSe8ZQAbNYSruUc8zzB+IbMNam+sgXfiMxLJAQS
	 hgi3xU95SRkMqznEBobYug2Xhvacd/YNtQWEB7WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgDPRhY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgDPRhW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 13:37:22 -0400
Received: from Mani-XPS-13-9360 (unknown [157.50.106.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D183A2076D;
        Thu, 16 Apr 2020 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587058642;
        bh=c6RjcLo9mHi0Qj+iI/ymrQ+8S7krFiwa/crVExYtMzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPW/w2Hfnyk6tUbCwgA+epGBp7s9x8qUWJj1HiCBq+J9LTkOTM2QYZTP/j5uo/wrm
         Zu7E5RQleCiRVXkZUgTILmP6u9Q5+x1hOTZEgCwX8xxgd1Ay9ngjsrcfWax9ah1H31
         eWIhS2p6dEJvzP9lw8E2V62BIIK92l1CFStWvCOY=
Date:   Thu, 16 Apr 2020 23:07:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add software flow control support for STM32 UART
Message-ID: <20200416173710.GA4548@Mani-XPS-13-9360>
References: <20200412180923.30774-1-mani@kernel.org>
 <CAHp75VfDUoFMWg42OFHZtKQ972eoR3UDLVAs+BQjJm3h3-fOGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfDUoFMWg42OFHZtKQ972eoR3UDLVAs+BQjJm3h3-fOGw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

On Mon, Apr 13, 2020 at 12:17:21PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 13, 2020 at 7:06 AM <mani@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <mani@kernel.org>
> >
> > Hello,
> >
> > This patchset adds software flow control support for STM32 UART controller.
> > This is necessary for the upcoming STM32MP1 based board called Stinger96
> > IoT-Box. On that board, a bluetooth chip is connected to one of the UART
> > controller but the CTS/RTS lines got swapped mistakenly. So in order to
> > workaround that hardware bug and also to support the usecase of using only
> > Tx/Rx pins, this patchset adds software flow control support.
> >
> > This patchset has been validated w/ Stinger96 IoT-Box connected to Murata
> > WiFi-BT combo chip.
> >
> 
> I think it's a mix of terminology or so. Looking into the patches I
> found that it's required to have GPIOs for SW flow control.
> No, SW flow control does not require any additional signals, except RxD/TxD.
> 

Yikes. Yes I got it wrong. 'st,hw-flow-ctrl' property confused me :)

> On top of that, it seems you adding mctrl-gpio functionality. Why
> can't you use that one? And thus no bindings needs to be updated.
> 

Sure. This looks feasible. Will submit a follow up patch.

Thanks,
Mani

> > Thanks,
> > Mani
> >
> > Manivannan Sadhasivam (2):
> >   dt-bindings: serial: Add binding for software flow control in STM32
> >     UART
> >   tty: serial: Add software flow control support for STM32 USART
> >
> >  .../bindings/serial/st,stm32-uart.yaml        |  15 +-
> >  drivers/tty/serial/stm32-usart.c              | 143 +++++++++++++++++-
> >  drivers/tty/serial/stm32-usart.h              |   4 +
> >  3 files changed, 155 insertions(+), 7 deletions(-)
> >
> > --
> > 2.17.1
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
