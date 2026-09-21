Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B24D957C
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011850; cv=none; b=Lt+VJ+HEYCJx61gRNKR111Y9NluEORXZibYhs/gbzZrKiv24gqPisf1tdQkvNg5DveOB7vdgHseRri/QsIykodfmXrhYmLO7Abt6kUaSFuA5V5ctT1VjqJ7fCdGG8Ek6gyV738FeB9lTyvTZjvp0fxEndT0x8ltW19NUY7W+0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011850; c=relaxed/simple;
	bh=+5uZ3k0+i0138r6TjbIE8SkNZdIkmusl5Zhh2otCCDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyAF4l+nflUeTQvhE6aFuuIW0ZYvphqjpYvskM9gwKeLtxVwMxzxcf31XXN7bOU8z+Rv2E8P79rps6CifLkIhr6D6/SRdQ1M4t6zxoqoTd7C7BZOmzkEsc9rTv2lbDmyp9tRwYrs2urvuBdz2T1rfKM5AIF0dkVdQovA2hXtNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Iui9m0ea; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Iui9m0ea"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so573802a12.3
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 10:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790011848; x=1790616648;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q1m8FIyre0txQoAK/ZMa3aVTldIqDlQtinxWjfyCf64=;
        b=nHpobadARwavz6B1oEEEOppUHgFdYqOcJLiVdyYb/i9JVrz0t3vv8uUuDZTqdpbnjU
         mstrdMv1bAftYHlF8n7kRRwX3kbGvqiy/LdIS0ZeBmHGd3OqDTbYjF2y2Gjor+p1hrsn
         iDNoJdb/sG0+kAJ5U0Omwg38WuSjvx/hxjsPPDA2jVGARthoe4w1PUcqST7XjBc42K/X
         cr4qzrVr9hPcax4ScaQc8v8j+UgeBzQxTtc3cH0hpeRHJzXrrOzlxwI3nqnbA+dWp+pi
         AAqXvG4EYXCqvpkwcfkyoGuuZEpU1KaUsDQDtwFnI+2hMceMmX4JVu3jVXGT3neMPzUy
         RLuw==
X-Forwarded-Encrypted: i=1; AKwUvBwa/IMVi5KCmVVfUG8TC5WPuXhWOAxSbR/p8RSlce2jFWyU+ytaO+E2mrD0qpOECJbb7cH2X9KavlFHrQc=@vger.kernel.org
X-Gm-Message-State: AFuF++l6k7+Fs/m4pDsgR59o75rZzbpVreOKB00hzzyBf3ykIwXj3Upm
	+TJaArwUVu2KvW3+CHPQN33PNlI3JJAuWSaFF7mXyw+5wnQv3w7z9KN4mEyTNYWPXE1dwBMcfGW
	x61mc2INXlbRVSQLp79ZnQVy+ukI9W2oWYIXrHQIyn4RMPisQRdJCcBoo+rulA5N//kV17R3N7d
	FF7Iu/kUaD/xen+w0ACwK/7S6GriNffApoj5FJL8riEI2PO3ScBpppQvlGQNm2EJZk//YFnyn70
	1klyFmB9xTdGCGQ+L+IWSlk
X-Gm-Gg: AYBFou29bz0ZfIynY1hx34ulDg5aoAqstcSHhes/AyFuRrIEovOnxqZI5qXAGyGw1X5
	HNNxhA4Q6cddDP0mY+sFQTu43Poso5qijzI9g2dPjXaJPma44U60HM7SmvSx1KdIlEaM0OYJjiI
	JksGubk09GWRe87DQtsIDhtuheEgUPGQV7xt83hH4tuTTZdy29FH3M2uPgkbr8SF0clNOxKroO4
	cjTSH0+QQF8ioDEf0QEHuIYKoAxERtvopdG+ia+RD0kmXaA9ZK3ka259WCyd9yXS91Pf85SbWJ1
	LdeSISdTT477Pslm61BsKjf3wRerz8Lk7oW2tgc95TzwmY0c5AgXUt76rDRlD/8cDIXIZFpwaL6
	MhnyffjNgkTrUkhIjDYFS9UX4nL+plveCvKoYn00LA5smpUe6qv4zsZ7wpnI9un2fNq+fVhbJtj
	GVO/HKgpRURttbe2FQ+1VS0WYg8d4S3Obso7Sgj0QJ
X-Received: by 2002:a05:6a20:4328:b0:3dd:7a92:77bf with SMTP id adf61e73a8af0-3dd8c21b6d2mr18364764637.0.1790011847711;
        Mon, 21 Sep 2026 10:30:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc72aea3ca8sm3998488a12.4.2026.09.21.10.30.47
        for <linux-serial@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:30:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a3f673221so538798685a.0
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790011846; x=1790616646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1m8FIyre0txQoAK/ZMa3aVTldIqDlQtinxWjfyCf64=;
        b=Iui9m0eavsuu8yiSHzfMGL1Jzf3vkUOOYzD3eLJyzddldgpcmr5uguUUCQTAEXfzkK
         nJugmgpWtycVtszJGly5Gs4fRTgriaqgu487gZvESKc649d+4Y58KW4MfLB02i2ARY0B
         S6L3HofajyvE2uwT2avFzdiQo9UZKEcElaYMQ=
X-Forwarded-Encrypted: i=1; AKwUvBydcP46GMxgDi6954fyI0EBErVnAu0em9D4oYyL4o8ew0vm/5pmmrD/bzZ9c54MgRG5hsrQSZWK0I15Q34=@vger.kernel.org
X-Received: by 2002:a05:620a:17a6:b0:93b:d7a1:ba12 with SMTP id af79cd13be357-93c15eb8261mr160200385a.61.1790011846468;
        Mon, 21 Sep 2026 10:30:46 -0700 (PDT)
X-Received: by 2002:a05:620a:17a6:b0:93b:d7a1:ba12 with SMTP id af79cd13be357-93c15eb8261mr160193585a.61.1790011845878;
        Mon, 21 Sep 2026 10:30:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93beda72290sm686610385a.8.2026.09.21.10.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:30:44 -0700 (PDT)
Message-ID: <7e2d1041-35ba-4d7d-8702-a13275e1791d@broadcom.com>
Date: Mon, 21 Sep 2026 10:30:31 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_bcm7271: fix use-after-free in
 brcmuart_remove()
To: Fan Wu <fanwu01@zju.edu.cn>, linux-serial@vger.kernel.org
Cc: alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260909084002.686911-1-fanwu01@zju.edu.cn>
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
In-Reply-To: <20260909084002.686911-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/9/26 01:40, Fan Wu wrote:
> brcmuart_handle_irq() starts priv->hrt to work around a receive-timeout
> quirk of the 8250 core when hardware flow control is enabled; the timer
> callback brcmuart_hrtimer_func() dereferences priv.
> 
> brcmuart_remove() cancels the hrtimer before it unregisters the port, so
> a receive-timeout interrupt that arrives in between re-arms the timer.
> After devm frees priv, the callback runs on freed memory.
> 
> Unregister the port before cancelling the hrtimer.
> serial8250_unregister_port() shuts the port down and frees its IRQ, so
> brcmuart_handle_irq() can no longer restart the timer, and the final
> hrtimer_cancel() drains any timer that was armed before or during the
> unregister.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
