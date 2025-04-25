Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA622A4CB;
	Fri, 25 Apr 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559536; cv=none; b=oA/UuiC2vDBzmMYKkXXO9EqSOErD/o64Ck9BRcAW5eC9CpMPM8k975NogNMTgcp8QcTYHn31+o9CBNSFhICrn4tAZlq3RgNEyzKfhcByQzXn3uMh9JNEMmYSSN8bqXo8TuTMJs9azxUbZ4sPXc4gk2EQYo5Jju328lhzotZBQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559536; c=relaxed/simple;
	bh=T9PRj5O97dJkFelJlxsgXHiHXmLvW+PPN5zPzsjWlug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blPMmBoPrAo6U/+7Ry4kW9ShRAcch7MOa5fn4vZUOKhu4gR79Uwj2w82FkhKaGCXBYbO0qNOYaXhyhL0I5j/EYCN+e/Q61/a2JC85KYKj0FIXdM/b8kq/bdBboiJ2A4BSLJ6OKpTX7vJ/BN3wNcR2a7eBRJrSbVDm+c2XVNOcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSnp/FO2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSnp/FO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22406C4CEE4;
	Fri, 25 Apr 2025 05:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745559535;
	bh=T9PRj5O97dJkFelJlxsgXHiHXmLvW+PPN5zPzsjWlug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dSnp/FO2ms1RqxUlgHeKn8Y8gtNtQ4hKkIFWMrZBSP8GarrrJB3XgjbnDITBFlqyi
	 Of317H8BMKHh1ws+0wTuYpVa1SjEK00QQEVAGYz6Hq5hruJD4m+wf6+ywbtDaZX3ud
	 09nXCQKDh6evnYn2CWz5v7SfwqZJdBEB0IjzPNraz299ruk5iRHHQrYG/E3LZ/PgoN
	 jmEcWX8/ZY3vY443urJg/eLqmx47Yd3uPdgQwGWk1bHmKBB8f/KcS5MtRwfm0kUISz
	 4TYTGULUTirl7LEozoBlSZpfiNIVhf9RMI2Pm4SKWkdwh3Dxdlq8MVo9W1yzAYXLo1
	 71MTownS9U8Eg==
Message-ID: <f2389ea1-44f9-4d66-b8e1-d55281541aa8@kernel.org>
Date: Fri, 25 Apr 2025 07:38:52 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serdev: Remove repeated device name in
 dev_(err|dbg) messages
To: Zijun Hu <zijun_hu@icloud.com>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com>
 <20250424-fix_serdev-v2-2-a1226ed77435@quicinc.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250424-fix_serdev-v2-2-a1226ed77435@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 04. 25, 14:23, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> There are serval dev_err() and dev_dbg() usages shown below:
> 
> dev_dbg(dev, "...%s...", dev_name(dev))
> 
> The device name is repeated since dev_dbg() also prints device
> name as prefix.
> 
> Fix by optimizing the messages printed.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>   drivers/tty/serdev/core.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 971651b8e18dcbb5b7983cdfa19e7d60d4cd292b..f00106de76a0f1e547310c7d21cc2fe3d5869e28 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -118,12 +118,12 @@ int serdev_device_add(struct serdev_device *serdev)
>   
>   	err = device_add(&serdev->dev);
>   	if (err < 0) {
> -		dev_err(&serdev->dev, "Can't add %s, status %pe\n",
> -			dev_name(&serdev->dev), ERR_PTR(err));
> +		dev_err(&serdev->dev, "Can't add serdev, status %pe\n",
> +			ERR_PTR(err));

You don't need to wrap now.

Could you also get rid of ERR_PTR() and print err directly using %d?

>   		goto err_clear_serdev;
>   	}
>   
> -	dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev->dev));
> +	dev_dbg(&serdev->dev, "serdev registered successfully\n");
>   
>   	return 0;
>   
> @@ -783,8 +783,8 @@ int serdev_controller_add(struct serdev_controller *ctrl)
>   		goto err_rpm_disable;
>   	}
>   
> -	dev_dbg(&ctrl->dev, "%s registered: dev:%p\n",
> -		dev_name(&ctrl->dev), &ctrl->dev);
> +	dev_dbg(&ctrl->dev, "serdev controller registered: dev:%p\n",
> +		&ctrl->dev);

No need to wrap.

-- 
js
suse labs
