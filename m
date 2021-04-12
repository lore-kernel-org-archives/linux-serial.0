Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C775C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F926128C
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 13:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhDLNmN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhDLNmM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 09:42:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E2C061574;
        Mon, 12 Apr 2021 06:41:54 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v26so13459489iox.11;
        Mon, 12 Apr 2021 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pv38UteoXPGc9YXROMqdyiZjnIKpHuvd+rCQ+sbZeWw=;
        b=IgnsvOg1yc+DKw8WBbPTuGFqtyCK45AVOGjp7CUdDarvXkIV1poSdV+eQLDgcHxDX8
         Kvz4nv3sE9Z8txCaFm6Ndroo5pPbrpSZsoCqj2eEK9gSs7icFybeHwkXzqyI5Kw9fV+x
         RK4S1ye3TnixqXv22X/w+CYQrVM4THdn1vMNtmM7f+kM57up82nKNlzola6F5LqheT0S
         S1G8hqz0525+dQX7t/7F5/MXkGv97BZHCe0PRHQ64R9yIBNWdxVVS0k+W6yafbdYiDQO
         SHpxtq+Lj3tVf8KW0UK2n/wGNiEj3SltZUBkx5v9nuQCIhU5HNQQa4aIbbH6vu3xEM3z
         OYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pv38UteoXPGc9YXROMqdyiZjnIKpHuvd+rCQ+sbZeWw=;
        b=S9SLGTrR8Q13sUCWYLuccDT35NhmRgX16nD4IGAp96O63Uz/Pt6t6icjKGkkpRu1sF
         An9c+F/dtoQ2DnEdVvVHfBeR8moJalNFItm4FcwyNPQZMdAYoHYbWaI08GcbbhxBR/l3
         F9ssb9bAfFMfUfKllaBHMjkrm5oMG/NSNWyYxK35IyDGsl9xgn/dDUa4DkfzT1hs/YOH
         OMsGWQrf+IJ2KzaK4y92vNVmi/1B3gr+u65Y4p75i5qEoPo4UeNennsge+Y9WyM1YWvJ
         F+Dlw0iwG3KKHecxrkyBwuNXJOClHHt2zarTWBMp0uK4+EqZq5DdaE97Ia+dZwsYU+lH
         idMw==
X-Gm-Message-State: AOAM530jqvrnioVjx/1EdemXeBxA8JIVfERGp3U6xhtCVhVRldS/MxlE
        COqWvz2r0dDTkA3nPNayN8F409bqJVoHN4EAMyM=
X-Google-Smtp-Source: ABdhPJyIRqHuaDnOp8+loeCg8vnJNjHw72xLypbdBBrx8vI6+21/qEwTHah2Nclx/TaTP2h1BcpOzUH+VGmoo5YxRzQ=
X-Received: by 2002:a02:818b:: with SMTP id n11mr4899093jag.62.1618234913716;
 Mon, 12 Apr 2021 06:41:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:8a0e:0:0:0:0:0 with HTTP; Mon, 12 Apr 2021 06:41:53
 -0700 (PDT)
In-Reply-To: <f3985d70-4f00-7442-de4e-e382b19e3e50@foss.st.com>
References: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com>
 <YHPgGI6EmTzmVH7g@kroah.com> <CAL9mu0Lt-3_O7V5HLxd5Hbt9afx9ryBUzWqmsc+2n3SP7JS6ig@mail.gmail.com>
 <YHQEA9jn5uXQCtrN@kroah.com> <CAL9mu0+hi5eYEder1Mj2yjUN+eicJ9qG8Kr4GTC2mqfY405Jkg@mail.gmail.com>
 <f3985d70-4f00-7442-de4e-e382b19e3e50@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 12 Apr 2021 21:41:53 +0800
Message-ID: <CAL9mu0LnxD69Y2F_TK_b+N5QhMS6bjz6YU-zJdscY75S3jj8qQ@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH] serial: stm32: optimize spin lock usage
To:     Erwan LE RAY <erwan.leray@foss.st.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        jirislaby@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 4/12/21, Erwan LE RAY <erwan.leray@foss.st.com> wrote:
> Hi Dillon,
>
> Thanks for your patch.
>
> Could you please elaborate the use case in your commit message ?

Sorry, local_irq_save() plus spin_lock() same to spin_lock_irqsave()
There is no deadlock . Please ignore this patch.

Thanks

