Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E6C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6D5611AB
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhDOIS2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhDOIS1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 04:18:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E51B611AB;
        Thu, 15 Apr 2021 08:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618474684;
        bh=7RCVtxr5iuVv7NYIuc19T/0RhkBsqrox+oxUw+CWC7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuMSQB2PtW8Ywe6dTv3RV9JG0+2CwAzpee4gbVoJuer2B0mNQEMto013OqYlGDGcl
         i+l69PxWFe4/3hLX//+O4CeEHzC4VSpRmlaDh8Q3mk4d9nlOR0UYrLuJckEGituu+y
         usEESkfaX/Zc1k38vtduMt3sAevgR9T8xRdQRIw0=
Date:   Thu, 15 Apr 2021 10:18:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Chapman <glitch@glitchwrks.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Sealevel Systems 7202 PCI Serial Card
Message-ID: <YHf2uo6uTfTyC2kJ@kroah.com>
References: <20210226160905.4809b6eef1b515b6790953cc@glitchwrks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226160905.4809b6eef1b515b6790953cc@glitchwrks.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 26, 2021 at 04:09:05PM -0500, Jonathan Chapman wrote:
> Below is the information for a PCI dual-port serial card I use:
> 
> Manufacturer: Sealevel Systems INC.
> Name/Model: 7202 Dual Port RS-232 Interface
> 
> Output of `lspci -vv`:
> 
> 00:11.0 Serial controller: Sealevel Systems Inc Dual Port RS-232 Interface (rev 01) (prog-if 02 [16550])
>         Subsystem: Sealevel Systems Inc Dual Port RS-232 Interface
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 12
>         Region 0: Memory at e9100000 (32-bit, non-prefetchable) [size=128]
>         Region 1: I/O ports at d800 [size=128]
>         Region 2: I/O ports at dc00 [size=8]
>         Region 3: I/O ports at e000 [size=8]
>         Kernel driver in use: serial
> 
> Lines from `dmesg`:
> 
> [    0.981647] serial 0000:00:11.0: found PCI INT A -> IRQ 12
> [    0.982022] serial 0000:00:11.0: 0000:00:11.0: Redundant entry in serial pci_table.
>                Please send the output of lspci -vv, this
>                message (0x135e,0x7202,0x135e,0x7202), the
>                manufacturer and name of serial board or
>                modem board to <linux-serial@vger.kernel.org>.
> 

Wow, that's odd.  This device id has been in the kernel since before
2005 and no one has reported it with this issue.  Maybe no one reads the
kernel logs?

Anyway, thanks for the report, as this is working properly I think we
should just leave it alone given the age of this hardware, we don't want
to accidentally break anything :)

greg k-h
