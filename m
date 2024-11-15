Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AD17BB1A;
	Fri, 15 Nov 2024 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649665; cv=none; b=BxGgKrcsybPbZVUD/t0WIQ5jeO4p5lfRINAzs0UBN39Mn0KtW7GrnLbEPOjutbSEudCAwgli60Qv3MjxLvPH3zVTtXS5QX98LPUzGTdKHLmaXTB4yFQ4fY3ohktoAjS4rCxzeM1eO7SVwkmtGuLd7GDQ5oYl2IgdUcyFmb+D39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649665; c=relaxed/simple;
	bh=2D978/Kh0o7jy7TQTaiVDXbS6B7RZq0zRoacBF7TCIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APHyXcaxxqhf6S9uCuUwtFFAz8CxV8lGUQgdAS56B/pOJ4EmAv8kYzKjsSNnWazwgP1PJef6w/Wf5Gby7/l3R87Cv6rPIsTPfOLSHV3No2hvVATGacGZsuvL/BkO9TuM13tAdtEMACSfN+OziSqdx4kR8TB2ItUnGuTgm6zQa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L6jmp3QU; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L6jmp3QU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731649660; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9RSKVoG9dlyN3iKCC7I0h5MQFiQl9bMyOsjyGONj2vw=;
	b=L6jmp3QUDdsSdInN4P6UoJUT2u2BYJezVskTVd9XZtUQ0zLu0ILTLbjVHEazO/M3aBUhOutPvTjuyZDGDys/5Dmwfz3CbA8DuVpCgcxT0Ls6hvx2ITxZ66hqw0856FoBsNFvt2TozugsH9hSAgaMLZ0lvZWzs9vwEl13jxnshV8=
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJRboEN_1731649658 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 13:47:39 +0800
Message-ID: <3f89369f-7c0a-47c3-a22a-a125847edb98@linux.alibaba.com>
Date: Fri, 15 Nov 2024 13:47:37 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: sprd: Add support for sc9632
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
References: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
 <20241113110516.2166328-2-Wenhua.Lin@unisoc.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241113110516.2166328-2-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/13 19:05, Wenhua Lin wrote:
> Due to the platform's new project uart ip upgrade,
> the new project's timeout interrupt needs to use bit17
> while other projects' timeout interrupt needs to use
> bit13, using private data to adapt and be compatible
> with all projects.
> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>   drivers/tty/serial/sprd_serial.c | 41 ++++++++++++++++++++++++++++----
>   1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 3fc54cc02a1f..882580c3cf37 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -53,10 +53,12 @@
>   #define SPRD_IEN_TX_EMPTY	BIT(1)
>   #define SPRD_IEN_BREAK_DETECT	BIT(7)
>   #define SPRD_IEN_TIMEOUT	BIT(13)
> +#define SPRD_IEN_DATA_TIMEOUT	BIT(17)

I don't know the meaning of 'DATA' in the new macro name. But I have no 
better name now:) Otherwise look good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
