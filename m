Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C5FC0015E
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 08:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjHCIf6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjHCIfk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 04:35:40 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 846DC4689;
        Thu,  3 Aug 2023 01:33:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6202F80FE;
        Thu,  3 Aug 2023 08:33:16 +0000 (UTC)
Date:   Thu, 3 Aug 2023 11:33:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     syzbot <syzbot+list2f20ebac1d924d54d3c4@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly serial report (Jul 2023)
Message-ID: <20230803083315.GH14799@atomide.com>
References: <000000000000036333060169d6a8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000036333060169d6a8@google.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* syzbot <syzbot+list2f20ebac1d924d54d3c4@syzkaller.appspotmail.com> [700101 02:00]:
> <3> 15      Yes   general protection fault in serial8250_tx_chars
>                   https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8

Looks like Hillf has a patch coming for this [0], not seeing the mail in lore
for some reason though.

Regards,

Tony

[0] https://groups.google.com/g/syzkaller-bugs/c/m3vOaJRjnMs
