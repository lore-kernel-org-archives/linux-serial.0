Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4CEC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB25320772
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594384834;
	bh=yQ2whhcujJFTVttB/Tcmh1eAH76VyXoPn1ZJkNdvY5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eWOXdxKPiHHbtSYgdlAK6b8JX6KgSyvMd+ORVLrXClJur6tf5Gf/ZzsgkQo3Rl84D
	 tiPam6e5ddYZr391eBIQK6cHdMcFV+wYj8eH70qFEb4DqMNgpou9xzs704xudRDpVW
	 E4zHC3MkLgX9q8F+jdGWtY2nMic5ouueFzm+v+j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJMke (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJMke (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 08:40:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E23206F4;
        Fri, 10 Jul 2020 12:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594384833;
        bh=yQ2whhcujJFTVttB/Tcmh1eAH76VyXoPn1ZJkNdvY5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPqqIPMjF8yHhnOagf5A0hA+3/qJbUk78jCENs3/AeSabC2Pjrj7UYUKN0PI+iSsl
         vAAszGeNmwkyBfBZPkQSKx9r04rywwi7gx1O3kQiAOWDjE9ORSicaMKTh4n4px6ofj
         OhNWhbOm45dAjTIwyJBcwTgyF3rgHsoxwptuY9VM=
Date:   Fri, 10 Jul 2020 14:40:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com
Subject: Re: [PATCH] serial: exar: Fix GPIO configuration for Sealevel cards
 based on XR17V35X
Message-ID: <20200710124038.GA1567243@kroah.com>
References: <473cc7ae-c870-ff0f-0c68-bdcfed19efde@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473cc7ae-c870-ff0f-0c68-bdcfed19efde@sealevel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 09, 2020 at 03:23:37PM -0400, Matthew Howell wrote:
> 
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> FIXES: 7dea8165f1d("serial: exar: Preconfigure xr17v35x MPIOs as output")

Nit, this should look like:

Fixes: 7dea8165f1d ("serial: exar: Preconfigure xr17v35x MPIOs as output")

and placed down in the signed-off-by area.  I'll fix it up this time...

