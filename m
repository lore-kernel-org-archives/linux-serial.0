Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385BC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 16 Dec 2022 02:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLPCQK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Dec 2022 21:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLPCQJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Dec 2022 21:16:09 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886C1A23B
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 18:16:08 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8582785319;
        Fri, 16 Dec 2022 03:16:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671156967;
        bh=P966DiPywJi72dDvlS35nXR4CLL+jEqDYx5pkSRR9dg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L1RrVNbTLZ4dKcU/KsGiSNQIipERmLDFbnjHlqyjpp6yrPFgQs3SGsiujpU9HLkK3
         Xy/15GWpIlyDVd1T5jz5ixBMibgZYrPMOuS5Yc2towCMOeU+fqI1GSx8BTfhTvYoIT
         Pf8S8+R5cMJftEphaa6+Qd2xOP46Fa0oPEyGVzSX7BurPyt6NWYqGLPLZJOs2RaCHZ
         JsqjY8o4T75OgbV4GYwbuuaHO57N8xCYjtFiASgf0Ai9vPmpPBUVvUCkYzYzBYhc0j
         ibIuxgC3wZtnkduN5ekOqThElFmpXfNRMAdk/DyakckULpkECFmmwiALrTotEHO/Uy
         x5p08Ip+j4Vjw==
Message-ID: <5ef20edd-7673-661d-5175-2c9a6af26dde@denx.de>
Date:   Fri, 16 Dec 2022 03:16:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] serial: stm32: Move hard IRQ handling to threaded
 interrupt context
Content-Language: en-US
To:     Valentin CARON <valentin.caron@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-serial@vger.kernel.org
References: <20221207195929.160267-1-marex@denx.de>
 <34ec91a2-2089-65ba-d5bb-fed03cda63b7@foss.st.com>
 <a984e2aa-1fbf-4b6b-9326-d926221740d8@denx.de>
 <f2373a2b-8229-8af3-116c-7f3b8ccf8062@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <f2373a2b-8229-8af3-116c-7f3b8ccf8062@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/15/22 17:52, Valentin CARON wrote:
> Hi Marek,

Hi,

> I test your patch with a loop-back test between usart3 and uart7 on 
> STM32MP157C-DK2. It
> shows a speed transfer diminution (about -1,5%), some locks during 
> transfer, RT throttling etc...
> (I use lszrz tool).
> 
> But finally, I think your patch is the best solution that we have.
> Other solutions always throws an RT exception on a spin_lock.

I just sent a V2, so let's see how that works.

Thanks for testing!
