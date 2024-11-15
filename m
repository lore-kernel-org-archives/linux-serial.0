Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7211DFFD;
	Fri, 15 Nov 2024 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657991; cv=none; b=qXT9y4JUH8fXKzKuHEJj7sAUWENWoKgXtuSNkkKUIH4luFYkC+KA3mBXNtAKRkRV8X4s5EXRoN4iKKrHMqpQJB6lMaCxhAftYWkkX4vpTXMHsbgbYA2gYb4lIb1GnoePo2uEF4lXYnmL/Os2F9ASptHyeNERwciAa/Ix/5NjGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657991; c=relaxed/simple;
	bh=wTqrSMid13G+0klYJYbhdPy5F5lLjNiY0gORfror8jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYjHSA3hkDdh2m9T//4wpEHWj2wZijX2IZFKyJCH8Lpbn3VSEaa618WAhXbinjcNQQVXDIatLpaDtHlUedEfEgf8Q9YmAq5l9ajXqQCruzRgtiLgfWjc8NtfbeIpY+BzIOwl1EuBb7ehnudZ3bsQQlNOrKMqOcXsk6z887jx7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=efqYc8gL; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="efqYc8gL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731657978; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4JGE2MRK2jGTuCAstiyOZdisKvWJk80qjRoK8h7z0Pw=;
	b=efqYc8gLDqeyz1yt29amFSbJCNaLgyro+N9d1iY7KiyV5OzsobpzKhtY3K907voMS/yqN4VGWP/f+cf7kArZkEhWeXagTRI19PLXYcgMl1jCn26UtAy6IarFIspCCwki+tWoCffJ4uP5Qu8huu8zgoCQRPDvELHDyXy/imXQIYA=
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJSyP5f_1731657976 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 16:06:17 +0800
Message-ID: <0f56de2a-49f9-4a13-86fa-e6a7fb3e79b7@linux.alibaba.com>
Date: Fri, 15 Nov 2024 16:06:15 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: sprd: Add support for sc9632
To: wenhua lin <wenhua.lin1994@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Cixi Geng <cixi.geng@linux.dev>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
 Zhaochen Su <Zhaochen.Su@unisoc.com>, Zhirong Qiu <Zhirong.Qiu@unisoc.com>
References: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
 <20241113110516.2166328-2-Wenhua.Lin@unisoc.com>
 <3f89369f-7c0a-47c3-a22a-a125847edb98@linux.alibaba.com>
 <CAB9BWhdi2Q3gViCPjYAUYeYktBKR_rc4DN5PqXKvAvA44LDd9g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAB9BWhdi2Q3gViCPjYAUYeYktBKR_rc4DN5PqXKvAvA44LDd9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/15 15:46, wenhua lin wrote:
> On Fri, Nov 15, 2024 at 1:47 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/11/13 19:05, Wenhua Lin wrote:
>>> Due to the platform's new project uart ip upgrade,
>>> the new project's timeout interrupt needs to use bit17
>>> while other projects' timeout interrupt needs to use
>>> bit13, using private data to adapt and be compatible
>>> with all projects.
>>>
>>> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>>> ---
>>>    drivers/tty/serial/sprd_serial.c | 41 ++++++++++++++++++++++++++++----
>>>    1 file changed, 36 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
>>> index 3fc54cc02a1f..882580c3cf37 100644
>>> --- a/drivers/tty/serial/sprd_serial.c
>>> +++ b/drivers/tty/serial/sprd_serial.c
>>> @@ -53,10 +53,12 @@
>>>    #define SPRD_IEN_TX_EMPTY   BIT(1)
>>>    #define SPRD_IEN_BREAK_DETECT       BIT(7)
>>>    #define SPRD_IEN_TIMEOUT    BIT(13)
>>> +#define SPRD_IEN_DATA_TIMEOUT        BIT(17)
>>
>> I don't know the meaning of 'DATA' in the new macro name. But I have no
>> better name now:) Otherwise look good to me.
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Hi baolin:
>    TIMEOUT means only timeout, DATA_TIMEOUT means timeout and fifo is not empty.
>    Therefore, the macro name is distinguished by adding DATA.

Good. These information should be added into commit message.
