Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC1FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 14:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59286121F
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 14:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJUOdN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhJUOdM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Oct 2021 10:33:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EC4760FE8;
        Thu, 21 Oct 2021 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634826656;
        bh=B+o1cjBN9eQT9F7JPHftlsce6OXXKpUz8ZiJsoSJSak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdB15nXUTVaFcqPRORXjtr2S/r/9WQJ9TGuQ/26Js8bRK0MAg5C+mc3pu96NH2p7n
         VPA+CYUghpE2TJBFscgzRk+kwWRGDvSVhASYJc5ypOSt7v0Q8s7A941/Q0vrOWX9b5
         PBW2CESJCzDjv1gq09biUY9VedK44ZVrmqP8uDe4=
Date:   Thu, 21 Oct 2021 16:30:54 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     mrhowel@g.clemson.edu
Cc:     Matthew Howell <matthew.howell@sealevel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: Possible issue with RS485 IOCTLs on 16C950 UARTs?
Message-ID: <YXF5nig6PzRWsLjS@kroah.com>
References: <BY5PR05MB7092A78C7C3441240685522DF9BE9@BY5PR05MB7092.namprd05.prod.outlook.com>
 <YXEdFPyvpnBCeoxt@kroah.com>
 <alpine.DEB.2.22.394.2110211004030.10664@SLTS-20200428.int.sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110211004030.10664@SLTS-20200428.int.sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 21, 2021 at 10:10:30AM -0400, mrhowel@g.clemson.edu wrote:
> 
> That noticed is enforced by our exchange server. I have removed it by 
> using an external email address instead.
> 
> Original message is copied below.
> 
> Hi,
> 
> I'm not sure if this is the right place for this, but hopefully someone 
> can help me figure out what else I can do to troubleshoot this problem, or 
> point me to the right place to ask questions about this.
> 
> A recent investigation led us to discover issues related to the RS485 
> IOCTLs on our serial cards utilizing the 16C950 UART. More specifically, 
> the TIOCSRS485 IOCTL to set the serial_rs485 flags as documented at 
> https://www.kernel.org/doc/html/latest/driver-api/serial/serial-rs485.html 
> .
> 
> When attempting to set the SER_RS485_ENABLED flag using TIOCSRS485 as per 
> below I receive an error code 25, "Inappropriate IOCTL for device"
> 
> 	/* -----RS485----- */
> 	struct serial_rs485 rs485conf = {0};
> 	rs485conf.flags |= SER_RS485_ENABLED;
> 	rc = ioctl(fd, TIOCSRS485, &rs485conf);
> 	if (rc < 0) {
>         	printf("error=%d %s\n", errno, strerror(errno));
> 		return rc;
> 	}
> 
> >From what I've read this typically indicates an unsupported serial device, 
> but the documentation mentions the 16C950 UART as a specific example, so I 
> would think the kernel is intended to support this functionality on the 
> 16C950. 
>  
> I have tried this across several kernel versions: 3.10 (Centos 7) , 4.18 
> (Centos 8), and 5.11 (Ubuntu 21.04) with no change in the behavior. 
> The issue was originally discovered on a PLX OXPCIe952 UART, but has been 
> replicated on 'standard' OX16C950 UARTs as well. setserial -ag correctly 
> identifies all cards as 16950's (Specifically "16950/954").
> 
> Has anyone else had or seen this IOCTL issue on the 16C950? Are there any 
> 'known good' 16C950 based cards people can confirm that this works with?

I do not think that that type of hardware actually supports RS485, as the
kernel is reporting that the driver says it is not allowed.

Perhaps you need to find some hardware that does support it?  It is not
very common at all.

good luck!

greg k-h
