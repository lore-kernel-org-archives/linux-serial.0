Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D23EB64D9
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jun 2023 13:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjFSNmY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Jun 2023 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFSNmW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Jun 2023 09:42:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE09E76;
        Mon, 19 Jun 2023 06:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6E4960C59;
        Mon, 19 Jun 2023 13:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C05C433C8;
        Mon, 19 Jun 2023 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687182136;
        bh=H06KR5Dhyi+0NKm+83jJG1aT37gPgMa/GVwV3K/qHVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvLKBRsqCgmQekJjsNrLEXt6AAMToofLQR4nqNCa1ipGoeXkpk26w4AgxV1wylgh9
         4ziWSXGc9WagpbqeRqae1f3PCFfn2HLusBF+0DXz7cwK9jdWNibrnAUAepdDEI4EfB
         Zzk6wQ7NBt7deGBZWd4YLx029vkPItn1zVCh24SU=
Date:   Mon, 19 Jun 2023 15:42:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Revert "8250: add support for ASIX devices with a
 FIFO bug"
Message-ID: <2023061950-unrigged-dosage-59e2@gregkh>
References: <20230619100818.778176-1-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619100818.778176-1-jiaqing.zhao@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 19, 2023 at 10:08:19AM +0000, Jiaqing Zhao wrote:
> Commit eb26dfe8aa7e ("8250: add support for ASIX devices with a FIFO
> bug") merged on Jul 13, 2012 adds a quirk for PCI_VENDOR_ID_ASIX
> (0x9710). But that ID is the same as PCI_VENDOR_ID_NETMOS defined in
> 1f8b061050c7 ("[PATCH] Netmos parallel/serial/combo support") merged
> on Mar 28, 2005. In pci_serial_quirks array, the NetMos entry always
> takes precedence over the ASIX entry even since it was initially
> merged, code in that commit is always unreachable.
> 
> In my tests adding the FIFO workaround to pci_netmos_init() makes no
> difference, and the vendor driver also does not have such workaround.
> Given that the code was never used for over a decade, it's safe to
> revert it.
> 
> Also, the real PCI_VENDOR_ID_ASIX should be 0x125b, which is used on
> their newer AX99100 PCIe serial controllers released on 2016. The FIFO
> workaround should not be intended for these newer controllers, and it
> was never implemented in vendor driver.
> 
> This reverts commit eb26dfe8aa7eeb5a5aa0b7574550125f8aa4c3b3.
> 
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fails to apply to my tree :(

Can you rebase this against the tty-next branch of my tty.git tree on
kernel.org?

thanks,

greg k-h
