Return-Path: <SRS0=bk4J=CD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48521C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252322076C
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 17:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnZw/EDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHYRNA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYRM5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Aug 2020 13:12:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6557C061574;
        Tue, 25 Aug 2020 10:12:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w186so5164919pgb.8;
        Tue, 25 Aug 2020 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CDJUAd9wV5rW2Ler2a2mLyA8fUH115tJlJPmgB4uBuY=;
        b=NnZw/EDHYt2NwwW6ntYS4NRclJi2nzS0qnpyZ5bOPH+F1THhlFHTusVgt0akMN1gHg
         cruU8w15DKhorJi2+8a0CgAleQeml1Ibg+Bkkp6iqxrqbpMl5Xy2PRKkHIHnw8DLUxBK
         kremo6Ji8Ywg1muwwQh1KGSfzGX3Cn36vVUhiAMBgdn80NgNo0UFCQUJjAkWtuczdWew
         z37hSfISD+N/dTDknT6czKgEsGrvYbecgW2DvnKaaYUSlC0EmAIadOnbHcNmFbCRAhye
         H6N+m7rbfMudLxWFTXNzTv/jXRx3QHfkqxyMoixpHjorW6O1PD0kKA0NfuVVX+xAIqjw
         9HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDJUAd9wV5rW2Ler2a2mLyA8fUH115tJlJPmgB4uBuY=;
        b=C3+NLszTegHPGz7CAggisbF+RnDcLyByNNrQTq95zVmkYQsAk1HoLbPWSN7l7FkcgR
         CpFlbIM9eOzpVUOFYWWsHfHiH0sBnZ/yFYuHM3Lpz11zs3BX79qpIydLAEdHPnLODX5A
         klGKmmZaS2yCvddL7Jyfg4xt57/8IB3haefx0U5ehbeWlfltZQe6AiMPZ30Ao8AQqBBM
         qj6MDphFTGK076IizMGtRs2G+CQOlzHvRRHYodNyIQfHTlqKoFVLiO40egp56QYA+aIf
         tUa9qPPbzN7hkIb6Xm64qxQITAMC9b9+s3xQ3wDLiq0mHs0gxdar69SkHAy0Afc6OlY6
         KSHg==
X-Gm-Message-State: AOAM5300C1fGG3HLLzZOS1E0QUKAZnvI9Ud6ZhWKiXSs37NQvqHokPqn
        ZD5wxyoFxP+AOPdHAeePo59IrL9xBEiv
X-Google-Smtp-Source: ABdhPJzhfdy/2hH5np/xlhW3evexK/onWwZg2iqcIhwkYrgFP32U51A3Eh68OeZL4e6QQ2I7bKGm9A==
X-Received: by 2002:a63:f4a:: with SMTP id 10mr7150104pgp.18.1598375576436;
        Tue, 25 Aug 2020 10:12:56 -0700 (PDT)
Received: from PWN ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id g8sm14481455pfo.132.2020.08.25.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:12:55 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:12:49 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.cz, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 15/16] vc_screen: extract vcs_read_buf_header
Message-ID: <20200825171249.GA860904@PWN>
References: <20200818085706.12163-15-jslaby@suse.cz>
 <20200825164804.860743-1-yepeilin.cs@gmail.com>
 <20200825165935.GA1527003@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825165935.GA1527003@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 25, 2020 at 06:59:35PM +0200, Greg KH wrote:
> On Tue, Aug 25, 2020 at 12:48:04PM -0400, Peilin Ye wrote:
> > Hi all,
> > 
> > Link: https://syzkaller.appspot.com/bug?id=f332576321998d36cd07d09c9c1268cfed1895c9
> > 
> > As reported by syzbot, vcs_read_buf() is overflowing `con_buf16`, since
> > this patch removed the following check:
> > 
> > -		if (count > CON_BUF_SIZE) {
> > -			count = CON_BUF_SIZE;
> > -			filled = count - pos;
> > -		}
> > 
> > Decreasing `count` by `min(HEADER_SIZE - pos, count)` bypasses this check.
> > Additionally, this patch also removed updates to `skip` and `filled`.
> > 
> > What should we do in order to fix it?
> 
> This patch is already reverted, and it has been discussed a bit as to
> how to do this properly if you look at the email where this was reported
> to us.

Ah, syzbot has reported this issue as two different bugs...I started
looking into it without noticing your discussion under another thread.

Sorry,
Peilin Ye
