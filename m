Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121563;
	b=ocZ94/AX3k/qG8xpiyZYlhSOfuUtdFGs/glR8DMp7u8iPbvd8RGAF/CLZQAkBO3hmgHW
	 +jBnPOmaZUiarDuYP52oYDjYYP83bj6B4NGtzXCTS+aKtxemLKsgW5GaWOFgnt+nnuq8l
	 udUEalLhsa7tfQVd2oHgOFyPditpv7eYpGM93+Azr44snAXfKSi+VGhPk/88oSIaJv8JX
	 c1uEX6HfL6YHR31uVZLX2DNAvPCfK0YLMuBNs+3VZ3x80HhfPd+pD1UYJErgBoCuNoO0W
	 ON1mJ2Yjt7cJsb/4yBlLeKfGHwbwg3tGSdpchfM7Ba1tgtHyHkYq88Q9BrzPSyNSHmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121563;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=99IwRrIIEaHMFF+rY4borg3F5L+N9Ajlog9GGweBEts=;
	b=bkurgYCsrWWCda/l1Jeh00xloJ6XNjRiKAzRiGjbraOepfyWXU9C99qfZhQkUOyo5O0D
	 b6JNenSC5CQy0sptDo+mqnJcDaOSxhYfL62IyrK+YY8t6GuUwuSL/U95VpdyB5hfV7IyD
	 OcAZ6wCuvJQvzBRKba+y3/VXClQk0O7p7MI/emE6dyAvL65SMFLARG59D9FJn3lP9FYCF
	 eU9MLELztXctWnUte9S+ckDF9dAHsQH33dzV2E+fMIaukgscuF/7WQuGrW0PsUC1aNE3Q
	 4XFHKQpZjHsCYkz3bTFO9oXRjitVa9wo5O6GS2uOBiUhiwOEfA+uR5Inzb4azu3zSYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VV5EKrin;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD45606A320
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 17:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DD45606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VV5EKrin
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e5fb79ce82so238565ad.0
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 10:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121562; x=1793726362;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=99IwRrIIEaHMFF+rY4borg3F5L+N9Ajlog9GGweBEts=;
        b=fkmpxLiDj6wXmK8vQI6gd34ssHj+/KZQORcKWvjXD9VLN6LXP4nnzVMWljMdcij8zC
         VFrCb93FCz5sHc72oV2iao6vCudvAMFYctUre6dSMCPjpojJSCo64hfoaTyzP+zbRG6j
         UcAvdViEDqNWWbGgXg38iJOoEEDPkbeqd1SG+1d9i18HBpSALoJEymozjHRisZ8WBYOt
         lqFOxeFHYCQ2oII05oomyV04AxQVF5vsRAU3WCzgylxpcGYICooBUEj0Vp235AqzU8B8
         DiFgAU5512+ACZJ4/rloKACJi9dBdaKcCeozpkVOzQqyqJWp2etWi4fV/kw0QlRSlORK
         LR8A==
X-Forwarded-Encrypted: i=1; AKwUvByHGNJngOFZezHH31BY7GAZWQiE+YANrif2PuJIGprRGjzaT+XxhrheUXPvNdE8KfQVjw5oWIJDFBXU8ys=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyBJmy5nkqMd2rZxc2Ut61P+O9i45/d/KRH31svW4hjObdCwpY
	W3QTP2d2p5UxnrcOsCsSCHzVElOkgadX23Y6Vd4CVt+sHvHY7YpJAiXzFXBaTmVCr9IE9eLyEKG
	BvJWibVLqNLT4Htv9DnzlObogFkB8wAnP/Golif7ECK7AnlhSQ5RxzC4rwJNOpeACMAOJmn/R5f
	Xp25DYfoFPny6gorX5Z2IMR63JHAFxAHa/4LDNiOnVny4Iuqrnkp77YggEv5tlRghMxAhktiJSp
	aPXO8KXIodIRls2gxaWOSU5d24=
X-Gm-Gg: AYBFou3OKsl+av5g70p6esMl4JzgULmzQ3Zwd9iAIu5THvJgqbgz1T/gL2aUtFR4D6R
	7L4cEBKMuJwa08utUxdGPj4tYPDK06BIUUnKcxjIY0ljIQ04QPUGs5wNjN6MP07mSGbE2TCz+vR
	sUCPB7fgqlAlMnBMBFh+y6q4FgklLQpS5e89MCySvCPLd6oKVNxBhxLhOp/sC5QTSkdrH3ushM0
	LHFMBgL9Kya1A4TL/3S1DT042/UEGbA6ZYcZpGneJXqazX0sFo/mkQhwWhiRz9Ut6Apv4fKbGQB
	dLE6v64xTNkMhuWD5nogT/aW8RXJ9qaRGgKYb4QRKgaDLSI1t+OB74eshzNWfpPTJkMXVqeZqMm
	rHuw/2VwxeP6oQT3GXtQPFbVAHa1Kcu1urpqY3D9z070m/xIS+PytQPl+b12d361Qi1BtwANyG5
	R/7MmTz68MwaU8qLXW2DV5FnQAB7wqiVMfBbHtdpZI
