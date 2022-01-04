Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75906C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jan 2022 11:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiADLiG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:38:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38350 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiADLiF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jan 2022 06:38:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 604F861349
        for <linux-serial@vger.kernel.org>; Tue,  4 Jan 2022 11:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0EAC36AE9;
        Tue,  4 Jan 2022 11:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641296284;
        bh=hx/fOp6SJmK2BQeMp++u3THrWv+QtsVOcMF50oxiGnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYtCfKzEtbt5wBeftsaEUAboto3Zvs471aYZxS2Imm1kI8l1xxpyUa1xQnWLpxa13
         oT2c07v5TQpnIK53PG+aVcHW7wulKM5k+SDnCQ7qpBJl3Ctycm0XXAFt81g+SMoII+
         dmPx+/+8JM4BrTePhDyaF6hBpWPdJrfs4MY5JXXU=
Date:   Tue, 4 Jan 2022 12:38:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
Message-ID: <YdQxmQ+OMCrabg2u@kroah.com>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 04, 2022 at 12:13:06PM +0100, Tomasz Moń wrote:
> On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
> > Why can't you do this dynamically based on the baud rate so as to always
> > work properly for all speeds without increased delays for slower ones?
> 
> Could you please advise on which baud rates to consider as slow? Does it
> sound good to have the old trigger level for rates up to and including
> 115200 and the new one for faster ones?

You tell me, you are the one seeing this issue and are seeing delays on
slower values with your change.  Do some testing to see where the curve
is.

thanks,

greg k-h
