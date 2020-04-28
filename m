Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAA1C83000
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 11:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71FE206D7
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588072725;
	bh=cTbH1jyXaJgV0FHofLFJaxzBEqrP3IX3dYt4iQDTkcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vz9NjSewPxE2Au53Vp4IOcJ8W/n6EO17VK4vZTVqZ0Qj2rTUhM6OmTmbJhlxsosb7
	 A4BcsuyqKNx4L6mEWfTqHOy3ys6s8qDsD5/6IaQcL7WDIe3qLPF9uj+8I4a5CVfXIC
	 sezKaVuRf1E0B2UQiGVQp5eyUqzSvL2gJv4THn5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgD1LSp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD1LSp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 07:18:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76334206D6;
        Tue, 28 Apr 2020 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588072724;
        bh=cTbH1jyXaJgV0FHofLFJaxzBEqrP3IX3dYt4iQDTkcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y1JLmVMQnEo2l2sL0mUfy8t81I9jhNm+SHA6QJBHCyeYNFRyV0qdt5wtiK4N6DKd4
         EnCi+QLriR3ovNnlKrzZKRLAaRKaKEG6u3vjRB6OirRbEO3TP4d/z0Q/EVaRlohJXn
         wl76F2SFH9YI6ZIK+q8X9ZYj28shIdD6Ivzu/CKY=
Date:   Tue, 28 Apr 2020 13:18:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Zou Wei <zou_wei@huawei.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tty: serial: bcm63xx: fix missing clk_put() in
 bcm63xx_uart
Message-ID: <20200428111842.GA1159152@kroah.com>
References: <1587472306-105155-1-git-send-email-zou_wei@huawei.com>
 <4cd8f963-9292-faef-1e24-df90821274d6@suse.cz>
 <73c4cebb-467b-e5d5-89bf-8a6fe29cf858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c4cebb-467b-e5d5-89bf-8a6fe29cf858@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 27, 2020 at 10:29:58AM -0700, Florian Fainelli wrote:
> 
> 
> On 4/26/2020 11:19 PM, Jiri Slaby wrote:
> > On 21. 04. 20, 14:31, Zou Wei wrote:
> >> This patch fixes below error reported by coccicheck
> >>
> >> drivers/tty/serial/bcm63xx_uart.c:848:2-8: ERROR: missing clk_put;
> >> clk_get on line 842 and execution via conditional on line 846
> >>
> >> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> >> ---
> >>  drivers/tty/serial/bcm63xx_uart.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
> >> index 5674da2..ed0aa5c 100644
> >> --- a/drivers/tty/serial/bcm63xx_uart.c
> >> +++ b/drivers/tty/serial/bcm63xx_uart.c
> >> @@ -843,8 +843,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
> >>  	if (IS_ERR(clk) && pdev->dev.of_node)
> >>  		clk = of_clk_get(pdev->dev.of_node, 0);
> >>  
> >> -	if (IS_ERR(clk))
> >> +	if (IS_ERR(clk)) {
> >> +		clk_put(clk);
> > 
> > Why would you want to put an erroneous clk?
> 
> Doh, somehow I completely missed, you are right this does not look legit.

Ugh, can you send a revert for this please?

thanks,

greg k-h
