Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52F529419
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868361; cv=none; b=iEnfHsqlsiT3kYpLvVlIztTeWhOCqscepsGqoyzY3quOIPzNBssFGZy78ciV/iCQei4WWpFDdcoq6QtHBduuLvZmNxpq6em8fkfEyKPfnlHzIhN0TaGAUG+WHEbuHqRkZsbOqDViNsMV/8rk/j9thXEW9PMYry6iRR1sF8Zxhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868361; c=relaxed/simple;
	bh=u2f5BkksbAx4MYFZJiRaIDTf2BUWlDOCLBiJhegy/0s=;
	h=Cc:Message-Id:References:To:Subject:Mime-Version:In-Reply-To:From:
	 Content-Type:Date; b=hIFV6DLD+v0ytVN02d8tqAdiuCCnFbhRSV2b6jdx2NRR828r+S/xxP47sWm/B0I5IYRBQfouGsmOO0Sut/sMxWsCwC/eF+SZbw7YXatM828oM3WBAduKpF8zwhSNXTPOFO5y1XrNfjU4KyOvPX8UgjJ5YKL7IUtrvaXXpjl3KOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=oAciaalE; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="oAciaalE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1788868349; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5hRKRFStZ3kEtkRaRC1rzuo8LqIY953LY/PKVlQqvE4=;
 b=oAciaalEffb71uX+sg5z6f5jDzSnbPFD1iEG6YmhvELBnkAhD9zucbEXXW7f2phztods6/
 H4oWdhu5xCwTjC95HICwkCev0swo+nzQI+8ALxnO6SVISEowtVH+4X+NRWYJM8zSi0YEdi
 yKxuoiM9D3QI3aktg8St0JxXCHjGkEKfIbX1xJkTUr/PA6jSow/cv4fX1bUD3DBO0r7YAH
 n0zBcVdPh+6QhRrxtZSdS0LPdFcj7bd3ApjJ2HHxTpYju+DcSdF7U/4WArMd5QwInMT7wX
 URvAGrxKE1RgzqXB2WQhm8MkVXe0q+x65pGtsz58rxfnbf2lTvxd27/4nPjQNg==
Content-Transfer-Encoding: 7bit
Cc: <yang.yicong@picoheart.com>, <ilpo.jarvinen@linux.intel.com>, 
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, 
	<geshijian@picoheart.com>, <yangyang.8776@picoheart.com>, 
	<yanligen@picoheart.com>
Message-Id: <37481c9a-fc5f-49d8-8f66-c07da703ba89@picoheart.com>
References: <20260907074035.77796-1-yang.yicong@picoheart.com> <ap_ik82SVnEGkBPU@ashevche-desk.local>
Content-Language: en-US
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <ap_ik82SVnEGkBPU@ashevche-desk.local>
Received: from [100.86.221.254] ([120.234.91.245]) by smtp.feishu.cn with ESMTPS; Tue, 08 Sep 2026 19:52:26 +0800
X-Lms-Return-Path: <lba+26a9ff6fb+916b45+vger.kernel.org+yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 8 Sep 2026 19:52:24 +0800

On 9/8/26 6:25 PM, Andy Shevchenko wrote:
> On Mon, Sep 07, 2026 at 03:40:35PM +0800, Yicong Yang wrote:
>> The DW uart could get into the cases where a bogus RX timeout
>> interrupt is asserted but no available data. This could be
>> workaround by doing a bogus read.
>>
>> Currently the driver's using the standard RBR (receive buffer
>> register) for this bogus read. However the reading of RBR
>> in this case is allowed to raise a hardware error if vendor
>> choose to implement in this way (our platform). It's also
>> allowed to do the bogus read using SRBR (shadow RBR) for
>> workaround which won't raise the hardware error. So change
>> to use the SRBR to workaround the issue if it's available.
> 
> ...
> 
>> struct dw8250_port_data {
> 
>>  
>>  	/* RS485 variables */
>>  	bool			hw_rs485_support;
>>
>> +	/* Shadow RBR offset, fallback to RBR if no shadow register support */
> 
> This comment is for "section", so split it to two
> 

sure, will split.

> 	/* Register offsets */
> 	/* Shadow RBR (if not defined RBR will be used) */
> 
>> +	unsigned int		srbr;
> 
> In APIs this defined as int, I would follow (however I agree that ideally in
> all of them it should be unsigned).
> 
> 	int		srbr;

will make it int. I remembered that I referred to
uart_port::serial_{in, out}() that use unsigned int
for offset, but yes serial_port_{in, out}() use int.

will update in v3.

Thanks.
