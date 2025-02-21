Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05E1FF610;
	Fri, 21 Feb 2025 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124418; cv=none; b=BzUfv99M6Hkm4j1HqY18svgCejdHBPQm4WhPYVFjDYQRaxKJexdPcKWyMZp+hWPj94EeIiBzHfTum8O6iq2rV9P5dKtmCVHPswRQBA3XbVndXhnwb1CpZ2w4p7leb1OQ0jfnIQ0/ssW6t4Or7BSkO/K5sJT+8/g2nNHfGzr/DeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124418; c=relaxed/simple;
	bh=bsl7AI4Fk69oe0KM3mv99Vgbb8n+nmX6nQ7QyQ3T9X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuOrJd+n78OUtOn1P7RCghhVpKehob+EMvKrQW8wic37EqBljULjNdi4MUie1bvzz5cOZvd22oqfTK1Q7+LHZSD8FGMZlXdCkHJBgssWpUm/TLkK/OkJDic5VcLNeXg8akJiio9GVk6lZxHOilCR6Psj1/WaC3bQYnuV0F+fTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poXd0/F9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poXd0/F9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E78C4CED6;
	Fri, 21 Feb 2025 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740124418;
	bh=bsl7AI4Fk69oe0KM3mv99Vgbb8n+nmX6nQ7QyQ3T9X8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=poXd0/F9tnQ8uQhBMXN59k88wJLDz+u6OCgcdsJ87flM06XJWDuk1j7LxXI/OZAyx
	 ejQyH+zco0JM9nlkend+hVJKhfwQBkjUb8Qu0OzqXLi1OjatX/QI8CE3zanpmK7s2j
	 ZDRWFFISZLXStK4j2Ik3/us/Z/UEBrCHEv8caobaifa4PazC9VCPaZNZq5uODiNhB9
	 WPa4t0BtQBCvPbYGnzIZbocvEZVPIfnkn8n7rzCRQoREd+sn6bPZzUmx+1r95N66+r
	 oVGZ2lZIk0X2BRi1hgVcvxmRkXD1vnh+isSgKTwW5NVVOJr+oe1O6qKvClNOoxI9JS
	 hXsSDU6uOhghQ==
Message-ID: <6e5ee9a3-f3fa-413e-b8cc-2fdfa8537590@kernel.org>
Date: Fri, 21 Feb 2025 08:53:34 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/29] tty: srmcons: fix retval from srmcons_init()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20250220111606.138045-1-jirislaby@kernel.org>
 <20250220111606.138045-21-jirislaby@kernel.org>
 <CA+=Fv5RadC05i29h_geUq3Moyn3hGydoRu335T-q9vnfcwZqew@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CA+=Fv5RadC05i29h_geUq3Moyn3hGydoRu335T-q9vnfcwZqew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20. 02. 25, 22:48, Magnus Lindholm wrote:
> I've applied and verified this patch on an Alphaserver ES40 with
> serial console.
> 
> Regarding the future use of label err_free_drv, is the intention to
> use it to break out early if tty_alloc_driver() fails?

...

>> +       if (!srm_is_registered_console)
>> +               return -ENODEV;
>> +
>> +       driver = tty_alloc_driver(MAX_SRM_CONSOLE_DEVICES, 0);
>> +       if (IS_ERR(driver))
>> +               return PTR_ERR(driver);
>> +
>> +       tty_port_init(&srmcons_singleton.port);
>> +
>> +       driver->driver_name = "srm";
>> +       driver->name = "srm";
>> +       driver->major = 0;      /* dynamic */
>> +       driver->minor_start = 0;
>> +       driver->type = TTY_DRIVER_TYPE_SYSTEM;
>> +       driver->subtype = SYSTEM_TYPE_SYSCONS;
>> +       driver->init_termios = tty_std_termios;
>> +       tty_set_operations(driver, &srmcons_ops);
>> +       tty_port_link_device(&srmcons_singleton.port, driver, 0);

I plan on removing tty_port_link_device() as it was a temporary aid. 
Yay, for 13 years! (commit 2cb4ca0208722).

>> +       err = tty_register_driver(driver);
>> +       if (err)
>> +               goto err_free_drv;

Instead, the idea is to properly tty_port_register_device() after 
tty_register_driver() instead. And that can fail. So is fail path reuses 
err_free_drv (and adds tty_unregister_driver() on top).

>> +
>> +       srmcons_driver = driver;
>> +
>> +       return 0;
>> +err_free_drv:
>> +       tty_driver_kref_put(driver);
>> +       tty_port_destroy(&srmcons_singleton.port);
>> +
>> +       return err;

thanks,
-- 
js
suse labs
