Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12493214
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705646168; cv=none; b=LxJDkw8q3dY+LV1VJAYtCP2NMq5JKmM1sDt0L+pmQbdZcmv3uKG140CpwNSR4tq5BS5PylDwJwO4EgXtjU1FgM/H3pqnMJOguuDjD+kAG+LV1PxV53eppWvRPG1zxEWbwZGjLoP3GiWEPVGBUJ4xBhOHZ+ZGyUl34XdOlW4G+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705646168; c=relaxed/simple;
	bh=Zd5Xc2uDzrdbQG4AtYst0v1O0RC1oNJOsKmM5zrlw8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJ7bQry+9KC9lBHC7vay5e+b4fNdoSBp9X2eNvogZtj7YomqOHGNUMUvGQLaLDlyjQJva8TcjV6Ot1diP/cVVGFBkL8Pe3Q1eyHtWjxomMVl7yutgjFteDQwqEpw7XRlL59ZDNadAhuat7HY2Ypv3+bOiGeRGNqJ3z0ershDvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e76626170so4672985e9.2
        for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 22:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705646165; x=1706250965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuWdfukhg7EltTT6nCLqp1txpQyeYsuPDBgt7kTU+X4=;
        b=NJVd9nX5eVsRGEoqhWTUE9s7OadOlBxqsgA9uIjpdDUlzI/tEJx6DtupYr/9svQAhY
         XqRn7EEc7WeTFVhK+DMFdC9nz0GPVIJ8IrGO4SJd3OlUfX7plCAz6kxiO6fZ9sJaxYGn
         voN5VTo8us+oAnazcMez3aN3ZhthCHfPAGN8BaGlUS2GvXkKVcw2drRtVTJu4RSX7+nU
         h/apQU/U7eeIM0NbljmK/lT1Z+5ylKPO8iZ9lIzLxp1DZI9Y1bMDeqiFOrDcLjHXvDNC
         iWWHB5b2QkvVYhyMxwfipeN47vKdaMx3puKumT9OUmA3AEk6cSezwugKPKmzEI+iIOKB
         962Q==
X-Gm-Message-State: AOJu0YwXAkD7rPyZ3dJ4rHcBVHy5wsK8V1n7YLMh7ox0Gub5McD2JUST
	XR9qXVz6hj+4eaaqrqmxOAKu/HjJu5DOg6RB37KEGha5kpsArwis
X-Google-Smtp-Source: AGHT+IEGBslw+28kwlM4hzrs3xjObh45QqwGzjaO5G93GAb0Kg/k4W3np8wSSzjg4YKrMPfufOyTog==
X-Received: by 2002:a5d:6481:0:b0:337:bafb:ce56 with SMTP id o1-20020a5d6481000000b00337bafbce56mr1490357wri.138.1705646164950;
        Thu, 18 Jan 2024 22:36:04 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id x5-20020adfffc5000000b0033672cfca96sm5696313wrs.89.2024.01.18.22.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 22:36:04 -0800 (PST)
Message-ID: <9cce131b-6f1e-4cb7-9149-5ac8bd3c01da@kernel.org>
Date: Fri, 19 Jan 2024 07:36:03 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] tty: serial: Fix bit order in RS485 flag definitions
Content-Language: en-US
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Crescent CY Hsieh <crescentcy.hsieh@moxa.com>, Lukas Wunner
 <lukas@wunner.de>, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Hugo Villeneuve <hugo@hugovil.com>
References: <20240118154624.5340-1-cniedermaier@dh-electronics.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240118154624.5340-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 01. 24, 16:46, Christoph Niedermaier wrote:
> Since the commit 93f3350c46fa ("RS485: fix inconsistencies in the
> meaning of some variables"), the definition for bit 3 has been removed.
> But with the switch to bit shift macros in commit 76ac8e29855b ("tty:
> serial: Cleanup the bit shift with macro"), this gap wasn't preserved.
> To avoid a break in user/kernel api of the system skip bit 3 again and
> add a placeholder comment.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Fixes: 76ac8e29855b ("tty: serial: Cleanup the bit shift with macro")
> Fixes: 6056f20f27e9 ("tty: serial: Add RS422 flag to struct serial_rs485")
> ---

This triple dash is superfluous and will likely break git am.

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Cc: Hugo Villeneuve <hugo@hugovil.com>
> To: linux-serial@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org

"To" is not supported here, IMO.

When you fix that:
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> V2: - Fix typo
>      - Add Fixes tags
> ---
>   include/uapi/linux/serial.h | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 9086367db043..de9b4733607e 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -145,12 +145,13 @@ struct serial_rs485 {
>   #define SER_RS485_ENABLED		_BITUL(0)
>   #define SER_RS485_RTS_ON_SEND		_BITUL(1)
>   #define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> -#define SER_RS485_RX_DURING_TX		_BITUL(3)
> -#define SER_RS485_TERMINATE_BUS		_BITUL(4)
> -#define SER_RS485_ADDRB			_BITUL(5)
> -#define SER_RS485_ADDR_RECV		_BITUL(6)
> -#define SER_RS485_ADDR_DEST		_BITUL(7)
> -#define SER_RS485_MODE_RS422		_BITUL(8)
> +/* Placeholder for bit 3: SER_RS485_RTS_BEFORE_SEND, which isn't used anymore */
> +#define SER_RS485_RX_DURING_TX		_BITUL(4)
> +#define SER_RS485_TERMINATE_BUS		_BITUL(5)
> +#define SER_RS485_ADDRB			_BITUL(6)
> +#define SER_RS485_ADDR_RECV		_BITUL(7)
> +#define SER_RS485_ADDR_DEST		_BITUL(8)
> +#define SER_RS485_MODE_RS422		_BITUL(9)
>   
>   	__u32	delay_rts_before_send;
>   	__u32	delay_rts_after_send;

-- 
js
suse labs

