Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4A2405E1
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401391; cv=none; b=eBlyMn142HltjvlghRORttyimMEswa8OKLOTIrjHNyo8i6MeE3hyiaN7AdLXA54Qxf9G5mDpTLWrJDohP4A4cKb05cGNte1a6metHpe/WZqgagsVnWFHwMYTgwESUNnQntSlAwWZ81KVyMuwbeGror0THsWTidzod/AEfL6pRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401391; c=relaxed/simple;
	bh=75ALPUSAd5QZjZ01fgv1SPQ4/Rl1o9oSpNEVjUjmPXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tS0q3dKXmLE2roQ0pBRAzoSszfTa0QmTo3b6c+xTGPwb/UqO/VQxL3L7wtctjnja6VGTprgKAhFfnoOQLo42JEHuG2EIDPGerK8hZsTwIWwH9RtF1OmDxq4g6KpkbbtY2TL07kF2BIwNv6CBrnaulGVHtqDlEFaesF0sTYOzAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tvcBGyTK; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tvcBGyTK"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251222110307euoutp01762fca5da888c3edcb96ff40ed4e3bcf~DhLP2mvuW3105831058euoutp01E
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 11:03:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251222110307euoutp01762fca5da888c3edcb96ff40ed4e3bcf~DhLP2mvuW3105831058euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766401387;
	bh=Ae7a5EVJ0WH8ZlNljQPpqxA+lrytR/XWv8DK7rWJRIY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tvcBGyTKcj/cVu9RHc6xCh+mRdhodiD4wsEQTsODrTovN3RD5HV9nKFF2LcTnawix
	 X1dVfjH9++6cZfrMSYzPNrEbDfh49jkARoDxLriJBPC2o3K1NZd5v8KYOy4BWYQHtZ
	 nF8DVmzJNi9TZrSWgUYhClzx4l9Sloo0gHBP7gII=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251222110307eucas1p170af604487b34afb50cac08624f57037~DhLPmbad52250422504eucas1p1-;
	Mon, 22 Dec 2025 11:03:07 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251222110306eusmtip2eb653036492a0a33f4e189369ce0c94e~DhLPQDIhT2499924999eusmtip2T;
	Mon, 22 Dec 2025 11:03:06 +0000 (GMT)
Message-ID: <5bc92b17-75db-4cac-a049-2b6aeba4bf3c@samsung.com>
Date: Mon, 22 Dec 2025 12:03:06 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/1] serial: core: Fix serial device initialization
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Stein
	<alexander.stein@ew.tq-group.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Cosmin Tanislav <demonsingur@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <2025122151-petition-joylessly-bdc5@gregkh>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251222110307eucas1p170af604487b34afb50cac08624f57037
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251222110307eucas1p170af604487b34afb50cac08624f57037
X-EPHeader: CA
X-CMS-RootMailID: 20251222110307eucas1p170af604487b34afb50cac08624f57037
References: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
	<2025122151-petition-joylessly-bdc5@gregkh>
	<CGME20251222110307eucas1p170af604487b34afb50cac08624f57037@eucas1p1.samsung.com>

On 21.12.2025 09:40, Greg Kroah-Hartman wrote:
> On Fri, Dec 19, 2025 at 04:28:12PM +0100, Alexander Stein wrote:
>> During restoring sysfs fwnode information the information of_node_reused
>> was dropped. This was previously set by device_set_of_node_from_dev().
>> Add it back manually
>>
>> Fixes: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
>> Suggested-by: Cosmin Tanislav <demonsingur@gmail.com>
>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>> ---
>>   drivers/tty/serial/serial_base_bus.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
>> index 8e891984cdc0d..1e1ad28d83fcf 100644
>> --- a/drivers/tty/serial/serial_base_bus.c
>> +++ b/drivers/tty/serial/serial_base_bus.c
>> @@ -74,6 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
>>   	dev->parent = parent_dev;
>>   	dev->bus = &serial_base_bus_type;
>>   	dev->release = release;
>> +	dev->of_node_reused = true;
>>   
>>   	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
>>   
>> -- 
>> 2.43.0
>>
>>
> Can I get some confirmation from people that this resolves the issue, or
> should I just revert the original problem commit instead and wait for a
> tested new version?

I came to the same fix in my analysis, see 
https://lore.kernel.org/all/361ad06d-0478-40f9-9894-6f53d7b27eff@samsung.com/ 


This patch fixes the boot break on most of my test systems.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

