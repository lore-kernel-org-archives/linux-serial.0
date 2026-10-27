Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085824;
	b=YYkjTBhg6RL4YJPlMtHNJ8yNp97UwaVI5lBhgC/Rao2upA607UJ/Lz/voamxZIYZXPvL
	 mLjk/LQsCTCZj02GomDMFom1tIno01YvZvb9P5QgBnn9Ho3wEq6FkSGOKCQSeVOjnOzas
	 6x9dNzruY9LqeRR9xCkywMtkEaMOrSdRp2MZVJhNlrICh6WFd3w4ZsTHWdCBb7psFyXTm
	 +N5N9NTHRomGQZEO76vXmv4K+uY7DDMcj7y3qr1KDBtStgABNrjYaCrHYgK/yHtwZBtEO
	 347lqvefW5DlUV5iXYNNfvsuUrbWJzOQ0c7ieec42NTf6jvFA1x3BBwA45gPFCRS71A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085824;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bO1yG0iNpQrDUD1BSljDEVJJw76/E5KtM6Y7Lj122vk=;
	b=BRLQ8n6ImXQcB71/9PaUKwHQXr1YiHkZ+lMPZ3W4dgnv3jhGQfldfcOpd0U2+XYKSjQt
	 VzIhcfjpXvJMYwOiDXQE781abziZmhDN6Drz3Wvob6zdHa1Nb4XAp7DcbXHCfIe4ITSFU
	 UPFuzjFTMpgR2+K/hwok5PMOl4jIQd4ebYgVnFjXLu+J+NDvUL7QflnbiFhlBxCSARcmM
	 s06BRwyCw1LqdFW/NU0MGSGRKkF0Z43PHuBLHky2G2sf92M73oZApRgCE7OyYA8TMHgKi
	 Lf5tTTuYWx73CLie3GymmdhJXT5QPOdspM1lKrKG+O4N8asucTeTwz6ZlIQt4XmcGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdw3zqsY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E4B606A31A;
	Tue, 27 Oct 2026 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdw3zqsY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462D61F01825;
	Tue, 27 Oct 2026 07:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793085823;
	bh=bO1yG0iNpQrDUD1BSljDEVJJw76/E5KtM6Y7Lj122vk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hdw3zqsYAf76NUfhNwEfIA3FMnSY4lAZtfSQhPcdXEN9kVlh6zGddyZInJI6bLac+
	 keCkbzhHw+xn1lsPX0MjFtxiU44ds4swNZiA9CcN920yetx/dgwEO24JUUbvzf77SG
	 qn/tmX/+wkbcDU8SRYbsnyBPHZvCOap5fiB1wJGO7ShhFvERwerguLMuUiUElADOC9
	 HL1xqYjI3S6oykGtA75sBt0j6uKKGquB5zL5LBOInh/Vd8Pdo+0XtVBAoacxr4Rg8i
	 Ot+eGt/kFCS60qDpvJTc1N1cFUuz5eV4Xsd+0lkprK8GTNzruA6vy7Thf3WrivKG5O
	 KE0ZSv4X8afCg==
Message-ID: <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
Date: Tue, 27 Oct 2026 08:23:36 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
To: Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>,
 "biju.das.au" <biju.das.au@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Au Dang <au.dang.jx@renesas.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2026 08:19, Biju Das wrote:
> Hi Borislav Petkov,
> 
> Thanks for the feedback.
> 
>> -----Original Message-----
>> From: Borislav Petkov <bp@alien8.de>
>> Sent: 27 October 2026 05:58
>> Subject: Re: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
>>
>> On Mon, Oct 26, 2026 at 11:23:32AM +0000, Biju Das wrote:
>>>  drivers/tty/serial/rsci.c          |  4 ++-
>>>  drivers/tty/serial/sh-sci-common.h |  4 +++
>>>  drivers/tty/serial/sh-sci.c        | 71 ++++++++++++++++++++++++++------------
>>>  3 files changed, 56 insertions(+), 23 deletions(-)
>>
>> $ ./scripts/get_maintainer.pl --no-rolestats -f drivers/tty/serial/rsci.c  drivers/tty/serial/sh-sci-
>> common.h  drivers/tty/serial/sh-sci.c Greg Kroah-Hartman <gregkh@linuxfoundation.org> Jiri Slaby
>> <jirislaby@kernel.org> Biju Das <biju.das.jz@bp.renesas.com> Geert Uytterhoeven <geert+renesas@glider.be>
>> Hugo Villeneuve <hvilleneuve@dimonoff.com> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Frank Li <Frank.Li@nxp.com>
>> linux-kernel@vger.kernel.org
>> linux-serial@vger.kernel.org
>>
>> So why is
>>
>> x86@kernel.org, linux-coco@lists.linux.dev
>>
>> in your Cc: list?
>>
>> What can those people do about Renesas-something-serial driver?
> 
> I have been told by some maintainers to use b4 for easy review
> rather than using 'git send-mail'.
> 
> If I do 'b4 prep --auto-to-cc' as per the b4 documentation,
> x86@kernel.org is automatically listed.

After 'b4 prep --auto-to-cc'  you edit the cover letter and see what is
there, no? You can easily spot bogus addressed added.

> 
> Can you please guide me how to remove x86@kernel.org from b4 tooling
> So that x86@kernel.org will not automatically listed?

b4 does not add these addresses for these files.

Best regards,
Krzysztof
