Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0833ADB3;
	Thu, 11 Jun 2026 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166942; cv=none; b=Mlw0kReOZsmDrMP/tcuCAUZEzYU+5r0dyyGV9oK8SDJmlkNJ1J54G8BGgUQLecss2Rjf58M/ho4OFbSzBtcVd8YxnjjY1fdQXdNnrCrylNppuYbNF0hhPfJMa+fuUFSCuer5W52xYP/JUXz3eP/PwphCWk4jCf8lwh5X/6xd/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166942; c=relaxed/simple;
	bh=55GMxwWe/EDOGVQsOBSXMfN0tKbpsnGov84slGU0vcI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gcIgt/PYOyNQGwPFG4AKVTaqygTOHQMTYnX0HCjTY5IiAxfneDEauAp9ayAcbUm5B/CtNkU3vibQG8zK9zJdkyz2FnVRSGeTrv+P153HXN26EMxQjgSTkFEDCRMCLti9hLhtZu6aPgz7GGt02ka5y4TMnFXzuh8iFCzJAFRXB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QpAudo+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jhgP7tVG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QpAudo+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jhgP7tVG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 01C17EC01CF;
	Thu, 11 Jun 2026 04:35:40 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 04:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781166939;
	 x=1781253339; bh=7BodSLv+bcZ9wOA2IVcLisAPbv5be0Uv9Ah/rLATO3o=; b=
	QpAudo+dZlasRHhV6TfhHiPyMGmUkSvbcZMOT9WD5P//5h9TeZPgUt7UXIuu8MIz
	+nEJF9CkkyuuEC8vWM9yiX8aAB3tTL4NOITa1/Q3JAK0eCCGhKyGVgQrqHGU4uvC
	486GTmF39+E6w1li2srV+owcUS+U+c4SjgaFZi2kKCkk/o5QR4XlHFAHkTR7++sJ
	U9c1pa2n2oclTjGjWSuFNCJ7sH9jijauue+VPHDdAGRchCZGBetqZqGms1u6UPde
	xJ8AWnqifNHSkgu4tsAzm7R4tGLLwdv6bw+heZfWHidiw8FFVbVXzH0GcBpZsIvx
	cXIzCjnr4Kna+pr5xC8JEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781166939; x=
	1781253339; bh=7BodSLv+bcZ9wOA2IVcLisAPbv5be0Uv9Ah/rLATO3o=; b=j
	hgP7tVGp1qwdg3dnmcpyQ5Pa0LJgGn46vkG1Zr1LS38cChprECsDNnoyOInVcrw2
	gyjpSuI6ImG8ZKUXdI/TqmKD+Q5JfWcqpr/G9VTEQPHsDOCrOAfcO8r/d4gV06S9
	XvPXLXwMBiL4zKe0VHhwFdBweSV5cHQJGh4YiA60UYqJJ7H00vNOG8B1dvpsoN4c
	OP2S9/i8EE3uA8eqLxQlRZ67AT89k2QRB2DukqcXhjjrB2elgC/cBp4vL6J3uZJW
	J6EdO8XEEEQJpW1YHVDvD03nQsVBQo1NoQyH3c6XJHyxsGeRfSaOTDfcw52MZUqW
	kia3/5AX7Yd3xKRp+vIHA==
X-ME-Sender: <xms:W3MqaiEHCvhgQD7R-k5bw32aCRCXtPyBlVmc6qjL-xKrZUYkQ_a-TQ>
    <xme:W3MqauKCp6qObdt8UTw-d-utiIvYOlsz1-7NFmBMHMY315vn6-h08QZ6AQVlxGFwx
    t5g4B87GHeoJm7S-BlK3sxMf2t6KuzBxeadethnl34Lqnsss2IfcSA>
