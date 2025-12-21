Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCC1D88A4
	for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310457; cv=none; b=eYw/cQkLLgBC6GNxG1aXjFSzvjrZWimoN30RtvVkpSJxlwTEEtlJ2fQeAWhUqHcdcntlcsFWutRf+e5cwd8mR3xPAy53tx5XC/n7NQLbP79TUK4Ml9YmNno2K2qLi6J7LMdmsDDmDZWwvr1l5iQDJvTSGSE5XgzeIpraH4slDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310457; c=relaxed/simple;
	bh=/5CyiCe6Ek2Cf+31Z2a5VBnxYVlWAfNhsKycfYhBHIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKmAKU2y/UpXAxu1s60iiKPUNF4s9uhlbV1ryMpqKv06HaoZLb7WLm30/6x0/uGHBsvqD0aVmZ/UQuyN1QlSxGw/iQ0TgyjlKzscVeM/leMK6tEChMADCT9gyWX5djYF3mx02ZL5rxULX+KtwVK3n0IRiYpIexo8EIEvG4h4dF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgGbWQw7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgGbWQw7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so17471745e9.3
        for <linux-serial@vger.kernel.org>; Sun, 21 Dec 2025 01:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766310454; x=1766915254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8h4EAhNwunCzrOYBrkFv8D6snrjBMI1olDbYJCejFo=;
        b=OgGbWQw7keU95mJ3hxkvGLJ+UcmdqKC2Kqh4AnPkIDUkLfd9ZHC7W4FNAfYZkYTklM
         V/39Sy3TyDMDLh0ZZv9g3MLtgmLHjRwtYGtGzwqzdI4MEuOo6o2y766HxPXfIRRAM6i4
         z9RKbrJe/QzSKGiPc2dvgMTWuSp6cxQnW0xZE7He7cxCwwHNoW6BjxyfZBsTjUQbDxke
         yJ59pY7VvcC+MVTF3U9crl81ytQuh8YgNFn0aXn696B9Wlxs8I0AGeDHK5X89aJGfBrp
         o2nXHAVdW6LvR+VMPUCmiquH1iQSxEzoyLcnD785WXJRDrnUBYJbZ6PUFXi0In5/l5ny
         /ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766310454; x=1766915254;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8h4EAhNwunCzrOYBrkFv8D6snrjBMI1olDbYJCejFo=;
        b=MmTLzjIMVsFXI621AXQoDTmEONyf0GKBLOAY/LowL+6oX3Lh13TNYXvWPCQ1nLKJPq
         1s9MGNtY3VlbslHSihA85yNuC5q8Ht1dXNn1kf4rL44kIrxhEkd7SP83of1RKVzAyKt3
         1PkiXrkeZ8JGX5gMjBkoNBAU8jLMyVhOIlGZZYDqH9EdCpyOvqeFJkdkQajxqIOMModu
         NmT7+Ul/+OuOIdmQh9lOdBQ5an29APqGbsP4PjfiYuHALPJlQXLgtbnXB7xkOctqfI8N
         e70N2SgW53W5ec5AQb7U/Ccgxn6w0tpQKvLZ1ZETRonfs0nQEyEF2aop2CBsyYjPMa78
         I3sA==
X-Forwarded-Encrypted: i=1; AJvYcCX14RFOJIa2bpdF8NiYhI8lhzebK6IQFeVLhSMqX8I8uMHWmk6WJYMyioGJJVsdB0xU1ewjP/0YzDhdnTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+ORwRLGOteLpsEb6EVg3I9xoBO5kAhYoIIyUllmI6Afwu29+
	WCmTRBvxeWLwAsqvcewS5Id58Zy6syLCvgV7bpTi2krjuSLPNqWG/4/T
X-Gm-Gg: AY/fxX7LD6DSkxMfQy4xggOvdJkAnqLBdpP+BIaPYAUJQisDlXDFEkxgceTFlwv3wHZ
	Ay4kLGL3FjsgmVp/5MyfnAO6b4ue/f7XxlxZkbDXVeZuPoup4FGLS9Q8ygZdoYMTiYwGZC3Io/B
	/1LAbMhJiokmdt6Y/KC3e/yTGLI5+r6STI2qq7mga/u/uDeQS2/n5DQRQbUwNYo9smbT53VGkZM
	TBI33xrq3f7Yi8c9RPL52GXlqiKppHYYrKymY9HIoorUcsca9e/mhAni9KkSOBVS68ttHpZv9bs
	IWbYMFcOO/efjyoycCaESGi4rq0dRW8LGj9pH9fnkDuxwhSe/IlB3mAoDdHVjIRj/wc6/eTNJ9u
	kv5LvMFD6g7r49WKJSL0JgdkKenfKVS2bOm38NYOfeYtp6+BmGp6n1U6UBhEiLoja648iZoYwAc
	cLU/5vYzsBtCumOUmjBw==
X-Google-Smtp-Source: AGHT+IEl9WTAbfygQI2pWym3AA43OO/HGiaa8HBUiU1QJEHP5QjrAhmS1k/nX4qDRQYO+RZgXpKJFw==
X-Received: by 2002:a05:600c:474d:b0:477:97ca:b727 with SMTP id 5b1f17b1804b1-47d1957d7e6mr75458595e9.19.1766310454203;
        Sun, 21 Dec 2025 01:47:34 -0800 (PST)
Received: from [192.168.0.100] ([188.27.130.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm182506755e9.4.2025.12.21.01.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 01:47:33 -0800 (PST)
Message-ID: <b88a2a52-274a-4e12-a839-564208495a44@gmail.com>
Date: Sun, 21 Dec 2025 11:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] serial: core: Fix serial device initialization
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
From: Cosmin Tanislav <demonsingur@gmail.com>
Content-Language: en-US
In-Reply-To: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/25 5:28 PM, Alexander Stein wrote:
> During restoring sysfs fwnode information the information of_node_reused
> was dropped. This was previously set by device_set_of_node_from_dev().
> Add it back manually
> 
> Fixes: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
> Suggested-by: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>


Tested-by: Cosmin Tanislav <demonsingur@gmail.com>

> ---
>   drivers/tty/serial/serial_base_bus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 8e891984cdc0d..1e1ad28d83fcf 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -74,6 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
>   	dev->parent = parent_dev;
>   	dev->bus = &serial_base_bus_type;
>   	dev->release = release;
> +	dev->of_node_reused = true;
>   
>   	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
>   

