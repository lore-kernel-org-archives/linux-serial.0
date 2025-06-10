Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1925DCFF;
	Tue, 10 Jun 2025 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749529694; cv=none; b=BGKqgYYjxhbKlKPalBs4wPmx+tXBsXUj3n4DtMMkY6JxfBxWVbjBViJl6DUdoLBju8sf3BKOLapK0jCkG+ihxTKOw/2lzNuBwjDsoRJaHarcVinmk5zY/T6rzCldWQa7X8LwJiqqTJPIwnVI0818RGv5xS9sgH8oevxFgV7dIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749529694; c=relaxed/simple;
	bh=YrTFC/H8xLh409xJFtmBzNKgdBYiICUbe3PxWSObngg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR9AUhgy5qL4yYlHbyKxniV9Ul5G+QOfqtGT3NejPV5Ns0yuXeskBHmTEzteUPB0Fz1dWr82k33KJ833TJhbAQ/T2w6PCYmpiM9kOdl4qInpDFJwQ/xHr6okYsCE4xumpUwtQqn6zSGdsGMZ9wIJwF9RuAThUHCBBWSMBWxCJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hD1CpmlY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hD1CpmlY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+pk3LP0Yr8/YCKPcs0XPhWfzyES4W15X9Fzg14oca+g=; b=hD1CpmlY93cubQ3n2l0LR4pOWA
	hC4b/hzlRcnrCiHDCz1Dj8U92Kbrur3mXbqT2FSchSp0WRDzXsHacUihdpYNqKRwbnK+4JAibQPCY
	gp3b/lGXsFmx9/WarkU3uIFdKH/yanzqmsXQmuSy08zEvrQOWI5S6kosHQQSb1Jg4As6znsX2oDnR
	8zmRdNyDnE+UjDPLt8x9AIjGOUdSSpywOw4KC4/8ml8+uk/ZyBYce5URb6/ux1X/Gi6fcKWI39KWe
	47et64J3ZzvkaySmklOMArNTuMpSaexQDexNf09fdtKBex6gub/3yZc+VXNAWGvAbOGwIs0QjTsAf
	R5VvW+Kw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqan-00000001jLv-3Isz;
	Tue, 10 Jun 2025 04:28:10 +0000
Message-ID: <09848df8-f6f3-4e48-a7a7-3a65868ce8a2@infradead.org>
Date: Mon, 9 Jun 2025 21:28:06 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vt: fix kernel-doc warnings in ucs_get_fallback()
To: Nicolas Pitre <npitre@baylibre.com>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
References: <20250610000251.282760-1-rdunlap@infradead.org>
 <6rr665sp-3q45-66q8-snso-5071q34q71pr@onlyvoer.pbz>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6rr665sp-3q45-66q8-snso-5071q34q71pr@onlyvoer.pbz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/25 7:19 PM, Nicolas Pitre wrote:
> On Mon, 9 Jun 2025, Randy Dunlap wrote:
> 
>> Use the correct function parameter name in ucs_get_fallback() to prevent
>> kernel-doc warnings:
>>
>> Warning: drivers/tty/vt/ucs.c:218 function parameter 'cp' not described in 'ucs_get_fallback'
>> Warning: drivers/tty/vt/ucs.c:218 Excess function parameter 'base' description in 'ucs_get_fallback'
>>
>> Fixes: fe26933cf1e1 ("vt: add ucs_get_fallback()")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Nicolas Pitre <npitre@baylibre.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: linux-serial@vger.kernel.org
>> ---
>> v2: add Jiri and linux-serial. Mea culpa.
>>
>>  drivers/tty/vt/ucs.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-616-rc1.orig/drivers/tty/vt/ucs.c
>> +++ lnx-616-rc1/drivers/tty/vt/ucs.c
>> @@ -206,7 +206,7 @@ static int ucs_page_entry_cmp(const void
>>  
>>  /**
>>   * ucs_get_fallback() - Get a substitution for the provided Unicode character
>> - * @base: Base Unicode code point (UCS-4)
>> + * @cp: Base Unicode code point (UCS-4)
> 
> Please delete the "Base" word from the definition as well.
> Then you can add Reviewed-by: Nicolas Pitre <npitre@baylibre.com>.

Sure, will do.
Thanks.

> 
>>   *
>>   * Get a simpler fallback character for the provided Unicode character.
>>   * This is used for terminal display when corresponding glyph is unavailable.
>>

-- 
~Randy