Dillon
>
> Best Regards, Erwan.
>
> On 4/12/21 10:54 AM, dillon min wrote:
>> Hi Greg,
>>
>> On Mon, Apr 12, 2021 at 4:25 PM Greg KH <gregkh@linuxfoundation.org>
>> wrote:
>>>
>>> On Mon, Apr 12, 2021 at 02:50:20PM +0800, dillon min wrote:
>>>> Hi Greg=EF=BC=8C
>>>>
>>>> Thanks for the quick response, please ignore the last private mail.
>>>>
>>>> On Mon, Apr 12, 2021 at 1:52 PM Greg KH <gregkh@linuxfoundation.org>
>>>> wrote:
>>>>>
>>>>> On Mon, Apr 12, 2021 at 12:34:21PM +0800, dillon.minfei@gmail.com
>>>>> wrote:
>>>>>> From: dillon min <dillon.minfei@gmail.com>
>>>>>>
>>>>>> To avoid potential deadlock in spin_lock usage, change to use
>>>>>> spin_lock_irqsave(), spin_unlock_irqrestore() in process(thread_fn)
>>>>>> context.
>>>>>> spin_lock(), spin_unlock() under handler context.
>>>>>>
>>>>>> remove unused local_irq_save/restore call.
>>>>>>
>>>>>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
>>>>>> ---
>>>>>> Was verified on stm32f469-disco board. need more test on stm32mp
>>>>>> platform.
>>>>>>
>>>>>>   drivers/tty/serial/stm32-usart.c | 27 +++++++++++++++++----------
>>>>>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/stm32-usart.c
>>>>>> b/drivers/tty/serial/stm32-usart.c
>>>>>> index b3675cf25a69..c4c859b34367 100644
>>>>>> --- a/drivers/tty/serial/stm32-usart.c
>>>>>> +++ b/drivers/tty/serial/stm32-usart.c
>>>>>> @@ -214,7 +214,7 @@ static void stm32_usart_receive_chars(struct
>>>>>> uart_port *port, bool threaded)
>>>>>>        struct tty_port *tport =3D &port->state->port;
>>>>>>        struct stm32_port *stm32_port =3D to_stm32_port(port);
>>>>>>        const struct stm32_usart_offsets *ofs =3D
>>>>>> &stm32_port->info->ofs;
>>>>>> -     unsigned long c;
>>>>>> +     unsigned long c, flags;
>>>>>>        u32 sr;
>>>>>>        char flag;
>>>>>>
>>>>>> @@ -276,9 +276,17 @@ static void stm32_usart_receive_chars(struct
>>>>>> uart_port *port, bool threaded)
>>>>>>                uart_insert_char(port, sr, USART_SR_ORE, c, flag);
>>>>>>        }
>>>>>>
>>>>>> -     spin_unlock(&port->lock);
>>>>>> +     if (threaded)
>>>>>> +             spin_unlock_irqrestore(&port->lock, flags);
>>>>>> +     else
>>>>>> +             spin_unlock(&port->lock);
>>>>>
>>>>> You shouldn't have to check for this, see the other patches on the
>>>>> list
>>>>> recently that fixed this up to not be an issue for irq handlers.
>>>> Can you help to give more hints, or the commit id of the patch which
>>>> fixed this. thanks.
>>>>
>>>> I'm still confused with this.
>>>>
>>>> The stm32_usart_threaded_interrupt() is a kthread context, once
>>>> port->lock holds by this function, another serial interrupts raised,
>>>> such as USART_SR_TXE,stm32_usart_interrupt() can't get the lock,
>>>> there will be a deadlock. isn't it?
>>>>
>>>>   So, shouldn't I use spin_lock{_irqsave} according to the caller's
>>>> context ?
>>>
>>> Please see 81e2073c175b ("genirq: Disable interrupts for force threaded
>>> handlers") for when threaded irq handlers have irqs disabled, isn't tha=
t
>>> the case you are trying to "protect" from here?
>>>
>>> Why is the "threaded" flag used at all?  The driver should not care.
>>>
>>> Also see 9baedb7baeda ("serial: imx: drop workaround for forced irq
>>> threading") in linux-next for an example of how this was fixed up in a
>>> serial driver.
>>>
>>> does that help?
>>>
>> Yes, it's really helpful. and 81e2073c175b should be highlighted in a
>> doc.
>> In my past knowledge, we should care about hard irq & thread_fn lock
>> conflict.
>> This patch has totally avoided patching code in the separate driver side=
.
>> thanks.
>>
>> I will just keep the changes in stm32_usart_console_write(), remove
>> these code in
>> thread_fn. update version 2 for you.
>>
>> thanks.
>>
>> Dillon,
>>> thanks,
>>>
>>> greg k-h
>> _______________________________________________
>> Linux-stm32 mailing list
>> Linux-stm32@st-md-mailman.stormreply.com
>> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
>>
>
