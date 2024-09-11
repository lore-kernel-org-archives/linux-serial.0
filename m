Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AF273FC
	for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092080; cv=none; b=Dn3OgdsLZVqJEGeG0jba8aSaRJYD2mQSCoXyrkj+Len0xA8sc0MNtjwVDsx1aphBEXS72qtk0Sse0GcrqaHGrQ8guW/V2XU9fNUiBeOdDghcQ/aNOSGH3nFTMpZMsE1Ye8iu3kIL+hdLUeSRHLd7BYHuYXjz3JIh5PQHf94Ld2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092080; c=relaxed/simple;
	bh=WHWAxhL/sOi76XZ+st7kSN1TPk8HaONO076qZDSjwi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzGlvJjulLaxp/ScXgDLl0eBIu3VFERK4UQzrcQO5xNukaV7FTXmnhTz7I1lj0WtgvSiYd7P5KqygwgLxeXkJdbDWhFajD3ZFSLHRY/J+lrV488kssMcd0qyU0JzMCdoRad4Km9AxSJdA/LcrTKuawDiao+o43UEj+yV69+mYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CypJFGqa; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CypJFGqa"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-710f388621fso140931a34.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726092076; x=1726696876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wpTO1ZtWohsTUam39DUlK/kEZKoTBomHvwfluVfCVWE=;
        b=CypJFGqa8ULqjF2FVgqcabPPi4E6PO4Sp3VODwFkFgotKLt442ytbkWkfCxAI/VdIm
         aaWPTi4otuSszGExuKl4/sD/gQfFGYiVVIuyuirJHCo2C7PkisZk2sd6rjpIYLfdLocf
         7saBlwN99wLbTanTSyTzh4vo652PJqTIBKBcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726092076; x=1726696876;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpTO1ZtWohsTUam39DUlK/kEZKoTBomHvwfluVfCVWE=;
        b=NOOKHaL2+No226dUsP702hbRRnQl1huNc9l6ECZA+ECJMiLwoj9CAj+7GOjZzn+3c/
         QhKQRpG6I35Xg9uqTQeegZof1iJpTXZdGtolx5NMmEsQIgCwQLTqPHMG2fXT1M1qes4O
         clktkIw2xu5tmaDdnGvytWANMFd3k4twfD4T15qZvM2Uf9mPys6VSccpd3LFbw2Yhrd8
         zsLZimiPQyPIbv5qWGX/sFG+SUcTFMxdRNhHKpcbaSSttN9kC5Ixyj8qnKDtfjFpphJM
         DftBsrwsiT1stNNlAttohoqZBpg2wLUt0naNWaWR3cpXi/IYDjexFrl2Hdus7TeWkvvz
         rppg==
X-Gm-Message-State: AOJu0YzIsYWAMX/yRG7aDUPvl8OZ1CIC3M1Js7aoyJlO4sgJLexJiJsj
	vJCr4R/zztlWuVTIFA0umv7IuAtlHe1KUS9/9UhgppiwPB7UJueoB7AsfkFOAg==
X-Google-Smtp-Source: AGHT+IGcq0VLXlxF61pCe/n1Slm7dUYAjtelbS+SsQ2Mv7wAQkXWRDY1eZrlYz7NXhQ5SOoB6bkZ5g==
X-Received: by 2002:a05:6830:280d:b0:710:eb9a:f8e3 with SMTP id 46e09a7af769-7110950299dmr972474a34.5.1726092076456;
        Wed, 11 Sep 2024 15:01:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53477c9c2sm46777986d6.130.2024.09.11.15.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 15:01:15 -0700 (PDT)
Message-ID: <2bb3a405-cb6b-4033-99f4-ecd25ffc095d@broadcom.com>
Date: Wed, 11 Sep 2024 15:01:13 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-serial@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
References: <20240906225435.707837-1-florian.fainelli@broadcom.com>
 <CA+-6iNxYwyfATMUq+nJfH_a08tdx_HT3k_d0fNS8f8-khghTfQ@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <CA+-6iNxYwyfATMUq+nJfH_a08tdx_HT3k_d0fNS8f8-khghTfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/24 14:47, Jim Quinlan wrote:
> On Fri, Sep 6, 2024 at 6:54 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> The write to RP2_GLOBAL_CMD followed by an immediate read of
>> RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the write,
>> however by then the device is already in reset and cannot respond to a
>> memory cycle access.
>>
>> On platforms such as the Raspberry Pi 4 and others using the
>> pcie-brcmstb.c driver, any memory access to a device that cannot respond
>> is met with a fatal system error, rather than being substituted with all
>> 1s as is usually the case on PC platforms.
>>
>> Swapping the delay and the read ensures that the device has finished
>> resetting before we attempt to read from it.
>>
>> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2 cards")
>> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/tty/serial/rp2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
>> index 4132fcff7d4e..8bab2aedc499 100644
>> --- a/drivers/tty/serial/rp2.c
>> +++ b/drivers/tty/serial/rp2.c
>> @@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
>>          u32 clk_cfg;
>>
>>          writew(1, base + RP2_GLOBAL_CMD);
>> -       readw(base + RP2_GLOBAL_CMD);
>>          msleep(100);
>> +       readw(base + RP2_GLOBAL_CMD);
> 
> Since the assumed purpose of the readw() was to flush the writew(),
> would it make sense to add a barrier after the writew()?

AFAICT there is one which is implied within the name, as it is not a 
_relaxed() variant. Did you mean a different sort of barrier to be used?
-- 
Florian

