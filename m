Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F71BDC3
	for <linux-serial@vger.kernel.org>; Mon, 14 Oct 2024 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728870427; cv=none; b=R02Owm+I/7/UQqxVV7a+HUifFJrwZbQWO6R1JDJ82NEyvtN1zgm3VO6pvggLA8bsxIAPCWp8PzKGI+RCUj22MjS8EKEh4fb8RwjlWM0DgPp+GqU3kDYXK63mkGuIfHP306yOI9oONk/KlDu5sALvFxw/3VnJKXRR9L9Q33UpOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728870427; c=relaxed/simple;
	bh=JSfvwKIqnl+5htU8d2GoX5/1b5lotPN/oeBFl9YMlZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBcaYuFbykrHW9J9NumUrhIxM7BuvwZUQQZ8L36ktBqxZFYjbWJnZ99bFhBuc7wCb/DcuIfn85HPxK69/ZjJe1jKnfSlMdAuVr3xSq/Aj3X5NllyDfI+5HCi1kIYwSB0WAwnaliMEPNtlZQepHG4rWLrbVA121WQCxB8xJcd4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u5mXinRW; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u5mXinRW"
Message-ID: <3aee5864-2e2b-4ce4-b814-6864deaa9d79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728870422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tM8TI4bsix+LFRik3NsQFzT3wxVSJoWfzVXZb+AB7ak=;
	b=u5mXinRWNNEvAsJ4dOe6YgQMQsoTt39YuXkkQu0f+xq8OBF27gI+VOg37risHmPpDfqaGI
	FWmGLn083Hgvtxl/znhDt1/Rh6pXTfSnlzv2VxMQ3GQ5OrK1QPxLmEQwdzh4qoCU+cC6zT
	eQznQB3uKiogPdrJgzmG4l53C38Iw8w=
Date: Mon, 14 Oct 2024 09:46:46 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] serial: clean up uart_info
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Yanteng Si <siyanteng@cqsoftware.com.cn>, linux@armlinux.org.uk,
 jirislaby@kernel.org, alan@linux.intel.com, bartosz.golaszewski@linaro.org,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de,
 u.kleine-koenig@pengutronix.de, mengdewei@cqsoftware.com.cn,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240920053423.1373354-1-siyanteng@cqsoftware.com.cn>
 <6b5d548b-82ab-4bf3-90da-173928968fb9@linux.dev>
 <2024101206-stench-eraser-e479@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <2024101206-stench-eraser-e479@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/10/12 15:57, Greg KH 写道:
> On Sat, Oct 12, 2024 at 11:10:05AM +0800, Yanteng Si wrote:
>> Hi all,
>>
>>
>> 在 2024/9/20 13:34, Yanteng Si 写道:
>>> Since commit ebd2c8f6d2ec ("serial: kill off uart_info") has
>>> removed uart_info, the uart_info declaration looks lonely,
>>> let it go.
>> Could someone pick up my patch? Or give me some hints on what else I need to
>> do?
> I picked it up yesterday, you should have gotten an email for it, it is
> commit 483c5c2bc6b1 ("serial: clean up uart_info") in my tree.  Do you
> not see it there?
Oh yeah! I've already seen this email!

Sorry, I forgot that my patch was generated during working hours,
so I used my company email. My company email has received your
email. Thank you!

Thanks,
Yanteng
>
> thanks,
>
> greg k-h

