Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44415CB
	for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2024 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726100354; cv=none; b=t4YocmR3FQR1DPD2g7uA30sLGo314Bnvpl1vGhmNst+YJnx/QH+Y+ctLZgBc6QXyoLKE1SMd0wRcnoSXUEZa9QXXCkkNHJffahI67Mxe/2PsXclKI/lxlhkRbAutdPUYgY295M2/GsTk3ET+8ljQ8XFgi+Y2SyEXo8363K9xjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726100354; c=relaxed/simple;
	bh=ZV7EiUt+oFZWV9GAgXCDECc9OFcGvXiV90IO8l+SI1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s22Ua5Qfdub+KYPq73NRm7UP9eD/jZaNPVCwscKnieDF7NM29OwljbQsOw4iKRMmzON5Il+EA3DN/cwfGS/1FUAp68go/iaeFchUi0ZI45e8DsIPkAnX5K+iL04vqk2+fTKX3xuBrqI416PN7guyz8ILc8kbl/ZJ96r8wCTxwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gRzu1Mh8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gRzu1Mh8"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7191f58054aso301597b3a.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726100352; x=1726705152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hT5rKHWAKJsST0zNJdthdY4KzorwGIDHgWoONGiVWAE=;
        b=gRzu1Mh8EHJGzTCm7qa7cXuG6Xd60EAMYDFg05rgrYHXvTz0YMGHZyjOjMyjQhUE14
         R5DqikbcV7g//8XWFpUg0tjFRPW+YW63bVtKwahrUZC2YKkbykLgdQxrFEo0dfqzicHA
         4UuR+eK45mhAHpO1yVojgv4cg9zguVBxbAuKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726100352; x=1726705152;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT5rKHWAKJsST0zNJdthdY4KzorwGIDHgWoONGiVWAE=;
        b=a3FoUBwrXpjXYVc1JKFB+Dr8bQkN8VCR7FNn8TAwGvXl9VT5L5YZr6I77JhGakuNRh
         iRO0tK4RQa3s/mS2lf9xHAyI1HRvBb9Y+Bb+MEA4wT0/KvZRwYc0ThJM2ejPbd/8DsFH
         bMJ3Ipw4W3iXnEAhB3k7a5hBoXNE36wDF/7G8co8PRz/gSOhSMOLc0WndZ2924kob/mk
         evDR/ZGhfiJ8nqEiynwpqTJk1cVxpV1EWGXO9Hqm8+Of23+4KQfmw1YxNMGouDAKypIT
         DpIFSf8AUBjb02hjpaRHSap3F3bi66b7QiFfwo1sCLoOdopM9OvzTdS3DY+h+bxYlws7
         lo7w==
X-Gm-Message-State: AOJu0YxvL2o/ix8iEd8SnKknlXyKbNm6FwftnIAG65ASwZUDx0WMUmWx
	ZdOCxpLfDWsKBJ+/k3KXxucFSc5o8h6+/LfCpLQFyuwB5S1yj/FY3G+JS5BDywQajEXx4mP8/zx
	JNA==
X-Google-Smtp-Source: AGHT+IEDlAjql4w6kcMMqnDMEb2ESUSgOgqccxHLAcOgtoRwe1nfCwDQ5h4BZa646f6hzxZK8UzBLg==
X-Received: by 2002:a05:6a00:6704:b0:714:3a4b:f78f with SMTP id d2e1a72fcca58-719261e1580mr1131648b3a.20.1726100351396;
        Wed, 11 Sep 2024 17:19:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba421dsm578767a12.5.2024.09.11.17.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 17:19:10 -0700 (PDT)
Message-ID: <fb68e9ab-06b1-43b9-906a-9c1e83bee2c7@broadcom.com>
Date: Wed, 11 Sep 2024 17:19:08 -0700
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
 <2bb3a405-cb6b-4033-99f4-ecd25ffc095d@broadcom.com>
 <CA+-6iNzFb_dn8cv_OkniWPEGZHrwtgwBkuJizn4icy-d9xPKOQ@mail.gmail.com>
 <d4ba49bf-60fa-4c5e-a1a8-52b1668b3d30@broadcom.com>
 <CA+-6iNyS45YOHuVRcnPrMk4NOdrDZLAX=k8NBF_HwA41m4LbvQ@mail.gmail.com>
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
In-Reply-To: <CA+-6iNyS45YOHuVRcnPrMk4NOdrDZLAX=k8NBF_HwA41m4LbvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/24 15:44, Jim Quinlan wrote:
> On Wed, Sep 11, 2024 at 6:19 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 9/11/24 15:16, Jim Quinlan wrote:
>>> On Wed, Sep 11, 2024 at 6:01 PM Florian Fainelli
>>> <florian.fainelli@broadcom.com> wrote:
>>>>
>>>> On 9/11/24 14:47, Jim Quinlan wrote:
>>>>> On Fri, Sep 6, 2024 at 6:54 PM Florian Fainelli
>>>>> <florian.fainelli@broadcom.com> wrote:
>>>>>>
>>>>>> The write to RP2_GLOBAL_CMD followed by an immediate read of
>>>>>> RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the write,
>>>>>> however by then the device is already in reset and cannot respond to a
>>>>>> memory cycle access.
>>>>>>
>>>>>> On platforms such as the Raspberry Pi 4 and others using the
>>>>>> pcie-brcmstb.c driver, any memory access to a device that cannot respond
>>>>>> is met with a fatal system error, rather than being substituted with all
>>>>>> 1s as is usually the case on PC platforms.
>>>>>>
>>>>>> Swapping the delay and the read ensures that the device has finished
>>>>>> resetting before we attempt to read from it.
>>>>>>
>>>>>> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2 cards")
>>>>>> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>>> ---
>>>>>>     drivers/tty/serial/rp2.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
>>>>>> index 4132fcff7d4e..8bab2aedc499 100644
>>>>>> --- a/drivers/tty/serial/rp2.c
>>>>>> +++ b/drivers/tty/serial/rp2.c
>>>>>> @@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
>>>>>>            u32 clk_cfg;
>>>>>>
>>>>>>            writew(1, base + RP2_GLOBAL_CMD);
>>>>>> -       readw(base + RP2_GLOBAL_CMD);
>>>>>>            msleep(100);
>>>>>> +       readw(base + RP2_GLOBAL_CMD);
>>>>>
>>>>> Since the assumed purpose of the readw() was to flush the writew(),
>>>>> would it make sense to add a barrier after the writew()?
>>>>
>>>> AFAICT there is one which is implied within the name, as it is not a
>>>> _relaxed() variant. Did you mean a different sort of barrier to be used?
>>>
>>> Not sure.  The __raw_writew() is followed by __io_aw(), which is a
>>> no-op on arm64.  I don't know arm64 well enough to know if a follow-up
>>> barrier is needed.
>>
>> By definition all of the {read,write}{b,w,l,q} do include an adequate
>> barrier
> I do see this in the kernel, e.g. altera_edac.c, pci-hyperv.c,
> oxu210hp-hcd.c, etc:
> 
>          write[lw](..);
>          wmb();
> 
> All I am saying is that the definition of writew() for arm64 has no
> explicit barrier *after* it makes the __raw_writew() call, since its
> __io_aw() call is a no-op.  I really don't know if this matters, just
> wanted to mention it.

Not having the documentation for this peripheral, not sure TBH.

As far as the drivers you quoted given the __io_bw() does include a 
barrier, it would appear that the barrier after is possibly redundant, 
or is based upon a misunderstanding of which side of the write the 
barrier must be on, or maybe they are actually necessary, but 
undocumented as such..
-- 
Florian
