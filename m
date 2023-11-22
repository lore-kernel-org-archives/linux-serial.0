Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EDSQzHi5"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6CD46
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 06:57:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D5FCFF80E;
	Wed, 22 Nov 2023 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700665059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzGKmEbQPMPlPJ3/uo2yA8Xyai4d0dMKgKji/5flbE8=;
	b=EDSQzHi5yNG1ZSM0cp8NGnsCEgoXpS3q0ZUzv9kMQzP4Rm4IqR3jfiImjm26q8S+t81Gbd
	BrJQ2yXoH0ti2+Z7KqVHKRWxbFQkCJBd5SO8xIDshS9jpRKgxzB6SLqjbupgkzvoSmDJkU
	Y+ipUGw+KSUr9+uaU5YQ8+TD6O0kpojBbz2GITtuJ/hhv9AzR3Ja5Dd5MOGzEhjQDbdzU4
	Wrswp3+4J1Wd1AQfYZQTYaNCcw6oFTJToY0ng/wituVxLEVXpWPmN0NQlXg/6D6aAHq84o
	DX+50tXVfQeQ0XaAhKAlXbPDF8MWvI5IhpFNxBoyTgWKg5zlp+tSsgEJAiSH9w==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
 linux-serial@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: [PATCH] ARM: PL011: Fix DMA support
In-Reply-To: <CACRpkdY6CtReAOr9oiVZ-97YRpyNCN_s1E_-j6zYuZbtmis80A@mail.gmail.com>
References: <20231122074535.184384-1-gregory.clement@bootlin.com>
 <CACRpkdY6CtReAOr9oiVZ-97YRpyNCN_s1E_-j6zYuZbtmis80A@mail.gmail.com>
Date: Wed, 22 Nov 2023 15:57:38 +0100
Message-ID: <8734wxhm3h.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Hello Linus,

> On Wed, Nov 22, 2023 at 8:47=E2=80=AFAM Gregory CLEMENT
> <gregory.clement@bootlin.com> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Since there is no guarantee that the memory returned by
>> dma_alloc_coherent() is associated with a 'struct page', using the
>> architecture specific phys_to_page() is wrong, but using
>> virt_to_page() would be as well.
>>
>> Stop using sg lists altogether and just use the *_single() functions
>> instead. This also simplifies the code a bit since the scatterlists in
>> this driver always have only one entry anyway.
>>
>> gcl: Add a commit log from the initial thread:
>
> First I thought this was Grant C. Likely, but now I realized it is
> Gregory :)

:)

Next time I will only use gc then.

>
>> https://lore.kernel.org/lkml/86db0fe5-930d-4cbb-bd7d-03367da38951@app.fa=
stmail.com/
>>
>> Fixes: cb06ff102e2d7 ("ARM: PL011: Add support for Rx DMA buffer polling=
.")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>
> Fair enough.
>
>>  struct pl011_sgbuf {
>> -       struct scatterlist sg;
>> -       char *buf;
>> +       dma_addr_t              dma;
>> +       size_t                  len;
>> +       char                    *buf;
>>  };
>
> Should this struct really be named "pl011_sgbuf" after this?
>
> It breaks Rusty Russell's API naming rules.
>
> What about renaming it pl011_dmabuf?

OK

>
>> @@ -369,18 +371,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port=
 *uap)
>>  static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *=
sg,
>
> And then parameters and variables named "sg" don't make much sense
> either, so just db or so for "dma buffer" if you wanna keep it short.

I am preparing a v2.

Thanks,

Gregory

>
> Yours,
> Linus Walleij

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
