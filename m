Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29F23FC7D;
	Tue, 15 Apr 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744396; cv=none; b=jYs4YNu0MB7mGZVUDnuL/PLeDul6C7AX/KxvBaJiOvsqRg8LKlfOk4EhWwi+fLYHi2BiLIC2Ae1qn2czLi3ge2eSnAVFpYl+VN4uGmtZwOTnnvm6Q6xgmno11ZppiycwBwf6kC1o58W1SQv1+jLhC05RyWb0agfukLAR5JsUBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744396; c=relaxed/simple;
	bh=wz8xPMukO/aSm1aDY5Cr5IlsKr4y3kHH3k8OWNypBvM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iIXbYCOVjFAKlQ3Ql2Drwbs8ZOJeBTL1Z/bpp5Nem7VajS+rHG/uwWh3ECAzbSyelpjr+5jbyCgJXt+QB4jYEJR1fTEHbQufZnUIa4WrRaWqVdMrEYwXJFNXSbG9u/1kmVTgo/u+4B84lxfVqdkdKkKuHmjycn1ssPoolvwHG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=ju9sK/0E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjI/1wUD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ju9sK/0E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjI/1wUD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20CEB114017D;
	Tue, 15 Apr 2025 15:13:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 15:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744744393; x=1744830793; bh=zsByCFFCTP
	FhABfVDAJ7hPpLqjzW362oqvziJ4wBl88=; b=ju9sK/0Egc/8WoAS0kKza4rs9Q
	/9cKCsVfsuIK4SEvJNjm4Wgyr0aP2YOuViJt1X/MptiMeJ3/DtoliGRQJKn00vE7
	ruYtFUGhKpJMwcHIE6iSQyAPZn+1POubkpg4Tx0sEFdc8ZcUrNesgSWi5LRqIrLh
	qSrLcRYlESyO3RmRu9Xa8GwrCJUamuYRjsi36J9DEyGgJuqeTsz+4LQfI17SMZ67
	EQN5QGHW1ow2DOhv/vYjhEq5tRrk5zZldWrJp/gHPjQicpFqUaEMxefSpXQT9r8z
	H0Ku4jEEEW+vJvjshZV8OMLeCGMQsv9DbsqESrHoh44wtPDSV9j0o5GxCf7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744744393; x=1744830793; bh=zsByCFFCTPFhABfVDAJ7hPpLqjzW362oqvz
	iJ4wBl88=; b=IjI/1wUDy2gWfYNsknF1+eG2pPncIe3sAUOqlZWH+tBKCLWqBum
	LTIQa2xRdBbNcc9CtAnXJLAAoT9caqGK9la3ACTlr6gOTgIUmzGjNju4k1lgDJZb
	dOuXQINkZ/WhhIDgOgMFBF/ngbWFDa0+GHPmHwJifKaVi2WReXwq8rnmbqH2AK9m
	VT9CxCuDm72imIBiD5e7bf28xjWduB+Qjoc+TA1N2AuNwbQzj8voo5kYs2GWshs/
	VbYvwUS5H15nL+sYDE+i3AXQqXFAYzSaJFDUBxBFotJblkp0oJZOtquRjYCCU9Jm
	EOoy/6fnF3tHnshDZyrj2IixaszHg/Y61lg==
X-ME-Sender: <xms:yK_-Z9FKXmvB8yyXeYp8xXqAJtBoKIj0wQOLp6IgPPbVJOy4QQW5dw>
    <xme:yK_-ZyW9_-wzeMM1FE-7yp08CtHbnFWa25yQb7AuRmG3qWJz8c2GX11d-jrlQwvIv
    CgtH3iRN9UnmVicGMw>
X-ME-Received: <xmr:yK_-Z_IeTximZRQZCmkWENMEGdgZCr0iYX2VBU708SBcG_H5b89hkc9zSahZJCqQUimy2sqpwCYmFY5eQFM1NbeX23Og4QYacvwIc-006B9v-UVVzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpefgvedvhfefueejgefggfefhfelffeiieduvdeh
    ffduheduffekkefhgeffhfefveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirhhishhlrggshieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yK_-ZzEFeRdby6La1C5uliTtTlcpUy_o8NNFha6-9HmCye8eMJRskw>
    <xmx:yK_-ZzUAoTx0Jqc3TzwZ8NpdKkdhGx7frpOLxPVatOkDW_MitDEQOg>
    <xmx:yK_-Z-NQfx7hSl_LFcDdeLjTiPPGwvJnXG5ogEpXZ7-tZSk1TQ95Ug>
    <xmx:yK_-Zy30wjyOF1KsULPfrLqAlL_fQHOxBEekf3DJcQrSr14ctWSCcQ>
    <xmx:ya_-ZzqGDx7rp330AHJ92dz92xZ9kYwyorCawzIyUMSBVwADbHnz_hKM>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:13:12 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 444BA11165C4;
	Tue, 15 Apr 2025 15:13:12 -0400 (EDT)
Date: Tue, 15 Apr 2025 15:13:12 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] vt: introduce gen_ucs_width.py to create
 ucs_width.c
In-Reply-To: <e1cfe5a4-5b4b-4b72-821c-9fae81fff3fa@kernel.org>
Message-ID: <n7on371q-5r52-3s59-r48n-811229064q3o@syhkavp.arg>
References: <20250410011839.64418-1-nico@fluxnic.net> <20250410011839.64418-5-nico@fluxnic.net> <e1cfe5a4-5b4b-4b72-821c-9fae81fff3fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 14 Apr 2025, Jiri Slaby wrote:

> On 10. 04. 25, 3:13, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > The table in the current ucs_width.c is terribly out of date and
> > incomplete. We also need a second table to store zero-width code points.
> > Properly maintaining those tables manually is impossible. So here's a
> > script to automatically generate them.
> > 
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > ---
> >   drivers/tty/vt/gen_ucs_width.py | 264 ++++++++++++++++++++++++++++++++
> >   1 file changed, 264 insertions(+)
> >   create mode 100755 drivers/tty/vt/gen_ucs_width.py
> > 
> > diff --git a/drivers/tty/vt/gen_ucs_width.py
> > b/drivers/tty/vt/gen_ucs_width.py
> > new file mode 100755
> > index 0000000000..41997fe001
> > --- /dev/null
> > +++ b/drivers/tty/vt/gen_ucs_width.py
[...]
> > +    # Mark these emoji modifiers as zero-width
> > +    for start, end in emoji_zero_width:
> > +        for cp in range(start, end + 1):
> > +            try:
> > +                width_map[cp] = 0
> > +            except (ValueError, OverflowError):
> 
> When can this happen and why is it not fatal?

This is some bogus leftovers. That doesn't fail.

Those scripts have been significantly cleaned up.

> > +    with open(c_file, 'w') as f:
> > +        f.write(f"""\
> 
> Why this backslash?

To inhibit the implied \n otherwise the file would start with an empty 
line. Same reason elsewhere: to prevent spurious empty lines.

> I wonder, if you could generate only zero_width_ranges[] to some generated.c
> and "maintain" the C functions in the kernel the standard way -- including
> that generated.c. I.e. not having C functions in a py script.

Yes, I did that. Easier to maintain in the end.


Nicolas
