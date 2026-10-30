Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371210;
	b=fUxJ04mp1m0ls2uYyjMQb2QVtZ7M9B3w6w0TiM9mZNrW2S3+fF9bjVZrtotUhE9gfY/A
	 D5mGkKydtJRnIRJmr6Z/ddFUVX6Oxzs8sx+RTx+GCcukyUfP3Mvebr6oeb/UoAXHzI1Th
	 9Q9aXgH7+1heP/16QEpjl73ByXVddaPIXXm3e1+KivBjjFoJqhuBqI58ozuOUUVyAN3e1
	 wo9LAOokwsDqLSe8PcYZqb4Jt9cicgjqUqLH2dOBGjsWjvvD3nFaSN0Q854SHV6p6kzjf
	 26GtSBKHXvTS3UIW8bIbUM08CyTL0zLSE6GTjMw6w9/elHe6NEAFYrNBYorWZ5TvvSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371210;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fcq75/n5to7KVPQGZLdMt4JCssKTlOZI1ZlvEz8dUiA=;
	b=on3artDbufN7PM/g/ltyVQFBI69TV4Ow/S5UGmBL1wWHLvd92E9RNbBCcrlLcIiDmfi/
	 ET00Uk8kuObJ/NipZlO/IcM1vZNMaT0DQjf4hBcy8byjPVUCK8eE2QTiD86s1eRc70CvK
	 TID4QvuEzcre8DFaWs7VvHOL/oPFv+aZZ0KjYrtvwcFShdkMCdQET1cd96jQgOYcMfFWc
	 dA/GbQtHt0XRhsMvt5fBgjv1F++fqyhQV6LmOpxnVJXNws95rFlZ4g7cRGB1npNo/LOfe
	 o3Gyouti9QSBzXDRZcUIeMv0lUG7DVbPJcsTDKGt4AKSgRrtGF24N9xuiT9UueN7QKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opnizZ+2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290F606A31A;
	Fri, 30 Oct 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opnizZ+2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220C81F00A02;
	Fri, 30 Oct 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371209;
	bh=fcq75/n5to7KVPQGZLdMt4JCssKTlOZI1ZlvEz8dUiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=opnizZ+2dNikd4k65O8cRdMCDWoFnGzGm8H06Tue87Fz2IY3Vl4g9tTezUqcwc3wT
	 2S6k8/wdhtbqKtvti1EgHreItj+UG5ZBkRBY+ay1FJ2DMCO5RncXnTjV+pURh7ZIro
	 XNZv6YTMLXemRfd3n+9r7A4h6KNmwKrYIG57sbEnbATY6K2ZIueRLWVNpW++DnTT2g
	 6j9cPgPuREHbNQ8UMD5t+M3B6xIbKyPezo5ElEInFyan2i1LKH1bgSwTQOQiILbWLB
	 6bxDTx1NypaHLyEF3TNygCKFE23hVT/x+Laf/8uav6MskOgnGXulWrMLVw1+eFCQcs
	 JzKAKQeuxklMw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 235AC198003A;
	Fri, 30 Oct 2026 10:40:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 10:40:06 -0400
X-ME-Sender: <xms:Q6zkahjpOj4ZSaCUZVh_bd9rI2MnpdmCfUnAYYGcnjInOD05oNfb1w>
    <xme:Q6zkajbGIHULW1k9syjh4YXvBPDt66fdFnIS_5PV7amJHak8pByIxZZQLkztpXdqg
    fBfkYOiqdNcPpFxCXn01p-8P6XxaWhRqh2_6Mpdfuqf9J6cdP6E3bly>
X-ME-Received: <xmr:Q6zkatHdsrPk1n_nDjoGF_qe5L9NFTQJTTaIt6u1UONBAAPWdR3k-2pAJpg>
X-ME-Proxy-Cause: dmFkZTGcH0aYPKX2YJAbVL0xyGQh0oSkJL6yLpuefE0X4Co1hkT5qUmJcZVHIEtIcIYX8y
    WY5Zc3yBQ6YcnmYlYpaq8uBDxFkI0uDlEyFyz2fkaB0ItzM9Er4N7JxO3vfQJMxLdTL27+
    TmMFq2gr7DbfJSNquyE3MQwnLRvpN3yKRyBeYNa3/4AwiM4h5DMNmwfBgZNYE7hNq2lNj0
    +qtXQ59/RfdGZcvFx3q0A4FZ2SwR8jIBm0jzU0fu/zsiosCzA5z+wHByYBr+XXSJ3DblCg
    yQgwRKwYdunH7rAOmH+JqasmO7UVYI3li7f/5VtJjFYoAwzKBFo+m6ITJ3x7qhmL8urmqt
    JYUmMRS3ow43Y9WEUMeuKWWOQ9DfLPeFvYXAp+mtXgXuec1e7OHrWVWY9Tf2yNa3DOy3UV
    sqoUk30o91JUgvRkm0ONxH84/jHYWY2nVdJDZjdX7y+43j1c9kEqJEE9fsKasLBd5HVGzC
    t8jd1lK9ja1hdBTqwKQSs2bBKzFC7Qtj2kifCEtyVFxIswfC8PyClvOMtMs7pIouk9oQxv
    MKSaifVFxabUBf9lJ4Qct3v64EREhYGltHSWCWcfdX2M+2ZuOJVne0k8rqE2nQZs/i+Fap
    yPAiUFR9GtpE9GVbrI295I/j7SS4UlsixVV6g3a6EdbJFDjwz4uOWGa6XYLg
X-ME-Proxy: <xmx:Q6zkap-66JLgSuqW2cp6D03ZHrfBFlScV2mKn7rB9A1LacGBqwA4XA>
    <xmx:Q6zkaqWb8s3rqXdJpGxh4w_EH5O13ebU5WMLHaomzoyCOAH5caYKYA>
    <xmx:Q6zkatboXt60IeNosoJWbYRrnnuFTz5pw0csjmwaWXvlhMWJjRETmA>
    <xmx:Q6zkanX9bgrJNDTkdR4HfJK1PP2V6QpuGzibD7EiQi5SI7BlwJMzaQ>
    <xmx:Q6zkakLU1l40MFtuUcUwTiJiNuzkjkEeC9docC7gsfxkRmed_bPge6oA>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 10:40:02 -0400 (EDT)
Date: Fri, 30 Oct 2026 14:40:00 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, "biju.das.au" <biju.das.au@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Au Dang <au.dang.jx@renesas.com>
Subject: Re: [PATCH] MAINTAINERS: Fix Intel TDX kernel file patterns
Message-ID: <auSrwtQgJRM09_ve@thinkstation>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>

On Thu, Oct 29, 2026 at 07:33:38PM -0700, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Thu, 29 Oct 2026 19:25:27 -0700
> 
> A K: is a content regex file pattern which matches any text in a patch
> so if a commit message contains "TDx" as in
> 
>   the TDxE (Transmit Data Empty) flag

K: matching is case-sensitive, so the TDxE prose never matched. The hit
was tdxe_auto_clear, the field that patch adds, in the diff as well as in
the changelog. A keyword can't tell that from TDX code, so paths only is
the right fix.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
