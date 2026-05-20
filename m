Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF4364925;
	Wed, 20 May 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259650; cv=none; b=PEGZulQYSC/yINyL4C6Faaf4G/TKlzs+GZYmby6UshkXNWyK+h+4d3+PstNg0QaVoKbvFsPgButlZaBrZIPtRQxY9OHZIrLDe82qtfBDzf9bKX0cj3X/ov5/0eSkhN2r/q9lBDtoG00z4kvmRr1+mx6RwHQa1slWNheRwS5lz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259650; c=relaxed/simple;
	bh=2efR+DnNIC3Gj7X/dNg8zFa+XK0jUXmSd1nXLl9DhdI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B47CXYZ4A3kB3nR7rQ109bU2gHOv2W+bnS39Q4EcIGVSTmNNLjybH0+ppnm2/xyLh0Ib41uO2U7sNP/+Ake1pPmw/LpR0qVpZWkCEzGLxkCkmp1P9jj9mhxWcZ1sQxRXBZ0M87miC1NZrXBy06YeUmTqeK5dpVP5exQg3EdarH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XTVeWEvl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gst2FdcV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XTVeWEvl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gst2FdcV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E4CFEC0245;
	Wed, 20 May 2026 02:47:28 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 02:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779259648;
	 x=1779346048; bh=yDR0xDfTCY4mJ5DTct6MR9yzaDqXA9D+fFo4AzPgurc=; b=
	XTVeWEvlPct60OU3uEF87ZBRMUE1CTz84nKHJndsktMorIyxr6ea/AuIGH2s7KyO
	KvVdBOgHYi5WF5TJ8vM46CwSgaNcAW6+aJESgrPPYOjowGFChcAxyc62pIcQuG9n
	8NCK/Hfarh4dh2rUN908QTiFttyRfy923NQt54DMN4qRbrJmrQt8q4X/nMpLwmDf
	Cuw7QyiLrnm1HOXkZFxIwZXHbUBtF8N36wEpVtLOpFXvcEdbRM9rM5J75tPfpMvT
	xruoCtCh+BapDF9YdKYAlvpWXwQ2fRT8oFP7/5Osz4t708yaC4kg2FOA/lEfSXnD
	3HzKiIGXQgZiPUsmBn2LWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779259648; x=
	1779346048; bh=yDR0xDfTCY4mJ5DTct6MR9yzaDqXA9D+fFo4AzPgurc=; b=g
	st2FdcVM7rREkWt4spzAwckv7AE9VxTaTZbaYc9WIkg2dDAS2AnYaZ8uUkFx4PrY
	9lo6iHfvwvzqafeGf3WP4XlTjNJ2ZRHcp4GkYJJ2HCbg0ADVJT5Wawm3VP4pF6wD
	OL4KgWSXQNyxj5tTL1pfrnlVG/o5qtFP9oGM4sL3SGv/R6abI8gRRqTNiGu9Lie6
	MRxFbBue79eFz5ZdvrXa6NPVh2CkryutbL1nf8C2kSnOWQIJzifru1Z2XL0WPcO5
	1MzeohgTdPX4z40X1oZ3KXiMJlQouziaYnu0VZY1lXnL7HY3Ru1xCxY1wrmlSFKW
	f6TkdZ/aIz3giWOKxUDVw==
X-ME-Sender: <xms:_1gNankYsELsANVgO5Jm4-EFRIEbKQhHKORAfMJDdIbdi6BpQTJKNw>
    <xme:_1gNalr1EfStH5QpA2vikkY8vbX1hSxDZY7Sl58QDyRNtWJ88NMpMsDnJ-ZRYJhwL
    ffcVmKNedIi8oE1pUZmEdBmzazguEaVHnEvh5xAHVZmymbIoZUYCOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhvhhilhhlvghnvg
    huvhgvseguihhmohhnohhffhdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghs
    rghssehglhhiuggvrhdrsggvpdhrtghpthhtohephhhughhosehhuhhgohhvihhlrdgtoh
    hmpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshi
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhn
    uggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_1gNav1qJ58oMDbOQAEskzj1IBJhFCUg89LdYOk7DIVxJWRJ08S_kQ>
    <xmx:_1gNauiRxUbCNRayQkD0q2fTKhJZZqViuvrUxiMVeSze_XlOiVr76g>
    <xmx:_1gNagmMHB5aV5SLniRprBKzKF78jl87DmohTnt45EDcjdUGh5Fn4Q>
    <xmx:_1gNasacD9YBWBM3zoz0YC5pZs9cjCyQdOpyf-PEGsVom_cO3rmnZw>
    <xmx:AFkNatfn-Cq_maHIUyIByNpNR3zL3phThzkkfmgUZcafqYtZKYFCNvIt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 28060182007A; Wed, 20 May 2026 02:47:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5CWzjrYWKeN
Date: Wed, 20 May 2026 08:47:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hugo Villeneuve" <hugo@hugovil.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <8478838f-3821-44ea-b281-c890441b9a12@app.fastmail.com>
In-Reply-To: <20260519171437.ff11a24d84c9ac8092348baf@hugovil.com>
References: <20260519203506.1341241-1-arnd@kernel.org>
 <20260519171437.ff11a24d84c9ac8092348baf@hugovil.com>
Subject: Re: [PATCH] serial: max310x: fix I2C-only build
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 19, 2026, at 23:14, Hugo Villeneuve wrote:
>> now causes build failures:
>
> A few days ago i sent v2 of a patch to fix this problem:
>
> https://lore.kernel.org/all/20260515183217.3554037-1-hugo@hugovil.com/raw
>
> Did you saw it?

Sorry I hadn't checked for other patches. I verified that your
changes are functionally the same as mine.

The one change I have that you didn't include is

>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 811250bbbd39..b9b40e80ea81 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -323,6 +323,7 @@ config SERIAL_MAX3100
>>  config SERIAL_MAX310X
>>  	tristate "MAX310X support"
>>  	depends on SPI_MASTER || I2C
>> +	depends on I2C || !I2C
>>  	select SERIAL_CORE
>>  	select REGMAP_SPI if SPI_MASTER
>>  	select REGMAP_I2C if I2C

This is still required to avoid a link failure with
SERIAL_MAX310X=y and I2C=m. Do you want to include this in
a v3 of your patch, or should I send this separately?

       Arnd
