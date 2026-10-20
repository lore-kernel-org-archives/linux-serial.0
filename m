Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484950;
	b=BziLgxt87+jenNtQPxvvEa9URg1Fu193KlXXDnzWyU+bKMYkEUo51GA1YBFj21Q/K8HX
	 mAtjsfbKUHRgdyEJYSI9nSCITNQaQ5HB/rB3TyXx4m33jhPf0RuJnsZT7cowgLeWljV+A
	 r3fEfdnPDGSBx3zKFWRLQvDKEU8EVrnVpig4ZcaJb8/BDjm53HysICbaILQq8ifT6MHOB
	 6D8uS9iVwvFuz9RGQBYiKZY0SngDPFieQIogE5jg/yPz3f/tkK/lgmLvxK3upYHUgMWm+
	 ws0zk0MWH+8AcQpBb1VjpJU72W9JkFjGxkOX4fuVSuPiXNfPEm85YvTatf/NiJT/csA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484950;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:References:
	 Content-Language:Organization:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=dKI7SJoRBN+M3CDA0gRIeQOLiu4EYqx3uSrVGnhZdI4=;
	b=TEVhZAix706OtnA4QuXzEky4kEtPdK4PS/g8MHEMTfedKlJZGetIpmljLNvnLstAYPTO
	 r9a26BuM44ygtJ1uIm2i0+t6eZL8s7AYrIs5STsY8imtyJ4KpxOedjBdpiNl/OINNL92R
	 L/IekTaS10P9tsrEM62W6/BLWj4H3yFAUY2RAii6nv5xngrTxPSq5KdEsE/Q4H1GkTKAb
	 ZKyXXdybnLo29zG7E7bzVRqAuSe0MX5ynCzY7tkqEqrIXbUAM32fLghEIwWHkgurelz9J
	 uc8MI81/3ZUkUEcSPLyvthvmKK29rqqMiPqeAU3RcocVriK71BdyDfM8V+qCLppJBSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uCX1WdL0;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE7606A31F
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFFE7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uCX1WdL0
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C46FD4E4128D;
	Tue, 20 Oct 2026 08:29:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9804D60393;
	Tue, 20 Oct 2026 08:29:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41A7110328D55;
	Tue, 20 Oct 2026 10:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792484945; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dKI7SJoRBN+M3CDA0gRIeQOLiu4EYqx3uSrVGnhZdI4=;
	b=uCX1WdL0Y5VXomjLjnZX5exPNRz2Em1LllHCa7EwBIPtsV6vzJ6jia5Hkay6N7itDXju1r
	AVaK0cpSa1YumhFO3cUzjWfXC300P6kHTFPc4qWo/ODjFBPdESnK0VyptJQNgR6bfJ6E6M
	G0Rr7MRuyS2Is8AmiLSMKB4EC1Hk/KduI8j6SJ3XFnH1puycDqQCeDDVnvTiFCeAL/xAxD
	Q7zyTXxuCzDu0urkDkm8RXzbQWCDkFMuJRg4/VAyOj5trvi3Ss+kM5WDaVVXuXt3XACkqm
	jBjINPfM9QvCSV9VecbgVXXmr9DFj61qsZmbNO+IAtvydl1IbCFecaLpmL9Kpg==
Message-ID: <fa5e93b6-d98d-440e-aa2a-727c91a5ffc1@bootlin.com>
Date: Tue, 20 Oct 2026 10:29:01 +0200
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel: Replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
From: Richard GENOUD <richard.genoud@bootlin.com>
To: Li Jun <lijun01@kylinos.cn>
References: <20260908113719.4078979-1-lijun01@kylinos.cn>
 <908e8237-f17a-46b1-be55-41a3c9146750@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-serial@vger.kernel.org
In-Reply-To: <908e8237-f17a-46b1-be55-41a3c9146750@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 25/09/2026 à 15:40, Richard GENOUD a écrit :
> Le 08/09/2026 à 13:37, Li Jun a écrit :
>> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
>> This also drops the __maybe_unused annotations on the suspend/resume
>> callbacks, since pm_sleep_ptr() inside the new macro already handles
>> the case where CONFIG_PM_SLEEP is disabled.
>> When CONFIG_PM=y but CONFIG_PM_SLEEP=n (a valid configuration that
>> enables runtime PM but disables system suspend/hibernation), this
>> keeps a completely empty dev_pm_ops structure -- all callbacks are
>> NULL -- as dead code in the object file.Modify pm_ptr to pm_sleep_ptr.
>>
> Acked-by: Richard Genoud <richard.genoud@bootlin.com>
> 
>> Signed-off-by: Li Jun <lijun01@kylinos.cn>

It seems this patch got lost, could you re-send it?

Regards,
Richard
