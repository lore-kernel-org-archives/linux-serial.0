Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C26DE732C5
	for <linux-serial@archiver.kernel.org>; Thu, 28 Sep 2023 12:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjI1MNb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Sep 2023 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1MNb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Sep 2023 08:13:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE66B122;
        Thu, 28 Sep 2023 05:13:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0048C433C8;
        Thu, 28 Sep 2023 12:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695903209;
        bh=SQN6E77zpBfJ27wOTh0uX3kSlNP+bH/CwKQHoJZ5nYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uvlvy4S3t84UZ4gUKyvsaikqM+sC2AHzBMKvAcUj2kcy/fmw2DQYAv1yZzbealfmG
         TY7YNIc+qLkTKe5Zp5La78KU1nWvqNMyu7b60SXFRBzWmpLhUSdBBYG+PsSm3cMIic
         J1Kc/9+q7tYdC78iOuwZLEQHYQDUAP0phc8EwJMw=
Date:   Thu, 28 Sep 2023 14:13:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 11/87] drivers/tty: convert to new inode {a,m}time
 accessors
Message-ID: <2023092858-paparazzi-budding-6c35@gregkh>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
 <20230928110413.33032-10-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928110413.33032-10-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 28, 2023 at 07:02:20AM -0400, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

As much difficulty muti-subsystem patches are, we do need a changelog
entry please.  Maybe some maintainers are nicer, but I can't ack a patch
without any text here at all, sorry.

thanks,

greg k-h
