Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C501B9B24;
	Mon,  9 Sep 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887428; cv=none; b=lvdHr3qoXsPlW42GtWl4tdwpvOJZ4gK+w37XmGIwKpnJTPmNA1W/jb10L0pUAfAtjR19dkAbX58mu8XJGn+ivgbdwN4LH0at4u6Q/xbHM8HW6EC3vERFziZsFB2fSU9U+BdqOd4euNh5ngeRpZ6seKtjMJgHzFqvpF9HVi34bjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887428; c=relaxed/simple;
	bh=FOb9cDj+LeGDsiMg28ppP3KCfoC0waIPwBP00Op7h7I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=alhgLLAXlM5i4ME0l0o+yVPOK8eeXjE0/9MRJLI07QISmgWTyGkRqaPqgApo5h5Yrt50e4FwxPqQY6AlfHxqtuVOtz5kSWyo4xfz47QvEEMd5hwge9Yb4WDfI835wyhMqESAgJHY35MZPHZkf0cYw92d3AEjJejZF+fn/OpEF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=iwaqh3Vb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVioyOQP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="iwaqh3Vb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVioyOQP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id AE6311380188;
	Mon,  9 Sep 2024 09:10:25 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-07.internal (MEProxy); Mon, 09 Sep 2024 09:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725887425;
	 x=1725973825; bh=hZmFB4zZqsK/lqmaZT6pZoo+wceOfyxthIa1HVadf+Y=; b=
	iwaqh3Vbcq58OuQaQSBvCXnuaPO69yL+rbF6X1Vt6CeonoomrDaAL3Cz+KtOC303
	glVVO0D2EUj1klePj8h5sQ52SBe7ejzOYBm0mazavBmDxMY3J9VkRPyBDIj2nTwC
	wS3BMz30Wsw37mvNyUeA6AkQRqGZRvkihcI1XaFU0yN8R0GCCzHYk9oztQHt+RUM
	w+uprG2zyz0vShXPC5Y5llMhazvo9hpFnmfgQVBKrh4u1RPqqEirq7qMmwZqSyTu
	750vlH/VNeUkeUdfotfLSWEZ9JobGZYAgUORGlz6OMhwivJFVMKY4reCzQlg4QF0
	Z4KFxk4DPnm6t/ULlHIH/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725887425; x=
	1725973825; bh=hZmFB4zZqsK/lqmaZT6pZoo+wceOfyxthIa1HVadf+Y=; b=l
	VioyOQP42MXQxqXbCMj7fp3PTTeQ1R7FETY5rdSVPo/jXrC7l2S6zRWwVFpQ5xYS
	Y+4Qp9PF4Xo4+HgesfwP49RRSkAiyQQkP/204rOBK3cOazwJL1GjXcUZl7XiEtXG
	XyjCUIs64cCj++lcgH/tJjIvzA+vCN8NbzOXR6E+vrOH7O92DqmADe3dsVE/nveK
	P8aD6N700Qaf+xu18NNYcGjlZdieRBuB57lwycz3MgP+CtLGceMr7IUREkQFBwSf
	3abCFNBxOambv9Yecvf5HNA7hJFJVVEnuAqMqnnzL/tQQmmzKQb/VzBwpTY7bzbO
	HkqvErpZ4kVQ7Nu6290Tg==
X-ME-Sender: <xms:wfPeZp_KlBfGdgbKnue9xuMPSs6vXzOXPLbsmuhi60qGWLC048-6Sw>
    <xme:wfPeZts776ysby-xTITgx-Ml3TL9BrCARzwFLxpNmEN5dUlo512Dr6gm2xPOr0Oay
    hvB-lFaW-0q6dctNYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedflfgrnhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvth
    eqnecuggftrfgrthhtvghrnhephfeuuedtteeigeekieffjedvgfetvdelgffhkeettedv
    veehieegfeffgfeiffetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdr
    nhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehtohifihhntghhvghnmhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhirhhi
    shhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheprghlihhmrdgrkhhhthgrrhesshgrmhhsuhhnghdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhsrghmshhunhhgqdhsohgtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wfPeZnCW56APoNKMia-eB44-4XJLrEWwOMaIWZRMQz27II4eFc2pjw>
    <xmx:wfPeZtcZ56e8XyEKz3_R-gfyk1UfLYKxumZYJ6wemzthZik7aEpTgg>
    <xmx:wfPeZuPuFJ_L1SCUzdo78KP74XZvuHUnR22OJVkiy6BM1l8dr0y-fw>
    <xmx:wfPeZvlEtB6d6IhLxLuZgrWlwc0x4WAAv5doPT6GZInS9zMwCFAhSw>
    <xmx:wfPeZlpeYuIYyn2ApEWOGwT3322zXzYJk7fTAS1UHDvZZ7TY4q_yEuu5>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B4241F00083; Mon,  9 Sep 2024 09:10:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 15:10:04 +0200
From: "Janne Grunau" <j@jannau.net>
To: "Nick Chan" <towinchenmi@gmail.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev
Message-Id: <d7c611c3-f2da-40a7-9b47-ebbdf6ddf321@app.fastmail.com>
In-Reply-To: <20240909084222.3209-1-towinchenmi@gmail.com>
References: <20240909084222.3209-1-towinchenmi@gmail.com>
Subject: Re: [PATCH v4 0/3] tty: serial: samsung: Serial fixes for Apple A7-A11 SoCs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

On Mon, Sep 9, 2024, at 10:37, Nick Chan wrote:
> Hi,
>
> This series fixes issues with serial on A7-A11 SoCs. The changes do not
> seem to affect existing M1 and up users so they can be applied
> unconditionally.
>
> Firstly, these SoCs require 32-bit writes on the serial port. This only
> manifested in earlycon as reg-io-width in device tree is consulted for
> normal serial writes.
>
> Secondly, A7-A9 SoCs seems to use different bits for RXTO and RXTO
> enable. Accessing these bits in addition to the original RXTO and RXTO
> enable bits will allow serial rx to work correctly on those SoCs.
>
> Changes in v4:
>   - Removed fake Reviewed-by tag added by accident... need to stop
>     making stupid mistakes that wastes everyone's time. The remaining
>     Reviewed-by is real as far as I am aware.
>
> Changes in v3:
>   - v2 did not declare itself as v2 in subject line... resend as v3.
>
> Changes in v2:
>   - Mention A7-A11 in the comment about changing register accesses to
>     MMIO32.
>
>   - Use BIT() macro for new entries, and change the existing APPLE_S5L_*
>     entries for consistency.
>
> v1: 
> https://lore.kernel.org/linux-samsung-soc/20240907111431.2970-1-towinchenmi@gmail.com
> v2: 
> https://lore.kernel.org/linux-samsung-soc/20240908075904.12133-1-towinchenmi@gmail.com
> v3: 
> https://lore.kernel.org/linux-samsung-soc/20240908090939.2745-1-towinchenmi@gmail.com
>
> Nick Chan
> ---
>
> Nick Chan (3):
>   tty: serial: samsung: Use BIT() macro for APPLE_S5L_*
>   tty: serial: samsung: Fix A7-A11 serial earlycon SError
>   tty: serial: samsung: Fix serial rx on Apple A7-A9
>
>  drivers/tty/serial/samsung_tty.c | 22 ++++++++++++++++------
>  include/linux/serial_s3c.h       | 24 ++++++++++++++----------
>  2 files changed, 30 insertions(+), 16 deletions(-)

whole series tested on M1 Max and M2 Pro

Tested-by: Janne Grunau <j@jannau.net>

best regards
janne
