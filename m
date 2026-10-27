Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093673;
	b=s6yYeWFXPwEDl7QWzbh6cAvOE7nXyuVVuGY+aYpzbKGvYcQ4hsfzLk/jISdiVnboHSpz
	 x9BhUTg1qltYsbvywwq6/1BwelL0Bp9YXJBBBXwaFQchovh7azgvW/IH1pzBOWYlT09dH
	 pe4ibJz5hcfxkAbIn9lZLJXH+wjlKCzkxEkk9v3YC626LfxzLB5cvMwGJLY3dTthBm5H2
	 yd9Ikwj23VtH9w2135cJTrJfVNlrMPP3TlFDVjOpcSV8OSAaSm+8sVFfSzyj5jzgkGwxd
	 ihfBCu/J6QxZMhKNwiAxEKhopGZFDA6KOdr9gs4qrwoTp4AOEAv/x9gHeEoe/T6CNpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093673;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=G3e2hhM45bSC6HYxroPmMZpcEdfEVWWFA0cIw7A06iM=;
	b=Co9Y1oL+qCkt4ZXj1P8zGAckIxZ+ou3YdKgclKDAgjFP4B7ydBL0M5g3D8LMQLTgoA/u
	 FXeU6BxUa8OKOQpBsXE9F4V09sOHsUPe36g0NGCvkLSKuQ8IzBxe+d28Ls9rKxCs7NizR
	 UUb9E7mPki/Nn9T1T930K/4f05lJuNtnI625zdlFqo5Xh/xA5p6wfQUwvHAKvbsmr/Wez
	 aJa+aPoyrnlpWsGyDJiIkhSRO6Wf7KIIYYqhrRnVOHPHmFRnsR8m2vy5h7BFAzeP3FZ8g
	 PxXB7Nn3F/TEVHLHm6fQO+qfRid9uca7uebXfSm4pNbbebsRkgplLueXw1f96TFqS9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlsTS4r2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AE606A321;
	Tue, 27 Oct 2026 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlsTS4r2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185211F01825;
	Tue, 27 Oct 2026 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093672;
	bh=G3e2hhM45bSC6HYxroPmMZpcEdfEVWWFA0cIw7A06iM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HlsTS4r2uasxl0qIyJsAbClYF91vD59p/wHoQ/OVR7hV6r4fY0bFQ1aTuYpUYYof6
	 rQmuEJkpJQ4RPJg2kCKz17lb66u0YGoxnD4kNn3rzMBpKhjcZzQMZWsE9Vxcl8/gWh
	 8l7EmZR+HLM2SEGIpilUMpXv5N3o2ibTF+8xaawGfJKUeI04qXxjPBbRxW0hDu2Ugc
	 sgvY8Khhi2U7dJppICtJuD5I+43+i8AIgIuUtQyi7UY1oOcMv4zgsVy8biUo6Hm1v7
	 d5hnC5uURfvpaFCY+lL4aIeHWlLYE1b2JRBgrgEege3F4ZAXXsHIU2xzaU6bCPpoFe
	 tV4yhnn7zxyCg==
Message-ID: <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
Date: Tue, 27 Oct 2026 10:34:24 +0100
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
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2026 09:33, Biju Das wrote:
>>
>>>
>>> Can you please guide me how to remove x86@kernel.org from b4 tooling
>>> So that x86@kernel.org will not automatically listed?
>>
>> b4 does not add these addresses for these files.
> 
> Then how x86@kernel.org added by 'b4 prep --auto-to-cc'? any pointers?

Indeed that's x86 fault, so I don't get why Borislav complains. They
added such pattern, so get_maintainers indeed reports it when run on the
patches (not with -f):

	Keyword:\b(tdx)

Best regards,
Krzysztof
