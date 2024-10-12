Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F8224D7
	for <linux-serial@vger.kernel.org>; Sat, 12 Oct 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702630; cv=none; b=o0WE8uKTZCIR/OcdkwgLvLovcqp6riN5Qs1a8RQ63DYdXl38oiVMdbjHWcP6WDSF4lXcCcHTFpcRRNJkug2D6ixtzllFWpf+3/xN27BboRmrsoAcK5zsKOMnhM1Gy2bPHP4WkeqXm3u6YDAFNPdvHIao6Vkwwx2pMTobH21wmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702630; c=relaxed/simple;
	bh=j9YtTlXisnelzZJoS/gWn6eeJJZahqyoQ4c7Bndn5VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg5ga4qfcEvcH4XgX2W/efF37UgwOnBc9NFbcPYCGL5UAvut4uIarBY8tPVm3Z2DrCFIloNG8ngmCjxFC7Gx/SochiUH4p4BKx4pKN5fOyL3acUbVI3gbe4PVKVgNDAyKji5+XHZzYx9Lrvj/GbgisTeMHdBFFibyK+Cb3jBr6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nBodNEE/; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nBodNEE/"
Message-ID: <6b5d548b-82ab-4bf3-90da-173928968fb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728702624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRD9Rtu59sjvavTxTYgXcbbxcWCSXOFg5CgNDOLxNRQ=;
	b=nBodNEE/A0yXx3SXoLGaWK3y11dnS2Fmnhjv8GieebViXxzxtCwbY+wT2dSdQIxTIN+Epz
	CwSxGhByScQIbGo7S/qpB5JzG91GhZC+EywLAT0/Z5FmMcnGPlH1UWR6q9V7hw+Jolwlwh
	Z7bybEpCgIVZjXd35ShiLExKCF8XzyM=
Date: Sat, 12 Oct 2024 11:10:05 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] serial: clean up uart_info
To: Yanteng Si <siyanteng@cqsoftware.com.cn>, linux@armlinux.org.uk,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, alan@linux.intel.com
Cc: bartosz.golaszewski@linaro.org, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, u.kleine-koenig@pengutronix.de, mengdewei@cqsoftware.com.cn,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240920053423.1373354-1-siyanteng@cqsoftware.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20240920053423.1373354-1-siyanteng@cqsoftware.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,


在 2024/9/20 13:34, Yanteng Si 写道:
> Since commit ebd2c8f6d2ec ("serial: kill off uart_info") has
> removed uart_info, the uart_info declaration looks lonely,
> let it go.
Could someone pick up my patch? Or give me some hints on what else I 
need to do?


Thanks,
Yanteng
>
> Signed-off-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
> ---
>   include/linux/platform_data/sa11x0-serial.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/platform_data/sa11x0-serial.h b/include/linux/platform_data/sa11x0-serial.h
> index 8b79ab08af45..a88096bc74e4 100644
> --- a/include/linux/platform_data/sa11x0-serial.h
> +++ b/include/linux/platform_data/sa11x0-serial.h
> @@ -10,7 +10,6 @@
>   #define SA11X0_SERIAL_H
>   
>   struct uart_port;
> -struct uart_info;
>   
>   /*
>    * This is a temporary structure for registering these

