Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99E9C3A5A7
	for <linux-serial@archiver.kernel.org>; Thu,  8 Dec 2022 07:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiLHHLE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Dec 2022 02:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHHLC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Dec 2022 02:11:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CC12AC61
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 23:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CF29B822DD
        for <linux-serial@vger.kernel.org>; Thu,  8 Dec 2022 07:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D54C433D6;
        Thu,  8 Dec 2022 07:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670483457;
        bh=Iqslwvll+Wkp0slJbi69VggTYsCkpr0aul42wY4aRVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdfTE5ynGsB8OVh5jO2wtoO264Jnw5MTUR/V74HuEg/HfT2J/WHZLJjQWuYtUznIa
         KD/nrwk7A5mNjS8lJyHYo+F7Ul97Hs1NvjHmU5DNUJv1/eFJdd7X17GlgMEExTwrc1
         R3V8lvfwYg2qf5nDD/pxaBHjWdJU6M0U92f/+JJg=
Date:   Thu, 8 Dec 2022 08:10:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christina Quast <contact@christina-quast.de>
Cc:     linux-serial@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>
Subject: Re: [PATCH tty-next v2] hid-ft260: Add serial driver
Message-ID: <Y5GN/dceC5NDfiYE@kroah.com>
References: <20221207220617.116082-1-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207220617.116082-1-contact@christina-quast.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 07, 2022 at 11:06:17PM +0100, Christina Quast wrote:
> This commit adds a serial interface /dev/FTx which implements the tty
> serial driver ops, so that it is possible to set the baudrate, send
> and receive data, etc.
> 
> Signed-off-by: Christina Quast <contact@christina-quast.de>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Daniel Beer <daniel.beer@igorinstitute.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> This patch applies after the cleanup patch series sent previously.
> 
> Changelog:
> Hopefully applied all clean-ups suggested by Ilpo Järvinen.
> Also considered some feedback from Greg Kroah-Hartman to Daniel Beer's
> patch.

We now have 2 competing patch series for the same functionality for the
same driver.  Can you and Daniel work together to agree on the way
forward here please?

And also, I still think that the usb-serial interface should be used.  I
know Daniel wrote back with why they think this will not work, can you
verify that is true or not?  I haven't had the chance to check yet...

thanks,

greg k-h
