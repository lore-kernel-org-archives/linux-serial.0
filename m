Received: from va-2-29.ptr.blmpb.com (va-2-29.ptr.blmpb.com [209.127.231.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580442DA28
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689335; cv=none; b=lzZ6Pp7KbHFtkPazSx2HRbK00+JiLJQJ7TaVY0z7bKB9Mql9sn9Bk6iBbYM9uyea2fj84eO25I47tOvkFl1HW7Y9WDli2dNsXRHie0GKkTMUAtTCi3UdF9vyRvXJ+SGqNRCXDT2nuU85r7O6DpkM0EpuFS6GQKNyfLJrt161rOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689335; c=relaxed/simple;
	bh=70EtN+38gFyhigF22qMDHljumzdAJvbl0jUAs13brUg=;
	h=In-Reply-To:Cc:Subject:Mime-Version:From:References:Content-Type:
	 Date:Message-Id:To; b=Mi9mCIl7iVOGMUsKIzHaeX3i0XPtu53YaC2FTyi3lPJ3dcz6Zrf5YAWpSd1022P+obx/bIyoWavUBGCVOnRADsQlrBYm5UjU4gFKuk1glDrnIGp6JwBhQJyIifysjTQ41qzzmHq5Ste02OcfDw/8FozzHkCIlqGH/u42hNVkyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=mE1FeIEo; arc=none smtp.client-ip=209.127.231.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="mE1FeIEo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1783689322;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=70EtN+38gFyhigF22qMDHljumzdAJvbl0jUAs13brUg=;
 b=mE1FeIEoV6AxfeGhAFKfH0FzVMciEnW4sDeFFsyIjd9MZDMPGOK+yP+p2qER5PTkUnNEVo
 RmntD4wfalwr6/3ld1hYAi3HbODaeSo7+l+5NeXrFO4cNjOPzeEfW/bD9Luajtk5F77HkN
 6BHr6psHOAwiQVqNi3xpkqmBDupUKdJnTBkGke3Nxdzy4rjw1HFzlzZ6VpUW8mhIIw95KK
 WacdLcOFl52vLfZh5TVn4+pTg4EOS/BZdqm/zgwghXfBXshkVVyNDw2Rpc8YYSgnuI44Tq
 OW3Amqd5Bt4PYyobNG4yfz+e/os11cKEcXBULl9w1sSYJwf56fH4c55VRCzmKg==
In-Reply-To: <2026071037-subprime-padding-3ba9@gregkh>
Content-Transfer-Encoding: quoted-printable
Cc: "Jing Wu" <realwujing@gmail.com>, <jirislaby@kernel.org>, 
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <20260708071138.3698581-1-realwujing@gmail.com> <20260708073938.3975921-1-realwujing@gmail.com> <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn> <20260708080820.62288-1-realwujing@gmail.com> <5cf37150673ea4d5c28f94db91cdf68504b50522.9be37cbd.7a04.4d7e.b20e.d3f90675af6e@feishu.cn>
	<2026071037-subprime-padding-3ba9@gregkh>
X-Lms-Return-Path: <lba+16a50f068+7c8cdb+vger.kernel.org+wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 21:15:19 +0800
Message-Id: <5cf37150673ea4d5c28f94db91cdf68504b50522.c00727f7.d760.4135.8321.a6234c57c54c@feishu.cn>
To: "Greg KH" <gregkh@linuxfoundation.org>

Hi Greg,

>=C2=A0
> As I said before, I'm not going to take either until you all can agree.
>=C2=A0
> And yes, a co-developed-by does require a signed-off-by. =C2=A0Without yo=
u
> all agreeing, none of this is going to be acceptable, sorry.
>=C2=A0

Understood.

I do not agree to a Co-developed-by tag with Jing/Qiliang.=C2=A0 My v1 was =
posted
before that series and already contained the functional lock move.=C2=A0 I
reviewed/tested parts of the other series against my reproducer, but I do n=
ot
consider this a jointly developed patch.

I do not require my patch to be the one accepted upstream.=C2=A0 If another=
 version
is used, I am fine with keeping Reported-by and a Link to my original patch=
,
and I can retest the final version against my QEMU ttyS1/ttyS3 shared IRQ
reproducer if needed.=C2=A0 But I do not provide my Signed-off-by for a
Co-developed-by tag.

> Also, all of these really look like they were created/found/whatever by
> a LLM, which is not being documented, and for that reason alone I think
> I need to reject all of these until that is properly addressed.
>=C2=A0

Regarding LLM assistance, my v1 explicitly included:

Assisted-by: Codex:gpt-5

That tag was dropped in later revisions while refreshing the patch. The bug=
 itself
was found and reproduced by me, not by an LLM.=C2=A0 I used the tool to hel=
p refine
the patch text and write the reproducer/test code, then reviewed the code
myself and validated the result with the QEMU ttyS1/ttyS3 shared IRQ
reproducer before submitting.=C2=A0 I also spent time testing/reviewing the=
 other
series; for example, one earlier revision did not pass the reproducer, whic=
h I
reported in that thread=E3=80=82

I understand this may mean my patch is not taken.=C2=A0 I am fine with that=
.=C2=A0 I do not want
to spend more community time on this dispute.

I will stop here and leave the technical record as-is.=C2=A0 I hope the reg=
ression
can still be fixed upstream without spending more time on the dispute.

Best regards,
Wang Zhaolong
