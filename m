Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119294;
	b=2SMNUZQTfuqSQKD5mtXZ8unuzchDmhaqwlX+8a1no9YXcU5be7MNsk5uxq15UVI4X3Du
	 iOVnyarO+1TBKYDAEOzG5xtwP4WbKGKXaF/KXk8MzjvTn/WZ52Y18vzz6TPNky+DhBmw0
	 sYdEFs7Z6bGMIXYGhNlfBpzadq2HzJG4T1fAIb0rCkr34wYRGF8Bnmj3tadnsz4tXL+Va
	 93/dHHPtRJkx4hpAskwED35saFZMtDjL+2nu5stYXyg5Q6eA0sKP38W3hWa8WqXX/36Pb
	 CV6bl2NX6m8GKG1gQMg32C7rrGyHbIU5zFRPJg2rDvy+9vZPM1vfHG0YF2GaluupeQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119294;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=9c/sKlfVBvxiup6XUAL14dVdvN30VybMCeHge63rflo=;
	b=0aTfAFbS903RQlDeBodjeKLHFTG4wqXaKpUQLeWOUKkGo4vgRVxR0gAV6KH9HjjtcHnI
	 oH2PlCQJopGs09zWUWA21/u+siHTXtMNB3vyoLB/zfKpdLCwYiwInEBZvDMq8gEUbn+q1
	 Hli+1t7HZEzEFeSBWca6L4Gi5qPzQy4+6fow4wNSZnxwExa29mpfuGV7ZGaYuf5x9ufi0
	 vLGFQ9Q3StDvB+JOR0af7lPtyiaOX/J/TfnPj0nyLor2o2IQNllQI72bBe5YJ4cvYVqZy
	 LKcZXvkLJCn+ngNutxjM1LBmxsnMNwYuSQb9JrcsX6QUrpESJfO3Obe1Nfzm3aaSGIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gqt8l82S;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C54606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 16:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C54606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gqt8l82S
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so61132a91.0
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 09:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119288; x=1793724088;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9c/sKlfVBvxiup6XUAL14dVdvN30VybMCeHge63rflo=;
        b=T955wrmU1z8Ob+58eOimcMlMlsvqkTRctL8Js5u16QUcH8IBMZuKTOCofHPUqj5f9t
         7F5ihVKA61QS/8xoX+asxLcTbChwMU4XWcqbgt9cd3pPWDJgCwfPyVtoYFhq+c/NW44b
         rzIz6ocem66RFeXDlYc03eXwGJSyqPYTpBZ/PotmXB8DDBrOCWOhgEJgQl7OaiYRoRDt
         8NG2swPQSY9Hk4DuyRND/ZDadvUPugP/p1Okcdyx/z+H2EKBgErEWUYo2bEvPIiWsN07
         zCrM7EFgmM13dOv5tpH/FH7M1EtqOvorPQNxUPj568H9JtyVw9rv52PIP+JmOIu3dNVK
         lEew==
X-Forwarded-Encrypted: i=1; AKwUvBxoO7KHQN5GeSk19NWa/7KFcXZNdzaBBaZLVd6B2e836D+nt0DIaarqgfsq9FY76g6H2GFjYQaZfnYOql0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfuKLIWafi1u730rzDnSki4hJSNFrCq04Q8MZJX7BemYPA5kw5
	VBasMQr4MAhlvVjGZpK7AxHkIUaJPJU8o2YvCQ5n2t3CQwlQxgkKbDuBKoiXjylnyxIjiWUZQmH
	Dz4IwA40XjN5b5Xw5rLn9H1yuvXoNY8Aafa6zs3LeoXNyNwkZxGghYiC9JwxDRrvsH8Cfj4fweQ
	MciVViqKKwFPQCBFOdhUdn8tUWuTvpiRj7/vqOeHF0y6t3LEgsjc+Mp0oY9ueDUDDQtibS1Py6d
	epAMWCfQNXen/3Td3m6L/AQgko=
