Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176A2C10F1B
	for <linux-serial@archiver.kernel.org>; Tue, 27 Dec 2022 09:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiL0Jsl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Dec 2022 04:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiL0Jsb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Dec 2022 04:48:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ABE95B3
        for <linux-serial@vger.kernel.org>; Tue, 27 Dec 2022 01:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 167F5B80EA4
        for <linux-serial@vger.kernel.org>; Tue, 27 Dec 2022 09:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9194C433D2;
        Tue, 27 Dec 2022 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672134504;
        bh=FPRejTJflkxDD1akuYLHxM30sgZ8FDF/3MxgqYsuX7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJYUrNHEk8Bps3LQBMN/UKwTgTSvBSV3Yk42HQdr5gjnVnQf1RVR73WfP8hp5PpYk
         uornCIWmlpC0KzRTxorQMrk2qrD2kZj+SPChAsDdoUiHKPwnv6G8m0w28hM95md9rv
         Uese1BTXvtzN2iRYfdyhb77Jyowa5cByBMzqSwWX5realBujRhQrnBb23NYn3FP4YP
         vNQsXE//tYMrdB6D8AF77T7kF1dRi6+8WnOLqjk4BIhSXapDyCD1N7mG0RfSHZrqZh
         m7OEzsBRFapcZvT4N/yNngLXq1o1uv8rK2q8aHyTOXjQ8oSBq4RU1DrP6lUroXWIEg
         IAHukV5o0qyog==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pA6ZM-0004Bj-7N; Tue, 27 Dec 2022 10:48:24 +0100
Date:   Tue, 27 Dec 2022 10:48:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Christina Quast <chrysh@christina-quast.de>
Cc:     Christina Quast <contact@christina-quast.de>,
        linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        gregkh@linuxfoundation.org, daniel.beer@igorinstitute.com
Subject: Re: [PATCH tty-next v2 3/3] hid-ft260: Change u8 to __u8 for hw
 facing structs
Message-ID: <Y6q/aN+wfIbvBiOR@hovoldconsulting.com>
References: <20221226171549.73645-1-contact@christina-quast.de>
 <20221226171549.73645-4-contact@christina-quast.de>
 <Y6qwwHbjmpn/hvp7@hovoldconsulting.com>
 <d9c0cc2c-c724-b641-80ce-e31336901410@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c0cc2c-c724-b641-80ce-e31336901410@christina-quast.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 27, 2022 at 10:32:25AM +0100, Christina Quast wrote:
> Hi Johan!
> 
> Thanks for your review. I added this change, because that was GKH's
> comment for the struct ft260_configure_uart_request in e previous
> review of the commit:
> 
> And as this is a structure that comes from the device, you should be
> using __u8 and friends.
> 
> So you are sure I should remove this change from the patchset? We want
> to continue using u8?

Yes, I believe Greg is mistaken here. He may prefer that style for some
reason, but there's really no need to go about changing existing drivers
to use __u8 for something which is not shared with user space.

Side note: your mailer seems to be sending mails with HTML which will be
rejected by the mailing lists.

> On 12/27/22 09:45, Johan Hovold wrote:
> > On Mon, Dec 26, 2022 at 06:15:49PM +0100, Christina Quast wrote:
> >> Structures that come from a device should use __u8 instead of u8
> >> for their elements. Therefore change all elements in the HID report
> >> structs from u8 to __u8.
> > No, this is not correct. You only need to use __u8 in header files that
> > are shared with user space.

Johan
