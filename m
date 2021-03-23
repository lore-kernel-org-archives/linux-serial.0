Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D8C433C1
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B686F61923
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCWJhK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhCWJgq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 05:36:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46C8961923;
        Tue, 23 Mar 2021 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616492205;
        bh=XfVvk9x0Xl6jSDtegB8uNoxoslvqQA26AIp8nlzMc1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vcdnD4/k/NPetX5KQ5LjborVFa235CkNkYtH5BncC61UcTkYAMKHZakiwrFIUMAR7
         KJFFa0OLJVwlh/hw7DTxpeGn/CtEfRq+rnHygLfChkt8SwYFqHHSdhkjrKbVrCgGvO
         I9MTyx95d/6MHA5wMQnQIFq5QzYJlh5SyHsLp9Bc=
Date:   Tue, 23 Mar 2021 10:36:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 2/2] serial: 8250: Add new 8250-core based Broadcom
 STB driver
Message-ID: <YFm2qwgNF7H7V54V@kroah.com>
References: <20210318191131.35992-1-alcooperx@gmail.com>
 <20210318191131.35992-3-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318191131.35992-3-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 18, 2021 at 03:11:31PM -0400, Al Cooper wrote:
> +config SERIAL_8250_BCM7271
> +	bool "Broadcom 8250 based serial port"

Why can this not be a module?

thanks,

greg k-h
