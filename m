Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA27FE810B1
	for <linux-serial@archiver.kernel.org>; Wed, 27 Sep 2023 09:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjI0Jlu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Sep 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjI0Jl3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Sep 2023 05:41:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAAEF3
        for <linux-serial@vger.kernel.org>; Wed, 27 Sep 2023 02:41:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD9FC433C8;
        Wed, 27 Sep 2023 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695807688;
        bh=T2eiVI+0IMVulFaNQUMQ2MIrqGL18Pe4RM4rNd/NaFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2h243oE0rQCIMTmyTvONqHWLjkbHJuCdHUPbtoU5d2098tEuyET+2GVdkNyCNDvht
         uAfG9qA9GBL7/XeyS0cjbU49/VM5T22tWLyxqsNcqSqfAwm/zK8fGqXim+Ix02qQaC
         hCpzjpfks/ajCawlKzCwXiUOIe8VVXYIjZY45/Ro=
Date:   Wed, 27 Sep 2023 11:41:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "yiyang (D)" <yiyang13@huawei.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, hedonistsmith@gmail.com,
        daniel.starke@siemens.com,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context in
 console_lock
Message-ID: <2023092756-santa-levitate-ac6a@gregkh>
References: <42c2c0c4-9ee2-6426-8c3c-2585e0345fcb@huawei.com>
 <c1dbec59-9564-5705-1ae6-200860a7371b@huawei.com>
 <2023091838-shrubs-paragraph-e579@gregkh>
 <943e34ff-5412-ee88-2b18-1e5b1e198b71@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943e34ff-5412-ee88-2b18-1e5b1e198b71@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 27, 2023 at 05:15:25PM +0800, yiyang (D) wrote:
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
> This problem seems to be a CVE problem.
> https://nvd.nist.gov/vuln/detail/CVE-2023-31082

If you think CVEs are actually valid for the kernel (hint, they aren't),
then wonderful, please work to resolve this issue.

Again, good luck!

greg k-h
