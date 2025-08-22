Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578792327A3;
	Fri, 22 Aug 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855782; cv=none; b=CNiGt5keIWVfdj1S7fdrOo4xAnecKtPn2DPQ1TfcD+Nl8RHMvSt+1qE/t6tnyMn9UmZMZAUPRRiKQcQKxyzqxP8MqkWNA+ydAEwYjN3MmpThW+o4HYX+nB4zM8J69yAyVuz23OeknlV8+IQdIsvAWEZTFqweMPF9i+VxBXyEXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855782; c=relaxed/simple;
	bh=GAAM0WfLy15KZaMv+Mv+m2ZoYa2aXG4Xc0Pkj8se6C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KP3Mhx2QRafyRXf2lXrvLLKzG3GDSZm2Qasiv9Z2NU7IdL029tbKzicX3PHTsYAswwL/zzMME/UorCK708L8prlVWhh9hQ61JeZLMiPt2tX9HYlhdIb6DkMevthpHtSp+pVpn0MDeGzUA3eTOIBYt87/X184mXfyRC673X1gsO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkWRe60c; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkWRe60c"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so2983108a12.0;
        Fri, 22 Aug 2025 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755855778; x=1756460578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NhTENhPiBZ0gP5DTq0s9G1TB1DFx2wNSSAtIKfu88s=;
        b=YkWRe60cvSN1MSWgeIHmqI9Y/0oMh//uN0f4Cr+/nrCvfHGrNkLPFd6Ft8V0YSqVCP
         50dcJHzW75YRgihowdYyHLiEfPU0LliruWyCfw5+ZwlhVti9sCluIXKjNFs455uCGsj3
         GpTR1nCttT8S0pXHAdMK82BE8f/9X3CazBgiJaUnzTMWh9gTHhLFgZKbpfKAF7y0lKtb
         VkoHOjlCitBC69lHgsRSekEAl+Lh0Mp0tLzxI7OJ1W01n6/RhPhM5CIZbvDrbkNc43G2
         mYiFokD0Ww+NGo1kfc6PGJgUk/rNiOMkCG8F2SaCOAEtl2Gv5gENrXkk6Lz2jIZ9kEia
         Lc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855778; x=1756460578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NhTENhPiBZ0gP5DTq0s9G1TB1DFx2wNSSAtIKfu88s=;
        b=GlWTUik7xGSTcOEBuES23xWcxq9N/cAT4yCEVHTbDP2WkpWkE+v/36coZcBxSkJnUT
         ugQymC/fL3WJVjnvgRQtMJy8b/V1EfOb0CByCQz+DQxWsB6FwlRn1o/tNjfLvl4KjI2v
         MkeLmTDhfapakEbBXDfXg49ljgmKL2xRcF7TRAG6wS+Cqs1NLr8CaEF7RRp7K1aZfTNS
         u35zT05cCIsobqyGPRgpRAtKSjdiS5siEyKzoeKin4pqAdoarHHdVxCGDX7plUKGN1MY
         K5KnZc9RaH56Bt4MXw94LJ9YxRU7Uwrk057rH3yaPNTbqqNWJWjPlSxAqgaB3E9X5a7z
         Pj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCm34UwSiJcb5oaPBnMUE0eqe0OtG0awmdQl3ZkIFQHWCuTcA/fqsry3XOI9GTkpAGUta4Glzq3UObGMJN@vger.kernel.org, AJvYcCUWEUBWdTJCKfOkAhJrvafms9hfAmRTYwSL/xh1ODI8qKaEpdARK3zKl1rWri10qP71WzM6I3HGuUt69No=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThrYpbG9M6DB/B1K4NvpU1kjHRhfzJk1nMgWJPvWPQj5H92wM
	xUo4A9mD7DkBP/dR9LTqKwgg+4TCXyc3vHN9+k5mfFFUouKB2BukAN4k
X-Gm-Gg: ASbGncukvKQTh4RTVcXlVUGPgO8ZxIskbZptdqAtRe+9FFBErdj6wEuViRtngJGXQPd
	fN49W2xR7A4oBvtmJnrWrywELaEH1uDYoZ2+yWe2zw/LoxqZWGgYnBAD7nfIW9Xf9A+PXfm/KnE
	zvurhAKlwA21G9yC/0ww3MDhfPLWRSk2rUpFhkRUxXz3dP+6F4igeKRrxH6TFGI9d9HkCnl2K4v
	f8KQLKvmdFXtpfqVXevTirUmy8jqvT2SuEFYiZ7y+SPc0/GqcYMn2fST6A6sfUkjgBvSGRtCDtu
	0kBpOEIUphiroRbRBcWN4x6URztCy1+IG/vSY2EewYSFF9iplJFbIjVmWrOaE77TVobVWyU7YXM
	OmrOj/8XCM2LZl7xlJvCaFK/quGUJuQobBj2wWUBHRJoxHwB59f8ABDrPar7fORylrMc57MGrGG
	OBeqt5J4XS8T1Jtrz5P62xuHP4yPed+RlK55jZaqS00ooGrPHUZb8DQMnm
X-Google-Smtp-Source: AGHT+IHhfqov5J5/cpzmqY6Y2xL2af4c9MM6Q4X67R+acnF53o3WvCLTbsPzluFzQjt4kJ8MhOfkcw==
X-Received: by 2002:a17:907:7f0b:b0:ade:44f8:569 with SMTP id a640c23a62f3a-afe29548f56mr209435166b.42.1755855777271;
        Fri, 22 Aug 2025 02:42:57 -0700 (PDT)
Received: from ?IPV6:2a02:908:1b0:afe0:2cf9:d2f0:ffe6:6e52? ([2a02:908:1b0:afe0:2cf9:d2f0:ffe6:6e52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf6ff14f8sm489424166b.67.2025.08.22.02.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:42:56 -0700 (PDT)
Message-ID: <6503f380-1566-4efc-913d-125d316787d1@gmail.com>
Date: Fri, 22 Aug 2025 11:42:55 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250_core: fix coding style issue
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, mingo@kernel.org,
 john.ogness@linutronix.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20250822082311.16501-1-osama.abdelkader@gmail.com>
 <2025082235-wriggly-wildcat-0477@gregkh>
Content-Language: en-US
From: Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <2025082235-wriggly-wildcat-0477@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/22/25 10:45 AM, Greg KH wrote:
> On Fri, Aug 22, 2025 at 10:23:10AM +0200, Osama Abdelkader wrote:
>> Fix a coding style issue in 8250_core.c:
>>
>> - Remove redundant NULL initialization of a global pointer
>>
>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>> ---
>>  drivers/tty/serial/8250/8250_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index feb920c5b2e8..225bb7e4b89c 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -307,7 +307,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
>>  		serial_unlink_irq_chain(up);
>>  }
>>  
>> -const struct uart_ops *univ8250_port_base_ops = NULL;
>> +const struct uart_ops *univ8250_port_base_ops;
>>  struct uart_ops univ8250_port_ops;
>>  
>>  static const struct uart_8250_ops univ8250_driver_ops = {
>> -- 
>> 2.43.0
>>
>>
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

Hi All,

I forgot to include the changelog in v2.

v2:

- Dropped extra blank line after gpios declaration

Thanks,

Osama


