Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648223AB9D
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499536; cv=none; b=Ei4ZHGnFpfJo0LxIDX9D3s078sf/hJkiK5TIjgc1LcUgmJgLlNRwg04CSLgQuX/BZlKeHvO8e4fYm18I1Y+ASaPqasgIvlNtdb/dg0e43Mxy/SZ5NnaRkXyvZtVgs+LWSJte9i6Rj0UTzdueoTIjtjwtoEsDdyXs3MBi96QIjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499536; c=relaxed/simple;
	bh=kBrrhAmVDNwWZwEpWE9tzpsTGgSpt+CpQUBrdnYjBfA=;
	h=Subject:In-Reply-To:Content-Type:Date:Message-Id:To:Cc:From:
	 Mime-Version:References; b=Jm2b898+HaQXmhQwYyGxOv7KpN4MOhErg4G2lZyUuuOtA68uyX4A59GeJ2ODgN5JyzD49EhjsVmOCvQzaqKnvuq4TEyGFjCyPkUKdDx5keYGGqYUCwyiekHzQ9AIaGtkrgqErRDXbChKnBUiuEfFv10bX1HgFa94ObEtgNYPsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=b/Xkd/Er; arc=none smtp.client-ip=209.127.231.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="b/Xkd/Er"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1783499530;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=kBrrhAmVDNwWZwEpWE9tzpsTGgSpt+CpQUBrdnYjBfA=;
 b=b/Xkd/ErqcJPeOcucOSSWl+mnIgyR/tcUY3O6FfJUoK3nVPygbk6U9mm9iM80aPp8rFYlM
 RrT+rQUtTYbRe0gamvn+Cv+CnPIe8TrQnBJC48LbQTykJzG/hUrJwBWH3kC5Ct+a7eYfvO
 qNGM4GjeZSKXNTi1/61oC0dURC74OZ80wMEyw6Is+bt2EAbxqVV/F+yNmpny1SeY1WAHK/
 bEJQkEwBHQIi73YN56Da/sNie9gWQYehmi9m2CeOttU639Md4RlIMz/hskiuq7QN30RwjB
 uqOaxZdAaDxoUIJLEqKr6c8PjpeNAlG2lypVzKU9lUFT2B3ZzdMtzd1Da+mXng==
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
X-Lms-Return-Path: <lba+16a4e0b08+03c684+vger.kernel.org+wangzhaolong@fnnas.com>
In-Reply-To: <20260708080820.62288-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 16:32:07 +0800
Message-Id: <5cf37150673ea4d5c28f94db91cdf68504b50522.cb0b8b97.00ba.4f15.8826.c668a9e57555@feishu.cn>
To: "Jing Wu" <realwujing@gmail.com>
Cc: <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>, 
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yuanql9@chinatelecom.cn>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <20260708071138.3698581-1-realwujing@gmail.com> <20260708073938.3975921-1-realwujing@gmail.com> <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn>
	<20260708080820.62288-1-realwujing@gmail.com>


> From: "Jing Wu"<realwujing@gmail.com>
> Date:=C2=A0 Wed, Jul 8, 2026, 4:08 PM
> Subject:=C2=A0 Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ cha=
in handling
> To: <wangzhaolong@fnnas.com>
> Cc: <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>, <linux-serial@v=
ger.kernel.org>, <linux-kernel@vger.kernel.org>, <yuanql9@chinatelecom.cn>
> On Wed, Jul 08, 2026 at 03:53:26PM +0800, Wang Zhaolong wrote:
> > Just one technical clarification: my v1 also moved hash_mutex to
> > serial_link_irq_chain() and kept it held across irq_info lookup, i->hea=
d
> > publication, the first request_irq(), and the request_irq() failure cle=
anup
>=C2=A0
> Your v1 commit message discusses only the "Unbalanced enable for IRQ"
> warning =E2=80=94 it never mentions the use-after-free. =C2=A0Our v1, one=
 day later,
> was the first to identify and document *both* races. =C2=A0You confirmed =
on
> May 29 that our v3 fixes your reproducer.
>=C2=A0
> But the v1 lock-move is not the issue. =C2=A0The issue is what happened a=
fter.
>=C2=A0
> Our v5 (Jun 24) added lockdep_assert_held() and __must_hold() =E2=80=94 r=
eviewed
> by Jiri on our v4. =C2=A0Our v7 (Jul 8) renamed hash_mutex to irq_chain_m=
utex
> =E2=80=94 per Jiri's review on our v6. =C2=A0Your v3 (Jul 8, after our v7=
) copies all
> three of these improvements and presents them in your changelog as:
>=C2=A0
> =C2=A0 "Changes in v3:
> =C2=A0 =C2=A0- Rename hash_mutex to irq_chain_mutex
> =C2=A0 =C2=A0- Add __must_hold() and lockdep_assert_held()"
>=C2=A0
> That is not a technical clarification. =C2=A0That is taking work we wrote=
,
> reviewed by Jiri on our patches, and claiming it as your own.
>=C2=A0
> Add the Co-developed-by tags. =C2=A0We already added them for you on our =
v7.
>=C2=A0
> Jing
>=C2=A0

Hi Jing,

No.

A changelog entry describes what changed between my v2 and my v3.=C2=A0 It =
is not
a claim that nobody else ever wrote a similar line in another patch.

The functional fix in my series was already in my v1 on May 27.=C2=A0 Wheth=
er my
v1 commit message named the UAF or not does not change the code: holding th=
e
same mutex across link and unlink closes that window too.=C2=A0 My v1 commi=
t
message intentionally described the failure mode I had reproduced and
validated: the unbalanced IRQ enable warning.=C2=A0 I did not want to overs=
tate the
impact beyond the evidence I had at the time.

The v3 rename follows Jiri's review comment that hash_mutex is no longer an
appropriate name.=C2=A0 The __must_hold() and lockdep_assert_held() annotat=
ions
document the locking rule after the mutex was moved to the caller.=C2=A0 Th=
ey are
not the functional fix.

I do not agree that Co-developed-by is appropriate for my patch, and I do n=
ot
authorize adding a Co-developed-by tag for me without my Signed-off-by.

I am not going to continue this argument.=C2=A0 Maintainers can decide whic=
h patch,
if any, to take.

Thanks,
Wang
