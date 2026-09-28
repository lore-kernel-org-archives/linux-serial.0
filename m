Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3A3644DE;
	Mon, 28 Sep 2026 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578279; cv=none; b=SkrgAXSSMGRYhzIu7gx0Fvk5w5OPvx20w1IYSGh8ZMnD6k40EulkNAmUJhfwcXlMLSyGsCJ1NrghfoRUhojU1Eg9wAhMZv/5CmdhTWRpWbs18izLcq34tBs+kcsgoXWa0WZfpDeE6cBRuxlxb3AeuKQKe0FAzkIcQINH6R3I68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578279; c=relaxed/simple;
	bh=vdhUNmVV0tAGz5Sa/G9YfcZcTTk9SfHwyuBGytisO88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pk1/KJQUQqR0UhRfoLbxUJ6XVFS+XHPIA346jXl6RDTiizZje7Kl7CQvq8higkKHoFi7hENQecxjn7FOoQRgfe6y13p2ZOGlVO0rD4wn7fXxzpLNqtPN5oayKrg9Q1gAKAcbsengZUyT96JTUPG6lbAcRyQt6atpwpEUTcDCAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Sep 2026 15:51:09 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 3ED5620914A4;
	Mon, 28 Sep 2026 15:51:09 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 28 Sep 2026 15:51:09 +0900
Received: from [10.213.138.107] (unknown [10.213.138.107])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id E9B2310A019;
	Mon, 28 Sep 2026 15:51:08 +0900 (JST)
Message-ID: <faa1027c-7279-462a-9c6f-f03354b9cfd3@socionext.com>
Date: Mon, 28 Sep 2026 15:51:09 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Malathi A <malathi.a2000@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260917040511.103232-1-malathi.a2000@gmail.com>
 <97e4ab26-b147-4cf4-97f9-307903f14e61@socionext.com>
 <arUvJyvChXXcasSu@ashevche-desk.local>
 <3ea1f574-ddb5-46a6-9bc1-7a8ea84c54bd@socionext.com>
 <arZ5KxIp55qA6UA7@ashevche-desk.local>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <arZ5KxIp55qA6UA7@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/09/25 22:37, Andy Shevchenko wrote:
> On Fri, Sep 25, 2026 at 08:32:20PM +0900, Kunihiko Hayashi wrote:
>> On 2026/09/24 23:09, Andy Shevchenko wrote:
>>> On Thu, Sep 24, 2026 at 06:07:37PM +0900, Kunihiko Hayashi wrote:
>>>> On 2026/09/17 13:05, Malathi A wrote:
> 
> ...
> 
>>>> I'm a bit concerned about the error path in uniphier_uart_resume().
>>>> The clock may have been disabled in uniphier_uart_suspend(), and
>>>> clk_prepare_enable() can fail when trying to enable it again.
>>>>
>>>> In that case, wouldn't devres try to disable an already disabled
>>>> clock on detach?
>>>
>>> Isn't there is a guarantee that the .remove() is called with PM
> runtime on
> 
> After reading a code of driver core I see that this is the opposite
> actually.
> The PM runtime might be off.
> 
>>> and get, meaning it's called with the enabled clock? But if not the
> case,
>>> we might use PM runtime force operations (resume and suspend in the
>>> respective cases.
>>
>> My concern was just the case where clk_prepare_enable() in the system
>> resume callback fails, leaving the clock disabled before devres cleanup.
>>
>> This driver currently only uses SET_SYSTEM_SLEEP_PM_OPS(), so I wasn't
>> considering runtime PM here.
> 
> So, in such a case how do you see the scenario when system is resumed
> (Right?
> Otherwise we can't do anything, like detaching driver from the device.)
> and
> clock is disabled?

Ah, I understand your point. I was assuming that the driver could later
be detached after uniphier_uart_resume() failed, leaving the clock disabled.

If that sequence cannot happen after a failed system resume, then my concern
doesn't apply. Thanks for pointing this out.

In that case, I have no further concerns about the use of
devm_clk_get_enabled() here.

Thank you,

---
Best Regards
Kunihiko Hayashi
