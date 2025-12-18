Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D4344046
	for <linux-serial@vger.kernel.org>; Thu, 18 Dec 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065901; cv=none; b=XrDMBd2EsMZlPrQRqRqM6IbCZPU56ZRkaSuifI3LuD9HYSaXUAgWYU+lfwNHnq3uki9nrZaNL8HRukPU/Nwv2ZqDNrHCr6Zyj+Mglr/I3jF59WIYJTjimkFP8xOSvyK1fAxPHlC3Gnvo6PZOBRPDQGX44a6tkpFa+uq7TrgyTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065901; c=relaxed/simple;
	bh=c83br87Fuj3FAiRyAe1sbqK67FAC37dBaSgus7jXXdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVltgiG6LnHyx+Tl+H3okG2BnqEXiVeYdeauITCIGyr9Xtwbp5Ypqp2ZCR67E4gIYRcsy1fUDx8bBvq0FDNAV7pIJ6nU1Zdl3KUFgVIPjX4Fa30oRa/uJQliIgfBQS2Nh9dyJK1EGHJhg0qstnc+DyePXixtvsC58qHK7mRTQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp2m2tJY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp2m2tJY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-431048c4068so399031f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 18 Dec 2025 05:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766065897; x=1766670697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdUtQKBs3Djto0B8q8YJrjhk/z/uULAk4Nd5edvNU08=;
        b=Zp2m2tJYmmGi8hqItfSjzum7aYHxgUgk7frt9WpOpBcd9BfQehNsvgbu50c45yx2RD
         3Kt81RhFQgVwfZ3TyNNnRASw1TP+1sXyw9r2z+kA/lge5+Fh4hJrY0yv5k0KQvp1MhEQ
         iEyLmq7eJ+oUi+hL6zRsOAzyhgEvsPfa2qTEe+BwHKBZFTbbZHm46zhWdUK3SRAd1h+X
         rMEH55AL21XytwdWdO3LoNSnbW9gVskHHrlA2VO9JVfIk778kZ+xgbpz8jri21GEk0eS
         lE14ijCj7fxlk1CIE8975+JXcSaL7tEUCe1e+JAcV/9Lt/peC4j5aNTcl6ftOGT54Pk9
         WVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766065897; x=1766670697;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdUtQKBs3Djto0B8q8YJrjhk/z/uULAk4Nd5edvNU08=;
        b=dZqm4jYX0FbcKQrLQ1ciOzDBc2X6Jqp42vELSfKUr2jjbCXrvZMiPGiICtyUepVbbO
         QJfxoY6deO0lOOkuVAe5amBM/qPcwYzQZK31QkMR68/5QDiZXhJZBis1zxHQGBeFgOkX
         4xmyRfl/x3egNj1MYvUnz+nafoAIoAKlAEXc9z7O/TMjQL3AMxo+wVRQvnV7HhLlrQrx
         qG5khMeUbTpOrgfgaY8inu11Zj8w1Yq14KrB7fGH8rYOoD02etr8c0vTA8tbNHYRXryj
         8rZMFyrVAJ7vVeSJJxrlczMzf6V+HQGRoJ4mT38FTEatfiP5LyGFPNMiDkCxGh5xfS/4
         XrOg==
X-Forwarded-Encrypted: i=1; AJvYcCUQq/q1/r5uXCCEMwmIv5Seyb5OG8bkBlijtxZUtTdhgLu53dAhYoiulN3A4xhqAsCW9u4XxgnVIU0bpxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUDGQL4B71L1vFEJzOtUqvPSKQaPxiaVwOCX9tOJWMPlzcXA3
	8xvPFkmDjC+sowGcpt0/O0aeRIiO0hUNNOS1Nz+gCaVSyLPtx+nNbzJ6
X-Gm-Gg: AY/fxX6uTyleKorJo8ntTk4o9L/jrVdygYA8Xeu2QuA02lV24vjReX7ciuQnuQs5RCF
	Jmuxwc7ONARP3lWpthhhTYv5ZXgPRWMHXKyZdbrmkdJEirsc98QVSBWTXtAbPNB73jyGRWk+B6Q
	ggh32kbaa7SJZylGcyr50C9tVoyBuHysl+eOFKd/0WjRrQABbjVYdyYgDL9bcN7xiSSwLx6nvzu
	OocZJpJoPAMMu/ptIkwads899hjUtU9Cgf6+d/OF5ITI/5g22UAaWS2FygzQtX81FmvVb7DhQtP
	kj+2TMNliH9+XuqkH5x5YBEka7blN4Pfr9EFMdBNacbtO9aQLTGPGB2H8qNJjhyV5V56y66vN6y
	qJRtR9ubBmSqG+JR81dGWK9wT9uhKilmj2sj7Vf+XTLy4P0JhQJ59BXOXhN6Rx/K97eSuwYKGuI
	zvxyw1UWb4ODYA90QOsA==
