Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51B23919C;
	Wed,  4 Dec 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352257; cv=none; b=qp37NorHYZadfR1SOt7UORmwwDDl3RP9pH4+2JTgwXqfqNHD7KC87Bwt/Y2xzamHjJylE3kXG7PzWWHNejVyAjI5W1FUfbrdeoelnGeZjyfTQLUbmTJhfLeKxF2/zgtPq+oqFwK8DHm0T8B2BJOQlFa94UnE0ZqliFmF+bfrExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352257; c=relaxed/simple;
	bh=Kl9iDPo7lrX9I7zE21LXq/Imop6jF6ny0ETjy1IR1Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASBvXsLkRMVV/XjNe+gdc+sSpNYQ1GWDzz9ooCAcgJYPh+fjUpLc2LtxVi8J9i6kEPucAMwWnAtO9P6RsEGo1tr4aG3b9M6utT+9SHOYyERJIKktp6Gi0An4rdhrWRPLAZbjb8f+PkRA1QRPnDGBGdpOVWGZrXwU53A8Bj3ajMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEIUNUwC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEIUNUwC"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso244538a91.1;
        Wed, 04 Dec 2024 14:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733352254; x=1733957054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=miU3jDOZxK0C1eX/fBokPwP1pYJVr7aKW2vVTaT/G7g=;
        b=TEIUNUwCAYVQq2JqM4SbGhx6UeYm2eclqDPYulKBbBN50uvF+R1KwmP3V6THh8m5ao
         SvUEv0miMkRVVIh9te05JhTG7a4Zr/X0vHODewv2e/xNPOEae9517pUi00DzMAPLk23O
         gby3Sg4jSCiclC4OASZop+yN+z9fmb5lhbtRP0vFvvkAHs73d6vJvu6cDH8mzXuSRcLZ
         OHJV0pVjFCmyalq5yHbinyEx0Q3S7T1W4PwURZFhg1M2wIKx5rRKvH2LSt8CEePAgNeC
         XX76+UJh7Nn7yqXfHeJlcEjW13rl3VsjUuYSMFKbCm3L8VX/9Pat3BeHjTn5rdWmSTJ9
         4JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733352254; x=1733957054;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miU3jDOZxK0C1eX/fBokPwP1pYJVr7aKW2vVTaT/G7g=;
        b=KHDxwhRHUYwBZMQB0S3qkDNG9zn/0WXTmdIzV1kZFJayrcG6JapTc/KWCT3+mQSgkD
         qxHgVwQIY2L0ayHQiJyDSSnoNZ9OaYK+2FRzU3vUyq6cLX+QUl1U07lYB80oyFP1jb2z
         Hz9nQPaey/M1PYYJ0H7YdUEGS/6aRBGugid1sT0h5Dg/AWb6fn/ZhtfKnO6JxbMBlGvi
         h457p07ivE0CICKROF2D6ggDozecoIRx75FCb9tNoTi+XervqLSqN4lhmHzgLSWLO6o4
         JiR2XCDOKx1lXwyfYjSf4dyIOOivevfCOBfAFHbp8q8679AudwVUjGIU9oeHJ9YC8REY
         5ODg==
X-Forwarded-Encrypted: i=1; AJvYcCURfiYKiOOb2yWtYdUfJFr6d0E3uRXt5iRm398zzBbt9337J5KuJ+ynVhQcBik6Hd2P9ATH60rFP4LbvuFy@vger.kernel.org, AJvYcCXysVcPHHVQzacapL9XucZd1KbJKArlUzrsr/6rVUQ1KGv9rIPzak0JRl7DtaFpX6iHe8BR+yq2pwNz4YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfoe6YXpNFWmewu2NDO0wVPQymGhrfKhJLUzJZfWjepiyCBB3v
	1+cEzZv7CJzqSBydkhC0vIyNmdaGEjzLptJ/Ai/GO9yMRcmR5BMYs48Dzw==
