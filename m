Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AEEC54EB4
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 09:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjAWJuZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 04:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAWJuY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 04:50:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E87D22010;
        Mon, 23 Jan 2023 01:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38569B80CB4;
        Mon, 23 Jan 2023 09:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670F3C433D2;
        Mon, 23 Jan 2023 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674467418;
        bh=FkPNJc0xLIxgv75yup8Gdo8quEm/AjModjlveLzw5O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfUShgyfjWMjib1bfWeQzsFR4YQ8ha2ssOL4WU5xDIIHagMCph8tGaF+N9RCYiEMW
         BO9lWykf5aIGkxdHGzttym79JfnmlFXZ4EKTLinsiDFFeL6+mRRDbRll3QthxbqCUx
         goZSwZdkQ3paLACQhbVep2/idfuhknJ7Pa8VflyE=
Date:   Mon, 23 Jan 2023 10:50:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Li Chen <me@linux.beauty>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH 10/15] serial: ambarella: add support for Ambarella
 uart_port
Message-ID: <Y85YWO6JzN++kdxe@kroah.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-11-lchen@ambarella.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123073305.149940-11-lchen@ambarella.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 23, 2023 at 03:32:25PM +0800, Li Chen wrote:
> This driver add support for Ambarella's uart, which
> can be used for console and etc.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: Ie68af7ad2187e21853e58d52cd97fd7145303730

Please always use scripts/checkpatch.pl so you don't get grumpy
maintainers asking you why you didn't run scripts/checkpatch.pl :(

