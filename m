Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677306;
	b=lCeeDJ6Jm+/h6rrQJr+tZOW7sNyCZFQ9lrZ1/9nrxRqRHZiexgmz5cjZpTTk3TM1sRkT
	 a+4pFNmxAHZRYraQLL66aRW3X9t+B3D2sxsTNPIqPykjbFMd5kZtEM8fCGyIhvYLlRu2Y
	 l+CyKq0AzmeD3akNR53tqUOn7ZR73TD3vGaYH6QPd+azDd5K0SiQa0Fhf2rf2r37ROPb5
	 dBU3RfjjhBlalEe66bVPJMQF/yLic1r1vYJh2dFxWZ20t26U7jwTd3xXhjgqi+EiUs64P
	 J5WWySShVvgoDAIFHJpSTSj35cQ0T3PS2stAzhzrvJOAuu6VBeErbQ/mP1NkWtzN0tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677306;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=l5aXbbkxmaFUi0aNpyvuSHB6QY9N0/Ewrnv/LM3KvJo=;
	b=WgcReOJoIfXacA+HnTs3EL5BRk/OJxWdk/CzBqRy/QefCiRpReaU6+YICCt0xhH6Ft82
	 rZzpd/JPbXufAsZm22v+yGqCRC7G7za33OnQppWTeNsgB57+UzYxHRuIrsn6ILWMY/r8l
	 SBV0mlMX2AsA3qHfCMy4/PuimbFM1/RtRW1knStmVg8FyBlnanDXgYLia2e6aX6gu0Acc
	 L4RT8jwnq/gwCa9C5V/LMlAXl0lDxWLHywVcgv+95FhRySWbpFh3SBSFyyRU9RqwJYT8V
	 R5pBYuGtOmGzW03qy9q0OcqQ8r4UkjYrQrAGZv20uR8p3kPBsitcF7ZcNQpJ+kz5lgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=c9LykKpO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vsbOmdVS;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90804606A31B
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 13:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90804606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=c9LykKpO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vsbOmdVS
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 87A95EC01C5
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 09:55:04 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 22 Oct 2026 09:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792677300;
	 x=1792763700; bh=l5aXbbkxmaFUi0aNpyvuSHB6QY9N0/Ewrnv/LM3KvJo=; b=
	c9LykKpOz2WZN95r+kC4EFXd1kE3HV0d/v913CwtCFeY60wXbCSBiKGAM16idduR
	B9B1zfZHO+55nP6Wd9wsj6WJTQw0uWuhV0FmwGEimIUBFvNYnt2+BK/v2L8vaqPb
	CoU7dh8bcxCHFEdgWFFFqTz3ZcqHAmEdu8rRmekCn6eV+z8C6LWbo32ALxL4/674
	DqN7uxZpQgSfKrE5ySYwxpVGR6ridi6f7BFShSnpu3eRiL1luNgRNY7PVfrOPcZ7
	8vNGUwQfvmtSoZ6Y1oO9P9OzyYs7tDECmMYZTPc4ngbQBK2Yn+wWJOrfy+cVKbv3
	in77sNEb4irwdZmpcKf0DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792677300; x=
	1792763700; bh=l5aXbbkxmaFUi0aNpyvuSHB6QY9N0/Ewrnv/LM3KvJo=; b=v
	sbOmdVSAD9ehRIBfWDcNyvJWWn3C4v7GbtsyNvw1Fe2D6z8PcDoU1emBBZ9DMP8l
	I/uEJaOeNAtT537u6vhdcxv05shLurMjwgFLNC6MUbcz56WxMFpzUKZCLmb+zFO6
	fyZDXdsPzhKzeTlHCazYIllsUCJ+4WgQwkLLPGgYP2Ao2b2HrGJkuvWWMEq4c5jo
	Az8fWn3GEF6rEMwluoDS7yb6rUweguGHI612qZxweEKNawRklRI1BbX+g1qQXc7F
	EQmgDraDSa7RuNplmJJ7jxz8Ai/muIGuO2++JhkkDSwxUJXWhRz7PUvT9brmonXN
	cFes90WL7Qfz2tYFNmr+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792677300; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:nr3aqrLRLaluY7hz9XPy3fyh27s+5bAIXYEsLf0IslJqq0S
	H0AwISVD6/jx3CmEbzorAXr28qeuktZvBSBX2UuiDfclBS9DhkCzhsmMc+0WDCVx
	4U2Hgy6n/uQccpikI8+v+xaw9rYbR/Yio5zt6PxXP9bCckFB1ACXax7OzodflzBs
	0KlF99zPbVukqUaJAQ/BFiWZNDYKJQLUt1hNGKMpvHLS8DW5hegkIih1uZk9uBX0
	dH0puIJsBgcyzG8Ddr6fxvR1FgruW2toReQpuL08sMNAShSrpSKF5Gnp78sEJKMR
	vsafQMiXdcYiZNlKBS/ARMD5DsBtcwUrtOakLvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jTJCjZKNFVveRZUeuPMJ4UHW3CgnGBnqJh+oGxVFboo=:gLoMRFxOPaqIn94+eUNRicB/Bv2kJELCa6t9Kgiz98A=;