X-ME-Proxy-Cause: dmFkZTFRxnniak2f8bd9bHlEGEKJqMwWFJelaf+rUBctwzckTZ+EcLfJGYpieiGl5N38KU
    m5+oqH86Qup/U8ETE7kKwx1+NrCs/eopjBUnJh5Om6EBJaYv8oAIO2fXikquLFTwSKSgiX
    Oj2oXa96YxHNsXtYkZ+d4j3Uhfpu7RLcAfMDXq6/mS9IQTjj3IMENqG+6lpKxZQBQWIOy+
    ep83Uf6RA5R7mRp9JtsrZk+1NOL1T/txcWsr2x8lT2tLltKdV3rSCZQ/nd29vpKjXwrRPI
    kMWalDx1S+wtHiEa6LAlMPmRGOaFuICh1Cmm5nrOSBHr5wSgo8vimlEVOsxiQqFt8wZPmD
    2TPj6zcQzkocAlfe9Olac4ophjMrZHT0eP1xGar2q+tEyu+SFpgWo8jEXxi9PVI8UjeGcI
    fXKz6M6dqO47CUuQv4qK4QBKJlvRqFxz4qneS4qIWvzRDLLaiPHydc9FXwPA8qQNG+31un
    aBEdQH3+gcCYWGTv4s+BrTSf9y9BbGvMFyP2M/Lyn2xWjxVoLSlp5GLf1lPN65dH1b/V30
    RSiIEVcDSBiKJqnoJDaShAQQWTnJEUfS0s5aOsUIRRd1sHq6y4fBRwEjfo9SrKFjrZq2QA
    mABk702B02M0tqrnu4HvgMmvZStSNeSfoYWkS6N7Zcf7sdKwE0qTx4pZP54Q
X-ME-Proxy: <xmx:W3MqavCNXa2Qs6YQAMreSbT8nRieztJ0JYdmMj2JoFKL7Xx0lGsTWg>
    <xmx:W3MqaqtWGwgtpwYW5G31CCHv_70cNjLw0aKO0Vc1cIC39TmXGEFjRA>
    <xmx:W3Mqat8QkFIu5VDtxxXDf1eObyHQygraIUNuWN79NHsp4BSHUUz5rg>
    <xmx:W3MqahTIMSQQ4ooIgaEFRGYmNQYoJO1fIiIcbP485TLjzZBL5jfj9A>
    <xmx:W3MqaixlyCBr9E5-5P6pO39JYfsPi0AaPnqsS5UA2NVVicc3QP0hIfcf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55E6B182007E; Thu, 11 Jun 2026 04:35:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APCtYiT4KAZo
Date: Thu, 11 Jun 2026 10:35:09 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Li" <jason.li@cortina-access.com>,
 "Jason Li" <jason.lee651024@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>
Cc: "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <d62541fd-36bb-4c67-a81b-a8e66887a2cc@app.fastmail.com>
In-Reply-To: 
 <JH0PR01MB5777B84BE8D9987329ABA54BA21B2@JH0PR01MB5777.apcprd01.prod.exchangelabs.com>
References: <20260610112821.3030099-1-jason.li@cortina-access.com>
 <20260610112821.3030099-2-jason.li@cortina-access.com>
 <7dcc8386-a0e0-4c79-a9f7-f63188bb997e@app.fastmail.com>
 <JH0PR01MB5777B84BE8D9987329ABA54BA21B2@JH0PR01MB5777.apcprd01.prod.exchangelabs.com>
Subject: Re: [PATCH 0/3] tty: serial: Add Cortina-Access UART driver and platform
 support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 11, 2026, at 07:27, Jason Li wrote:
> Hi Arnd,
>
> Your memory is truly amazing; you even remember a submission from a few 
> years ago.

No, I just looked up your previous submissions when I saw the new one,
lore.kernel.org never forgets anything ;-)

> Yes, we expect actual end-user products based on these SoCs, and our 
> intention is to provide complete upstream support over time. The UART 
> driver and DTS support submitted in this series are the first step in 
> that effort.
>
> Cortina-System and Cortina-Access are now totally different company.
> Current aarch64 chipset are totally different with legacy gemini 
> processor.
> Realtek has many business unit, different BU may have upstream plan but 
> they are individual.
> Although Cortina-Access is a wholly-owned subsidiary of Realtek, our 
> product development is entirely independent.

Thanks for the information. Please make sure to add something along
these into the changeset text for the initial arm64 patch, along
with a brief description of what type of chip this is

       Arnd
