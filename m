Return-Path: <SRS0=BL42=AG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDFAC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 14:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8961D20768
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593097183;
	bh=wG8QHDQ5wXxLIg0GUFph/M3AwAogggkkTP3PGvLuWWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ALryiJDZoApTooCLeMqnBPFIlDTlBf3B5g7ilHiBZgffZG7UGmSqb1HrvbISk7Bq+
	 SsRz3lZISfHNc6jVcbWX4D+6/+dgY/S2cmk/Ak/J+ZPfQBVk/m6F7JXMKhR9dq+EAz
	 4iK+tcrQ+N41VUmcgo6jzOx9iC2THSQ21oc6FtmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405462AbgFYO7n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405378AbgFYO7n (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jun 2020 10:59:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204FD20768;
        Thu, 25 Jun 2020 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593097182;
        bh=wG8QHDQ5wXxLIg0GUFph/M3AwAogggkkTP3PGvLuWWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rt4s9M9jQBkOdd4x60qO/LNCVmqgI/NtvPm+2djnyhy3lLTkLsnb7MgSknxYD3eBU
         3MV/4VC3BODTEHadjgYx/IIfHA8epLbtYO4R33Q3wqIuVWAB8SpvMxLNKeGmNi8AFM
         6ZLTzIxhBJX8DG7+XDKyN5SmoRPHK/mcQwDGddIo=
Date:   Thu, 25 Jun 2020 16:59:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anthony Canino <anthony.canino1@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Possible bug in drivers/tty/vt/vt.c
Message-ID: <20200625145938.GA3911993@kroah.com>
References: <CA+dbEpsJs8AgcpjU_-Vwh60BRL4Eq21L1=3sDNJRGHr2acLWLg@mail.gmail.com>
 <CA+dbEpt3YmDE7Q_BBhZZw9CfrUJfrhfR16XVoevXSqi=kOQjJg@mail.gmail.com>
 <20200623115148.GC1963415@kroah.com>
 <CA+dbEpv3kBjEBAV+8d0ea7pFjw6qE7nYW1wC5_NADUNvC5=O4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+dbEpv3kBjEBAV+8d0ea7pFjw6qE7nYW1wC5_NADUNvC5=O4g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 25, 2020 at 10:44:27AM -0400, Anthony Canino wrote:
> Hi Greg,
> 
> Thanks for the reply--what you said makes sense. If we find a case
> where this happens in a normal execution, we will file another bug.

Just email please, that's the best way to work on things, bugzilla is a
black hole...
