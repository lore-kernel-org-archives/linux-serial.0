Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5172550D8
	for <linux-serial@vger.kernel.org>; Thu, 14 Aug 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206315; cv=none; b=nZCX7Ast4cJBTnHLtGcsOFNOdZH/1Npw66QIxpVF5n/5CN7i60dw7MZv7PmgdHfO9wUTrFQMxpMASRhuErfebGWssfJ7Mbe6JsN4oDDvTq/zFF4UF4+trAeBWe1rOr0hDQ77OJklFWDDzuyWkIOztxtA7jB3DT8aHkzc9edrT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206315; c=relaxed/simple;
	bh=DGT/jWa8qfrlAoBv9pWpgQ5DVzDhdHztGsHRb9C0uD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p32fexP8xUMxz/QAgsJx/A29DyrZhprZrH9OREmLwdK3GFa9vvoWN+Zy4hpete/wV2NwSPoQ8v1OYbFOwkAlqcwBBUYG3+WECA2X7gQj4LAXfVKvyksV2s2lGPDaGRSz1i/NB3M+MSsrJ0M9Z0Fj+jaItsMPN2wWHD790G4Tb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C6kXWl1k; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C6kXWl1k"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109921fe7so14523831cf.0
        for <linux-serial@vger.kernel.org>; Thu, 14 Aug 2025 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755206313; x=1755811113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JAdg0B99nBx176JSa2IHf0Gqum3MIVsaAKCTeNllKPY=;
        b=C6kXWl1k7C/HcqGA+nO/yQH0Rg4c80ZDp4wAoQVv3BcEwfc5l6lvfoDlRQxMZVDUzf
         SSjXRTLlC5goA9748vboFSXfPR0LcXSUHIY0MdSW/FK3yYkeOSs0BQcPXwZvZZrAeYuu
         4+OHdQn+YYLq6kHBiyqc9ZqGY7c/Wg1Rx+7jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206313; x=1755811113;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAdg0B99nBx176JSa2IHf0Gqum3MIVsaAKCTeNllKPY=;
        b=B8YzkHapBw5hDOlOSv9IOeWLK2FJdiM+Dinw373upaSlJ8GX3DptcnMg8bH8EOFMYq
         D5VON9K5Gu1YHYrz16f3134oAlR/CnGjY/zSZsTdM9umgMviZHSyvhzKKNuXjmnh/mn/
         XHE9rA5Ui2UT5wB4mYT/SaKS5DKKIEch26Opxd7427GdNFW2PvHsDX6QoVpklwhpvmLU
         Pf34XyPK0cvg2AxtoT2Jw/DkflnB9cAKCN1x21t8IUdmVMsWzygVTfspyz09NPcwraoM
         JDsWwSeQ3WnH+/5k8MkCDXMiBEUw4zVlb3WQjsiursq+jCgB9tb9K7giTJVfQKEg60Rb
         3m5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3Qs3mCd2vv8wlVLBnQrur6ISWeQD5miw8bPCqBX3QpsqcqblA8TQGayl1AIgo6UAgZ1STym+p6PGTsxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1H7LCKKZV6rWN4htigKSioGfTxSzMu/BRJ09iRFuwm2YDnEj5
	W+iA5/glnY7BdhRMPZ64UhZIzAh8OqaeS4VmPqUhetHmjlmChbT2L/gLT/kDbYp5dA==
X-Gm-Gg: ASbGncut+xenyTVUjLfF5+DnFtngOtgmdBZGDZ9kQ1YDUkAvnLbui0iiOtF5uNH1BK2
	9IbGJArZNscUNqjeNZW3lBvW6n3WKF0gZqO2qOrWGj1UyqnmdDnaGqU0oAJr8oXIRZrWG6v04YU
	g2Tdr4129t6GwveUEPqiB5BhUE+NMhcNsM53nOK8Mn8YfEjR9o85FNdw+5/Nmp9AZgz2lJBfe45
	RDPKTjcBGWfiXQtZa55flU44JkIoDvck3+T85hxeadcdvaZCDxzNmJNUyPeiCcRbv/FGCL1Yyxh
	Y/Sule/JZDydweAzcaAShlgO8vl3qcT1ey78th3fciY7Sh0tcur86czAjJSALzDemoGIg/uq3Bn
	wCM/vJucvdmXDXHzpwLWujr9e+GI8F5wlvEME+0l4zUuAI/soBng6kp1kqcXH7qwddA==
X-Google-Smtp-Source: AGHT+IEkyDNQAVKyJmRDAdsYevWYyNxbZ/vyLLcRBzDMVeiEDD92XcTmdKvPGNmmapwrDIe+yHQzFQ==
X-Received: by 2002:a05:622a:5b0d:b0:4b0:89c2:68fe with SMTP id d75a77b69052e-4b10c5d9357mr58049511cf.52.1755206312164;
        Thu, 14 Aug 2025 14:18:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11aa1216fsm1550341cf.37.2025.08.14.14.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 14:18:31 -0700 (PDT)
Message-ID: <84811e34-05ca-4988-b5e5-64c31e2733e9@broadcom.com>
Date: Thu, 14 Aug 2025 14:18:29 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250812121630.67072-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20250812121630.67072-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 05:16, Krzysztof Kozlowski wrote:
> Lists should have fixed constraints, because binding must be specific in
> respect to hardware, thus add missing constraints to number of clocks.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 88a499cd70d4 ("dt-bindings: Add support for the Broadcom UART driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
--
Florian
