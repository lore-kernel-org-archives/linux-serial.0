Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43F2877F1;
	Tue, 14 Oct 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460631; cv=none; b=lOK6igMgRIcfqkvntGjOjxMKjYPMPY1HdkECkER/YBzFg5UIbpIoCmQQi+kttMl+6oQhpSfMnh8oYFICa7xSUVamaTWyYm+ugtsrmlvD6/LYW0Zf+5qH2zgFB7GQOQVRc1OzTo4+i2NimOFeH5pOgzvZioyGtSOQtX55yBzzzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460631; c=relaxed/simple;
	bh=lj4+opJ2lf52x3VatQsYL5KWHmN3jms4mtg4SxdF1pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kp7gZW8fwwovc5E6B88mepQRhjtlYhMU/t+l76zUYjcFZPNJKvH/MGrR7+ON/ENDsKOMYoqNM6KdMQWocYayXm5s03Zcx7DfwkYgix0T2S8bJFxCMElouGT/L/H+5/EpyhqYWZjf8KxDTzg54c2z72JcRQjUaejHBDuLOAMiHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.128.219) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 14 Oct
 2025 19:50:16 +0300
Message-ID: <25e098b2-d786-437c-ad92-eccb90b148f7@omp.ru>
Date: Tue, 14 Oct 2025 19:50:16 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250_mtk: correct max baud rate in
 set_termios() method
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<lvc-project@linuxtesting.org>, Eddie Huang <eddie.huang@mediatek.com>, Long
 Cheng <long.cheng@mediatek.com>
References: <3eb40848-3bec-42ca-845b-c66d4b53cedc@omp.ru>
 <20251014130050-5cdb9e464558d609872d38cc-pchelkin@ispras>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20251014130050-5cdb9e464558d609872d38cc-pchelkin@ispras>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/14/2025 16:35:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197067 [Oct 14 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 71 0.3.71
 ee78c3da48e828d2b9b16d6d0b31328b8b240a3c
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;213.87.128.219:7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_References_header}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.128.219
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/14/2025 16:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/14/2025 3:29:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 10/14/25 1:07 PM, Fedor Pchelkin wrote:

>> Mediatek MT798x datasheets (that I was able to get my hands on) claim

   Thank you, Fedor, BTW! :-)

>> the maximum supported baud rate to be 3 Mbps, while commit 81bb549fdf14
>> ("serial: 8250_mtk: support big baud rate.") claimed it to be 4 Mbps --
> 
> At least MT7987A datasheet claims to support up to 4 Mbps, so I think 4 Mbps
> should be chosen for the upper limit.

   FTR, this SoC doesn't seem to be supported by the mainline kernel (looking
at Linus' repo, at least).
   I think, we should "parametrize" the max (and maybe even min?) baud rate
adding more specific compatibles to mtk8250_of_match[] (and probably setting
this parameter to 4 Mbps for the existing entry)...

> + added the authors of 81bb549fdf14 ("serial: 8250_mtk: support big baud rate.")
> to Cc.

  Just noticed that the author of this "wonderful" patch didn't even sign off
on it. "Excellent" work! :-/

> --
> Fedor

MBR, Sergey

