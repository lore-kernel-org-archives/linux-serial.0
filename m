Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323DDC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 08:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhKXIQp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 03:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241286AbhKXIQp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 03:16:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43F006056B;
        Wed, 24 Nov 2021 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637741615;
        bh=ar2oDTi0OeAcJvDVPxa+cwSMgc8Svaa/2Jgtk66tMSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELcH9qGaPFtJosOFrCg32RpY5g4WiTr1a+41n5a+ftU0Bc7NNneEd+9ZfRnv+cWpA
         2Kn7+Hi8sF/j/21yOEOX1Sz3FmUyCbEVHdB+VwEPjc5fE1UEIl1kWj68XR0lYlPQuZ
         fRp9eYfIbE5rqRYKL7hxVWa1cWGX7Gbuz2dfmWKA=
Date:   Wed, 24 Nov 2021 09:13:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jacmet@sunsite.dk
Subject: Re: [PATCH 1/1] tty: serial: uartlite: allow 64 bit address
Message-ID: <YZ30La8Z7oZEoXFF@kroah.com>
References: <20211123184506.1184561-1-lizhi.hou@xilinx.com>
 <YZ05/73+BhIANNGF@kroah.com>
 <0e212384-396b-f765-be28-f9319c64b5f7@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e212384-396b-f765-be28-f9319c64b5f7@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 23, 2021 at 12:12:06PM -0800, Lizhi Hou wrote:
> 
> On 11/23/21 10:59 AM, Greg KH wrote:
> > 
> > On Tue, Nov 23, 2021 at 10:45:06AM -0800, Lizhi Hou wrote:
> > > Fix the uartlite probe failure when it is mapped to address above 4G.
> > Fix it how?
> 
> Does this detail comment look ok to you?
> 
> The base address of uartlite registers could be 64 bit address which is from
> device resource. When ulite_probe() calls ulite_assign(), this 64 bit
> address is casted to 32-bit. The fix is to replace "u32" type with
> "phys_addr_t" type for the base address in ulite_assign() argument list.

Much better.

> > 
> > > Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> > What commit caused this problem?  What commit does this fix?  Should it
> > go to stable kernels?
> 
> I searched the history. This problem was introduced by https://github.com/torvalds/linux/commit/8fa7b6100693e0b648ffd34564f6f41226502a19
> 
> And yes, I agree this should go to stable kernels. I will add
> stable@vger.kernel.org to cc list.

Thank you, please add a Fixes: tag to the patch as well when you
resubmit it.

greg k-h
