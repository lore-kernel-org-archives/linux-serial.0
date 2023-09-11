Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D4CCA0EED
	for <linux-serial@archiver.kernel.org>; Mon, 11 Sep 2023 21:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348716AbjIKVaP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjIKNPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 09:15:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C25E9
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 06:15:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DDCC433C7;
        Mon, 11 Sep 2023 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694438146;
        bh=ZSPV7kLm8MLAk6zQ4JStK9Ot08WWA+yDCunO4FP/51Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okXcOGwXBkCXE2N0Ytl018Bx5wodCkw84vBV+Cjr20O2YBv+IrQnHp0M926g88/9u
         NvCUCB3Jfh7VaqGGMhDMiRDtp51K2s1F9benSfhub2/ZMQJmCPAZ2VAnEuNGeVsBOT
         R25XChd3z0GpT/3Tz+8jg0Pdl0o6W0VvyXsC5GCk=
Date:   Mon, 11 Sep 2023 15:15:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
Message-ID: <2023091154-gallery-janitor-6ae3@gregkh>
References: <20230829201557.GK11662@atomide.com>
 <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com>
 <20230901044730.GL11662@atomide.com>
 <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com>
 <20230902043424.GM11662@atomide.com>
 <c4b1db31-7814-0d22-36de-a7e6f117d89c@sealevel.com>
 <20230905155524.GR11662@atomide.com>
 <79e44ee3-f4a0-6f3e-cb5d-dc2b7bd048fb@sealevel.com>
 <20230905165147.GS11662@atomide.com>
 <73817d5-cab-341-be76-ee9d565df57@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73817d5-cab-341-be76-ee9d565df57@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 11, 2023 at 09:04:14AM -0400, Matthew Howell wrote:
> So it seems like this might not be an issue for typical 'users' of the 
> kernel, but may impact people who need to build and load 8250_exar 
> manually for whatever reason, unless I am just building the module 
> incorrectly somehow. 

Yes, Linux does not support building a module against one source
tree/configuration and attempting to load it into a different kernel at
all.  You are lucky that this was the only thing that broke :)

Thanks for the testing and letting us know that all is good with the
tree as-is.

greg k-h
