Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D35C4338F
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 12:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE89610A0
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 12:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhHBMut (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhHBMur (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Aug 2021 08:50:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31A2E60F58;
        Mon,  2 Aug 2021 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627908637;
        bh=3MKa7wkl36ZJdn/Xya+VfMjlloeBPMGrEJKPARDl+yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxTuvGr3pW6lB1+3AQgFJu9HPjbAUosWqP6/9JWJz3LeNTIPpxD/F/a1D7jrcb2ZT
         +/FYU6dQKC6lYf6oTXbeUAV5Ktvza34J84OhoAGva0cmythnZjuSkmUSi7sSJGyj7H
         lQz3rD7EOzaKmuCUi+bi+XUPqxvIUOtDDWrisnIHNQO3A1ZRi5q2ltRqt/jBiKmhXc
         KhDHv3cde1TW9PuskA/3YtYrgLTosUEJsOulfC3AiTcxJ0/xtgqEsWK2Up4rM+ZCd/
         khkmw00tUWx07XG+laKvEPGNrnGkU0PsKfui1s3QPIIJLzT059cbe/j/TC9IZzrIFz
         P7O69YhvrI2eg==
Received: by pali.im (Postfix)
        id BE1C1B98; Mon,  2 Aug 2021 14:50:34 +0200 (CEST)
Date:   Mon, 2 Aug 2021 14:50:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Glibc <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: Document the types "struct termios" and "struct termios2"
Message-ID: <20210802125034.gubtf24tsm7lkh3k@pali>
References: <ef6a352d-4926-9cdc-9894-e387866a00c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6a352d-4926-9cdc-9894-e387866a00c4@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

+ linux-serial

On Monday 02 August 2021 14:38:43 Alejandro Colomar (man-pages) wrote:
> Hi,
> 
> From a few patches of Pali and their subsequent discussions,

For others, link to patch with code example:
https://lore.kernel.org/linux-man/20210801135146.14849-1-pali@kernel.org/

And links to other discussions:
https://lore.kernel.org/linux-man/20210725225506.7404-1-pali@kernel.org/t/#u
https://lore.kernel.org/linux-man/20210730105353.10424-1-pali@kernel.org/t/#u
https://lore.kernel.org/linux-man/20210730153044.23673-1-pali@kernel.org/t/#u

> it was clear
> that those types need to be documented (the most appropriate place being
> system_data_types(7), with link pages termios-struct(3) and
> termios2-struct(3)).
> 
> The most important part (the one we had problems with) being which headers
> should be included for each type (and for each version of the type
> (kernel/glibc)).  That includes the recommended header, and other headers
> that _shall_ also provide the type.
> 
> Is there someone that knows those types enough to write such documentation
> and wants to do it? :)
> 
> Thanks,
> 
> Alex
> 
> -- 
> Alejandro Colomar
> Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
> http://www.alejandro-colomar.es/