X-Received: by 2002:a17:903:2983:b0:2dd:2b8:7198 with SMTP id d9443c01a7336-2eb0005e7camr659565ad.6.1793121562298;
        Tue, 27 Oct 2026 10:19:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eae6c058efsm622895ad.37.2026.10.27.10.19.20
        for <linux-serial@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:19:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e49a1d3b1so17870185a.2
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793121560; x=1793726360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99IwRrIIEaHMFF+rY4borg3F5L+N9Ajlog9GGweBEts=;
        b=VV5EKrinqzJ/tw/mRSXgjW5pZV53LXpbfhxah4MS24ZMalhLUBJAHGOQiHm2VL+8nj
         6gcyhq3r9Xl4RsZ3VsY8HsUG/o+NthL83XOe9PsDVR+RfnlAdrs0YunP+XP8+9kCfiLo
         aiv9EV+XW8YZE+zliHb2tx5kzXgPyT/qGg7+I=
X-Forwarded-Encrypted: i=1; AKwUvBy3EecuWEmAtiSc9C2FDnnO4xyVHWV4G0jC2qZflZaIiY64ETkZqnZBoE7Kcl2GWgR5wSP/kMtzAml94eg=@vger.kernel.org
X-Received: by 2002:a05:620a:4155:b0:93f:3391:d5a1 with SMTP id af79cd13be357-940ef947dd9mr1698503685a.75.1793121559818;
        Tue, 27 Oct 2026 10:19:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4155:b0:93f:3391:d5a1 with SMTP id af79cd13be357-940ef947dd9mr1698495885a.75.1793121559363;
        Tue, 27 Oct 2026 10:19:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a982d6sm1012057185a.43.2026.10.27.10.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:19:18 -0700 (PDT)
Message-ID: <8ef10868-b203-4846-bc47-2d046805e1d3@broadcom.com>
Date: Tue, 27 Oct 2026 10:19:13 -0700
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] serial: 8250: 8250_bcm7271: fix DMA address
 truncation to 32 bits
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Robert Baldyga
 <r.baldyga@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>,
 Kukjin Kim <kgene.kim@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable <stable@kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
 <auC-_1Er0Kp-Wq76@ashevche-desk.local>
 <993d16f4-c8e6-4896-adf4-f7f36d937152@broadcom.com>
 <auDb57N7KCqaTWW0@ashevche-desk.local>
Content-Language: en-US, fr-FR
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
In-Reply-To: <auDb57N7KCqaTWW0@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/27/26 10:14, Andy Shevchenko wrote:
> On Tue, Oct 27, 2026 at 09:41:17AM -0700, Florian Fainelli wrote:
>> On 10/27/26 08:10, Andy Shevchenko wrote:
>>> On Tue, Oct 27, 2026 at 12:06:35PM +0100, Greg Kroah-Hartman wrote:
>>>>
>>>> The local variable daddr is declared as u32 but assigned from dma_addr_t
>>>> fields (priv->rx_addr and priv->tx_addr), which are 64-bit on ARM64.
>>>> This silently truncates the upper 32 bits, causing upper_32_bits(daddr)
>>>> to always produce zero when programming the UART DMA descriptor high
>>>> address registers.  Change the type to dma_addr_t to preserve the full
>>>> DMA address.
>>>
>>> Since this value goes to HW, it should be u64. Even on 32-bit machines there
>>> are possibilities to cover a bigger address space / DMA space.
>>
>> That is one way to go about it, but since the size of dma_addr_t follows
>> ARCH_DMA_ADDR_T_64BIT, we could also take this patch, and also make the
>> upper 32-bits programming conditional upon CONFIG_ARCH_DMA_ADDR_T_64BIT.
> 
> You never know this. The use of u64 is simple as that: it goes to HW as 64-bit
> value no matter what. Note, in the past we used to have a problematic use of
> dma_addr_t exactly due to its dependency on the data bus size when programming
> HW, and hence, based on my experience, I hardly recommend not to use dma_addr_t
> in this case, use plain fixed u64.

It's not a hot path where optimizing for bus transactions would make 
sense, so I guess it's fine to use u64 and have the two halves 
programmed accordingly.
--
Florian
