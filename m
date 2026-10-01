Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A262486620;
	Thu,  1 Oct 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887470; cv=none; b=kdByNg5NE5eiuLRWlKBLyvRNB2abOWU0IjXsniab/6+cXEFeqaePS5AQSXlJuJi5Ko3kYqou+s63jmo+TDrGkaO9FXUl9mlyNCXG4OrKB804MdamXSFcJIwPr3uCAe5He/eO6nE6Unu6y9lT7dfbVUKOTaGU1yfq07HZXu+i+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887470; c=relaxed/simple;
	bh=Msm8G96Z8LsGSSGgnwfeBQBqJqjIt1nC0qnxocKxX1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRJ8tWdPtCGFIDVZXTminkVaoHjPp1TSwUowwSRASdkD+SAjPVHFLcdi1OylLiVwzKDG6pTSfvCkZ6r4Z8jpAOMuFZ6AspLPavUH+IgP2qjGV5BnfqGlTjSCROyW83XyhC7tqWeafcUpmTdRT+Hz2Gayh2EvCbZJra0+OG8o2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AYE0AjWH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYE0AjWH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=BrokjqjJjFZqUTDSv2++iKVr7YyyXPU/fy3hPc1Hrqg=; b=AYE0AjWHoTnpDBXumGyRcPWygA
	eVsEPKqQQmRWYk7YMNSFlvyTQcWKjfUPXfF8KWAgoFvD0nL6KEZ0yKh3ZYkG6JGgoBdcORRXZCVFE
	yBbzVOKf8CMCjOoiTV/HU92dEe9qTa9B/1TMVRD+JvL2DKORIdN5wcaDWOOXFRPcHnP3bQp/zXXZL
	/lwYArC/eEcNqlR8NMMLzGfTCyWcfg6Snq1QbemFr/zuMKYxdIEj76Fd+57kd6jQOPQyMIqZXtoGo
	BF+zqEwI/xD5pkXE62Z8zLrTfRIlDP7EPs5d9p+IR8NDUT8Jap3023HJ2CX55AgWsFej5Hvxm6FGL
	S0WHcozg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCNdh-0000000AB8J-2YGB;
	Thu, 01 Oct 2026 20:44:25 +0000
Message-ID: <ec3a09d6-4ba4-41b8-abb1-b59e265f4532@infradead.org>
Date: Thu, 1 Oct 2026 13:44:24 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 30 (htmldocs:
 include/linux/tty_driver.h)
To: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Johan Hovold <johan@kernel.org>, Linux Serial <linux-serial@vger.kernel.org>
References: <ar5CMQqWGUCVevPL@sirena.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ar5CMQqWGUCVevPL@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 4:21 AM, Mark Brown wrote:
> Hi all,
> 

Hi John,

Please add kernel-doc for:

WARNING: ../include/linux/tty_driver.h:92 Enum value 'TTY_DRIVER_RESET_SAVED_TERMIOS' not described in enum 'tty_driver_flag'

-- 
~Randy

