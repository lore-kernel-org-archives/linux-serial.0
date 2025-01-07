Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBDB1D7E47;
	Tue,  7 Jan 2025 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239777; cv=none; b=YqTfr7wTROe/BcA2A8MEfNY1nDx3+1BqCxPhfRgjqnSmcenXzbKDX/5G7DW1p0HT3GABHrRay38cZPzJV0Xlo2TORADdP3L8LXGZrsqBb8OPNHead/egTTuaRBxREd8+E9StX75HQszVX6ddCgAmTCybG2crA1qrVYp3NZCaFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239777; c=relaxed/simple;
	bh=gjEPgqLkkiYS4kMyaL3xU0ZUnSKwvMLRGduQu6gI9zM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ViJl9+Fw7o9IzyUgayFoFbowRM08r5FtnJkJU5bMzYTofJWfYBcLjgEvPpM3qQmp3nhjuBpUy7wuF6CW47aK1FN3yyxZPYO/7/GoVRghZ/V+LoV8dUf8KSDpOqTzum9lE98sPzDCp1bt/Df8FgSnmPnheyhMuXRpVm6HMrDC+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=HkC9L15i; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="HkC9L15i"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 299F39400109;
	Tue,  7 Jan 2025 09:49:30 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 09yDynO_7LEB; Tue,  7 Jan 2025 09:49:30 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id CA47894016AD;
	Tue,  7 Jan 2025 09:49:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com CA47894016AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736239770; bh=gjEPgqLkkiYS4kMyaL3xU0ZUnSKwvMLRGduQu6gI9zM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=HkC9L15iZnXS0CIYDVVz7Zqf5G+oxTw3eQ/dF/sIB0oAxUtoIp3sSIJQYfNZIXYuf
	 7AsiXlshIjO4p9dIPNV0Itu4HM+oktOCZnz4cJPnFncxURaf0A5KozNZKNi0i1SDem
	 h6A8wNHWSnaWAX6BJ3EPXgqUZZSgB2Yir8tOLeT5IjlAPu25Qf6k3gUOVtGTzs+BLJ
	 9Bg3swuXIYafYbwuiFLbqiGwAK+uL2S6U6ZYK70gizAcBDvCbc8fNRVAYvWgbX+U+8
	 CXpcjg9kYtgvi1hS+hsZKFyuAhZc0vZ9wgj2T3lVjz3TdbFdpprjtf6THus8RhLUKe
	 C8sWcqRa2AooA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8ROXOkz5FEcd; Tue,  7 Jan 2025 09:49:29 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 09D259400109;
	Tue,  7 Jan 2025 09:49:28 +0100 (CET)
Date: Tue, 7 Jan 2025 09:49:28 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: Andre Werner <andre.werner@systec-electronic.com>, 
    gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
    andy@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, lech.perczak@camlingroup.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Subject: Re: [External Email] Re: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx:
 Add description for polling mode
In-Reply-To: <4pcgrt5zwtjxk3qa4twjzvmaxknu7sasmwrgphc364ril7aref@uurm62vwexr3>
Message-ID: <5582697e-bbf1-9a35-c5a4-52f09fdc6067@systec-electronic.com>
References: <20250106085051.50861-1-andre.werner@systec-electronic.com> <4pcgrt5zwtjxk3qa4twjzvmaxknu7sasmwrgphc364ril7aref@uurm62vwexr3>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Dear Krzysztof,

On Tue, 7 Jan 2025, Krzysztof Kozlowski wrote:

> On Mon, Jan 06, 2025 at 09:50:50AM +0100, Andre Werner wrote:
> > Polling mode is enabled if the "interrupts" property is missing.
> > Thus, this commit deletes "interrupts" entry from "required" section
> > and adds a description for the fallback to polling mode at the
> > "interrupts" entry.
>
> Can the device actually operate with interrupt line disconnected? I
> skimmed through datasheet and they did not mention that as a valid
> setup.

For polling mode the datasheet said:

In Polled mode (IER[3:0] = 0000) the status of the receiver and transmitter can be
checked by polling the Line Status Register (LSR). This mode is an alternative to the FIFO
Interrupt mode of operation where the status of the receiver and transmitter is
automatically known by means of interrupts sent to the CPU.

This is what the driver does. It polls the LSR according to poll period
used in the driver. Unfortunately, the internal TX and especially RX
buffer is very small. So we need to poll in a very short period.


>
> Best regards,
> Krzysztof
>
>

Regards,

Andre
