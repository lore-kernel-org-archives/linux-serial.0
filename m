Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B644C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 06:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A784610E8
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 06:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhJRGb5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Oct 2021 02:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhJRGb4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Oct 2021 02:31:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F8C9610A6;
        Mon, 18 Oct 2021 06:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634538586;
        bh=yd2eQKSmYdFKIcLdgbZvxfq69K8jZUqpOQea2RLdzeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcwXSfmanggC30dDW5dLSg3wOR+uEj/zg8Xvgv3bGyr/+QDQYO4Oq8e0Lo1ySHebz
         0Y5Xdq2bv667n5ytmZtSKWmeY9D3d5vEO2JXl4FVqjFKjFGlKKPsgfXKt/gZbusSfK
         ab0RfWtmbG+zkBYdHBfmBKb03KoCtC93NC7Y497vTNpj6qxngZh1OsnOo3MmsbnJ+g
         JJNdQK/yVmA9UgK0zCGlWCYXFbbMiTELcWywAboLZEN1LlnyduwLEi1xcDv4vonyUk
         MDse9OBW1Xdj+1gwo8wweR5Mr3fvrGMOy6CuvRnnuXsfZIwZLH1+dSsyb6VvgibRFd
         hiU5rlqJBt7rw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mcM9Q-0008V6-9Y; Mon, 18 Oct 2021 08:29:36 +0200
Date:   Mon, 18 Oct 2021 08:29:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] serial: 8250: fix racy uartclk update
Message-ID: <YW0UUAZaJSjdovXg@hovoldconsulting.com>
References: <20211015111422.1027-1-johan@kernel.org>
 <20211015191000.hspyxgkwwd47w4nl@mobilestation>
 <20211016152521.zmzhtkswhphos4q7@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016152521.zmzhtkswhphos4q7@mobilestation>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Oct 16, 2021 at 06:25:21PM +0300, Serge Semin wrote:

> The series has been tested on Baikal-T1 SoC with two UART ports
> feed with a common reference clock. It's working well. Thanks again
> for fixing the problem. For the whole series
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>

Thanks for testing.

Johan
