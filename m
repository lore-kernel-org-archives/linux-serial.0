Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A7171CD
	for <linux-serial@vger.kernel.org>; Wed,  4 Dec 2024 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350703; cv=none; b=JlV4IILJp4+LCrL6RrloMSYXC4DSS7l/eDS4Z5yUr1+RXF32SLof9mFLsJIoLaFbDpvbSZ+ppAu2Ioy6tuJzv9cQW0nQFiU4muTC9yDRanVgTcvMyNfyLpJh4yS6zyA+HI5c8f/B26g73uhCZuyHz6KIe4VJ4fXfFEjB9YCYpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350703; c=relaxed/simple;
	bh=qU5q0LrfZfd0gc6aCN9UL8zXfE1IkaXyTJAJEv6IAJA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=naCRJa5z22+kBIEOrl7eEHKHf9gGetbEuYzsQ93dMTNSBmbrzP4Icgj5vnsdGgpE74htQAujCcO7lFrha5VzL1SjRyomHTc3REa3T3J1ZFl5TNQNgEO7mBwtlieCntdpoY7ttW9+cR/J93+APGygO8actUZZ1LAqfRwEL4VokXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpuBpkja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpuBpkja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E906CC4CECD;
	Wed,  4 Dec 2024 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733350703;
	bh=qU5q0LrfZfd0gc6aCN9UL8zXfE1IkaXyTJAJEv6IAJA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lpuBpkjayZLGNHDd5Nm0JwCmC2cSiqR3n6bBL0kmAA44deplIPR3QGho8Tft0MsV1
	 cnJ9Kpkih9/ALRlBL0IYnpnkRMPy9BKABkWQw61O4FJNHIwQO6DJR3tg61kIoCE1Iv
	 hejDpZXl37SI6+TvtajLzIYd/TG2CnO40GoRR0lLViIyjnC1eU8A3xIdXA6c1iFWla
	 DgGMpDt9m7CH3+vJ8XCBCSJGVC+7Cs54g59qgPkBeR5fr39XPuPtxXQx8I55n/ldPk
	 WoWdOJJtcjd/S8gkiO3WLBEESV+JCfm+BmWLRF+fUq/MXvpVxxU9yFKGjy+g//purk
	 Sb3tilCaVuWmw==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E9428120006A;
	Wed,  4 Dec 2024 17:18:21 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 04 Dec 2024 17:18:21 -0500
X-ME-Sender: <xms:LdVQZw140ccJoZBYp-VWOw-jHBSutfZAbckYPLHqNQEBIvKVnJrqFA>
    <xme:LdVQZ7Hn_X-7yB7XP7mb_oFJsxs4SB3ycZGhcP8nfxvEu3qoNhfwPTlRXYqpDKI3W
    rNw6IKvm_dMEfr7-8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeetgeeuhfffvefgheeuteduveeiueeuffeh
    vdevhfejtdfhuddtteehgfefkeelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekje
    dttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggvpdhnsggp
    rhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephigrnhhghi
    hinhhglhhirghngheshhhurgifvghirdgtohhmpdhrtghpthhtohepjhhirhhishhlrggs
    hieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtg
    homhdprhgtphhtthhopehstghhnhgvlhhlvgeslhhinhhugidrihgsmhdrtghomhdprhgt
    phhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgv
    lhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonh
    drohhrghdprhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgvthdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LdVQZ44E0alFHkc7uQH1W3zPRPu02HhkJlWEHja1wXr43j2Dcl3q0Q>
    <xmx:LdVQZ53w4bOWG7sOo6y3qRTbJ0PDU75DG9WO2c0xaGRS9msh2XMStw>
    <xmx:LdVQZzFFYMgrv08RUo0uZKt8vHZQRa8S3GjviIhsetXXkJorJ19Kvg>
    <xmx:LdVQZy8YOpeIcacJMXjZcKf44wNI6LSALD2IrozbEJJgk9N_rBq-SQ>
    <xmx:LdVQZ4kXaBUIYbDVQGeZlnhgj5q5AnQnURmnT6-kTF_cGnS2nK4tAk0j>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B8F442220073; Wed,  4 Dec 2024 17:18:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 23:17:56 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, "Yang Yingliang" <yangyingliang@huawei.com>
Message-Id: <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
In-Reply-To: <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
References: <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
 <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 4, 2024, at 22:09, Guenter Roeck wrote:
> On Mon, Nov 25, 2024 at 04:59:00PM +0100, Arnd Bergmann wrote:
>> On Mon, Nov 25, 2024, at 12:06, Arnd Bergmann wrote:
>> > +unsigned int nr_uarts = ARRAY_SIZE(old_serial_port);;
>> > +
>> 
>> Unfortunately, this breaks on non-x86 because of the check
>> added in 59cfc45f17d6 ("serial: 8250: Do nothing if nr_uarts=0").
>> 
>> I still think it's the right idea, but need to unwind further
>> to make this possible, and find a different fix for the bug
>> from that commit.
>> 
>
> I decided to apply the patch below to my fixes branch. It doesn't change
> the code, it just gets rid of the warning backtrace.

I got stuck in this rabbit hole of running into more issues
with the 8250 driver. Any time you touch something, it breaks
elsewhere.

I've uploaded what I have here now:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=8250-cleanup

but this probably needs more testing, and a few smaller changes

>  drivers/tty/serial/8250/8250_port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c 
> b/drivers/tty/serial/8250/8250_port.c
> index 4d63d80e78a9..649e74e9b52f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -467,7 +467,8 @@ static void set_io_from_upio(struct uart_port *p)
>  		break;
>  #endif
>  	default:
> -		WARN(1, "Unsupported UART type %x\n", p->iotype);
> +		WARN(p->iotype != UPIO_PORT || p->iobase,
> +		     "Unsupported UART type %x\n", p->iotype);
>  		p->serial_in = no_serial_in;
>  		p->serial_out = no_serial_out;
>  	}

I had considered this at first but didn't really want to do
it like this because we should not be registering empty ports
on platforms that don't use the setserial style override for
the port configuration.

It does of course address the warning, just not the
underlying bug.

      Arnd
