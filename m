Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022103101CE
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403725; cv=none; b=jhlFp17a30XrF7DYBGkD4yQ41kPJ1DRBv+b5oDrUGXJkOdzWDItDls0v2zLlXWcpbusqhd72RshVo7BpHbVYXQ28xM1IsoO2GPWpCIuFHIWlXoCnBw6q8R3Qdun7Skb2HetBhVEofQXUYYP/qFaaco8g6uj94jtk94aCP2FBj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403725; c=relaxed/simple;
	bh=R14UUwlFd9WyllyAUMobSnqrrO3wS1S5ZoDDpcGtalU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6mZJDdQQcuKBPWfqCu9U4o2YwRdNsO8fD/zdKthYEjUAZb/bWIuSTlgdLSM0Lhm7FzYuAdTu3l/Lui2Lxi8C0STZkr8ESyRDVJzNMFnutPM7bIXqGw06HhLtmhNAIm+xz+yFqibFh6ra6K2nPwSvs9e5WEz20r6NAQyPu/pY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=tkssef5V; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tkssef5V"
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:e923:0:640:e4a1:0])
	by forward500d.mail.yandex.net (postfix) with ESMTPS id 59D74818C2;
	Tue, 07 Jul 2026 08:50:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp) with ESMTPSA id 2oAFG84dBiE0-mxye4FXI;
	Tue, 07 Jul 2026 08:50:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783403403; bh=R14UUwlFd9WyllyAUMobSnqrrO3wS1S5ZoDDpcGtalU=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=tkssef5VQjm0XixCdHmknG6ZbfsAq2xOkNd9UQPFaNMLgm2x9Y1WpFWiY7fX5PuLe
	 S3bX/8Q0UnP7gkqL+VBPsXFqEA4pmswYG5pX5/TzwCrtZ1FQMKRI0NhHFp5tVgZdLt
	 W03FFrsquLxnUz1HXzL+rv0GurAL9fMC/cRVoyBE=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <3ca834d7-1ee0-426c-89d1-b52dab0b0a24@yandex.ru>
Date: Tue, 7 Jul 2026 08:47:46 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tty: n_gsm: avoid reactivation without previous
 cleanup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
References: <20260706142016.3385636-1-dmantipov@yandex.ru>
 <2026070611-pamperer-traps-84d4@gregkh>
 <16b08a3e-4b31-4941-a0aa-0b53a0dc4cec@yandex.ru>
 <2026070616-handsaw-careless-c428@gregkh>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <2026070616-handsaw-careless-c428@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 6:18 PM, Greg Kroah-Hartman wrote:

> That's why userspace does not do this from multiple threads :)

What about malicious userspace like https://github.com/fff-vr/n_gsm_exploit?
IIUC completely unlocked 'gsmld_ioctl()' makes such a things relatively simple.

Dmitry

