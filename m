Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD3C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 23 May 2022 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiEWNZM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 May 2022 09:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiEWNZK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 May 2022 09:25:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E56C00;
        Mon, 23 May 2022 06:25:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6C1771F4332B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653312309;
        bh=nLAJ424Uh7yMOyPhA731RzWvn1haYM2Coj+CudAs2+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ELuPVjRgeU7fvOefU/93dWvHT9RvQXDhlfrvyvSOBx7OCnrs9Qw38ANsJw4WFy7gQ
         vP/NVcbI3bieA25MAsuxB8XnLIV2NpX8ZHW6JuaxybYTLUI7UOKms82XLOHV7g82G4
         EkMVZbBoYLYTEPQZ5CQVHWSQb/WooQ/t0befGVCpE/HWKYlbHoROZrKmQXmKNNEMH6
         e6zgrWDnd0vGzdrCD1V74GrwI3Uk7yw/zBgWDLLYSxG4VIR7q/ZAGMNbUvVd/3BBqE
         E1D3lUfjas7PPKQ6uFQsBBPtD0YnUlIws+FJKwLZkTWXJ0maFBN+RhIsH73CxHVXXp
         m3g4U2FcNLXNA==
Message-ID: <8a027bdc-0fc3-a41e-4142-0033706d3da6@collabora.com>
Date:   Mon, 23 May 2022 15:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right
 FEATURE_SEL"
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, jirislaby@kernel.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
References: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
 <YnpeYGbo7JJK0lDk@sirena.org.uk>
 <b13b019f-f766-60df-3764-d375f64ea7d3@collabora.com>
 <YnphFjs4E4EYafT4@sirena.org.uk>
 <63169e65-cbfa-d495-754f-023dc8befa42@collabora.com>
 <d91977d2-ebc6-de6e-5eeb-61c25ba0cc64@collabora.com>
 <Yot5uls/3vLzZu7I@kroah.com>
 <da1e4b31-de71-1fda-eff7-2e70fe1331ac@collabora.com>
 <Yot+xTBus04O9TUu@kroah.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Yot+xTBus04O9TUu@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Il 23/05/22 14:32, Greg KH ha scritto:
> On Mon, May 23, 2022 at 02:13:35PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 23/05/22 14:10, Greg KH ha scritto:
>>> On Mon, May 23, 2022 at 12:17:06PM +0200, AngeloGioacchino Del Regno wrote:
>>>> Il 10/05/22 17:29, AngeloGioacchino Del Regno ha scritto:
>>>>> Il 10/05/22 14:56, Mark Brown ha scritto:
>>>>>> On Tue, May 10, 2022 at 02:46:28PM +0200, AngeloGioacchino Del Regno wrote:
>>>>>>
>>>>>>> Sorry for missing this tag, and also I'm sorry for the noise.
>>>>>>
>>>>>> Hey, if nobody broke anything all this testing stuff wouldn't be worth
>>>>>> it!
>>>>>
>>>>>
>>>>> Haha! That's true :-)
>>>>>
>>>>> Thank you!
>>>>
>>>>
>>>> Hello Mark, Greg
>>>>
>>>> I've just noticed that v5.18 was released, but without this revert.
>>>
>>> What is "this revert"?
>>>
>>
>> "this revert" == "this commit", reverting
>>
>> 6f81fdded0d0 ("serial: 8250_mtk: Make sure to select the right FEATURE_SEL")
>>
>>>> Can you schedule this for backport on v5.18?
>>>
>>> I need more context here, sorry.
>>>
>>
>> As stated in the commit description, some MediaTek SoCs are incompatible with
>> this change, hence it's actually breaking late serial for some machines.
> 
> Did I already apply this change to my tree?

Yes you have applied it to tty-next.

 >
>  If so, once it hits Linus's
> tree we can backport it to 5.18.1.
> 

Okay, sounds good, thank you!

Regards,
Angelo


