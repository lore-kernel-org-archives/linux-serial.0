Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358B1B87E9;
	Mon, 13 Jan 2025 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748492; cv=none; b=SP+TG16jCzM3nCzxqtCsZNZjvx8Yd+nzuL1/QDsCAE0vvRF56S7OsGRkVhXN/f24YO90N1ROJ5/jZEvbPXKKege639QwBpIbj5I+wHQZevT5hqJC89jYJsm5Xqy3tpHchQnrWCiSxkurlAuGA5urYhDaiSqhJ0TqSdt43kB579E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748492; c=relaxed/simple;
	bh=5CXr9VSrRJai84JtzB6YQRuzzC4LX+KQtjyLUOftu6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PG2wJc0fxOIPc8+9LrxIQ45tJKngjq4KO7NE4u3z7OOTmRKr/PhDgd6ecOzJafhedqZ229MITVzBEUktwywT9gx8ixHQMGKr2TW1cQ6gqSx6XeioRbcf6rr5mFWkLzbJ2CodFiF1D/eV6nUuL5IyFYq6XB5LfcB44XcNIDC4Kn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kGBvZTvV; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kGBvZTvV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736748481; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g8PZYPGxtZWEWPyskmL9rNhNAFnWFEGdiprKLlNU5ls=;
	b=kGBvZTvV970I0X1uTx7EEd8fmhUmh1z6OmW74C8MZKWxMITaEAcjOQFbGr62nxxAwh4R1MjD8Q1a2IkNHWtGag0ULlWVWtuHCIPpJeSo3Eeu4Y5VcpO025OfLq2Siw2Jnr4872d4luUHe2TPj+IZJ0/ZZiZBH639V3taIigWORI=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WNTcKEI_1736748479 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jan 2025 14:08:00 +0800
Message-ID: <7385b093-378a-499d-ae1f-4c85001f088c@linux.alibaba.com>
Date: Mon, 13 Jan 2025 14:07:59 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] serial: sprd: Add support for sc9632
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
 <20250113031917.3354988-3-Wenhua.Lin@unisoc.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250113031917.3354988-3-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/13 11:19, Wenhua Lin wrote:
> Due to the platform's new project uart ip upgrade,
> the new project's timeout interrupt needs to use bit17
> while other projects' timeout interrupt needs to use
> bit13, using private data to adapt and be compatible
> with all projects.
> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>

People have already given you reviewed or acked tags[1], if you did not 
change the code, please keep them in the next version.

[1] 
https://lore.kernel.org/lkml/20241113110516.2166328-2-Wenhua.Lin@unisoc.com/
