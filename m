Return-Path: <SRS0=3UWf=Z4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F5BC43603
	for <linux-serial@archiver.kernel.org>; Fri,  6 Dec 2019 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B142024680
	for <linux-serial@archiver.kernel.org>; Fri,  6 Dec 2019 06:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575614424;
	bh=p+tIxBSz0bQmkPz89oUoLma0YvcFZrDr6uINE15sZsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LSyXckop+aMvH7nPVAR1GB1OYB/qWMrQkRfcCvh5KK6GHho2jY+cLY5OqZrEtEykq
	 HhC8qZSUwdGL7B6OKPNBteF3eiLpHDkNX0GY+17kwYPMnEBJ/wj7XfvlfeZWXHzLbj
	 JvB5oKO02XMQ5G+848cT6XARr31u7Ab3WO0ydhWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfLFGkY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfLFGkY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Dec 2019 01:40:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1043D24679;
        Fri,  6 Dec 2019 06:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575614423;
        bh=p+tIxBSz0bQmkPz89oUoLma0YvcFZrDr6uINE15sZsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hml23TGZcwh3DGHy6YiUYyWCx3/yK8SjA6ahPmbeXXwggLNiZ9/h1aHnwkgL8Bhk6
         IpTghxQznhBFiRqEG/yMkMpL2q7dSEryGMZc/DrJ0nkGg4ZNeLnvbGH8pWwOulXfgT
         jcZzZNsyOhCoceEbDr4eMhNqplQVEMcntqyhRsAQ=
Date:   Fri, 6 Dec 2019 07:40:20 +0100
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     =?utf-8?B?77+977+977+977+977+977+9L0hZVU4tS0k=?= KOO 
        <hyunki00.koo@samsung.com>
Cc:     'Krzysztof Kozlowski' <krzk@kernel.org>,
        'Hyunki Koo' <kkoos00@naver.com>, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kkoos00@gmail.com, 'Shinbeom Choi' <sbeom.choi@samsung.com>
Subject: Re: [PATCH] tty: serial: samsung: support driver modulization
Message-ID: <20191206064020.GA1318959@kroah.com>
References: <20191201075914.23512-1-kkoos00@naver.com>
 <20191201080314.GA3716559@kroah.com>
 <CAJKOXPet=RyJ3nrcOooHdN0GSO33Ce82-9L_X0oYC2MjN7nOig@mail.gmail.com>
 <CGME20191205160249epcas2p3c1dcb24aba71f6b4264e76ebea36348c@epcas2p3.samsung.com>
 <20191205160243.GA757198@kroah.com>
 <000001d5abd6$ae5a6b50$0b0f41f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001d5abd6$ae5a6b50$0b0f41f0$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Dec 06, 2019 at 10:44:20AM +0900, ������/HYUN-KI KOO wrote:
> To support module for Samsung serial driver,
> I would like to split the file into 2 files.

But you did not do that here in this patch, right?

> Because it cannot be supported in one file both early console and
> module driver
> Thus some function need to change to EXPORT_SYMBOL to use in module
> driver file.
> I'm not pushed yet for module driver.

I do not understand, this patch feels wrong and incomplete as-is, right?
Please fix it up to work properly.

thanks,

greg k-h
