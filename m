Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F7AC3815B
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065D022246
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045802;
	bh=lERJmzbwc5ScyG8KTnuTzGkoZ1Fds8erwGnk4BHFhws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LPonOvh8a8jiDOY7DLcPVKvlg9LO/AYyHDhwtg7Wz/Q1IV7ve+zwXvX+9cHgo3Dnl
	 MYDSaH8SrHnnRQs9BzS6fgWFIsz3fhGvWSGQVEIdxTxv0B1k7wI6n/f6rL52B1cRq2
	 YdFYFJVQUvhsoQ/hYC/ikU2Zw/EHhzB/ceIgk5OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbgDPODU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732703AbgDPOCx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 10:02:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4CA22247;
        Thu, 16 Apr 2020 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045772;
        bh=lERJmzbwc5ScyG8KTnuTzGkoZ1Fds8erwGnk4BHFhws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntKugfcpsklKuYMeG5MOV6czGfk8XQoFoBzDuOP0gdFmtDAT/0/cd7WdooVN+Mfqj
         HZ3W+QJIADrTLeTCtREHWt5DOKAq/G3y1jeSjuBnV6t2l8MN3tCJmgY1A+KrScYZw6
         TFXvZDdoY7pmzFrTWkh48CI8SJiB7mNk4TLHEgQU=
Date:   Thu, 16 Apr 2020 15:56:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hyunki Koo <hyunki00.koo@gmail.com>
Cc:     robh+dt@kernel.org, krzk@kernel.org,
        Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v7 2/2] Support 32-bit access for the TX/RX hold
 registers UTXH and URXH.
Message-ID: <20200416135618.GA1295013@kroah.com>
References: <20200411123325.30501-1-hyunki00.koo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411123325.30501-1-hyunki00.koo@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Apr 11, 2020 at 09:33:24PM +0900, Hyunki Koo wrote:
> From: Hyunki Koo <hyunki00.koo@samsung.com>
> 
> This is required for some newer SoCs.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested on Odroid HC1 (Exynos5422):
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> v2: 
> line 954 : change rd_regl to rd_reg in for backward compatibility.
> line 2031: Add init value for ourport->port.iotype  to UPIO_MEM 
> v3:
> line 2031: remove redundant init value  for ourport->port.iotype 
> v4:
> correct variable types and change misleading function name
> v5:
> add dt-binding and go as first patch in this series.
> v6:
> no change in this patch, only chaged in [PATCH v6 1/2]
> v7:
> add reviewed by and tested by
> ---

Your subject line changed for this and patch 2 :(

Also, I asked you to split this patch up better in the past, you seem to
have ignored that :(

First patch would be to create the new functions and use them, with no
functional change to the code as-is.  A second patch would add the new
binding, and a third patch would be to add the new functionality.

And you need to describe all of this very well in your changelog, the
one sentence here is not sufficient at all.

Please fix this all up and resend.

thanks,

greg k-h
