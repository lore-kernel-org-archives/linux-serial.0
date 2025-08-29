Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1586315790;
	Fri, 29 Aug 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477155; cv=none; b=h7iKL+O2OT4l9kgBBAketclpIztLv1IH+U91V90uVtQtDzRMwi2i6c81eLJo3UyThfn7wUCiowQshU4eRinMS8sdVPCmQxEOOpP/6pX/yocXMwXhNEYShuxtmwggz0XB0NWkpEIGp8R7IifCw3BWleIEtKBXgWm2zQoXzvpqVPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477155; c=relaxed/simple;
	bh=/bctECxnyur5FzEzpTeYahNv8xjX0UYOKQX4SJa5AmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIiB8Le+axm3kgHu3oRLW+jsCZi6Nznldv9a/EViKd80FE+P0AUCLC2PPF+xvn3MIHcX4VHJ/FiMUVA8IliV9dXeIqZarliI649hbqcot+DrcoFeIacyVS5WCch8cbpU2PKGim636JZEqX4kgzc3hXP86Cm79uwwwf4pQRkGqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlUdB8T3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlUdB8T3"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so299352766b.3;
        Fri, 29 Aug 2025 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756477152; x=1757081952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZewhOHS/oYbB8CL96NH+4zbtn4JHTwX/wy8X/OvrF4=;
        b=IlUdB8T3Sb9xWFlG8eopDY6zzOahDZFh210WU3tcdiZkhKPlNUuu5Z/YOwAftL3vQ8
         Bt9A9zdN2/R/WI1+L71qbLqKx7Wx2Dz4fmopzan/E6EUUqrQBrXMpNkEc5dGo7tBr6le
         G5GJVAoOtR5m9PqP3FPVobHof6yI1v8LnES2xnFH0E1bq1+884ZKd/P7vo/f6JYDC+q9
         7SLmSEkKhjwfXx3JFkWOjGS5kAHbyu4lRYpeRWSsOt0SLCXxnGNfCl39kU3dAmbDWGEr
         UW57rdr/HEg2LBoEg0dCy/q9tWc8tnb7TzkYcIoF/HXXFkzzklXYpWMrhBPWHzVNnMnk
         eccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756477152; x=1757081952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZewhOHS/oYbB8CL96NH+4zbtn4JHTwX/wy8X/OvrF4=;
        b=Kazq6ME441WqD+3Lxc5UOi0rabq1mN+PgHYqcXhl/EDxUyb/aNM6F1/xohGZCNGKKb
         fsPr0vF7II0SiO7X8pgflOJ7lN1Bya3EqLv8NPfyD1pip76T0ldu80D36z27IGRpZySo
         O1NcWOZ4KYE7vcwVh1hgy+hVgov6FY0vNZZN12it1W+szt0jLBV4Ew/pK7xkzW397dVJ
         4pcespXcJldDXmYQe8dDZ4KQwDmULFViFWBSWX/oP3FXgPP83EW73WCzAOTlUU6xaBps
         t/QrHVt5Q564wVIUaF/eOwnkkQly5oizcOvRmXxU31xAKRaUvjNUoP7i6IJ7C8GnILNo
         UzUg==
X-Forwarded-Encrypted: i=1; AJvYcCUCZq4dbOM5Gcm/G2TWWaob6YjfRHCBOs9Ny5dZC+Zx00U5AhzAHsSwcj4OPZincXsktoEVlttsFoteWtLF@vger.kernel.org, AJvYcCXqRKXVSEJjdT1YqSa7ANQZslgJFjffgwJgzLCFp8uB6lM9M00Ra1Hv4clra1WF4XH8DAvMmDJ2cqShC70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNASK/P3fNAIVqIPP4ROaN2Mk+lpUP8nSxZEUB7Yu0ZbQeJkwo
	0OKwYHkfOWwsvK0W0uGBJXJIYaHEZmw7Bv1T4GVKGBfGx2Hl5J4Lmw42
