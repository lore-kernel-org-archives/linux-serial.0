Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2BF1B07D0
	for <linux-serial@vger.kernel.org>; Thu, 26 Sep 2024 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391062; cv=none; b=EIBnJQU+91UsRmzfr7T7XgKvLRjGrbGH8zTIzFWSX08LX2uoExphPgIB6CXA/UwckHOzgGQqDiaOf8c/nHa6R/ZN/uDgQkmysn/qX5HZRM/XVfLIwjG8FO8DmpEgkQbVuG04uQ7/6FZvNSH9qRvWPc453zcllr2uWQhbqdOrgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391062; c=relaxed/simple;
	bh=wM4Em3VEhJtp/Xtz11kJP1Szcv6f2nMy2+C7W0mDoOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmMwp4RhdNAJTHk5vO/fYDE+WXk5V7kXm/rIMbWDLHkH9ys9Vg5qP92BYRbbAjrbK/HII/zMVmeu65EeNlsByBUaC+pEYtxtsAfbUOWc/ZwbB3Hy2miNK8fuLJktg5FSqslUIt1CqdaQ1vcRMW7lC+Xf9dqmTqMVqNlOF09Q5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SexKBv/n; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SexKBv/n"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71798661a52so1204289b3a.0
        for <linux-serial@vger.kernel.org>; Thu, 26 Sep 2024 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727391060; x=1727995860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tZtkH1NS24sPLOlh1XDiIBzgFeoWNq8FUIPBUR+lBZ8=;
        b=SexKBv/nj4ILmDUD1vbx9gDLsKMpjnsOumj7zLZ8nniTEQcnk58pVi2R258+ZY8nH6
         7Z1JnaxYPBcvnGN/Kg1KiZVd++Gf8RGU+l9k9W7CzqQE9G5F9lj/xUR08eSraGOfLtho
         pJ7N0Qq75t0eW7oqt1gXEjpeuO/ZFMc1CULrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727391060; x=1727995860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZtkH1NS24sPLOlh1XDiIBzgFeoWNq8FUIPBUR+lBZ8=;
        b=eGAQEbqlzITtm+mxrI01wA7feqQpFuRSfUnGmghJauqZCPYX61GfeiNknSDhUfHUMU
         CbCAfAFO6iXZ4mF1psEWx+wLN6pF5+DLJRpgKwpXVJtH87sgcB6fwCgp7WgR0NTK+teP
         7S0+KclCnHblnAykKJc8mmZinfJgWspY5ZWQdy7oOFraArcXDEb4TnVRgB/wEPGRrsfF
         ctISItxtamwp6AfOs4phN+hvnIGaTYm79zyHhIM+0cL+g1rSv8uGoizZhPHgMOAhv4R0
         ddYRfL/dOaGuu855vuHsXHJs2fEo4cUhy2csedI9vCObafhXITDBhep837LbOk7JDjxI
         2BxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVU2X7A1pLzhPqiDh6JbL7MG3p1fbOWJaxQhyFP4gP3K0ols4uqAMLfdDHPbSnFoInRx3AeHZsf4Nbp3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMHh++5o5LUeeU95QtD+MD2rVV+rU/OuKOBG0xUqutoU0SC8Z
	f/DRLyg4aElxRo1ENpFzMOcoFMgbsyLQ5H2PVlQpUI2Q0QDItFeqVgJI3dVvDA==
X-Google-Smtp-Source: AGHT+IH/vjkfYVf/N8MGKQtye03lkEIKFc7xzp9osU8CMet+HP+YJiMnMjJend8DrbLfyOCvenmUzw==
X-Received: by 2002:a05:6a00:91a6:b0:718:dda3:d7fe with SMTP id d2e1a72fcca58-71b193ee37dmr6637622b3a.12.1727391059968;
        Thu, 26 Sep 2024 15:50:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515ef9sm403643b3a.134.2024.09.26.15.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 15:50:59 -0700 (PDT)
Message-ID: <543df2e3-dcb4-4a5d-b781-e2b39d62715a@broadcom.com>
Date: Thu, 26 Sep 2024 15:50:57 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
To: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc: Jim Quinlan <james.quinlan@broadcom.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
References: <20240906225435.707837-1-florian.fainelli@broadcom.com>
 <051fdbe1-e5d9-4d5d-bc1a-921d8d3d4a9e@kernel.org>
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
In-Reply-To: <051fdbe1-e5d9-4d5d-bc1a-921d8d3d4a9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 02:44, Jiri Slaby wrote:
> On 07. 09. 24, 0:54, Florian Fainelli wrote:
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
>> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2 
>> cards")
>> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/tty/serial/rp2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
>> index 4132fcff7d4e..8bab2aedc499 100644
>> --- a/drivers/tty/serial/rp2.c
>> +++ b/drivers/tty/serial/rp2.c
>> @@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, 
>> unsigned int asic_id)
>>       u32 clk_cfg;
>>       writew(1, base + RP2_GLOBAL_CMD);
>> -    readw(base + RP2_GLOBAL_CMD);
>>       msleep(100);
>> +    readw(base + RP2_GLOBAL_CMD);
> 
> The read was there to force PCI posting to really flush the write to the 
> device before the sleep (and not to post). How is this ensured now? (In 
> fact, instead of the move, you could have deleted it completely.)
> 
> Can you actually read another register which a resetting device would 
> reply?

Sure I can do that, give me a couple more days to get back to you.
-- 
Florian
