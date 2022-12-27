Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F19C10F1B
	for <linux-serial@archiver.kernel.org>; Tue, 27 Dec 2022 07:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiL0HZ2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Dec 2022 02:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiL0HZ0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Dec 2022 02:25:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3387B5D
        for <linux-serial@vger.kernel.org>; Mon, 26 Dec 2022 23:25:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A1B560F90
        for <linux-serial@vger.kernel.org>; Tue, 27 Dec 2022 07:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC57C433EF;
        Tue, 27 Dec 2022 07:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672125924;
        bh=6dIYbyfYaUhfpmnPos8JjrujqxevVJWiOs4DB+iF9fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2RHhjh+AeFDGaf3JnOhyvUpSvyPz4kzxySM047hQe82uOXMK7j4Jb9DcwXjz4nf2S
         LILmVNlpl2+86AF8zSDOJfksN9IEGMIdmOTWhU8Sjcv9Mu9Fc6RQt9L7aKvjR8AMc0
         rtK7ywQiaxbkugySLRJbG7ePntIZhJY5KxVlguHQ=
Date:   Tue, 27 Dec 2022 08:25:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christina Quast <contact@christina-quast.de>
Cc:     linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        daniel.beer@igorinstitute.com
Subject: Re: [PATCH tty-next v2 1/3] hid-ft260: Cleanup macro formatting
Message-ID: <Y6qd4TG8BSHd0KY1@kroah.com>
References: <20221226171549.73645-1-contact@christina-quast.de>
 <20221226171549.73645-2-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226171549.73645-2-contact@christina-quast.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 26, 2022 at 06:15:47PM +0100, Christina Quast wrote:
> Wrap macro arguments in braces.

This says _what_ you did here, but no explaination of _why_ you did
this, or why it was even needed.

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/process/submitting-patches.rst for what is
needed in order to properly describe the change.

thanks,

greg k-h
