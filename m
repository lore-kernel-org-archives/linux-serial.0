Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE636221FC6;
	Sat, 20 Sep 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758358620; cv=none; b=ZUIVX+pKNgKpyIGHWTN3UQfSk/hdJ9pF0KaZCacgDq4MS4GenHXpZ1+zNz0GFlIba83xZrWA3NNVpIukmzIdK6SXLFEMpTYTPCyoWi2Mg4b0gg9H4SlAVLnLm+nE0lIQf4eNJmAc7E1YoLaLKdQZG+IIkZbOYZMt5agq3EuO874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758358620; c=relaxed/simple;
	bh=ZrCnW8J2sJBMWqEmPffenmgJiU20qJrMUSM/2Tm9sRw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=sMlOcDywr9x/6h40BFOv8hh9caRZ+nz3vvamnpxQR+svYPgRp0NTA55WCXLWbE1dpqfQhlSLyCHxIfIj5P4VcywaCv/ZJ4/bgS56BGPubQdqXmMWqmG3OMV/I1Y80JyZSH3rqaobANVQlQptNVH5hZEakKzyNONVyCLdp92CVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.103] (213.87.157.150) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 20 Sep
 2025 11:56:29 +0300
Message-ID: <4be800b2-1c2b-4803-9cac-f3d0928a5975@omp.ru>
Date: Sat, 20 Sep 2025 11:56:29 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_mtk: correct max baud rate in the
 set_termios() method
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <bd8764c5-c43c-4bca-996d-65367805ad5a@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <bd8764c5-c43c-4bca-996d-65367805ad5a@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/20/2025 08:43:34
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 196453 [Sep 19 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 67 0.3.67
 f6b3a124585516de4e61e2bf9df040d8947a2fd5
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {Tracking_spam_in_reply_from_match_msgid}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.157.150 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.157.150
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/20/2025 08:45:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/20/2025 6:43:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/5/25 11:07 PM, Sergey Shtylyov wrote:

> As is obvious from the code calculating the divisor in the set_termios()
> method, the Mediatek UART driver uses 256-time oversampling for the high
> baud rates, so passing port->uartclk to uart_get_baud_rate() for the max
> acceptable baud rate makes no sense, we should divide by 256 first (this

   Well, I thought again and 256 seems to be an overkill, I should probably
have reverted to division by 16 instead...

> should also prevent overflow when some arbitrary baud rate is passed via
> termios->c_ospeed)...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: 81bb549fdf14 ("serial: 8250_mtk: support big baud rate.")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