X-ME-Sender: <xms:rxXaarnThHdAwz_iU3dy5EbVuTgrRFdT7RosIDOls8h6vpZuavjqbw>
    <xme:rxXaapov4bER9VuTEcKa-b1PbO652ECDYQvJth9OtD4BuJdgr1SCwXMl5Ly6R0a7d
    WVQSqpShPIatCbyJAxc4iHeUnBHBMIxniq3F5K0E9vGI7Go7VAWaTkZ>
X-ME-Proxy-Cause: dmFkZTFn6eaGcV85U3YvE7EtaniTIOIaXF/v2CoswBxqFF7JtGWZMoQnAGQQTir8RYKDiO
    KvPRnYP2VI74ZQlIDX+N6Pbot14qPDvtyrdOhtuoST5EE4G9a1RmfBlsrpJ/MfK+nlKW2O
    HfgP2YofBohpMyU8l8nBFgxTlIMSWdqBK4t+bKkAa6aAs808bLO8BGbgjnjkjCtepmsMRA
    A2JNvDYg1ZQTKLgScHX+HEN09pmywQSdmvY9Mlf8PiJkP5aP09XZWTMw2p39nSodJAdcPk
    LvzOjpg/ojAERqxfBQrBi7FT9/T4BEITbMrpVRDYqoAOCbsQlIN6p3aXIaGlG0WaWEayf6
    8E8NmKCb6SCGeRxzZ2+CUQyQu7o21Yk4y1w5llrYRsRCYd5+KpDD7B7mHMJlH5NQo1mZ3H
    0RvICTNANcFQ5qiZFVTJe8cl+uK3rHPjSKH4Fq51tfiLJxVx3NA0zg2+oMs0pYzKW8wBvR
    56xxfcvmdrOvuvxLjXacLsBg9uC+NfeXQ4ER92TO3o90hAQfSCdA/VLUeflqHmBgyS32Wy
    TtesIqYxeZwDw1pBuZVf9OHOhqcHZNmNZ8quq5yXTfS5es4qGqcYuN48/CvcgMMiY12gm+
    Jj1BGQ2qjeGFcVHZW7MIs1fSxA7mNL2d0E4VEFkZzXs3og1KRc59rQQTId4A
X-ME-Proxy: <xmx:sBXaanHYz3hrdZpjcYDcBRuPX1ywxOpaUU7VmhalhRSWOt5WioIk4g>
    <xmx:sBXaanavlePOWD_8CwVw6sk_wF_Ri6V0QoXKMfP8cBlmUgQlkD57dQ>
    <xmx:sBXaajyRRdN51ILteqkWynoaXDELTxniVfbaQ_-jfLxQ5V1O1Uwfyg>
    <xmx:sBXaahQ2bTmudxu4MuOBRW_TJy6KXl0aaMKetnevMllDSJqnkQMVWQ>
    <xmx:tBXaahy66MOeP5BVuXljfIA4pQQqYP_gvdefW_Ntbo-H-VqLc1F8HL0k>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id ED79C32A0093; Thu, 22 Oct 2026 09:54:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AsT4sEkvhRpB
Date: Thu, 22 Oct 2026 15:54:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-Id: <0cd9560c-6de5-4744-90a4-ecb613594133@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2610220418380.22065@angie.orcam.me.uk>
References: <20261019090017.430425-1-arnd@kernel.org>
 <alpine.DEB.2.21.2610210422160.22065@angie.orcam.me.uk>
 <alpine.DEB.2.21.2610210500560.22065@angie.orcam.me.uk>
 <215c694e-bb97-4c21-ae5b-308c03e21611@app.fastmail.com>
 <alpine.DEB.2.21.2610220418380.22065@angie.orcam.me.uk>
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 22, 2026, at 05:34, Maciej W. Rozycki wrote:
> On Wed, 21 Oct 2026, Arnd Bergmann wrote:
>
>> >  Or, to self-correct after a few more mind cycles spent on this piece, the 
>> > region below `port->iobase' is an expansion of one above, where standard 
>> > 8250 registers of the onboard serial port reside.  Which makes even more 
>> > sense, to me anyway.
>> 
>> Good catch, so it should still work the same way it was originally
>> designed, though I think it still requires a modified setserial to
>> set PORT_RSA, or a boot time argument for autoconfiguration with
>> UART_CONFIG_TYPE.
>
>  Well, this is ISA, what do you expect?  We've dropped lots of stuff that 
> required perhaps even more complex manual configuration already (QIC-02 
> tapes, anyone?).

I pointed it out because this is the only UART driver that relies on
that specific mechanism. Everything else uses either hardcoded port
numbers that like the 3f8/2f8/3e8/2e8 ports for PC compatibility or
they rely on PnP. I understand that we have other network/scsi/sound/iio
drivers that also do this.

    Arnd
