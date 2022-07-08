Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DDCC433EF
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jul 2022 08:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiGHIBN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Jul 2022 04:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiGHIBL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Jul 2022 04:01:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E617E028;
        Fri,  8 Jul 2022 01:01:10 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657267268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slhUfzwux9ajrta/wJhEQ8iOkSClaYWHZmFx03+gEaU=;
        b=ifC0jjjBGQwIsVbinNt6MMrPfUTeosvK1q1gjv+wToOJi5HMPJsDFOmX5IaqnGZzcNFNDV
        YNfxaF+9qNGU+ir610gTvtgjCaNRw0nvdBBNjAjyxkOTdi84xJjTQchM7dNFYED62ymH86
        5+YXuj4+Jt/rkWhFeOTr954iwlZRcpTGfTYA7+16Vy6HFYf5zMQtVHwlWAcmSqBLJX4/dX
        YoeKVJJfv6P+7Be5X8WfoWWtO5pHBmWq1Uv1WRVQnSEYcubuGAhRw9/Gv/B6W3gixVOwIQ
        fmWU1KfX3CDgidNaz8Ij6uEKqspvHKtaozkHfuD1Ri8ulgYyMIz0TzLeMvlf7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657267268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slhUfzwux9ajrta/wJhEQ8iOkSClaYWHZmFx03+gEaU=;
        b=4qsGIFQ7K5tDhZLDNlwXWOpfdltBY0rkY77dwhQ8+uvGdIYKvSPiB2oUz0HdD9ukOmDH+T
        GEXisYKmJj4MjpBw==
To:     todd.e.brandt@linux.intel.com, pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
In-Reply-To: <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
Date:   Fri, 08 Jul 2022 10:07:08 +0206
Message-ID: <87czegxccb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Todd,

Thanks for reporting this.

On 2022-07-07, Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> Ever since 5.19.0-rc1 the serial device has taken almost a second
> longer in both suspend and resume. This effect is witnessed in half
> the machines in our lab (~10 machines). It occurs on dell, asus,
> gigabyte and other machines so it's not hardware specific.

Please provide a full dmesg log if you can. The important parts of the
log would be:

- boot arguments
- any lines with "printk" in it
- timing information
- messages during suspend and resume

pr_flush() uses a timeout of 1 second. I assume your console driver is
not printing and therefore not making any forward progress.

John Ogness
