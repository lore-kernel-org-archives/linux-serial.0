Return-Path: <SRS0=Pw1G=6W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B26C38A2A
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A616520A8B
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588937558;
	bh=Jk4XlK+h8HjWzOoEefISU2WBXo0ACe5SKHQjWnAgzh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t33+svkiHedzwoMx4xdgnyjVFk3fIuVF/s1vy4dVulGtedRqjBmQPshvqedeKdOUR
	 SI3xhfzGlV6tQZ/ts/gVV+FaIjzsnyqISuiMyXyR37+WAWgMwPd2NlIHEn9BskEhCl
	 9JHwnIEPrf7EmQ+GokmzITzdCgNI2ifTZJ0Tpq9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHLci (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 May 2020 07:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHLci (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 07:32:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4E3208E4;
        Fri,  8 May 2020 11:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588937556;
        bh=Jk4XlK+h8HjWzOoEefISU2WBXo0ACe5SKHQjWnAgzh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crJ8TyzdhXXNeNZtaZn+upCXolAaF3UitO6luducGLkzahvIspYLV2Fs0JRahkpRI
         eXm00AwIrL3wvvP/ae3so+/X/9O9BcKNaqQ7JT9KAAicAbd+I5D3dRwoUy8AIQEN1a
         GI0hkyOCObZMUDqo5l1rWlb4DxeO3Z6fOlSzsnGg=
Date:   Fri, 8 May 2020 13:32:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH] serial: lantiq: Make driver modular and console
 configurable
Message-ID: <20200508113233.GA4043190@kroah.com>
References: <42292519ba78f086eb19d058dec6411f5f29da51.1588936756.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42292519ba78f086eb19d058dec6411f5f29da51.1588936756.git.rahul.tanwar@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 08, 2020 at 07:20:49PM +0800, Rahul Tanwar wrote:
> Add changes so Lantiq serial driver can be compiled as a module.
> Also, make this driver's use as console selectable/configurable.

When you say "also" in a patch description, that's usually a huge hint
that this needs to be broken up into multiple patches.

Please do that here, this should be 2.

thanks,

greg k-h
