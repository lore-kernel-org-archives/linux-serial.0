Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16E13D504;
	Mon, 13 Jan 2025 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748641; cv=none; b=cVplY+HUqEUBwi6HRQbZKGzRKXUiH31qKMuNKuV0sLCaX+YAuyf57woSUfUiLSzDxGFGO8YoaGvd4Jw2ZeVu8kBtzQySuPywc+3yg3Nqgli1LEQ9HXggRc+m/EErmWjNIaTPXvAueUDfRrzz4Q/+CSWLBFG0bMtOsQk1erVZ8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748641; c=relaxed/simple;
	bh=OLnS4dY1F262TKpWd9J+Wp5PORcxdAPh0sFUA6uJon4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQLpVRWfz6Gyzt7XFmE8gITx3NxszCsC4UlTOZR2lUQZ92R0/fv+6LyR3aEb3P+5Ya8bgV6Yfs+6bGzbH3mfOokvvUpJxI2aTwJFuY54ehYsQlNoyWfwjyGZp3eJTjK6EthDbfacnc7z0aet3ocjZgGuwS/v326iTe4FRfmbug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IlqVJXcR; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IlqVJXcR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736748630; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EItjLVmJF27mB8Ga2WTnmZ3AKDY+t6Bh09q/7CtH9VE=;
	b=IlqVJXcRRNDnBbbm0bgZ4CK4Rpo6UNJ9XKaAZLllNU5lwcQAMDrpJmZmnONuMXE3WU50ZlZ8Ke2f4BRoYTcHSyRDa0dqE+0mIqrjD3kqvFY+UrpT20ZyCliLglDfI6nZTxDX2OcMmrp9YUxNhRLiEsAEJXN4tjBf3dsgj5acZ2A=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WNTg6HF_1736748308 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jan 2025 14:05:09 +0800
Message-ID: <37702364-4452-4ccf-bbe9-9cbe6d21a57f@linux.alibaba.com>
Date: Mon, 13 Jan 2025 14:05:07 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] serial: sprd: Modification of UNISOC Platform UART
 Driver
To: Wenhua Lin <Wenhua.Lin@unisoc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 wenhua lin <wenhua.lin1994@gmail.com>, Xiongpeng Wu
 <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>,
 Zhirong Qiu <Zhirong.Qiu@unisoc.com>
References: <20250113031917.3354988-1-Wenhua.Lin@unisoc.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250113031917.3354988-1-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/13 11:19, Wenhua Lin wrote:
> In order to be compatible with UNISOC's new UART IP, the UART driver uses
> private data for adaptation. Patch1 adds UART timeout interrupt BIT17, and
> the old project uses BIT13. In order to be compatible with all projects,
> private data is used for adaptation. Patch2 adds a new compatible string.
> 
> Change in V2:
> -Change commit message in PATCH 2/2.

You did NOT change any commit messages compared to V1[1]! Please write 
correct commit messages.

[1] 
https://lore.kernel.org/lkml/20241113110516.2166328-2-Wenhua.Lin@unisoc.com/

> -Add a new items supports sc9832 compatible string in PATCH 2/2.
> 
> Wenhua Lin (2):
>    dt-bindings: serial: Add a new compatible string for UMS9632
>    serial: sprd: Add support for sc9632
> 
>   .../devicetree/bindings/serial/sprd-uart.yaml |  5 +++
>   drivers/tty/serial/sprd_serial.c              | 41 ++++++++++++++++---
>   2 files changed, 41 insertions(+), 5 deletions(-)
> 
