Received: from va-2-40.ptr.blmpb.com (va-2-40.ptr.blmpb.com [209.127.231.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD13EDACC
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497236; cv=none; b=MaLM9l43rLJ7umeu00dm2/tyJPgIOzTtD3/YCy8mukuCAIl2saRZ/u1H+XXuQnB9jHwtsNkaKhrwyDac3I0Jq02dqyfz0vZD0QeJzFm0NEsEQYyl5TQuhNHlIP+QGnwuFLQo8xXFCipUcZTTrOBsqtvhPwNON5YmquNvZb3VkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497236; c=relaxed/simple;
	bh=cSeLbssq3ESfjjWmZu3uOMZlqCxKxm6q8QZOIteBtZk=;
	h=In-Reply-To:Content-Type:Cc:From:Mime-Version:Subject:References:
	 Date:Message-Id:To; b=oKi9htZKTI0aGeK2mfBz05fyKveCzA0NDb7SROVQKyZvKIsAuTF6zHlA5DSa+PH4uWNgCrGmGjxhYnxnBcl3j079LBxAEA1oyoFKbMwhy36oW1ybG81yWwRxE5HS0B6PO8ZTNKrOrJbCl+x7+wJc8a4kACiyJrzsmtm4qUayZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=aHy9fuzu; arc=none smtp.client-ip=209.127.231.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="aHy9fuzu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1783497209;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cSeLbssq3ESfjjWmZu3uOMZlqCxKxm6q8QZOIteBtZk=;
 b=aHy9fuzu73r7sd/AxSd6OOzypc2ZY/TG/tNa7u3Ij+pIFFN5OBVKfqSGawtPf5Hpf5cpY5
 JVsB7x+KaW4WXfIJ3F2OyEfcsZ+xkqvEZF4mWGKDfYSp20jCeo6mS6tYFe029xMGnBL96d
 OF21XqOPYPoBCvxd4B/JPteUmth4ZUsGC9ufn+NuP3+BKXatiDmN+RLeDgvfypyTjHdJ3n
 TprxMPt+S2iQ84D+Pg3Q5k9XvxoLW/VNO0k4FjXktKig4wceThHNFzBKNp9uVVTOVPvI6W
 FW8WF/Zw3iyDuC98UxLpL4s5FVjfstzpxJWONsxIXkIAJFXlRjfoV8VSE5VOqA==
In-Reply-To: <20260708073938.3975921-1-realwujing@gmail.com>
X-Lms-Return-Path: <lba+16a4e01f7+b4d4cc+vger.kernel.org+wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>, 
	<avorontsov@ru.mvista.com>, <alan@redhat.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, 
	<yuanql9@chinatelecom.cn>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <20260708071138.3698581-1-realwujing@gmail.com>
	<20260708073938.3975921-1-realwujing@gmail.com>
Date: Wed, 08 Jul 2026 15:53:26 +0800
Message-Id: <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn>
To: "Jing Wu" <realwujing@gmail.com>


> From: "Jing Wu"<realwujing@gmail.com>
> Date:=C2=A0 Wed, Jul 8, 2026, 3:39 PM
> Subject:=C2=A0 Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ cha=
in handling
> To: <jirislaby@kernel.org>
> Cc: <gregkh@linuxfoundation.org>, <avorontsov@ru.mvista.com>, <alan@redha=
t.com>, <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, <wa=
ngzhaolong@fnnas.com>, <yuanql9@chinatelecom.cn>
> On Wed, Jul 08, 2026 at 08:03:55AM +0200, Jiri Slaby wrote:
> > Ah, now I see you are fixing the same thing as:
> > https://lore.kernel.org/all/20260708031115.3757150-1-wangzhaolong@fnnas=
.com/
> > I did not look up who of you was first.
> > Looks like he reported and apparently tries to fix that too ;). You wer=
e
> > obviously CCed, talk to them and don't send two patches for the same is=
sue.
>=C2=A0
> I sent a v7 [1] addressing the three review items you raised, and added
> Co-developed-by: Wang Zhaolong and Qiliang Yuan.
>=C2=A0
> Wang has just posted a v3 [2] which copies the very same changes from
> our series =E2=80=94 irq_chain_mutex rename, __must_hold(), lockdep_asser=
t_held()
> =E2=80=94 without any acknowledgment. =C2=A0No Co-developed-by, no mentio=
n of our
> series in the changelog. =C2=A0It presents these as his own improvements.
>=C2=A0
> The full timeline, for the record:
>=C2=A0
> =C2=A0 May 27 =C2=A0Wang v1 =E2=80=94 only the THRE test race, no use-aft=
er-free fix

Hi Jing,

Just one technical clarification: my v1 also moved hash_mutex to
serial_link_irq_chain() and kept it held across irq_info lookup, i->head
publication, the first request_irq(), and the request_irq() failure cleanup=
:

=C2=A0 https://lore.kernel.org/r/20260527092052.2086342-1-wangzhaolong@fnna=
s.com

Since serial_unlink_irq_chain() takes the same mutex before free_irq() and
serial_do_unlink()/kfree(i), that also closes the irq_info UAF window.=C2=
=A0 My
commit message focused on the IRQ warning because that was the failure I
reported and reproduced.

> =C2=A0 May 28 =C2=A0Our v1 =E2=80=94 both races, full fix
> =C2=A0 May 29 =C2=A0Wang on our v3 thread: "v3 fixes the Bugzilla reprodu=
cer"
> =C2=A0 Jun 24 =C2=A0Our v5 =E2=80=94 added __must_hold() and lockdep_asse=
rt_held()
> =C2=A0 Jul =C2=A07 =C2=A0Our v6 =E2=80=94 back to guard style
> =C2=A0 Jul =C2=A08 =C2=A0Our v7 =E2=80=94 renamed hash_mutex to irq_chain=
_mutex (per Jiri)
> =C2=A0 Jul =C2=A08 =C2=A0Wang v3 =E2=80=94 copies the rename, __must_hold=
(), lockdep_assert_held()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from our v=
5/v7, claims as own work
>=C2=A0
> Wang's v2 (Jul 8) was posted after our v5 and v6 and uses the same
> lock-move skeleton. =C2=A0His v3 (Jul 8) was posted after our v7 and copi=
es
> the irq_chain_mutex rename and __must_hold()/lockdep_assert_held() that
> we added in v5 and v7 =E2=80=94 yet his changelog gives no credit.
>=C2=A0
> I've been happy to add him as co-developer on our v7. =C2=A0I would expec=
t
> the same basic courtesy in return, but apparently that's too much to
> ask.
>=C2=A0
> [1] https://lore.kernel.org/r/20260708-bug-221579-8250-shared-irq-race-v7=
-1-xxx@gmail.com
> [2] https://lore.kernel.org/all/20260708072306.3921604-1-wangzhaolong@fnn=
as.com/
>=C2=A0
> Thanks,
> Jing
>=C2=A0

=C2=A0I do not want to keep tracking or arguing about this issue. My only g=
oal is to get this
regression fixed upstream.

Thanks,
Wang
