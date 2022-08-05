Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EF5C00140
	for <linux-serial@archiver.kernel.org>; Fri,  5 Aug 2022 08:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbiHEISz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Aug 2022 04:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiHEISy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Aug 2022 04:18:54 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B174DF7
        for <linux-serial@vger.kernel.org>; Fri,  5 Aug 2022 01:18:52 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 13EB930000870;
        Fri,  5 Aug 2022 10:18:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 09F748957C0; Fri,  5 Aug 2022 10:18:51 +0200 (CEST)
Date:   Fri, 5 Aug 2022 10:18:51 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Roosen Henri <Henri.Roosen@ginzinger.com>
Cc:     "chao.zeng@siemens.com" <chao.zeng@siemens.com>,
        "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
        "baocheng_su@163.com" <baocheng_su@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "p.rosenberger@kunbus.com" <p.rosenberger@kunbus.com>,
        "baocheng.su@siemens.com" <baocheng.su@siemens.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "rgc@hms.se" <rgc@hms.se>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: [PATCH] serial: Fix incorrect rs485 polarity on uart open
Message-ID: <20220805081851.GA21615@wunner.de>
References: <9395767847833f2f3193c49cde38501eeb3b5669.1639821059.git.lukas@wunner.de>
 <8f538a8903795f22f9acc94a9a31b03c9c4ccacb.camel@ginzinger.com>
 <20220804155210.GA350@wunner.de>
 <72acc08080f3675f529160270be840b06629761c.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72acc08080f3675f529160270be840b06629761c.camel@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 04, 2022 at 04:11:26PM +0000, Roosen Henri wrote:
> On Thu, 2022-08-04 at 17:52 +0200, Lukas Wunner wrote:
> > On Thu, Aug 04, 2022 at 02:38:23PM +0000, Roosen Henri wrote:
> > > unfortunately this commit, which has been backported to v5.4.x,
> > > seems
> > > to break RS485 functionality on our iMX boards.
> > 
> > What exactly broke?  Are you seeing incorrect polarity after opening
> > the tty but correct polarity after the first send? Or is polarity
> > always incorrect?
> 
> I'm not sure about the state before opening, I have to measure that
> when I'm back at the office.
> 
> After opening, the polarity is always incorrect (inverted) when this
> patch is applied. We open the tty and try to receive, which now fails
> because the rs485 transmitter is on.

Does reception work after you send something?

Please provide the contents of the pinctrl_uart2_rs485 node in your DT.

Thanks,

Lukas
