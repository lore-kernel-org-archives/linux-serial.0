Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B47EE4993
	for <linux-serial@archiver.kernel.org>; Fri, 25 Aug 2023 08:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbjHYI1I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Aug 2023 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241178AbjHYI0s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Aug 2023 04:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94519A1
        for <linux-serial@vger.kernel.org>; Fri, 25 Aug 2023 01:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DBF862450
        for <linux-serial@vger.kernel.org>; Fri, 25 Aug 2023 08:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82954C433C7;
        Fri, 25 Aug 2023 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692952005;
        bh=gzI4hMvorgx0Aj7uBLzzLwbfDCkgUDGJVzo94rKGsKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+uZ7i9EwCMZf79UTllMRTPgL/TJr9OmVxQeeXR2AlGqvWX4x5r5EpZfqrEgDn1KG
         bbN/eumpMADP8QXdg/ywxMWSY+QdGV5TaD2rzt/yVXz1uezJT1K4n0hKbZ7N7Gv/GP
         Z4iqC0L8lV6ZFECbGEdfONC1tifhUhmCvSBTMe8w=
Date:   Fri, 25 Aug 2023 10:06:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v3] tty/serial: create debugfs interface for UART
 register tracing
Message-ID: <2023082515-scored-rage-50a3@gregkh>
References: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 24, 2023 at 02:59:01PM -0600, Dan Raymond wrote:
> Implement a UART register tracing facility using the debugfs.  This can be
> used as a "serial port sniffer" to monitor UART traffic and line settings
> with timestamps at microsecond granularity.  This can be useful for general
> serial port debugging or to debug the UART driver itself.
> 
> Signed-off-by: Dan Raymond <draymond@foxvalley.net>
> ---
> V1 -> V2:
>   - add Kconfig option to disable SERIAL_8250_DEBUG feature
>   - limit comments to 80 columns
>   - add defaults to documentation for debugfs files
>   - convert documentation to kernel-doc and link to Documentation/trace/index.rst
>   - switch user types (uint32_t) to kernel types (u32)
>   - reorganize reg_queue structure to prevent memory holes
>   - embed spinlock inside structure it protects
>   - reduce size of line[] buffer to avoid wasted memory
>   - use min_t() macro to select minimum of two integers
>   - simplify return statement from buffer_read()
>   - move comment for "round down to nearest power of 2"
>   - split double assignment of pointers into two lines
>   - use SZ_4K instead of 4096
> 
> V2 -> V3:
>   - change formatting of timestamp from "hh:mm:ss.mmmuuu" to "ssssssss.mmmuuu"
>   - create a new field in 'struct uart_port' instead of using 'private_data'

Better!  But please, look into using the tracing infrastructure and
functionality first.  Only if that is somehow not workable at all should
we regress into using stuff like debugfs for this.

thanks,

greg k-h
