Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126286;
	b=dwf1fJFk5sh1VcvHrLGhxWBl+Yy6pS9jw0GV1ikArDQBClgtk68I08kM61Cm/hBAx/c5
	 hcQPZnLqpfmcGMzBH8qU2w1zYfYhjHbZ5My3IwTpb1Yy//qbq1Svc3RtBtO+yHeI3EZWu
	 wlh6VtRAdCjwNR2cSRnbisYrRzkkv40uNJnvcH5117VxLjsGVgGPY9HQVgGT/rvJkMmk5
	 vPl9sHgfkV/bSURi/3SPtAyykbUWpfgbMYxmPUmOabzDt9GpE38BO6bgbsUI5AgnpjREx
	 QGyJ2gukZbPtHagMOgiCa4md/MOtHHOgbs8uClIzToGnJOiywNnDKGz7boSkce0bT6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126286;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=I0bzisDBuTS1Q78ghbcJzWMDpiSkPusoR4glwS10mTY=;
	b=iFiKmoVFDqVT0bgd9fwQ82WMCtONvPi5iRxKk0SJopwopLiQzYnwhvnSMIh/H3jToN6a
	 Vk0rkrp3Fvd0zkW1BSrekvSwnWWDY4teZ7AgJ6By5/3MInk6xt0J/2KVnVQeS16JPf7jh
	 sXr2+FdoQgMex4P6gNddZuogXaB9MMp11VUNSVWlmoa44H4Bo9Pn4ISiC3Tq4oPX64sJn
	 Ov5lxmaOX8zYNoUszTI0k+t5rnEGlzkgOVA51fMfwFIzR9exVbwlgrFRlayt9npt1dZ+x
	 9U1Jfj2XIzoWU0+ThxYhlPMk2No43tbU7966xkTCk07x9jsGMrMwrzA5YgZNWLOHp+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=TbUvqJ65;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZeWGuxdf;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7C606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 18:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70E7C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=TbUvqJ65;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZeWGuxdf
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A8DEEC0E2C
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 14:38:05 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 27 Oct 2026 14:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793126267;
	 x=1793212667; bh=I0bzisDBuTS1Q78ghbcJzWMDpiSkPusoR4glwS10mTY=; b=
	TbUvqJ651iaEyGi/ny+upjG23e16fw5zdIUkVtuRWn3URuwJnEdU4o9bMfl14FfL
	5qaJSQKWCTWS0JtPIKqy9J3QCnV3uOXQjJS3Axh2GIJfqeVQk8fx0SG3yXQh2Q7q
	9uEXQSDEvW96qUsoX2OlxAutaSsZmbZvbvKdjQD7vh3cTokHneP/YLwRQ6mx6vo1
	+nLnCFZX6z/QMZzzJToIMKP94lpBznGTIjLGKXK8eUCd7cudL/yhuH/fa/ZAhYpZ
	iAmqZ2WtqLSy3m+pew8sv8wuhyGY5rFvPUCKhx5MzWMqWgFsMec+JKi+ZdACyTtW
	/05UhOxvTHVLeDqhB1x6ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793126267; x=
	1793212667; bh=I0bzisDBuTS1Q78ghbcJzWMDpiSkPusoR4glwS10mTY=; b=Z
	eWGuxdf9JHhw/xAFbEAvKql4PqmnFwJBiqQZ+KiMnZxILCOD3vf5VmxVj0/SGLs+
	XaVnXjtmeIht119BNUzDz4t+OncAI/NxWbszSye3ZpEnkvWRUXRo7Y94pd/luomK
	pjtxdv3XHivNOpy1sjX0kJcm/DehpqrxAXTqqtegItWeB/Rt/1BVsehdgo+7RLgh
	87GYUjHHpq1DV3NnfD4xMoGZLru3zRuVwGyuokPthnhspiOnBU/F2QQf+MDM4Fyc
	WQ90r2bzyx/TUsK1z101M9hjpz3CivbtFUM9TdM2yPvwot/0ylIOYuauqVofOwAR
	zn2t/vxA94HBFZyE/TbQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793126267; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AbIbPaqDzOvuG7ygylfVzccIFpbChi8kDIHdCUZwxlWpR+f
	YBKgfSbjv0M8n5D/lBxIzpCk8l6FzRF7qeipozyKigKUDkz+UXJ1g70TDOGJbSqX
	+Kd2BJnv0aPGS7fiPSPco+4HpFMJ4eBYgpOOwcXTRjHUBa32KyVGstM8xq9KxNPO
	dgxdkIhAea5EUI4brzVCpTBsHuHGAgODpuu1PsUWnzVh76mX8cyMxTKIipIS7PYm
	Idfm37XbwNVtUUwdEQQjT9zh/cxYmJ6X78/5LFTT3SjRM5OCf8N3vyQ/6qV1jDuF
	q065XmqTxrK//WFfiWKsOkQLN2lds3fQoBqojLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:shQIbZbfW2UplPxIlxdSmCWNC74DcI6YbtirgSmuf/o=:D04eJIdyxoeHJFFPd44xIR1K3XcUmM+8k3F2BW/mAYM=;
X-ME-Sender: <xms:cO_ganAP_gJianBj89RA_0ymu92l5vyeJrdRXlM5JSGcRq7jPbRKDg>
    <xme:cO_gaoUG2r7G_APiJ434rOh8LaWT-Gt85C6rUS7yD_CjWZknZm8jORKu3AI1oyj5U
    cyIy0hcPvnLG_6H8OU2S1SScrWbnrY4QS0mw7Cg0IZx7dIUzaJdino>
