Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A354C433E2
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 13:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BCB20748
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594387178;
	bh=FDmh7SvjbjWx0OM7oE+TtNSj5C1Dcnw8yiDBj+VMUWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fKM+d4nO356CekMTkMO1slypXH/nYczH2ISsbN2VzOeTA27FyQ/ZiaCrwv5LcHrWv
	 WwAUl6JqXoeKhI6kZXOgdj7VDKOrRq+CBjRKa3ptoUhmo0vfEjMg8B45L91IqcRtBV
	 SKNhNtlNOta9n68tOvdAZjGUym8ripC0DxjYIw8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGJNTh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgGJNTh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 09:19:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A750206A5;
        Fri, 10 Jul 2020 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594387176;
        bh=FDmh7SvjbjWx0OM7oE+TtNSj5C1Dcnw8yiDBj+VMUWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AP87kpRqwCcVnSIiUR9d/k0VNaSNi5Yxk86YXSmwE08ycskdqNbOLOqdm1vVOU3nG
         0YVonHA76lz5V7KWzXizBIYrMv8u0BcwyBl9dskwXLaIHtLCZyum/HIuA/p7+hCrBT
         OZtc+takRDAH6PixBnS8L7opKnFtFINJ9jkSsDl0=
Date:   Fri, 10 Jul 2020 15:19:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com
Subject: Re: [PATCH] serial: exar: Fix GPIO configuration for Sealevel cards
 based on XR17V35X
Message-ID: <20200710131941.GA1824558@kroah.com>
References: <473cc7ae-c870-ff0f-0c68-bdcfed19efde@sealevel.com>
 <20200710124103.GB1567243@kroah.com>
 <568e88c6-6f66-c9d0-b692-f15698a13577@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568e88c6-6f66-c9d0-b692-f15698a13577@sealevel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 10, 2020 at 09:13:19AM -0400, Matthew Howell wrote:
> 
> Could you clarify what info was not acceptable? And was the whole patch deleted/rejected, or just the
> info removed?

Your email footer is not compatible with public kernel development.
