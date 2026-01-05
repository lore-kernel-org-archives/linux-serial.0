Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C83FFD;
	Mon,  5 Jan 2026 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655539; cv=none; b=kfBPie8k6w8fWZR6jwQ5NbbXx9OXcAJconw2yDAlwjne7c814J8SxWmpIeNlMBzlmne2xlt0lKVM33iV0oDWeA0ylCPcRlODLiwzf66OhHx/fEJ3JK9upMghBAc6rY5LiW1UUxaNaypTX9GrRkSgW6UXaxQDBHAgCj2B2EUnB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655539; c=relaxed/simple;
	bh=mxOrBdVUuTXZMya8gHCERPyx6/sDGr131BsPFtUsAAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJLnL7rM0J5DLBcbr1cQYwcilbirTnxKNNhW/oxpizX9uYoGMl5hVtkvxeRJLadwd2PFBAngAqI/ijqni0+wrQMJZTCYamHgZuAGaNLdP0yQoJDq1ZUr8ivou2lCkv5HEx+IdBkwiGONWrt7T2CVW1bWpowG/d0TQNM1aehZJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sn3K7wft; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sn3K7wft"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=eZXRxzDgqiXt8Ji2tBMSiCDP7JVzOeUIjlv957eS44M=; b=sn3K7wfta3W+ZnhvZdAYv83TXd
	aGYBs2WgcJeAz5Po0Ne6oUBupoxWm0O/3J4nCkpQP5DyUz542rgG9WdjDvA9kQA6jNASiwbA/wmPP
	THXB7S7sp1t3Hxzvey1JBu4BbsPhBj6u96Q3D2Ko5nbgrKcKTSFxWTNhJjoyXkIQ9kL+LJzzy3B7+
	bWYJib2WW6W8dZkYM/RhH57JftCeXNQK6wouh/iij42JqGVa4YvVv3DX4JzIyYKOizOJsrm0Bhpy5
	TdxRDsPBN0j4fLVR9FNK+D0DEQ2yGp20ixFDykO5uEyZBzitp2hifZnXmWA02qonz4dbVHqAe5C5t
	LQxt3Yfw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vctx2-0000000CEjg-0hj4;
	Mon, 05 Jan 2026 23:25:28 +0000
Message-ID: <fa3c154d-4cc8-4567-b8a7-d725e34d93de@infradead.org>
Date: Mon, 5 Jan 2026 15:25:26 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] serial: SH_SCI: improve "DMA support" prompt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Fugang Duan <fugang.duan@nxp.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-serial@vger.kernel.org
References: <20251227202509.2084000-1-rdunlap@infradead.org>
 <20251227202509.2084000-5-rdunlap@infradead.org>
 <CAMuHMdXmO0+WpMfBusFDjeD6Zqmm=UU+1X9RdRojckMd_HVzLQ@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdXmO0+WpMfBusFDjeD6Zqmm=UU+1X9RdRojckMd_HVzLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/5/26 8:51 AM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Sat, 27 Dec 2025 at 21:25, Randy Dunlap <rdunlap@infradead.org> wrote:
>> Having a prompt of "DMA support" suddenly appear during a
>> "make oldconfig" can be confusing. Add a little helpful text to
>> the prompt message.
>>
>> Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for your patch!
> 
>> --- linux-next-20251219.orig/drivers/tty/serial/Kconfig
>> +++ linux-next-20251219/drivers/tty/serial/Kconfig
>> @@ -671,7 +671,7 @@ config SERIAL_SH_SCI_EARLYCON
>>         default ARCH_RENESAS
>>
>>  config SERIAL_SH_SCI_DMA
>> -       bool "DMA support" if EXPERT
>> +       bool "DMA support on SuperH SCI(F)" if EXPERT
> 
> Perhaps reword to "Support for DMA on SuperH SCI(F)", to match
> the surrounding options?

OK. Thanks.

>>         depends on SERIAL_SH_SCI && DMA_ENGINE
>>         default ARCH_RENESAS
-- 
~Randy

