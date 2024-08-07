Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3EE1917E6;
	Wed,  7 Aug 2024 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019011; cv=none; b=Ytgj0IzZtUr/2+ddfGsasVL2XxpV+DJFf/xP5dUlg7lKGDvg8LhNnrtRXjm8GxB246F7+6hmlZ94SynXoDz1mfjuHJPoSPjkpqRZweYpoDPFNj4x2YzJ69fXGiqoS6G+AJO4LSoDlmFvi5hA0BYL1yGl+9NJQACo1zq0fy3QcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019011; c=relaxed/simple;
	bh=bVpeD1TPk0eLXfpcVNkzHFDlsmDXfNiXac3DR+ChgkU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UCY1qDctRbxnveADFyOF5GRGTzJeLBVnyEV96akkLG/QKTcFsE9qdmNMtLKpiTMpC6pxGNqZm0r9mpn22YN4K2Q3xUmnaqYs8CpCwc9yj3GUrk/HavfSzD/P8OzbBj8xIP9JNR2FYyE7scyGhVpsXKzkc9GdNDw7+EziPRW5JP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8Dxi+r_LrNmoyYKAA--.32028S3;
	Wed, 07 Aug 2024 16:23:27 +0800 (CST)
Received: from [10.20.4.132] (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMBxsuH+LrNmGrUHAA--.10863S2;
	Wed, 07 Aug 2024 16:23:26 +0800 (CST)
Message-ID: <3b4f94d4-51f6-45ad-be22-52be0f5e39d6@loongson.cn>
Date: Wed, 7 Aug 2024 16:23:26 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?6YOR6LGq5aiB?= <zhenghaowei@loongson.cn>
Subject: Re: [PATCH v2 3/3] LoongArch: dts: Update UART driver to
 Loongson-2K0500, Loongson-2K1000 and Loongson-2K2000.
To: Krzysztof Kozlowski <krzk@kernel.org>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
 <20240804063834.70022-3-zhenghaowei@loongson.cn>
 <bf6fbb80-95f5-4c9c-b7d4-dd7f432056c7@kernel.org>
Content-Language: en-US
In-Reply-To: <bf6fbb80-95f5-4c9c-b7d4-dd7f432056c7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxsuH+LrNmGrUHAA--.10863S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAQECBGayEXMQJQABsE
X-Coremail-Antispam: 1Uk129KBj9xXoWrWF17tF4xXF13Zr18Ww1rAFc_yoWxGFg_XF
	9Fyws293WkJrWrWwnIqFnrZr1avw1UXwnrCrs5Kr17Zw1UKFW5CFyDAryrGrW3uFWDKryr
	Gr4kWF18AF43ZosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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


在 2024/8/4 16:40, Krzysztof Kozlowski 写道:
> On 04/08/2024 08:38,zhenghaowei@loongson.cn wrote:
>> From: Haowei Zheng<zhenghaowei@loongson.cn>
>>
>> Change to use the Loongson UART driver by default.
>>
>> Signed-off-by: Haowei Zheng<zhenghaowei@loongson.cn>
> No changelog? Nothing improved?
>
> Best regards,
> Krzysztof

Sorry , I will include the update from V1 to V2 in the next patch update.

Here is the content of the update from V1 to V2:

Changes in V2:

- The compatible property for the UART is changed from "ns16650,loongson"

    to "loongson,ls7a-uart".


Best regards,

Haowei Zheng

