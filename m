Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C6EC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 15:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348532AbhKZPlu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 10:41:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33520 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351972AbhKZPju (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 10:39:50 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 10:39:50 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 025E6B82811;
        Fri, 26 Nov 2021 15:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125A0C93056;
        Fri, 26 Nov 2021 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637940554;
        bh=xWAYeSXvSv88kJNEunVREZHHQoDhcTk0/UaJ3ba86Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zz2r/N6YG9o1YB6q4AGV7CZphcVMQqpwmkKtP+dt9WdWGeBJGlmKjhvZZIOPOoEC7
         KY0DSCnsuZLq7L4VjfoUwAotG9SazgxsuP+QhzmLU+iWSmNhTtWyUqRxe5wgKpC+t8
         MtfZyCqddEBiTc5WvKQISfXqGhZBpEpXWPI/MUuY=
Date:   Fri, 26 Nov 2021 16:28:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] tty: documentation revamp
Message-ID: <YaD9DVL10AZBLVS5@kroah.com>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 26, 2021 at 09:15:48AM +0100, Jiri Slaby wrote:
> This series adds/updates:
> 1) kernel-doc documentation for most exported functions, and
> 2) adds a chapter to Documentation/tty to glue it all together.
> 
> I think it's a good base for further improvements. It deduplicates
> and unify multiple documentation files.

Wow, thanks for this!  All now queued up, much appreciated.

greg k-h
