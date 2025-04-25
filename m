Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7218DB02;
	Fri, 25 Apr 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597638; cv=none; b=kHzfgKVdX6RLqcrWzvQcvoZednJPVb6+5yxftVL0+XaRGSWZAbzamcSHjeke5qlDw1Ek3Y+AzU3g5B1gApIubLm6cydUywJIr06ip7fsSot1+E451VK8pRJJYUKWl/+3vqu/QspFbacTH3wa8xFwdDycvVIN0ajfnooRbkp38qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597638; c=relaxed/simple;
	bh=AuyWfrx+dvQzrTxgKjoCW6rOdYeZI6fYUeL+Q/ZBG4k=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HqVNseBpH1PsllOMtJ4cNj3mBZPp5s5eI56J1oV5Z26ueLyGbUSWkgM9bGTjj1oGpMjVLgdaVEscMcOJ7N9us1E9YdQj9rf3UonWwKh2nfeCJirFOQA+CAzn/U2Pe6IVlRGPo3pr1cJPlAaQU5tVWnjgK/3qAIKNGscnEAjE/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=i0DDBjj4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puyFUw+t; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="i0DDBjj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puyFUw+t"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C81B625401F0;
	Fri, 25 Apr 2025 12:13:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 25 Apr 2025 12:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745597633;
	 x=1745684033; bh=gu5XKhpxKX7r1k09RdqlZZq6m7CirpXTD87nnSUIIsk=; b=
	i0DDBjj45+tOoDXX+WAZXYetG8Ifb5PSUy1CRf3nYVPtXGURGdK9F/m8gBoUEtT1
	V3CaedFFI9XZ4dtjP98IaPN9zVmwZ3SH7btBvIiRceT4GB+rsiEcEcqcrX3gpqRT
	RCU8XbPKZUatotnBWmvEawlEH2rZHHRBA1Jwk0Pdj9f9Porqeiscvj/Lm2HUDNJe
	fSTCDIDF5Zr/2cZvE7Mel4Bdu1n5RF9p862C3NT0LpkF2wJDkpgM+mXTgDvj0K8x
	rdmgQoCDXHO1Cr/O3zQrfLAJ/7GRY4AVddVWCW98vrkTQyICAmOMQWA46qSysTmD
	8vgZj+BbohjIImaJ7w/KdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745597633; x=
	1745684033; bh=gu5XKhpxKX7r1k09RdqlZZq6m7CirpXTD87nnSUIIsk=; b=p
	uyFUw+t0LhgFBcqSVnZc83CizGVQVk1cW6A0fpmbOAmjaIykXQmVIdT9LEb2aNWr
	kFoHmwtlbxYDeJH5APY4Q2mi16WjrPBoWn1IuGMWqYLjP5hS0Fdg6/CIjNNvVjoI
	YZ9eS86L9Y3UMU9EydrEMRbkSCy+0EgfqQJqMHImccdGAEGKETJgFDC3nkt8LQFN
	daoKClvwhhH05LYStricOtTX7V8n0JiVyx6/rEykj6XpUgomIIlR5WOVcPbv/ui0
	tQSNvjL3Q1wf8SogErx25/i/+4TnrXFZkWt9tNZK+nriJMJwfcRdP4Ll6ydAJUij
	bSYxhG8j/RomEb3vNyTfg==
X-ME-Sender: <xms:wbQLaEKDBhlLyqNKlG1e_sCMIjaVXdulvnO0SgvVhEISTDVRwgjc5g>
    <xme:wbQLaEJLgQYKhSJvRVDxWOGyCea2e41fOwtovKSEy47jwtTRz4bOT2vyI6F-ef3dx
    GAZYvMr8JojizJ2-M4>
X-ME-Received: <xmr:wbQLaEuv4oIkbXQBcmH38OU9KtFvm4WdQr2W4oJ3jX6T2i03tllIGdT_W2uJqPr4Lpa_SmwcSoafrXVHvSlnPfhPHC_mFThgROZhDv9d5qVjN3M_yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhh
    tdejnecuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnih
    gtrdhnvghtqeenucggtffrrghtthgvrhhnpeeuudejheeltdeikefgleefledtvdekgffg
    ffffueetvdduueduledvtdekleefieenucfkphepudekjedrudehvddrudeikedrleenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohes
    fhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthho
    pehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhh
    eslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wbQLaBZxCUyiRo_NBA1XWbALgkjApUSj-bKLrk5tyhmoknKYKcDIaA>
    <xmx:wbQLaLauKmx5cCvi_X__LyRMm4EsTHj30O6DQr96-6HKmxarSwvmWQ>
    <xmx:wbQLaNCD0stycjs7yIlIBcJMVj8nH0NGZW0EzFcZOY8Mg0zDJ6Oo_w>
    <xmx:wbQLaBaRbEF4cJz4je0uzpJFm_W0bhlNdETn0Ar5t1wzAsZlvIr7DQ>
    <xmx:wbQLaBpznivKYl_RoWeTZOet3aT98pf7Mwie_GQttSkjLayRRrWXovie>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 12:13:53 -0400 (EDT)
