Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE155E810A2
	for <linux-serial@archiver.kernel.org>; Wed, 27 Sep 2023 08:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjI0IYh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Sep 2023 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjI0IYg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Sep 2023 04:24:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4120C116
        for <linux-serial@vger.kernel.org>; Wed, 27 Sep 2023 01:24:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CED5C433C7;
        Wed, 27 Sep 2023 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695803074;
        bh=xh54gg2SSmqDr88p/sblGPHAUNEGvufvqce+W6sJzGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKoHPSnVdJ2nmKSINSeafaCDSIZt1bC5mElBagpM6jnnRVB4gDcBdMUqltSPY1mwP
         bHwiyqDkyRvr3HIoEG9FjOJa4DOa+joJWK4hgoR4uoPskk3H9G6YmNGzf/U2Ad5OsX
         2wMcu4wC7KAXbwkUT4xeLL54rGr+IX5280DkCL0w=
Date:   Wed, 27 Sep 2023 10:24:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "yiyang (D)" <yiyang13@huawei.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, hedonistsmith@gmail.com,
        daniel.starke@siemens.com,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context in
 console_lock
Message-ID: <2023092703-parrot-bobbed-d5d2@gregkh>
References: <42c2c0c4-9ee2-6426-8c3c-2585e0345fcb@huawei.com>
 <c1dbec59-9564-5705-1ae6-200860a7371b@huawei.com>
 <2023091838-shrubs-paragraph-e579@gregkh>
 <9613ee6f-08f7-ab6e-64f0-38505f67b891@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9613ee6f-08f7-ab6e-64f0-38505f67b891@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 27, 2023 at 03:48:33PM +0800, yiyang (D) wrote:
> On 2023/9/18 23:19, Greg Kroah-Hartman wrote:
> > On Mon, Sep 18, 2023 at 09:35:23PM +0800, yiyang (D) wrote:
> > > In recent years, this problem has been reported in syzkaller all the time.
> > > 
> > > Link: https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
> > > 
> > > Historically, the developers have tried to fix this problem by use mutex
> > > instead spinlock, but it didn't solve the problem..
> > > 
> > > Link: https://lore.kernel.org/all/20220826193545.20363-1-pchelkin@ispras.ru/
> > > 
> > > Other developers have recently reported this problem, but no one has
> > > continued to try to fix it.
> > > 
> > > Link:
> > > https://lore.kernel.org/all/20230420082153.6711-1-daniel.starke@siemens.com/
> > > 
> > > Anyway, do we have any ideas for solving this problem?
> > 
> > Nope!  Why do you think this is something that even needs to be
> > addressed?
> > .
> > 
> Kernel only perform cannot sleep operations in atomic context, as otherwise
> a system hang or crash may occur.
> 
> So there's a risk to this problem.
> 

Have you see this risk in real workloads?  If so, great, please provide
a working solution that is tested and verified to work properly.

good luck!

greg k-h
