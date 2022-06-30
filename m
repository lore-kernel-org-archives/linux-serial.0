Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437E7C43334
	for <linux-serial@archiver.kernel.org>; Thu, 30 Jun 2022 14:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiF3O7i (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiF3O7a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Jun 2022 10:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61EC1EEDD;
        Thu, 30 Jun 2022 07:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A66EB82A19;
        Thu, 30 Jun 2022 14:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA1AC34115;
        Thu, 30 Jun 2022 14:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656601166;
        bh=QxkMY3Y9fETvRjjJ3Mkcp2JRigNnfkqjA3O71N05ka4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FR6Wos0hy4zxbZvvfGCEfYxTDThKjZPAJFWt5W4cLzocxGZZ3KBr3VMWXEzKQDdFr
         a8XDLve+MCdBNCq8w/OTN64O0nnyo52ZyomCd3ynQrEnqXDjK/+JokmrvPfh+Jsimv
         hTt2Uvg1nRHCDgQ0cX4PCgLA4lvR7A1RT1h3XKUE=
Date:   Thu, 30 Jun 2022 16:59:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] tty: n_gsm: fix deadlock and link starvation in
 outgoing data path
Message-ID: <Yr26TChFOO3fXdqT@kroah.com>
References: <DB9PR10MB58813B83E903F1856FD0CAAAE0B89@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB58813B83E903F1856FD0CAAAE0B89@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 28, 2022 at 09:41:17AM +0000, Starke, Daniel wrote:
> Hence, I would like to resubmit this patch series without any stable
> backport remark to avoid unmanageable effort.

That would be great, please do!