Received: from smtpclient.apple (unknown [187.152.168.9])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 380ED115C2ED;
	Fri, 25 Apr 2025 12:13:52 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Nicolas Pitre <nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 00/14] vt: implement proper Unicode handling
Date: Fri, 25 Apr 2025 11:13:40 -0500
Message-Id: <2EDC209B-7D6B-4EFB-ADD0-58D494D8AF98@fluxnic.net>
References: <2025042517-defacing-lushly-10d5@gregkh>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2025042517-defacing-lushly-10d5@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: iPhone Mail (22E252)



> Le 25 avr. 2025 =C3=A0 09:29, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> a =C3=A9crit :
>=20
> =EF=BB=BFOn Thu, Apr 17, 2025 at 02:45:02PM -0400, Nicolas Pitre wrote:
>> The Linux VT console has many problems with regards to proper Unicode
>> handling:
>>=20
>> - All new double-width Unicode code points which have been introduced sin=
ce
>>  Unicode 5.0 are not recognized as such (we're at Unicode 16.0 now).
>>=20
>> - Zero-width code points are not recognized at all. If you try to edit fi=
les
>>  containing a lot of emojis, you will see the rendering issues. When ther=
e
>>  are a lot of zero-width characters (like "variation selectors"), long
>>  lines get wrapped, but any Unicode-aware editor thinks that the content
>>  was rendered properly and its rendering logic starts to work in very bad=

>>  ways. Combine this with tmux or screen, and there is a huge mess going o=
n
>>  in the terminal.
>>=20
>> - Also, text which uses combining diacritics has the same effect as text
>>  with zero-width characters as programs expect the characters to take few=
er
>>  columns than what they actually do.
>>=20
>> Some may argue that the Linux VT console is unmaintained and/or not used
>> much any longer and that one should consider a user space terminal
>> alternative instead. But every such alternative that is not less maintain=
ed
>> than the Linux VT console does require a full heavy graphical environment=

>> and that is the exact antithesis of what the Linux console is meant to be=
.
>>=20
>> Furthermore, there is a significant Linux console user base represented b=
y
>> blind users (which I'm a member of) for whom the alternatives are way mor=
e
>> cumbersome to use reducing our productivity. So it has to stay and
>> be maintained to the best of our abilities.
>>=20
>> That being said...
>>=20
>> This patch series is about fixing all the above issues. This is accomplis=
hed
>> with some Python scripts leveraging Python's unicodedata module to genera=
te
>> C code with lookup tables that is suitable for the kernel. In summary:
>>=20
>> - The double-width code point table is updated to the latest Unicode vers=
ion
>>  and the table itself is optimized to reduce its size.
>>=20
>> - A zero-width code point table is created and the console code is modifi=
ed
>>  to properly use it.
>>=20
>> - A table with base character + combining mark pairs is created to conver=
t
>>  them into their precomposed equivalents when they're encountered.
>>  By default the generated table contains most commonly used Latin, Greek,=

>>  and Cyrillic recomposition pairs only, but one can execute the provided
>>  script with the --full argument to create a table that covers all
>>  possibilities. Combining marks that are not listed in the table are simp=
ly
>>  treated like zero-width code points and properly ignored.
>>=20
>> - All those tables plus related lookup code require about 3500 additional=

>>  bytes of text which is not very significant these days. Yet, one
>>  can still set CONFIG_CONSOLE_TRANSLATIONS=3Dn to configure this all out
>>  if need be.
>>=20
>> Note: The generated C code makes scripts/checkpatch.pl complain about
>>      "... exceeds 100 columns" because the inserted comments with code
>>      point names, well, make some inlines exceed 100 columns. Please make=

>>      an exception for those files and disregard those warnings. When
>>      checkpatch.pl is used on those files directly with -f then it doesn'=
t
>>      complain.
>>=20
>> This series was tested on top of v6.15-rc2.
>=20
> I've taken the first version of this, should I revert all of them and
> then apply these, or do you want to send a diff between this and what is
> in the tty-next tree?
Please remove what you have and replace with this v3. Will be much cleaner t=
his way.=20


>=20
> thanks,
>=20
> greg k-h