X-Google-Smtp-Source: AGHT+IESz48kSogK53GaGaTvcUuu/WVUi+Dp3vVcRjR5l2Bhk5WtPtlFNFJKTssk7+HOl5t9c5hDTw==
X-Received: by 2002:a05:6000:288a:b0:431:2b7:f8da with SMTP id ffacd0b85a97d-432447a3c75mr3571571f8f.9.1766065897291;
        Thu, 18 Dec 2025 05:51:37 -0800 (PST)
Received: from [192.168.0.100] ([188.27.130.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244940113sm5327670f8f.18.2025.12.18.05.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 05:51:36 -0800 (PST)
Message-ID: <4b601513-5257-4511-95db-390791e17ba8@gmail.com>
Date: Thu, 18 Dec 2025 15:50:49 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] serial: core: Restore sysfs fwnode information
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
From: Cosmin Tanislav <demonsingur@gmail.com>
Content-Language: en-US
In-Reply-To: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/27/25 6:36 PM, Andy Shevchenko wrote:
> The change that restores sysfs fwnode information does it only for OF cases.
> Update the fix to cover all possible types of fwnodes.
> 
> Fixes: d36f0e9a0002 ("serial: core: restore of_node information in sysfs")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/serial_base_bus.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 22749ab0428a..8e891984cdc0 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -13,7 +13,7 @@
>   #include <linux/device.h>
>   #include <linux/idr.h>
>   #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/property.h>
>   #include <linux/serial_core.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> @@ -60,6 +60,7 @@ void serial_base_driver_unregister(struct device_driver *driver)
>   	driver_unregister(driver);
>   }
>   
> +/* On failure the caller must put device @dev with put_device() */
>   static int serial_base_device_init(struct uart_port *port,
>   				   struct device *dev,
>   				   struct device *parent_dev,
> @@ -73,7 +74,8 @@ static int serial_base_device_init(struct uart_port *port,
>   	dev->parent = parent_dev;
>   	dev->bus = &serial_base_bus_type;
>   	dev->release = release;
> -	device_set_of_node_from_dev(dev, parent_dev);
> +
> +	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));

device_set_of_node_from_dev() used to set dev->of_node_reused = true;
which made the pinctrl subsystem skip the logic inside
pinctrl_bind_pins().

Since you changed to device_set_node(), dev->of_node_reused is no longer
set to true and the following errors are issued because pinctrl will try
to request the same pins for all sub-devices.

> [    0.472463] pinctrl-rzt2h 802c0000.pinctrl: pin P27_4 already requested by 80005000.serial; cannot claim for 80005000.serial:0
> [    0.472485] pinctrl-rzt2h 802c0000.pinctrl: error -EINVAL: pin-220 (80005000.serial:0)
> [    0.472501] pinctrl-rzt2h 802c0000.pinctrl: error -EINVAL: could not request pin 220 (P27_4) from group sci0-pins on device pinctrl-rzt2h
> [    0.472515] ctrl 80005000.serial:0: Error applying setting, reverse things back
> [    0.472711] pinctrl-rzt2h 802c0000.pinctrl: pin P27_4 already requested by 80005000.serial; cannot claim for 80005000.serial:0.0
> [    0.472725] pinctrl-rzt2h 802c0000.pinctrl: error -EINVAL: pin-220 (80005000.serial:0.0)
> [    0.472738] pinctrl-rzt2h 802c0000.pinctrl: error -EINVAL: could not request pin 220 (P27_4) from group sci0-pins on device pinctrl-rzt2h
> [    0.472752] port 80005000.serial:0.0: Error applying setting, reverse things back

Maybe we should set

dev->of_node_reused = true;

manually right above the call to device_set_node(), grouped with the
rest of dev initialization?

>   
>   	if (!serial_base_initialized) {
>   		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
> @@ -94,7 +96,7 @@ static void serial_base_ctrl_release(struct device *dev)
>   {
>   	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
>   
> -	of_node_put(dev->of_node);
> +	fwnode_handle_put(dev_fwnode(dev));
>   	kfree(ctrl_dev);
>   }
>   
> @@ -142,7 +144,7 @@ static void serial_base_port_release(struct device *dev)
>   {
>   	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
>   
> -	of_node_put(dev->of_node);
> +	fwnode_handle_put(dev_fwnode(dev));
>   	kfree(port_dev);
>   }
>   

