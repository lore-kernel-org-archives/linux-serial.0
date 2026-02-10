Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E5366DB2;
	Tue, 10 Feb 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732679; cv=none; b=lrlPVmGlTDyI3xE9Fl7sCgQBaF1QxcLDzS0M3CO+2ep0iTYZ1SDR5mwZoW5fpU8yQYn6k2PGfQF7osuTPoCd+FaFiUXIfVg8oNWGtbJIC478de9Yz6zbqD3ui/VRf63sWCS26NiaRp2nWKaH2vTM+A5cIXGv8f1wBHUvITtF+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732679; c=relaxed/simple;
	bh=CoS6Jf753eEZ0gvS8nbVoJ0dfuWzf+THNxH+RaSyKZg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CRyh6NVTrEtd6o2v8DC3W0bBAu5ovxj99PF48V/FprL/4IpLSAz4F9Q/bD3CbTTFYno2CMYfg3fgT5e00iNOQwXhP2k6/tzbU3D3U/rfGcoZ/voYhTww2Vb8d0rZwA1gz7oHNfVb18wjFGUTDmH7/DA8sqtg/ACqeP+uiRObCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kLstkvx5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htvVur6L; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kLstkvx5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htvVur6L"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2959E7A01EA;
	Tue, 10 Feb 2026 09:11:17 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 09:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770732676;
	 x=1770819076; bh=bWqqOcw4XreRirHPPhwHf9g6BsMeJi4kw6rOh4QnDDY=; b=
	kLstkvx5COCCf+qgR8yQGQX72EnsDgrfppj6D9BtfHfs4FUFyDOm37l1TSNFTqA5
	b/qnWOgxcleRsAOumGbSnr9gx6SA9umUvavVXfe29gzPUPy9VBdw/rYEssqAh4t2
	X5qs3SCK7fqhGb4QniUn8Ptvz2m5fULj8+H++VdMzXz4avlY8LVzmOb5xzqNqens
	sZhruz3aHwgZrxWLv46k20CID9HYoCtAv1dQmub+/SkSwAl0IpLVM4rp9+lDZSsV
	FXFo8J7aFSjQSpl8OYQDl3D9KXn03/9tPtkg4wvICcKXGiAt0Y6iJtFzRTnyIKgG
	DtYewY85HwTLRBXSXznBqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770732676; x=
	1770819076; bh=bWqqOcw4XreRirHPPhwHf9g6BsMeJi4kw6rOh4QnDDY=; b=h
	tvVur6LcsaH7Q6nTvvoU1DcOINsd2n7fbB7M6BPmHFQzcbw+pytUvoryY29BLzfl
	9qb/eW4WK704Gat6h5+nTdKSzHaGc6Iqk8soImWWwmvzYopMJK2fdb/Fq97D1Py9
	F7RdP9D0GMHyPfxom1u+NA5fi/o+0qbbKuODI4zguxNB604go96DbXD+v/0eTkko
	PwQAIj8sLIQYH5GpQMQkcGZeNs2NQC0FshXlvTeCVla53aNLhPjICj1QuLA6DafL
	YjiSqLsd886AgmbS6F4LlwIXn/EGdlQDwMcSryvNQoGec1+Vjkh4YfNFvpUPBgoU
	GCLIWd9/MeuiLuCndryqA==
X-ME-Sender: <xms:hDyLaUeqkeZ6OJmnMf-04gLjQ7sBhtBcMDB44aqQHMenygEzNL2esw>
    <xme:hDyLaRAeBHLe7VM8JkyysY5nY05SQMBSxn2gdxLa5ah034os8MdKwQxXWjAaxYOAB
    25w7195hWWqcv0bffevHhTFS8OkUCRSUe5Xd2TmWubr0ewEMQE4nzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehlihhnmhhqtddtieesghhmrghilhdrtghomhdprhgtphhtthhopehjihhrihhslhgr
    sgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhr
    tghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hDyLaRN8SitmdCqiQa2KhqP22JeOqXM55N2MlhK9MBvGsNXK0a_egQ>
    <xmx:hDyLaWjGZ2iGG7q5G5iz0DgWWvEjUeBoc3jYNe3_vOR7mRC9xcgAMA>
    <xmx:hDyLaT6_bk-DQiqbF4FVTRXBn-czXfxL96FhGS1TKlyTtIGbb_2cjA>
    <xmx:hDyLad3WrXDBtXca5An97TA4XtQc4Sy_nWl4UPdO7xjyes9zj3MWWQ>
    <xmx:hDyLaT2rqz4wbZy0vFRRz3IOAzjZUDWaM62_AqETEJiBIjQRUlQpGl4t>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 778D3700065; Tue, 10 Feb 2026 09:11:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7aFLWfceQ13
Date: Tue, 10 Feb 2026 15:10:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Maydell" <peter.maydell@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>, "Miaoqian Lin" <linmq006@gmail.com>
Message-Id: <7a80b31d-f909-48fc-9856-37d698b448fb@app.fastmail.com>
In-Reply-To: 
 <CAFEAcA_nUiQ9ROXBq6Q=3G1wzLtBHDEKSB+4OyYWkt-tR_ZTJA@mail.gmail.com>
References: <20260210125100.223138-1-peter.maydell@linaro.org>
 <316ebe17-5938-4e8b-9269-934c7c773c01@app.fastmail.com>
 <CAFEAcA_nUiQ9ROXBq6Q=3G1wzLtBHDEKSB+4OyYWkt-tR_ZTJA@mail.gmail.com>
Subject: Re: [PATCH] serial: amba-pl011: Enable UART in earlycon setup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 10, 2026, at 14:49, Peter Maydell wrote:
> On Tue, 10 Feb 2026 at 13:23, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tue, Feb 10, 2026, at 13:50, Peter Maydell wrote:
>>
>> One more question: what is the symptom without this patch with
>> qemu? You mentioned on IRC that qemu may warn about attempting
>> to write to the uart when it is disabled. Would we still get
>> the correct early console output before the uart is enabled?
>
> The symptom is that if you run QEMU with '-d guest_errors' to ask
> it to log things the guest does that it thinks are bugs in the
> guest, then you get a lot of "PL011 data written to disabled UART"
> warnings. The guest still boots fine, and assuming you directed
> the logging to a file rather than stdout you see the guest output.

Ok, thanks for the explanation! I still wonder whether we will
want a stable backport of the patch. It sounds like it won't
be needed for qemu (because most people won't see the harmless
warning especially after your patch) or most real hardware
(because the bootloader will have initialized the console),
but there may still be corner cases that need it.

      Arnd
