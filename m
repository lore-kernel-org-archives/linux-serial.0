Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0D1917E6;
	Wed,  7 Aug 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019021; cv=none; b=bRmYlpacODmTd4lRyTtVV1/8+WE2L9uh/Ttb1MvODuiYDFG8OlCyFgXOQBF4qAUIPLsgDbf1h6JPMyENZG8AzNy4LKTf7UPOoGjo7VBOg8M0fOSkQYI6gn1LxPKv6tQKpz+FkcgkE+tWZKmdD7+6PL0ixHJuG5Sw0tjVmOZAGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019021; c=relaxed/simple;
	bh=cfIpmgiI5x0yn2PAOj2m02+n6eZ7sC+4EZ8CMsWZ2c8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=avmAby3Vrfl4Vy9GPFRz76cRMcnzl7FF091/4O98lWFVG3Jphkh2L0o+v9c0UgmQKFIkVwXd/GLVinZMNg3NTf8tdWqVC0LTWcdBHoSK2PRN+ga9bSBt+UNIMAwbXmCw2emJcq0hk3e9LcwISLOCb7syu7Dr3+wmRaVwB7KrA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8Bx35sJL7NmwyYKAA--.5466S3;
	Wed, 07 Aug 2024 16:23:37 +0800 (CST)
Received: from [10.20.4.132] (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMDx_2cIL7NmJrUHAA--.10741S2;
	Wed, 07 Aug 2024 16:23:36 +0800 (CST)
Message-ID: <fe8c919a-766b-4eb7-853c-19a14341018e@loongson.cn>
Date: Wed, 7 Aug 2024 16:23:36 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?6YOR6LGq5aiB?= <zhenghaowei@loongson.cn>
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: Add Loongson UART controller
To: Krzysztof Kozlowski <krzk@kernel.org>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
 <8aeb4071-3609-4f89-abc7-5b8328dc4290@kernel.org>
Content-Language: en-US
In-Reply-To: <8aeb4071-3609-4f89-abc7-5b8328dc4290@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_2cIL7NmJrUHAA--.10741S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAgECBGayEhgQoAABsq
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gw47AF1rtr1Utw43WrWDKFX_yoWxZFX_GF
	9Fyw4vgr1ktFWrA3Z8XF4kJry3uayj934DuayYyr1Iv3s0vFy5Jry0yryfWF4fJFZ0kF9a
	9rWkWFnYyr43uosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4ZqXDUUUU


在 2024/8/4 16:41, Krzysztof Kozlowski 写道:
> On 04/08/2024 08:38,zhenghaowei@loongson.cn wrote:
>> From: Haowei Zheng<zhenghaowei@loongson.cn>
>>
>> Add Loongson UART controller binding with DT schema format using
>> json-schema.
>>
> Where is the changelog? Are you sending the same patch again?
>
> Best regards,
> Krzysztof

Sorry, here are the change log from V1 to V2, and I will include the update

in the next patch update.

Changes in V2:

- Correct the schema formatting errors.

- file name changed from 'loongson-uart.yaml' to 'loongson,ls7a-uart.yaml'

- Replace 'loongson,loongson-uart' with 'loongson,ls7a-uart'.


Best regards,

Haowei Zheng