X-ME-Proxy-Cause: dmFkZTFUNM9h/ZpGr9ttM2X8UOAFboKzl/RmINxk15H4Mi8NcCXgrz/uu220pe/4VAqLoN
    pk+9H7J0lh6wvCz9UicpjPpaiWzTAgQdD/n/jbGACDaxtn/pd3XG2WFPg6l72WZ9Si8+En
    Ufv+kWWQcKd8Vl0cXqL8b0TyTnu6VaySRBaoSOjc9ARti/itUaDm8BqimvggRkmgVYK57F
    JEsKvqk0Rx/l0OC6ZMF2NyGgW8ug7pC6KvlD0wJg87ldI1JPsrcpAz1mKZdK4cnqpI3ElC
    5KKNTEa0TDVPolG2Q0uf9pBFK5uZcTKpsgMor/P2hTs3tbzlthg/Ak2gtMObhZ0WugGxmN
    7VwSotz8GlwCuAiYttcv5kwZq4kjxAnO+labb698J3NdctOLWO55ULMYgbHqr26GZbYTkl
    KPZimfM0Q8wCZPdBddGa9o457+OeYUHTRukTju6/Yk1d0fWWrO/s1HZujGcDXAn4m6eo5W
    DpYVgCHi4/7ZYg5SCJ4vKvvNavD7VHPJki9UGgcJ24aTZx0GzR4gNGaki39OyZN8mL1Ym8
    nHbQhxn7ndq4820m6jAsjBs3FbnATQF3H+DhA+6Irjx5NKADAUxjwBFwAdX+uFO42VB99E
    wPXpjKL/MvmdzOkk579u3euThnauBoOP39gYNk3pGT2ptuLtFH92TXzfAiUw
X-ME-Proxy: <xmx:du_gauVFp73xhY9ZqloV3_W7TMxNMUhxrX15mXW4sW-eU0-bGRVx8g>
    <xmx:du_gat5usgQeLPkMC41z4NYB1DEfx0VWUFVIz8uOjLjjiTnyeUOeHw>
    <xmx:du_gamdSdBav2pHiC02Zt7PdCqsuYQ2aD-jFSdfDwlR0AerLjT8J9g>
    <xmx:du_garvpUo9uNooxiJI9rGbyYzzeygV319neqXWPb5iiKnsJUtsAAw>
    <xmx:e-_gajDdi3PaFEuf93EVKyxYBA5dhAEL44TkcJY42_SyqdZWrW9K-qfQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6D78932A0097; Tue, 27 Oct 2026 14:37:36 -0400 (EDT)
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
X-ThreadId: AOq_Oqeu6MIs
Date: Tue, 27 Oct 2026 19:37:16 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Joshua Rogers" <linux@joshua.hu>,
 "Chris Mason" <mason@kernel.org>, "Josef Bacik" <josef@toxicpanda.com>,
 "Tony Lindgren" <tony@atomide.com>, "Rafael Gago Castano" <rgc@hms.se>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Peter Hurley" <peter@hurleysoftware.com>,
 "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Crescent Hsieh" <crescentcy.hsieh@moxa.com>, "Frank Li" <Frank.Li@nxp.com>,
 "Sherry Sun" <sherry.sun@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Olof Johansson" <olof@lixom.net>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Peter Griffin" <peter.griffin@linaro.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>,
 "Robert Baldyga" <r.baldyga@samsung.com>,
 "Thomas Abraham" <thomas.abraham@linaro.org>,
 "Kukjin Kim" <kgene.kim@samsung.com>,
 "Patrice Chotard" <patrice.chotard@foss.st.com>,
 "Srinivas Kandagatla" <srini@kernel.org>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Vladimir Zapolskiy" <vladimir_zapolskiy@mentor.com>,
 "Al Cooper" <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable <stable@kernel.org>,
 "Broadcom internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>
Message-Id: <4243bcc1-63a7-449b-ab8f-4eb901aec7ee@app.fastmail.com>
In-Reply-To: <8ef10868-b203-4846-bc47-2d046805e1d3@broadcom.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
 <auC-_1Er0Kp-Wq76@ashevche-desk.local>
 <993d16f4-c8e6-4896-adf4-f7f36d937152@broadcom.com>
 <auDb57N7KCqaTWW0@ashevche-desk.local>
 <8ef10868-b203-4846-bc47-2d046805e1d3@broadcom.com>
Subject: Re: [PATCH 09/24] serial: 8250: 8250_bcm7271: fix DMA address truncation to 32
 bits
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 27, 2026, at 18:19, Florian Fainelli wrote:
> On 10/27/26 10:14, Andy Shevchenko wrote:
>> On Tue, Oct 27, 2026 at 09:41:17AM -0700, Florian Fainelli wrote:
>> You never know this. The use of u64 is simple as that: it goes to HW as 64-bit
>> value no matter what. Note, in the past we used to have a problematic use of
>> dma_addr_t exactly due to its dependency on the data bus size when programming
>> HW, and hence, based on my experience, I hardly recommend not to use dma_addr_t
>> in this case, use plain fixed u64.
>
> It's not a hot path where optimizing for bus transactions would make 
> sense, so I guess it's fine to use u64 and have the two halves 
> programmed accordingly.

I would suggest also setting a 64-bit dma mask in this case. The
reason that the temporary 32-bit address was always fine is that
dma_alloc_coherent() is limited to a 32-bit address by default.

     Arnd
