Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C9C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 10 May 2022 08:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiEJIFp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 May 2022 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbiEJIFg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 May 2022 04:05:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31043AFA
        for <linux-serial@vger.kernel.org>; Tue, 10 May 2022 01:01:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0EF601F442DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652169680;
        bh=p42Xi0ShEUnD7GtALOa5CgFGIIwTmsW38K7ePg5SwLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Br4+p4BTN2Ux5se3JCys2+1hjAwUgmE4vMlVUf1Rc5UxPL/0ERLHZfMHMR9gsxMyk
         Yz1HY9eyLCVpdaEc7XVhrq8XyiWdz4d7nbEYjIhGDl3/uRCEPyCUBQzSefGVZ51F1X
         1gsbaDPcwKlpBTncRQTV5WAbHnRIUxcr+yWVCBWYWgxh5gTE+APyxviHqM/ApvEehT
         FiN9WduhNd41fsdLQZGJD6BluxY6H85moEYKcw15imsUz9F4EWuuwRIj7j/ehagdaG
         B1nuFWGeWp0gQzqO2jxxb65KtuS+yyhw1AHdQpaGwZ1ZEWeUJTTz4H85pAIrjQkaCJ
         tU+pPvYneduag==
Message-ID: <9a2b8b38-c4c0-b1a3-832b-74a937d66047@collabora.com>
Date:   Tue, 10 May 2022 10:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: next/pending-fixes bisection: baseline.login on mt8173-elm-hana
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org
References: <62793d83.1c69fb81.71b96.033e@mx.google.com>
 <YnlBAoZTJ6WbM394@sirena.org.uk> <YnlaZgJfGASYwO8Y@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YnlaZgJfGASYwO8Y@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Il 09/05/22 20:16, Mark Brown ha scritto:
> On Mon, May 09, 2022 at 05:27:51PM +0100, Mark Brown wrote:
>> On Mon, May 09, 2022 at 09:12:51AM -0700, KernelCI bot wrote:
>>
>> The KernelCI bisection bot found a boot regression on mt8173-elm-hana
>> which bisected to 6f81fdded0d02 ("serial: 8250_mtk: Make sure to select
>> the right FEATURE_SEL").  With the patch the output terminates at:
> 
> There was also a similar report on mt8183-kukui-jacuzzi-juniper-sku16.


Strange, we tested it on another Kukui device and it didn't produce any issue...

Doubt is if it's just about the FEATURE_SEL register, as that may be protected
and/or not exist on 8173?

I'm investigating that today.

Cheers,
Angelo
