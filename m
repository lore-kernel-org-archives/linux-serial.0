Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5223DC4332F
	for <linux-serial@archiver.kernel.org>; Thu,  8 Dec 2022 13:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLHN3u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLHN3t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Dec 2022 08:29:49 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A328658F
        for <linux-serial@vger.kernel.org>; Thu,  8 Dec 2022 05:29:47 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B6D4381253;
        Thu,  8 Dec 2022 14:29:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1670506185;
        bh=4DUlDl/WRb+joognhqzxZXXrzOnsFPGMBRZ1TB+CdOc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TjpbJ/CGkLC7AM+EJQws5+wvpfR5lVl/dZ4lRQJqG2bc1xD6fpeatceMPEkO9qQdR
         tzzszcc3XJEezvHtc3NhmBuuO9eruhE/FJHD+E25j3R3qnJfooQX3JBjLSBYvM4hsE
         O/y4EdnHxhfB4vQ3n1ruEDUSDVatnOsfofZMzY7GxUt59VZxxwPfeIdMxt7okRVz/n
         rPsHtTJ4ps6cUNmNo6kRJaOLnztUm025+DBa7o8q5HJ93fQLWEX2N67e5mB//AMMIO
         yLQ+XQGSOYQGaDu8DSq5idI0MZ58xK96He+e5VCoYY9rH0aKr9xqsSwW0nJhzCDSN7
         PHk+Kf7LQc2+Q==
Message-ID: <a984e2aa-1fbf-4b6b-9326-d926221740d8@denx.de>
Date:   Thu, 8 Dec 2022 14:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] serial: stm32: Move hard IRQ handling to threaded
 interrupt context
To:     Valentin CARON <valentin.caron@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-serial@vger.kernel.org
References: <20221207195929.160267-1-marex@denx.de>
 <34ec91a2-2089-65ba-d5bb-fed03cda63b7@foss.st.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <34ec91a2-2089-65ba-d5bb-fed03cda63b7@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/8/22 11:18, Valentin CARON wrote:
> Hi Marek,

Hi,

> I've got a patch in the same spirit in downstream.
> The test campaign reveals performance issues with this patch.
> 
> In fact, hard IRQ have been introduced in stm32-usart driver to solve 
> performance issues due to short FIFO size (16 bytes).
> 
> We are currently testing another patch, similar as your RFC proposition, 
> for RT context.
> But results are not ready yet. We can wait them before merging this big 
> change into driver ?

Can you post your patch as an RFC so others can test as well ?
