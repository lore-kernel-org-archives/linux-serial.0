Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05E29BDBA;
	Mon, 12 Jan 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212753; cv=none; b=ingmLZ3deCkl3Dkz6S7/JdsS2t26V3t2yoikeKp5nzdI2RsHMTE6UUY0HV1a+eI/N19wrYX8ZIp/qd/+Yj0hePrEV4/F+TCy4oxJVWtbXmfm4VFh8HdM1pALX/JPVjkMCD+br8BjNEuQnMjElh7OfE2HMqD8wEj4S6SgqORnc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212753; c=relaxed/simple;
	bh=qVZcFnrNthbxIcajKAMeoZAZ6XhV/2cB/xhUjnVSQlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvBHKOWDb/sAc2OQt7XGi0Yg71nTdQUUSfMLBEydqJY2cDCtYmi9FMbxQ9uR2f9H+shvBo4j9n7RESGR2qr2evEmYSEUjM8XxJdytdfht7Zb6UahY0KKx0/vz8N8dggadS+OMCk5Hf6kpZR0QY/wSHd2m9LxRnbAq/jxGidDA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=tdlqqs2+; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=tdlqqs2+; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="tdlqqs2+";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="tdlqqs2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768212401; bh=qVZcFnrNthbxIcajKAMeoZAZ6XhV/2cB/xhUjnVSQlA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tdlqqs2+zjhDKdcI8o60OZTvU1k68yw80JyRbVZNjHpY4+3EqsmvQ2B/VrLmVkXZv
	 2LnOTgo7/tcmmm4rbIO0ZKy8o8fWNyga83PndfeAPslGMDB6Y8SYUb0brETTW2Xi+C
	 11jMik0w4Qzmov8AapwRhp7jevx6Hvu/+qR67VN6IotVjDcoK0fqf14EuHKBn/cSmD
	 avI26sxzf4+PGv7BT8G4XUyp2M4EcsCGh4iHqBrhDK2+qICjRY0mX5LNUTVsGKvGYz
	 ovrG+Vq9l0PFvckdkTgwnagUzX6zQ/00asqIxbY/EfRJNObCvaEgyKYX6zb2C7Mt2X
	 WeuKBOp8FMzsg==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 4DD023EBBAC;
	Mon, 12 Jan 2026 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768212401; bh=qVZcFnrNthbxIcajKAMeoZAZ6XhV/2cB/xhUjnVSQlA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tdlqqs2+zjhDKdcI8o60OZTvU1k68yw80JyRbVZNjHpY4+3EqsmvQ2B/VrLmVkXZv
	 2LnOTgo7/tcmmm4rbIO0ZKy8o8fWNyga83PndfeAPslGMDB6Y8SYUb0brETTW2Xi+C
	 11jMik0w4Qzmov8AapwRhp7jevx6Hvu/+qR67VN6IotVjDcoK0fqf14EuHKBn/cSmD
	 avI26sxzf4+PGv7BT8G4XUyp2M4EcsCGh4iHqBrhDK2+qICjRY0mX5LNUTVsGKvGYz
	 ovrG+Vq9l0PFvckdkTgwnagUzX6zQ/00asqIxbY/EfRJNObCvaEgyKYX6zb2C7Mt2X
	 WeuKBOp8FMzsg==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id A1C1C3EBBA0;
	Mon, 12 Jan 2026 10:06:40 +0000 (UTC)
Message-ID: <7dbce9cc-e043-43ae-8d3a-a20b8ad2a5fb@mleia.com>
Date: Mon, 12 Jan 2026 12:06:33 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: Explicitly make LPC32xx
 UARTs compatible with 16550A
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260110024647.3389345-1-vz@mleia.com>
 <20260110024647.3389345-2-vz@mleia.com>
 <20260112-hopeful-spiffy-antelope-334765@quoll>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20260112-hopeful-spiffy-antelope-334765@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260112_100641_338297_E5F18793 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message. 

On 1/12/26 11:25, Krzysztof Kozlowski wrote:
> On Sat, Jan 10, 2026 at 04:46:46AM +0200, Vladimir Zapolskiy wrote:
>> NXP LPC32xx SoC has 4 16550A compatible UARTs with 64 byte TX and RX FIFO
>> sizes, and the platform UART hardware is well supported as a standard
>> 16550A UART.
> 
> Driver uses dedicated driver/match data, so some context here about
> compatibility would be useful.
> 

As the commit message says, 4 LPC32xx UARTs are NS16550A compatible, this
is the context of the change.

Any bootloader or operating system which does not locate "nxp,lpc3220-uart"
device driver shall use the general "ns16550" compatible device driver.

-- 
Best wishes,
Vladimir
