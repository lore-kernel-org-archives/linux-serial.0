Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAF0CD37B0
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 16:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjIRQp3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjIRQpR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 12:45:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7262D47
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 09:37:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85763C116A7;
        Mon, 18 Sep 2023 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695050398;
        bh=K7SGmCr3ugYF9ty2Bu0Z+gJEXgo0SrhuklDXL2/v6zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jInMwNRz613cPGnU1t6xNE9fDYi/T6ug/nTSRFSuwHwU3WELZ2Db0DxXIKHEMDgQq
         qcEXd4vxbREz/J9g3d+djlXpRRgBG7iqxDR7Bp00Mpcw63p3+2/bS/zeyDm2pGw1xr
         qtiXfZXLz8SkHxZOhI9wTJ6r75LGf18Oqc5xYFCc=
Date:   Mon, 18 Sep 2023 17:19:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "yiyang (D)" <yiyang13@huawei.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, hedonistsmith@gmail.com,
        daniel.starke@siemens.com,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context in
 console_lock
Message-ID: <2023091838-shrubs-paragraph-e579@gregkh>
References: <42c2c0c4-9ee2-6426-8c3c-2585e0345fcb@huawei.com>
 <c1dbec59-9564-5705-1ae6-200860a7371b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1dbec59-9564-5705-1ae6-200860a7371b@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 18, 2023 at 09:35:23PM +0800, yiyang (D) wrote:
> In recent years, this problem has been reported in syzkaller all the time.
> 
> Link: https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
> 
> Historically, the developers have tried to fix this problem by use mutex
> instead spinlock, but it didn't solve the problem..
> 
> Link: https://lore.kernel.org/all/20220826193545.20363-1-pchelkin@ispras.ru/
> 
> Other developers have recently reported this problem, but no one has
> continued to try to fix it.
> 
> Link:
> https://lore.kernel.org/all/20230420082153.6711-1-daniel.starke@siemens.com/
> 
> Anyway, do we have any ideas for solving this problem?

Nope!  Why do you think this is something that even needs to be
addressed?
