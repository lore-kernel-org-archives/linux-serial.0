Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A2EC4332F
	for <linux-serial@archiver.kernel.org>; Thu,  8 Dec 2022 07:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLHHLy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Dec 2022 02:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHHLx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Dec 2022 02:11:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803612AC61
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 23:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 300ABB822DD
        for <linux-serial@vger.kernel.org>; Thu,  8 Dec 2022 07:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C35EC43470;
        Thu,  8 Dec 2022 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670483509;
        bh=6oBfHSeciKfXTdQXO0hXyvcCnwfDem+pVlmflkL+Tl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0OFm3cVQi+rFz6Vh1zXthNsn029ithgLMcwDHlSYyfd8c44OrfBU6j9oQH9Rvkau
         J+TGH8djZ8oPLSHiVuuxlXL5vsksARvBV/YOLImmlQASwvXaF01HKiLKVhtxtZWCni
         oDCgPD9ezuGOPDMosczQwsXpIxYzHVlmGIzejTYQ=
Date:   Thu, 8 Dec 2022 08:11:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christina Quast <contact@christina-quast.de>
Cc:     linux-serial@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>
Subject: Re: [PATCH tty-next 0/3] hid-ft260 cleanups
Message-ID: <Y5GOMh0DJovRWGJf@kroah.com>
References: <20221207215540.114920-1-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207215540.114920-1-contact@christina-quast.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 07, 2022 at 10:55:37PM +0100, Christina Quast wrote:
> Cleanups in preparation for the serial driver functionality addition
> to hid-ft260.
> 
> Thanks for the review to Ilpo Järvinen and Greg Kroah-Hartman.
> 
> Christina Quast (3):
>   hid-ft260: Cleanup macro formatting
>   hid-ft260: Rename struct ft260_i2c_input_report
>   hid-ft260: Change u8 to __u8 for hw facing structs

None of these have any changelog text in them, which isn't something we
can accept (nor should you want us to.)

thanks,

greg k-h
