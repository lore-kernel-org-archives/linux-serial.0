Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75254C2BA4C
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jan 2022 14:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbiAZO1n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiAZO1l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jan 2022 09:27:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07158C06161C
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 06:27:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l25so26065787wrb.13
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 06:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=I4w02VhkRyFr5VEwZFKIkvdYb4b0zWdMdwb/T2REyN8=;
        b=pAGybiPRoMdEMrdjEKRI1i/ztmFw+waCQJ42jX4l9If4oNp4R6l4byat9mfFYxHGdi
         ycu51NuN9dfI/mrDuEIbVSXcXEt078nm5DAHQl2WHK4F8hmyT6ljnNwJL238w3j39fWo
         1eDAMmrdK2gCm4BAZRRLN4hv9ehcXKSmkqLaZ56ILl0LkA9bYNvVBycOIuSJ9uIaRy84
         Iqxg8TPkr2VxCIYTLO67S/CzcnaOzsHHctRrhPYaWK8akAOylSm+yQAz//RNeV6kPwJP
         V1MEV3qhB0RriYKxVbfIc8qUvgOlYsDGeDD3o2jopDMXiTWW+yROhChPQhBNNnnjA80l
         0Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I4w02VhkRyFr5VEwZFKIkvdYb4b0zWdMdwb/T2REyN8=;
        b=aelPdLBkUc0RmFQWWOYpvGsOXrt3uZ08kPjLOSWDQ8hpJTiDlWqy9Iq3NtAQTAFL5J
         NQnEkJ2DE9hnqtQTlg3Liho4nkbBCsT6Uxf1KqwmDIEhIA8SiQ3IVZxi2+tcnvCk3Srg
         /v01fD41p+nuTouWRI9EQv1Y3FxNlMTdetG675p97OpDGlQkhbQtqbDfXu/lriHNpg1Y
         YA1hZeFqDaPY6Ur0LccYegDwC6GcWB4Vm9ZniS3vUkAzTt5hW0JXAuFvInjKn/Wr6niC
         frzDvFciMZFGHoaDZ2EOLSKTer+FVCwN2q7LQqQEFJ8vep9qlUe195PlfdV4rKwreVJH
         N3Kw==
X-Gm-Message-State: AOAM533PKBg1ac5z8JE/5luShKLJrfCrdqtFdYicxYsdY+KNv/Uyf+Bj
        8lNJ30WiySzuLEf6+q0rYGwJ4g==
X-Google-Smtp-Source: ABdhPJyET15ftrAgRqVFgPecGJQ3iM41mvvWGLE+voB1ETQZnr/rxgcuoJBxYMJ1LDnRTj/qAVkCBg==
X-Received: by 2002:a5d:4251:: with SMTP id s17mr6673727wrr.549.1643207259616;
        Wed, 26 Jan 2022 06:27:39 -0800 (PST)
Received: from [192.168.187.147] ([86.12.200.143])
        by smtp.gmail.com with ESMTPSA id l24sm3141575wme.17.2022.01.26.06.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:27:39 -0800 (PST)
Message-ID: <e646b677-2497-1e6a-b347-8a7e6ada0209@raspberrypi.com>
Date:   Wed, 26 Jan 2022 14:27:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] serial: 8250: Fix ...console_fifo_write on BCM283x
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
References: <20220126141124.4086065-1-phil@raspberrypi.com>
 <YfFY6Rnor85CE9yH@kroah.com>
From:   Phil Elwell <phil@raspberrypi.com>
In-Reply-To: <YfFY6Rnor85CE9yH@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On 26/01/2022 14:21, Greg Kroah-Hartman wrote:
> On Wed, Jan 26, 2022 at 02:11:24PM +0000, Phil Elwell wrote:
>> The mini-UART on BCM283x is doubly crippled - it has 8-byte FIFOs and
>> the THRE bit indicates that the TX FIFO is not-full rather than empty.
>>
>> The optimisation to enable the use of the FIFO assumes that it is safe
>> to write fifosize bytes whenever THRE is set, but the BCM283x quirk
>> (indicated by the presence of UART_CAP_MINI) makes it necessary to
>> check the FIFO state after each byte.
>>
>> See: https://github.com/raspberrypi/linux/issues/4849
>>
>> Fixes: 5021d709b31b ("tty: serial: Use fifo in 8250 console driver")
> 
> I have just reverted this commit, it's broken for many platforms now,
> not just yours.
> 
> So there shouldn't be a need for this change now, right?

This patch is sufficient on the BCM283x family of devices, but a Fix
for a non-existent patch is clearly superfluous. The author of the
original patch can consider this as a hint about the kind of issues that
need to be considered before resubmitting.

Thanks,

Phil
