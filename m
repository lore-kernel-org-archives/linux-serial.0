Return-Path: <SRS0=GPH0=AY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D56C433E2
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jul 2020 07:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375392073A
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jul 2020 07:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="pHAb52yN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGMHLd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:11:33 -0400
Received: from mail.intenta.de ([178.249.25.132]:33348 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMHLd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jul 2020 03:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=kRgItzgVjopJ0+BF6ESNn5SkXGN3c3eqdjKHFyqO2Nc=;
        b=pHAb52yNpOpnCnq7Ls3ghIwI7CDn5XmxT0/QTkc9d+70x1kgat8w8DgFds5OmdW1EAQH5as+tpkBq0qm/KF5EtybJhAk28kvKfC4BfoGt5ZylHv2o3XvlGNH+ZXYiSNsn4Y456ZchObvyjcQLUnIZP8OsY0gVzYHnFGuhLmBEWYLjpPQUfonnef+TtRIIoqOmQPsB4pZMx96v7Zmlxp1efAFIzA48OlL+90FgdLBiVwvW3keQFwJPa6Yjo3Ajv5bbTxmyg6XNilyUASGu0dU8es6CCYT1rwbbkyb59tR0A4w92sJu2XH1sa+fwEMeUubyJ3VPyVeprtS3H1N/XaNdg==;
Date:   Mon, 13 Jul 2020 09:11:25 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "Jan Kiszka" <jan.kiszka@web.de>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
Message-ID: <20200713071123.GA1994@laureti-dev>
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
 <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Michal,

On Fri, Jul 10, 2020 at 01:45:21PM +0200, Michal Simek wrote:
> Thanks for the patch. I think that it will be very useful to list out
> all testcases to make sure that we test all that scenarios and finally
> get over it.
> We are testing scenarios and likely we are missing some that we are not
> able catch all issues before we submit a patch.

Let me try to enumerate those I know:

uart0    | uart1    | console | remark
---------+----------+---------+----------
serial0  | serial1  | ttyPS0  | regular case
serial0  | serial1  | ttyPS1  | normal assignment, second console
serial1  | serial0  | ttyPS0  | -> Jan Kiszka, broken since revert
disabled | serial0  | ttyPS0  | use only uart1 as serial0
serial0  | disabled | ttyPS0  | regular case with uart1 disabled

Out of these, I'm actively using configurations 3 and 4.

Which of these scenarios do you test already?

Helmut
