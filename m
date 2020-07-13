Return-Path: <SRS0=GPH0=AY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA2C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jul 2020 12:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBA520773
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jul 2020 12:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="inf5MulV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGMMKZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:10:25 -0400
Received: from mail.intenta.de ([178.249.25.132]:34971 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgGMMKZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jul 2020 08:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=1FfHxGk9Fkq4rbXPd8sX91QgCFVfWDb1d+CXYS3YaHM=;
        b=inf5MulVjWhipWbArKPDwNh25OqJ9z+5Ul/bTDyK+Zj8W8PmEQKjGrpTZaCEDkCzN+V45PZAlKC+6drpa+4ZKb0OI5DBKL2PfPHnXZDM5Zwy6cAD05+T7ad50dK/eHK0hdixmZq2FUWm8b/ZehcKYf/+1buSle6Frv8AIpFxX6GKkVSMbDasPvDaRi1CMDhjHfCS6+5PkWbKkzK8DIF6Y5WtH4NASeDXgwJXDsQQiEyVLBMEQM5nBfMm9z3zLMwfk3W/90Co7WIGCet6WvIgZ8XPvtIummjHEU+QRr3QWTUwMR9BVYrGXLG9kkrb0SVQoTOFAGZ4+n3qS0XcNmY14g==;
Date:   Mon, 13 Jul 2020 14:10:19 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "Jan Kiszka" <jan.kiszka@web.de>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
Message-ID: <20200713121019.GA6920@laureti-dev>
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
 <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
 <20200713071123.GA1994@laureti-dev>
 <e7b766ab-8c99-d30c-2352-6d7b09033537@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7b766ab-8c99-d30c-2352-6d7b09033537@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Michal,

On Mon, Jul 13, 2020 at 01:49:38PM +0200, Michal Simek wrote:
> On 13. 07. 20 9:11, Helmut Grohne wrote:
> > Let me try to enumerate those I know:
> > 
> > uart0    | uart1    | console | remark
> > ---------+----------+---------+----------
> > serial0  | serial1  | ttyPS0  | regular case
> > serial0  | serial1  | ttyPS1  | normal assignment, second console
> > serial1  | serial0  | ttyPS0  | -> Jan Kiszka, broken since revert
> > disabled | serial0  | ttyPS0  | use only uart1 as serial0
> > serial0  | disabled | ttyPS0  | regular case with uart1 disabled
> > 
> > Out of these, I'm actively using configurations 3 and 4.
> > 
> > Which of these scenarios do you test already?
> 
> For above we are missing also others
> serial1 | serial0 | ttyPS1
> disabled| serial1 | ttyPS1

Is it actually possible to have ttyPS1, but no ttyPS0? I think I tried
doing that earlier and it resulted in there being ttyPS0, but no ttyPS1.

> serial1 | disables | ttyPS0

I'm not sure what this is supposed to mean. When there is no serial0
alias, I'd expect ttyPS0 to be missing. However as indicated above that
is not what happens in practice. So either of these two configurations
seems invalid to me.

> All of these above are just not setting any console= on bootargs.

We usually set the console= assignment on bootargs.

> It means mix of these combinations is tested regularly but not all of
> them. Do you see any other combination which is not supported?

I'm not aware of further relevant combinations.

Can we maybe trim down the matrix somehow? In my context, the need for
swapping the serial aliases arises from a limitation in u-boot-xlnx and
the desire to use one dtb for both linux and u-boot. It requires that
the serial0 alias is the console. Are there other reasons to swap them?
If not, maybe fixing u-boot would be an option?

Helmut
