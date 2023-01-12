Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08675C54EBE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Jan 2023 18:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbjALSTO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Jan 2023 13:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbjALSSj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:39 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA42ACB
        for <linux-serial@vger.kernel.org>; Thu, 12 Jan 2023 09:50:38 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4A53E854CD;
        Thu, 12 Jan 2023 18:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1673545836;
        bh=qu2W7NqtJUjgvf7eHxl057a2RpoLqvtPlVzDvOVesMw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HFsmpbCVzQRhSkAekS3F0KSi/s7ZdbE3FEy4G6JXicAJd/qxLRFY4C6fhwm/3yin5
         Xkoxcv6PNjVgeyzZySaykIdu6TLeHjyyA4EJAe+ehyRhe+E2uRX0xUqCKyVkV8gjTH
         sVF/Q8H+oFIeRc4iTCOJbXiFmyKKOObr0Ejm7iku2obs3kX9lTTSwbZRqhlE9o9trt
         1xC6o5n9j9tqoKTiDCnUFqMUpX88Gf4CytFAEA5vRL+LSjdghIrMXzzaXyEx0+ueky
         cvSNAGz8oCumnF3LH/gcQyWw/UUN1coQ0bI6SPwg8LEKsiH7z0UAIjaXsu1xfAnk7Y
         TSocy/SkKFJ7Q==
Message-ID: <c2f69d59-7c10-53a2-44d3-e3d274da0892@denx.de>
Date:   Thu, 12 Jan 2023 18:50:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221216115338.7150-1-marex@denx.de>
 <Y6sHr5kuxUoahlzJ@hovoldconsulting.com> <Y7vou3wAeLP4X+TY@linutronix.de>
 <Y8AHaJIttNga68q4@hovoldconsulting.com>
 <78e3f61f-4f87-9ac5-7c7c-172714da69d3@denx.de>
 <Y8A+1wUUNCU+3Kry@hovoldconsulting.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y8A+1wUUNCU+3Kry@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/12/23 18:09, Johan Hovold wrote:
> On Thu, Jan 12, 2023 at 05:38:48PM +0100, Marek Vasut wrote:
>> On 1/12/23 14:13, Johan Hovold wrote:
>    
>>> The author did not seem to think this was stable material as there is no
>>> cc-stable tag and it also seems fairly intrusive.
>>
>> The author does not have enough experience with preempt-rt to make that
>> determination, hence deferred to Sebastian for better judgement.
> 
> Fair enough. And it's not obvious that the stable team should backport
> patches that only concern PREEMPT_RT either (e.g. as parts of it are
> still out-of-tree).
> 
> The stable tag is still missing from the final revision though.

Please pardon my ignorance, which stable tag is missing ?

Can you maybe just comment on the V4 and point this out to me ? I'll 
send a V5 then.

Thanks !
