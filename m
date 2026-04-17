Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD77356A37
	for <linux-serial@vger.kernel.org>; Fri, 17 Apr 2026 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776398447; cv=none; b=put9DyP3ZwjzYsWNas84OEuIpJhN1y0P22dN3MBuH6tS8jEyYV8Fw6o0HYV3ORa/e1lBgPJ926YspFndtqTKwdKdzNyWVQSGiPj8DGl6DDkyaUv/Myg68QqVxqncviefGHJBhY03QRFH+OxVp119QpXcx409380/6jXlKm8jOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776398447; c=relaxed/simple;
	bh=iw9rQlFZBwFdFEP5r95oKXAl4WoTy/IYZLAToCZ2MvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxtss1KBZcewbCs5IRTkP1oma10taPUGEgmQlelQ2r7jIuvHEvB07c+LV+xDzRaFWrr3FqCDbAwYKzbnb7L7RD+t7GQS16jT2zP/Zx9sjxor0rTe6S0AazY6v8edSwNWeso8Sdill8i0eeb6R44PQrGImh++F5G1MuT9Kt+iZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GK6xkBEo; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GK6xkBEo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776398434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qny/q3FG3lrUcEpWO8RN4b+jSyeAwmomOwlY9tquCTE=;
	b=GK6xkBEoIa555G4AoQgXgtsJLj3hQaMOi7ttu5UhYvjwhGaJVukmRvmFxUv/TBSK2un5Ba
	2Flz6aJsyBdhzP21ZO3DLw/FES/VJG6Nh1+nEmBlg318usnhkG3NTsXAxosoVpxh4HlAIC
	9QwKa4DI9fk34X4EzP6LUXgGCmKZKq0=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: andy.shevchenko@gmail.com
Cc: fushuai.wang@linux.dev,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	osama.abdelkader@gmail.com,
	wangfushuai@baidu.com
Subject: Re: [PATCH] serial: 8250: Clear CON_PRINTBUFFER on port re-registration 
Date: Fri, 17 Apr 2026 12:00:17 +0800
Message-Id: <20260417040017.63474-1-fushuai.wang@linux.dev>
In-Reply-To: <CAHp75VfyArBYG6p17A__hASERs6-rAp9U_NV68u5OOCUU_qoxA@mail.gmail.com>
References: <CAHp75VfyArBYG6p17A__hASERs6-rAp9U_NV68u5OOCUU_qoxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>> ...
>> When BIOS "Serial Device" option is set to BMC, both 00:04 and 00:05 are mapped to
>> the same physical I/O port 0x3f8. And then:
>>
>>   1.00:04 is probed first and registers the console for port 0x3f8
>>   2.00:05 is detected and also needs to use port 0x3f8
>
> This is simply wrong. Do we ever support such a FW configuration?
> Why on earth are there two devices for the same resource exposed to
> the OS? It smells like a bug in BIOS.

My BIOS has this configuration option, and I also found other vendors'
BIOS with the same option, e.g.:

	https://download.msi.com/archive/mnu_exe/server/S3066-S377-v1.1-BIOS-UG.pdf

	Serial Device [BMC]/[S3M] Sets the Serial Device used to output bios serial log

Also, the kernel's serial8250_register_8250_port() already 
handles the case where multiple devices map to the same physical 
port. When serial8250_find_match_or_unused() detects that 
a device with the same port already exists, the caller 
(serial8250_register_8250_port()) removes the existing 
port before registering the new one.

Since the kernel already supports this remove-re-add process, I
think it makes sense to fix the CON_PRINTBUFFER issue to handle
this scenario, rather than relying on BIOS to avoid such configurations.

-- 
Regards,
WANG
