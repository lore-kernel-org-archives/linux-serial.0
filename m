Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9A0C433E6
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 10:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDA264E89
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 10:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCOKYx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhCOKYd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 06:24:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78F2664E0F;
        Mon, 15 Mar 2021 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615803872;
        bh=LeBXZfQoSIIuvAJ4FtOVNZEvZGLJJToQfIjnx89fKTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2gf5iMAqkcjjY0BmWQugWbnFRykAqkYNE8w+KEK1/2bBJS6kS8ZdtLSv/iOHPtNR
         /glr5v0MNwHZmPQjV3QNf053rudlzy/S3eeD7qevtb0lycgkGAOIZw0e0tlyIvmlSi
         uFByPMK2KioSTfhHFRHJwBYq+4UU6mxcSvmC4ttahvpIcgXDRe9yHuQOa7Y+HDoSUV
         lj6K/tWPPV4wfI5xySFieYTRseoCmnDBzLP9teCYRtdqQxa97SKeQya+NOvuTn+jvz
         DK2cBOmEUrW9PJoLvgn08niUZq1wRpf0AtkIu/8ReTMts/tmAsWdRLNiUxMLPuhUAk
         FJIwymqxuf0mw==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lLkOz-0001T0-9M; Mon, 15 Mar 2021 11:24:46 +0100
Date:   Mon, 15 Mar 2021 11:24:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Charles Yeh <charlesyeh522@gmail.com>
Cc:     "Michael G. Katzmann" <michaelk@ieee.org>,
        =?utf-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YE817THBnXndx0py@hovoldconsulting.com>
References: <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
 <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
 <YEH7okblCx8+Odxn@hovoldconsulting.com>
 <ddc0e424-21c2-b8f4-1b00-f589267d2b51@IEEE.org>
 <YEpAaL9QtVMduEpi@hovoldconsulting.com>
 <9d02257d-cca1-116e-634a-6ac952362c5d@IEEE.org>
 <YEtwNzhCmvyKhRto@hovoldconsulting.com>
 <a475110e-2f44-eeca-3cd2-dd946e5abfe7@IEEE.org>
 <YE8j1XdfQNDGLzZR@hovoldconsulting.com>
 <CAAZvQQ6NCocMXQXVcKGEi7ivbysyU8EJeeRUK5RPqAmEyqSXcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZvQQ6NCocMXQXVcKGEi7ivbysyU8EJeeRUK5RPqAmEyqSXcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 15, 2021 at 06:07:18PM +0800, Charles Yeh wrote:
> > Charles, could you help us out here? Which other device types use the
> > alternate encoding (e.g. HX(A) or TB) if any?
> 
> TA and TB are the same hardware design: no need to design a new type

Thanks for confirming.

According to the datasheet the maximum baudrate is 6 Mbps for TA and 12
Mbps for TB so I guess we need to keep them separate:

	https://prolificusa.com/app/uploads/2018/02/DS_PL2303TB_d20180327_v1.1.0.pdf

Johan
