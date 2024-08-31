Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21019BB7
	for <linux-serial@vger.kernel.org>; Sat, 31 Aug 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725095833; cv=none; b=nouFqO6X4/OijkBjZc6K1fLOeFwT4kxUq7+WJetGKIv2xETC7VFRxl1BiOqeTtL9G6SCt82TADYg89ejRfGFb78x7oZaLigehkxCpZnOoD4sHRws706fk2UX3FzsV+XHkco3kTOlNdBfmss+rYk+d66REChJmSi3lW5D3sEEbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725095833; c=relaxed/simple;
	bh=LvOTrlRBEPwDyI6/Nc6lSz3wa+Iw9Uc6C0EWseKykXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BN+luGRPx2f63VCCiKd8/ylKxGNlvNZpT21Ojy0YpLYQvy8zm/GbWWFPfW2ianXVRow/tcjiQzBqjP3bCj5IkPlsBZBAZM4trwRZRpm3RrqrHYFnOVD9bEvJyK5UDWQmV+DbZmmh1er471p6t0KUq/ZYL7becJlFA1Ue0MHGE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ZoM0svnk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ZoM0svnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725095815; x=1725700615; i=wahrenst@gmx.net;
	bh=95z+oY7txvjaR/pEdJjsNVU9eKUfNKM/C8Gs7mhXYl8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZoM0svnkXM4kbMzjacd9aoLEe4w6rMTMwOd5+QLtM4bwF5h4jzVrFmV3WuK57sEb
	 9/Fllw4J4EaAhUlIXH0I9Sktz4ZjvWV0twX3TFthv5+YLh68bIqi0X312lFmr/r7s
	 vNjKLt/ln8hNn0fSc/FZ/jGEk9bqPryDqFnWRxEkz+xbCYqPxAVL6uiLbAa7OOkq7
	 5RTjC6uFuS4dqw50ZkGivWLFhfDbgC8j8KkDeUl4u1elCt/ivM0tsuybxCaPVg45q
	 83TA0x+b9OUKBwYKY2OHTGyFZiBqKC53/C5Vp3yzIRg61MFmRMXFgf3TEgCZJPqk6
	 e+HX0MyVR7my6E+XjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1sS6cP1Xqk-00IhOE; Sat, 31
 Aug 2024 11:16:55 +0200
Message-ID: <b7103011-d1e0-468b-bab3-ae49fac7d848@gmx.net>
Date: Sat, 31 Aug 2024 11:16:54 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_bcm2835aux: Fix clock imbalance in PM resume
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
References: <20240818174936.88372-1-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240818174936.88372-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IFRjJrWXOlqE64WzjrmQCYB7lEd5SLTSb8W3plWlXWSDsumnpG0
 5wbvpF8skOZsrLj6EtUeOyB7xWSarEqF6zXLhjRB2Gkd8ZLBrYGs+KRffxPPDVascWtoQyl
 bFrRJYcE9glKat4lKPExTj4TtH8EBlVo2wWKBy1QsrfcMcrDdKMtmzvLRYALF+oOBDWuW7e
 l3HubNk4wAG+oBoInP+WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yY8fp6PlrBI=;/MSasBIcbk/fqd1lPBTDg1NLsq1
 pqZRo47gfayXbLuNFlcN2Wd9LBFnllmnJU2trfO8KSitvWKZqWdUDE2xnrVEbkTFR126UxFqi
 3Jt0giYfr+1VxMUQr9gSpy8Qud1TFl/L8+OHAQSFIcjWNfEWcdC2gvIg61qEXDOnUKen0TUUW
 cFPd2Bkqq3xz9F+hmGKqZ52tAtU0GD3IDEo5a2qd243yhp8Rroz9d2I8aKgISt+N+c54V/6nP
 x6x+olfcdgr4oyFBMKPtDPqSFTH27eU4iQ84apVQqYuN5smSoF4TUm5ngUK2HBf2eofXim/mv
 mVqLn9VoopDQJcQHVkRvNvDZYSpht9VyzCNJht/m3q4Tyxzc8WoddOo+pltA6YNOjo6ob8cg6
 aQ8YE3DAGqUjQ/L81bBThZLERlnc5v+eLJUMXpjcAHAo/tFd7ZQSowPcy7Lr++3rv4J6Xx+6d
 iGwctPuHZYI19YkaoYZKa+pv6HDYS9x1x1sj0ERqIAPTI9/s+o3sJiQuTucDlqJy+n7RiS4h9
 2+5Gb+jgYgxEA1X+J5gNopcnZumw3KJs/03W2ie1iWyFmNV5GwLkEU6YzcybkW5wO/gyPQHAU
 o2kmPGS1fM5b7wSBX9Tjmu2/9Y91wPcA3xFXFAXmGRAjo09EjrxBAPisiFsgnAhsCmCt4FwYP
 3az628vCshyUOG5sNln7djN6O9NvAbVEsTnWZDri/c3DUut+cBwnIvtgRZSn7XLocy9e3ZupR
 1JXEsyBd2s9ZBKhj7tmVkdKJhFUWTfcKyhRFQIjGto3N87E7gnp6txcf+KnyCg8+lk6dnSdaq
 KFJ/+wBv4lA/reTx3UhgpjSw==

Hi,

Am 18.08.24 um 19:49 schrieb Stefan Wahren:
> During review Ulf Hansson discovered a clock imbalance in the recently
> introduced PM resume code. The driver should enable the clock only in
> case it has been disabled in suspend before. In order to make the
> conditions easier to read, refactor this into a separate function.
>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Closes: https://lore.kernel.org/linux-arm-kernel/CAPDyKFoJh3j8xSeXZ9o031YZLTCDYVA+dgvURuwozjDpU_aauA@mail.gmail.com/
> Fixes: 0e1d8780526f ("serial: 8250_bcm2835aux: add PM suspend/resume support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
i missed to mention that this is for tty-next.

Now i can take the chance for a gentle ping ...
> ---
>   drivers/tty/serial/8250/8250_bcm2835aux.c | 26 +++++++++++++++++------
>   1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index 36e2bb34d82b..e6b42ca6151e 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -214,17 +214,27 @@ static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
>   };
>   MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
>
> -static int bcm2835aux_suspend(struct device *dev)
> +static bool bcm2835aux_can_disable_clock(struct device *dev)
>   {
>   	struct bcm2835aux_data *data = dev_get_drvdata(dev);
>   	struct uart_8250_port *up = serial8250_get_port(data->line);
>
> -	serial8250_suspend_port(data->line);
> -
>   	if (device_may_wakeup(dev))
> -		return 0;
> +		return false;
>
>   	if (uart_console(&up->port) && !console_suspend_enabled)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int bcm2835aux_suspend(struct device *dev)
> +{
> +	struct bcm2835aux_data *data = dev_get_drvdata(dev);
> +
> +	serial8250_suspend_port(data->line);
> +
> +	if (!bcm2835aux_can_disable_clock(dev))
>   		return 0;
>
>   	clk_disable_unprepare(data->clk);
> @@ -236,9 +246,11 @@ static int bcm2835aux_resume(struct device *dev)
>   	struct bcm2835aux_data *data = dev_get_drvdata(dev);
>   	int ret;
>
> -	ret = clk_prepare_enable(data->clk);
> -	if (ret)
> -		return ret;
> +	if (bcm2835aux_can_disable_clock(dev)) {
> +		ret = clk_prepare_enable(data->clk);
> +		if (ret)
> +			return ret;
> +	}
>
>   	serial8250_resume_port(data->line);
>
> --
> 2.34.1
>