X-Gm-Gg: AYBFou3AD09G8kTp96ZShUwj+sKSRAtAogfolayFR6cIZvJ0/z2Cr2A6Ezxwm1Rz/Hs
	4DD4rOx+4lQfZs2ECbFZns+bbzvm6/jpZhqmJm9c0l0/r93tns+dbiTXgMiWPSsROlYaL12qxZi
	3HqG6L+QlUrNBzueZ5zxvCYL++lDTNDp41WQNKBqYfoXG+nv7BQs1F8v4AJBZSyUASM5ArZbFer
	+ZInxEYsfQjGvYEKa1LI65ChhphD2JCex5UVZbOzlieVUst4wnTlV1tkQjHb+ZGak4jCUFuh1Mw
	T51Uypo6hpfL49lVd4mo/NGziCYut0y3EAPZWcFNf8TeGBiqxSuAZtzuj2iz77MyWxht0Dftx+k
	75ORi9cGxiD7s3I3dPCHnVERlL+qzJ4aCNHDIY+tMugl97LpW9jGrSKpy/odBHvwHzt4mWainOe
	NQ4Heo6ljjIx4enM0RcIV67LmzxRaCkvghU3NGa3FX
X-Received: by 2002:a17:90b:564d:b0:3ad:370f:46be with SMTP id 98e67ed59e1d1-3adeabe0cd8mr9031800a91.36.1793119288258;
        Tue, 27 Oct 2026 09:41:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae405f13ecsm2485611a91.4.2026.10.27.09.41.27
        for <linux-serial@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:41:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5339739b343so2487531cf.2
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793119287; x=1793724087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9c/sKlfVBvxiup6XUAL14dVdvN30VybMCeHge63rflo=;
        b=gqt8l82S2503W5bNwUbFWW/cc7dpvpT7T6Fu/J1YvMhrYTZPx+VNIPLTaGxkA/OmrR
         N5XcazADUm9pHHpFq8L0phSX1NV9UcsfSMSIhkOsHdGRRBCPuSZuZAd0/6SWqwo4bKCk
         oSs+BtZC40NfMT6OfQmh4RtMS07bop4BIngqA=
X-Forwarded-Encrypted: i=1; AKwUvBynE5uXTcNxK+HLOUy/Y5UHipA6N1VOGgCSkQ47i6BVvOGprPlSP6eviiE3RNPt4u0Rj33HheVlnivgjR8=@vger.kernel.org
X-Received: by 2002:a05:622a:5c05:b0:533:7a4c:d8ec with SMTP id d75a77b69052e-5383b54f453mr161685031cf.43.1793119286734;
        Tue, 27 Oct 2026 09:41:26 -0700 (PDT)
X-Received: by 2002:a05:622a:5c05:b0:533:7a4c:d8ec with SMTP id d75a77b69052e-5383b54f453mr161684661cf.43.1793119286272;
        Tue, 27 Oct 2026 09:41:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53838cf2e96sm83296431cf.1.2026.10.27.09.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:41:25 -0700 (PDT)
Message-ID: <993d16f4-c8e6-4896-adf4-f7f36d937152@broadcom.com>
Date: Tue, 27 Oct 2026 09:41:17 -0700
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
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
In-Reply-To: <auC-_1Er0Kp-Wq76@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/27/26 08:10, Andy Shevchenko wrote:
> On Tue, Oct 27, 2026 at 12:06:35PM +0100, Greg Kroah-Hartman wrote:
>>
>> The local variable daddr is declared as u32 but assigned from dma_addr_t
>> fields (priv->rx_addr and priv->tx_addr), which are 64-bit on ARM64.
>> This silently truncates the upper 32 bits, causing upper_32_bits(daddr)
>> to always produce zero when programming the UART DMA descriptor high
>> address registers.  Change the type to dma_addr_t to preserve the full
>> DMA address.
> 
> Since this value goes to HW, it should be u64. Even on 32-bit machines there
> are possibilities to cover a bigger address space / DMA space.

That is one way to go about it, but since the size of dma_addr_t follows 
ARCH_DMA_ADDR_T_64BIT, we could also take this patch, and also make the 
upper 32-bits programming conditional upon CONFIG_ARCH_DMA_ADDR_T_64BIT.
-- 
Florian