X-Gm-Gg: ASbGncuWc+5morfA+xfH+5zB9WBX+TIIYdYYgXqQhdQpmUUjanjSQb5PFjYrJsD+jJ0
	l8bfhPcdaSNQkBdZOo/nbrZ7m2Or/+EbiNtF3iKkeOJdGw9TKrPr3mzrijbSGbnMltppog0IZeS
	zJTAjM6/HQRgrBMNGR1AAEZRt59rp0LTy5DB9/2aoaDkNKdkWa1RRUzCfRQ7cKgsuoCAuAoQBV6
	P8LZ9sb8PMbPDmrIHSsL0nZv4gP2HaDF8gg24ewq7tG1l40gcMXbVQU0MV8aqIqD0Ugb0YL12GO
	mdcfxaw6DTWG8UIgdbOcVAOHTKlabgm8xBT9vTkxylCbXMwXoqC17ZnMxkd/lFbO3JZ1NQI8uq0
	tXfAb8kaowKc3pmlKk/MdVgzJg1r0dNcnRPWeL6UPlBNKSBdqxcanDNEVN4wDimT7pfMlxrgW3a
	J7APBynPlk2KyoqJxnm6GDNGZS3WHKsMuXA/RgrducDzTS105KszTnJ1gn2VcdtoY7JN0=
X-Google-Smtp-Source: AGHT+IFUpS6iflpct/0RWQ5RxJwfVBvfVDJIxOyHVtQwHMDp4XvEsdinfMiWdu6rR1nx22P+XeoB1w==
X-Received: by 2002:a17:907:2d23:b0:afe:b7c3:df29 with SMTP id a640c23a62f3a-afeb7c4a718mr1043120466b.8.1756477151941;
        Fri, 29 Aug 2025 07:19:11 -0700 (PDT)
Received: from ?IPV6:2a02:908:1b0:afe0:7f20:afeb:8c24:8d02? ([2a02:908:1b0:afe0:7f20:afeb:8c24:8d02])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0e0basm211246166b.39.2025.08.29.07.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 07:19:11 -0700 (PDT)
Message-ID: <2c6a3bc2-abd3-4d57-99e9-1c341c13d554@gmail.com>
Date: Fri, 29 Aug 2025 16:19:10 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_of: replace kzalloc with devm_kzalloc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
 elder@riscstar.com, benjamin.larsson@genexis.eu,
 u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20250827231105.126378-1-osama.abdelkader@gmail.com>
 <2025082817-laborious-provoke-2ac0@gregkh>
 <27562003-b129-4dea-818c-2e81176f842b@gmail.com>
 <2025082908-charbroil-saline-ef5f@gregkh>
Content-Language: en-US
From: Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <2025082908-charbroil-saline-ef5f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/29/25 2:44 PM, Greg KH wrote:
> On Fri, Aug 29, 2025 at 11:49:41AM +0200, Osama Abdelkader wrote:
>> On 8/28/25 7:51 AM, Greg KH wrote:
>>> On Thu, Aug 28, 2025 at 01:11:05AM +0200, Osama Abdelkader wrote:
>>>> Use devm_kzalloc for automatic memory cleanup.
>>> Why?
>>>
>>> I do not see a good reason here as to how this makes anything better
>>> overall?  How was it tested?
>>>
>>> thanks,
>>>
>>> greg k-h
>> Hi Greg,
>>
>> Thanks for the feedback, the change to devm_kzalloc ensures the allocated
>> memory is tied to the device's lifetime. This removed the need for explicit
>> kfree() calls in the remove path and avoids potential leaks in probe error 
>> paths.
> But there are no existing errors, so why change working code?
>
>> It also aligns the driver with others in the 8250 subsystem which 
>> already use devm-managed resources.
> This code is older than the devm api :)
>
>> For testing, I built the kernel and booted it on QEMU riscv with of_serial
>> enabled. The driver probed successfully and the serial console worked as
>> expected, also tested unbinding/rebinding the driver via sysfs to confirm
>> no leaks or errors occur.
> But did you test the error paths?  That is what you changed here.
>
> And changes like this, for old, working, code, is usually not needed
> unless you are fixing a bug somewhere.
>
> thanks,
>
> greg k-h

Thanks Greg, totally understandable. I was looking for a simple patch to be honest
though looked for modernizing some APIs but looks like I chose the wrong driver:D
If you guide me to a simple bug or a simple contribution here would be much appreciated.

Thanks,
Osama

