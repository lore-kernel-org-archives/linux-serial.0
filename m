Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113C30C35C;
	Fri, 29 May 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044774; cv=none; b=lDqZ4twGxaLpOeQowakV7Eo6xxRPX5u7qeUXTGlKqN5HxQTdjNNcrqgGfGJoc2xoQFLoGvqeQBYyN8LEJ8RqJ97TMqP5k/21T4nqRpNqL3kS97CVt34ShhSPqbA+DpMUk6DkVnL/EA/hr9G300GxmiA4IHjxiDhd41qfjk0bVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044774; c=relaxed/simple;
	bh=Kj8zAitcPURDltALQzQxQhN6dh13HzIzjAaniOlbUUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L77UDKrLRWK9ZPZ8nb5iOHySpujmoUEOWh29lyYdgeYqgduEapKJGTe7+qWWVdwEZV6Z8Y1dzRxyqc4GEseeYQTSy0uJ9FZpvB9Gin7B+EbYrlqlK7T1K28aio1F8+aPkpTZvaIBOYAIkK+OnrAViOLqlbHqJGXacvja2Ik2KX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kly1uSR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kly1uSR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2B61F00893;
	Fri, 29 May 2026 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044773;
	bh=bwfWO5ylsSIxckFIR6JvOs3hi0LSk9IH+1TJ7RISKWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kly1uSR1H7SUbGt+pgv1Du70uRlv9LbWIZlTPKTyZbdCZ9nDIli84ih+5Mv4c+jsE
	 8c9m5PwrcPCTpzCrmeT/YzD3dBYPjIN+hiY0DBulWa9uqcxr1chJPtPkEoIxrl2UaH
	 nIZmLZU8boYKEwogyUeSu3rj+QRlq4KP5q+kVpLJdntJYg2rr/8d0Dddj0wjvOZwKF
	 ytGTr/oFMLyvcL6uKxVlc7I+MkwDV4c6NbaNiGlSeWmpqASTC+1Y/6lyA9IhczaKuW
	 dHVo/6j10Rv2fsOD2Ad1MHCSWpPIkMirRkQlIT/Pb9xQQVhABfPuKAyh8KhzNuDWyu
	 XbrL6H11zlYFQ==
Message-ID: <98ebf7d1-244f-4fbc-afc4-3e8940df5422@kernel.org>
Date: Fri, 29 May 2026 10:52:49 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tty: serial: men_z135_uart: replace __get_free_page()
 with kmalloc()
To: Mike Rapoport <rppt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-serial@vger.kernel.org
References: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
 <20260528-b4-tty-v1-3-9da9f7aec5f2@kernel.org>
 <18bb4a45-c26b-4a89-b598-a844d3aadafa@kernel.org>
 <ahlRqd3e94ojSfWE@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ahlRqd3e94ojSfWE@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29. 05. 26, 10:43, Mike Rapoport wrote:
> On Fri, May 29, 2026 at 09:47:33AM +0200, Jiri Slaby wrote:
>> On 28. 05. 26, 12:24, Mike Rapoport (Microsoft) wrote:
>>> men_z135_probe() allocates a receive staging buffer filled by the
>>> CPU via memcpy_fromio() from the device MMIO region.
>>>
>>> This buffer can be allocated with kmalloc() as there's nothing special
>>> about it to go directly to the page allocator.
>>>
>>> kmalloc() provides a better API that does not require ugly casts and
>>> kfree() does not need to know the size of the freed object.
>>>
>>> Replace use of __get_free_page() with kmalloc() and free_page() with
>>> kfree().
>>>
>>> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>>    drivers/tty/serial/men_z135_uart.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
>>> index 6fad57fee912..9c32b01edc9e 100644
>>> --- a/drivers/tty/serial/men_z135_uart.c
>>> +++ b/drivers/tty/serial/men_z135_uart.c
>>> @@ -17,6 +17,7 @@
>>>    #include <linux/bitops.h>
>>>    #include <linux/mcb.h>
>>> +#include <linux/slab.h>
>>>    #define MEN_Z135_MAX_PORTS		12
>>
>> This one is misplaced.
> 
> Do you mean an empty line is missing? Or there's particular order of
> includes here?

You added it after an empty line -- along to #defines. You should had 
added it along #includes instead -- before the empty line.

>> thanks,
>> -- 
>> js
>> suse labs
> 


-- 
js
suse labs
