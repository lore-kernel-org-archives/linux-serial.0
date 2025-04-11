Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC232586FE
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400169; cv=none; b=ryugGZ/afaq5fvwtbYs759vA9s3QRdNcgfVik23cGfdrUxMgil4/5wkCmueKrlf/zLMGdrjstA3LC17OPRp8P9fOalhe7nTBvTp9ofZzQiSKRdt2GSZKx5Rjj/ORDYPzwpTs6sq5LtgvtAIKtaie2P4tdC3qYvr6pOJe2YJtkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400169; c=relaxed/simple;
	bh=YWpsO5xUUd8r+lQC+34HlNpUYxi1N7dTXlea29z2cjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ2VBOZMRkEQuenOgyOYMcteAee5OjNgFRh98HbFlflGIobL9lLDHxc+EUy/fPh7FM5vg+5SjVahrEEvT+vxcbTbHG0F4XQWNJogbFnoscSvfS4Mw8nEIQTXo+iduJHabZW/aZymkUidemwN2qONL8+bY7s/yN0MferQqaNo91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Ju8bl2gP; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Ju8bl2gP"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86142446f3fso60398539f.2
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744400167; x=1745004967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8IJA/pmXvNuiKKrx3r2PtlepPD+xmj2yEuRTpmM5lw=;
        b=Ju8bl2gP0mV12mt8bsAgo8oJEj7o9WSc/Fc9K713oROoZXtvxVsveKZW3/74T1VkKE
         QGP0GJEwSMaKwNQY6Bb/kZPm1CQ1w+Vq1Ezt7LYy7SQs12Uvy+lje3GhmjfzALr9FdKe
         1E0nwTdK0BBE7TEDCCsYjDz6UHL+V00CH/p4HomCZPheBZ6xp+moH5UhiEwGKkIRuMPa
         m3bjRlbIwGWzCEQi1mIw6T+170Vkew9P5hgBbm+rV7F+9mFEMzupy4pJYOGB2mMxk8Ah
         WElQHTu4qM2dDVzyitOIgTxa8YTUMLCRpn4Q5E/z40hDlwlWp0/pjuxQ2pzSFvWLF2SF
         gsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744400167; x=1745004967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8IJA/pmXvNuiKKrx3r2PtlepPD+xmj2yEuRTpmM5lw=;
        b=bqO8UuK1bbKjaiXk2UI8+i/jS+ifhWgltLkWyrry8ISIL1klxvfrwi9gBkfOvnpLxv
         UGyGr5RE7qHRckGW/Y/RLZbNzDhDeeUFIGxsaGSOiZ6CwL+OutGaIN0cQlXyHjitcBJW
         ty0AHYaaBwQKSDv665RqFf1aojMd39iUGYJd2Lb9ix1bmtK2Z2McL/jgJvX4ufVzQxHA
         8xvZYNe7DHrqX1sbd2AhagfhNP2Ch5q29xMO9leTmC8y6spI5/PWvu9nEdpWir3nChL3
         8PiQTrz/gjGfG/yYZhIo/Q6NikdfF01H9sLSl9Cdm3uaLhy9b16n0zeuNUDOQcg7xM3E
         7K4A==
X-Forwarded-Encrypted: i=1; AJvYcCW4OhfZ5NPSPeWkFvVtw4dlh6gcQRfg69L5TsIzTm0g6Iekhnmj8Tsal3ii3pXjweGRSFXa+jxjoODwJCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0E+FYa8zivpp8AILJQRn2Tl9cx9znKbfsJ49tql9ucK/IqdDC
	ZSEuMsK6bAji4tGgzi/Ao08p26NcjavvFEu6Ej3YdmiLrFTVske/zIyCc2VCLWY=
X-Gm-Gg: ASbGncvOziKc9qTpZacnm8nEEnt4ze8/qz13HKB9e3g4qPtCvc6R3zFh/JGqixF/Fd5
	YpTNV3vR/Ord1WF9nYpiXfchheahqJfvnEncfEYt/IhzGFHC82QXL1j0fdJZEZQ1A/Ao2MVQ8La
	jhifSQxu4IAMxHCO9kjDcZZSmw0zQ+xTCinTXHG8WzgbgkDYdENo2vw85lPuHaBezr53ASTilKb
	StM60Lc2+HyWEI2oVcCKlvY47/VqSBPOFrQlpD92GYsyOpUuoZ/2CZVgd8RmwSFDzJJl6aFVvtW
	AmFytJ1B/DoOxWr3HVSTq+EPdLhV2kSHhNI+btMy0C7xVOIh7tLyu0jzjYm4BBgItKww2BxtcKE
	oDpjdmrp1871hjdQ=
X-Google-Smtp-Source: AGHT+IHpEgSqemBHCC96JM+TCmkYLDtVyLUCKWRb0L7zdDTWhisBDSszCwSCFlcKlvql0c4WxZEtlA==
X-Received: by 2002:a05:6602:3713:b0:855:5e3a:e56b with SMTP id ca18e2360f4ac-8617cc3d525mr485687939f.12.1744400166792;
        Fri, 11 Apr 2025 12:36:06 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861654295d5sm107606839f.19.2025.04.11.12.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 12:36:06 -0700 (PDT)
Message-ID: <a3b2d0cc-c055-4cf0-9e03-3ea73041642a@riscstar.com>
Date: Fri, 11 Apr 2025 14:36:04 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] serial: 8250_of: manage bus clock in
 suspend/resume
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
 benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com,
 andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
 lkundrak@v3.sk, devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250411154419.1379529-1-elder@riscstar.com>
 <20250411154419.1379529-4-elder@riscstar.com>
 <Z_ltyAO-OBzl0adV@surfacebook.localdomain>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <Z_ltyAO-OBzl0adV@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/25 2:30 PM, Andy Shevchenko wrote:
> Fri, Apr 11, 2025 at 10:44:18AM -0500, Alex Elder kirjoitti:
>> Save the bus clock pointer in the of_serial_info structure, and use
>> that to disable the bus clock on suspend and re-enable it on resume.
> 
> ...
> 
>>   	if (!port->uartclk) {
>> -		struct clk *bus_clk;
>> -
>> -		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
>> -		if (IS_ERR(bus_clk)) {
>> -			ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
>> +		info->bus_clk = devm_clk_get_optional_enabled(dev, "bus");
>> +		if (IS_ERR(info->bus_clk)) {
>> +			ret = dev_err_probe(dev, PTR_ERR(info->bus_clk),
>> +					    "failed to get bus clock\n");
>>   			goto err_pmruntime;
>>   		}
>>   
>>   		/* If the bus clock is required, core clock must be named */
>> -		info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
>> +		info->clk = devm_clk_get_enabled(dev, info->bus_clk ? "core" : NULL);
>>   		if (IS_ERR(info->clk)) {
>>   			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
> 
> While the first patch against this file looks okay now, this one inherits the
> same problem (seems like not enought thinking about the code representation).
> 
> Instead of rewritting half of the lines you just introduced (which is also a
> bad practice), add a one-liner that assigns a field to the local variable.

So you want me to re-spin this again so that I use the local variable?

I understand what you're saying based on ease of review, but this
is a simple patch and the change is very understandable, and the
code is no more or less clear when using the local variable.

					-Alex


> 
>>   			goto err_pmruntime;
> 
> 