X-Gm-Gg: ASbGnct1dOo+JiEQmKd0XC1NQcgFbMOCxCbkfv+aNbLgbQYyRMt2izvAeptR8JonkGB
	MBeXyQT0rBEhwL6tb+ulW71Ad0DZbYKsp1q02aoZ5zyFovu1HTDGrZGPUYsDRiggB8F2zC9oxBz
	yvw2O+VmPtK+2GqwrmChz+LhaKTbDydpck/ffgPgxQpjE9rZxf1irntXAiHtzF2bmxAgsoB4pzs
	NcjfoKslSw3Y9HLLLM1O+bjOGQzRlbgVaU5svqZCngFvI4MIxQFQBAfVNIkJpol6YBl37YYMlMO
	MMmgJ51y+BSM3oFD2T8jSFo=
X-Google-Smtp-Source: AGHT+IFOw9bH6f9zgUPa3kGQFU/MLU78dIIxrTh8A5J+bmMAepSAseWeeow7CYHdnKMJTnUpqQQIVA==
X-Received: by 2002:a17:90b:540e:b0:2ee:f687:6ad3 with SMTP id 98e67ed59e1d1-2ef0125c454mr9761125a91.28.1733352253849;
        Wed, 04 Dec 2024 14:44:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffc948sm1966570a91.3.2024.12.04.14.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:44:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0e07c26d-5136-44d8-b9a0-96154050ae8e@roeck-us.net>
Date: Wed, 4 Dec 2024 14:44:11 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>
References: <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
 <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
 <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/24 14:17, Arnd Bergmann wrote:
> On Wed, Dec 4, 2024, at 22:09, Guenter Roeck wrote:
>> On Mon, Nov 25, 2024 at 04:59:00PM +0100, Arnd Bergmann wrote:
>>> On Mon, Nov 25, 2024, at 12:06, Arnd Bergmann wrote:
>>>> +unsigned int nr_uarts = ARRAY_SIZE(old_serial_port);;
>>>> +
>>>
>>> Unfortunately, this breaks on non-x86 because of the check
>>> added in 59cfc45f17d6 ("serial: 8250: Do nothing if nr_uarts=0").
>>>
>>> I still think it's the right idea, but need to unwind further
>>> to make this possible, and find a different fix for the bug
>>> from that commit.
>>>
>>
>> I decided to apply the patch below to my fixes branch. It doesn't change
>> the code, it just gets rid of the warning backtrace.
> 
> I got stuck in this rabbit hole of running into more issues
> with the 8250 driver. Any time you touch something, it breaks
> elsewhere.
> 
> I've uploaded what I have here now:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=8250-cleanup
> 
> but this probably needs more testing, and a few smaller changes
> 
>>   drivers/tty/serial/8250/8250_port.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c
>> b/drivers/tty/serial/8250/8250_port.c
>> index 4d63d80e78a9..649e74e9b52f 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -467,7 +467,8 @@ static void set_io_from_upio(struct uart_port *p)
>>   		break;
>>   #endif
>>   	default:
>> -		WARN(1, "Unsupported UART type %x\n", p->iotype);
>> +		WARN(p->iotype != UPIO_PORT || p->iobase,
>> +		     "Unsupported UART type %x\n", p->iotype);
>>   		p->serial_in = no_serial_in;
>>   		p->serial_out = no_serial_out;
>>   	}
> 
> I had considered this at first but didn't really want to do
> it like this because we should not be registering empty ports
> on platforms that don't use the setserial style override for
> the port configuration.
> 
> It does of course address the warning, just not the
> underlying bug.
> 

I had a look myself, and concluded that a clean fix will likely require
substantial changes to avoid regressions. Your patch series pretty much
confirms that. This is why I came up with the hack below. Yes, it doesn't
get rid of the underlying problem, but IMO it is good enough for 6.13,
or at least not worse than 6.12, while at the same time avoiding the
warning backtrace. It seems to me that a clean fix would be 6.14 material,
and I really don't want those backtraces to clog up test logs until then.

Thanks,
Guenter

