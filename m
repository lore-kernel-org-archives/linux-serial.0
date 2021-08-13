Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF19C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 15:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4922F6112F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 15:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbhHMPCL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241003AbhHMPCL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 11:02:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9E6A61103;
        Fri, 13 Aug 2021 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628866904;
        bh=I65Rgbb3ZgNsrMF5mpaQrz+X9IBc/w4G2CT5Fy7g6YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGr5x9H0ZohviSpaZcJ2yRbylQjXp1i1nQ7WHuLsaYQxC1k+ER6V8qMu8DV9VRaHR
         XCD2rT6MEGUXU5rTMEoS3OcYXWHzeZpJp3fuhqE/XvIxIdeq9jQSYQZZeg2mW2h0oX
         O1zwFJoPG/D2N2FD5s2uttEYgpDZvHUdBPvxEQ3A=
Date:   Fri, 13 Aug 2021 17:01:41 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     =?utf-8?B?dG9tYmluZmFuKOiMg+WFtSk=?= <tombinfan@tencent.com>,
        Bing Fan <hptsfb@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Internet]Re: [PATCH v5] arm pl011 serial: support multi-irq
 request
Message-ID: <YRaJVZOJMKtAM8Sl@kroah.com>
References: <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
 <a1843494-5c8e-1ec8-5b98-df318db40922@quicinc.com>
 <7535ae2f-6a12-8203-0498-8ac85ab0d9a7@arm.com>
 <290c01ec-173f-755f-788e-2a33a69586e8@quicinc.com>
 <e98962f3-9232-4abf-ec27-a7524a9e786d@arm.com>
 <bddf2712-72f4-2e20-da17-33b3de08f769@gmail.com>
 <0819592c-1baa-e98d-9118-5abde8b8c562@quicinc.com>
 <67cd6c830e33491e99ea4d2480f4a89d@tencent.com>
 <09918b566884413898f63b92ddd037a0@tencent.com>
 <0206c94d-c91b-b7da-8132-d06e23c9d964@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0206c94d-c91b-b7da-8132-d06e23c9d964@quicinc.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 13, 2021 at 09:42:52AM -0400, Qian Cai wrote:
> 
> 
> On 8/12/2021 11:32 PM, tombinfan(范兵) wrote:
> > hello,
> > 
> > I have sent the modified patch to the following mailboxes. THX
> > 
> > gregkh@linuxfoundation.org
> > linux-serial@vger.kernel.org
> > linux-kernel@vger.kernel.org
> 
> Thanks for the pointer. It is good to get some reviews from Arm
> people in the first place, so we don't break Arm like this.
> 
> Anyway, for anyone who might be watching, here is the new patch,
> 
> https://lore.kernel.org/linux-serial/1628825490-18937-1-git-send-email-hptsfb@gmail.com/
> 
> Unfortunately, I saw Greg mentioned that it was not based on
> tty-next, so not something I can apply easily on linux-next here
> as well.

That is because the code in tty-next (and linux-next), looks to already
do exactly what you submitted, right?

So is this working now for everyone in linux-next?

thanks,

greg k-h
