Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F0314A92
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232458; cv=none; b=byy/jBNKknPEgAnTZosK2z+SS0gTNmrHxpr8B4zv8f8hZpuAzE3wt+oFIauW2d9r2N8FlaFCajQGmrv04aJjRKeuCgag66tyj0nv92RmnmdDxUzRkgQPo1q4KH40sg6l3nwzhemQ3omXlgVjDmETGTJ65mipia6dYuROtsreR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232458; c=relaxed/simple;
	bh=dq+iJljyvmRgmfSSIdpM80pUbzt7H4p00O59CLAHX3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWFRRiQkJfMytvOKf/4NpZm2DoimILL0PsyDsK1E9uXsqnzeNpvG8bZN/8lKIgcWS5tjAXcs68gvzbFX1E9MEd9DP0cQx7jhMYGxdBMD8dOwnVQfLfN8Mye2ZIsomJOPeYPRY/TH0h0umXND7T0KcIzxW1YG5gBt0lIWt+ZRIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=j1W8PNwP; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="j1W8PNwP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XL+Lu1rwlcAej3FwD3sbEWg20w4vlxnmEZUS9/cRl0Y=; b=j1W8PNwPzhBWE526eLNKDqBuDP
	D+mmE27v6V+4B7KyvaKg7YCmlOykVtsuYwCHM2QYko0w9tTDi8hbNlrIIdIq0oK8rFOsuFEdcW6pf
	zT/k1do0PDjckv5Ta58Nf2c85eh3gHg9KX8bJ4ARD16X82Bsta7H/Kf9GV68qMBZf8Q0=;
Received: from [188.22.5.236] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vBx13-000000006NQ-0Pfy;
	Thu, 23 Oct 2025 17:14:14 +0200
Message-ID: <8abb4ae0-df0b-4fba-843f-cf89a270aa5b@engleder-embedded.com>
Date: Thu, 23 Oct 2025 17:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] serial: 8250: add driver for KEBA UART
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>,
 Daniel Gierlinger <gida@keba.com>
References: <20251020190658.30655-1-gerhard@engleder-embedded.com>
 <20251020190658.30655-3-gerhard@engleder-embedded.com>
 <aPmLONW5q55Yta3N@wunner.de>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aPmLONW5q55Yta3N@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 23.10.25 03:56, Lukas Wunner wrote:
> On Mon, Oct 20, 2025 at 09:06:58PM +0200, Gerhard Engleder wrote:
>> +++ b/drivers/tty/serial/8250/8250_keba.c
>> @@ -0,0 +1,281 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2025 KEBA Industrial Automation GmbH
>> + *
>> + * Driver for KEBA UART FPGA IP core
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/misc/keba.h>
> 
> Duplicate inclusion of <linux/module.h>.
> 
> Usually these are sorted alphabetically.

Cleaned up and ordered. Thanks!

Gerhard
