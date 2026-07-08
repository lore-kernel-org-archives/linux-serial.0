Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724283E7BC7
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498860; cv=none; b=Z69JfW41+Q6YaN4G9FiqgXmCpAHO/BBJ/peT7aV0QzHU8BmwzwK2k6Xkw/mTKyE4620EGCK0GwYh/XiIOI/mCGRefBHO6x5iqQwM5uL1yGqzPM2TOPoamtqWMYy/DSCQPqy6I1Hgqb3GUuyTz16NgqlMQ2AQY37Z+BamurYCIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498860; c=relaxed/simple;
	bh=KP2HhCDVJbHdDyk+1uCxEaxn3pFymhU2kRDT0wNv/2U=;
	h=Message-Id:To:Content-Type:In-Reply-To:Date:Cc:Subject:From:
	 Mime-Version:References; b=HsjcASBWnIHG/ZyeALM+Wk3qgKxKKn8We30fs23v/DsIdvMogDSnwbx3niXEeTj0i0A0GkGtg6Ri6ZvEbv1BkOew0PmOtedr3oPzDk2hWgbnw7BDMJccoORS/X1i2ByfFzIQwfApB8C17H0qZ9bMg5c3m9/Yk26C1/jxVrSMRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=E2smCrGB; arc=none smtp.client-ip=209.127.231.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="E2smCrGB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1783498853;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=KP2HhCDVJbHdDyk+1uCxEaxn3pFymhU2kRDT0wNv/2U=;
 b=E2smCrGBsABSPGLnOnrivO39UmF6b7EM5WPpMhlWWN7K69jD9otuZ1k638oUQVKLOAynhm
 j6QlNdHIeDa3n0pad6rTmky51IVtGbhCSy86TqdyX3QdK7vjD8O+f/HV7Nr/nXFFHU7SEc
 5E5rCNqtfr+DGVC6vip0u3hsnNahTmbehBoAfdTmuu/He5sf8IVuZsJLP8/Ufcs6ElsB5A
 g5qv5XZoElwN5nndenXYQkHNrgI2x82/5ZoPzY+nrao6CsSzwnu3MWks61e7zzt2IcWvWb
 rGuf86s+ulHIQC4LrGHYj3GVVM+AhRU92u90deIgbZ/OcpIWYwun+6lKKEBxGw==
Message-Id: <5cf37150673ea4d5c28f94db91cdf68504b50522.a94e27ef.52e1.464f.ba92.ccb0f72c6079@feishu.cn>
To: "Jing Wu" <realwujing@gmail.com>
X-Lms-Return-Path: <lba+16a4e0863+8309b5+vger.kernel.org+wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260708075732.4139996-1-realwujing@gmail.com>
Date: Wed, 08 Jul 2026 16:20:50 +0800
Cc: <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>, 
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <5cf37150673ea4d5c28f94db91cdf68504b50522.0e091ec2.1d26.4eb2.8da3.53f8a6520707@feishu.cn>
	<20260708075732.4139996-1-realwujing@gmail.com>

> From: "Jing Wu"<realwujing@gmail.com>
> Date:=C2=A0 Wed, Jul 8, 2026, 3:57 PM
> Subject:=C2=A0 Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ cha=
in handling
> To: <wangzhaolong@fnnas.com>
> Cc: <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>, <linux-serial@v=
ger.kernel.org>, <linux-kernel@vger.kernel.org>, <yuanql9@chinatelecom.cn>
> On Wed, Jul 08, 2026 at 03:33:36PM +0800, Wang Zhaolong wrote:
> > I do not want to make this a patch ownership discussion.
>=C2=A0
> Let's be clear about the facts, then.
>=C2=A0
> You reported the bug. =C2=A0Our team fixed it =E2=80=94 the next day. =C2=
=A0May 28, our
> v1. =C2=A0You confirmed on May 29 that our v3 fixes your reproducer.
>=C2=A0
> Since then, you've posted three versions =E2=80=94 v1, v2, v3 =E2=80=94 t=
hat
> incrementally copy the work we developed and refined through seven
> iterations. =C2=A0Your v2 copied our lock-move skeleton. =C2=A0Your v3 co=
pied the
> irq_chain_mutex rename, __must_hold(), and lockdep_assert_held() =E2=80=
=94 all
> written by us, all reviewed by Jiri on our patches.
>=C2=A0
> You list these as your own "Changes in v3" with zero attribution.
>=C2=A0
> This is not a "patch ownership discussion." =C2=A0You copied our code. =
=C2=A0The
> kernel is GPLv2 =E2=80=94 that means you can use the code, but you must
> preserve the copyright notices. =C2=A0Co-developed-by is the mechanism fo=
r
> that.
>=C2=A0
> You reported the bug =E2=80=94 we fixed it first. =C2=A0We credited you. =
=C2=A0Now add
> the tags.
>=C2=A0
> Jing
>=C2=A0


Hi Jing,

This accusation is not acceptable.

My v1 was posted on May 27, before your v1, and it already made the core
locking change: move hash_mutex to serial_link_irq_chain() and keep it held
across irq_info lookup, i->head publication, the first request_irq(), and t=
he
request_irq() failure cleanup:

=C2=A0 https://lore.kernel.org/r/20260527092052.2086342-1-wangzhaolong@fnna=
s.com

So the claim that my v2 copied your lock-move skeleton is false.

That same locking change also closes the irq_info UAF window, because
serial_unlink_irq_chain() takes the same mutex before free_irq() and
serial_do_unlink()/kfree(i).=C2=A0 My commit message focused on the IRQ war=
ning
because that was the failure I reported and reproduced.

For v3, the irq_chain_mutex rename was made in response to Jiri's review
comment that hash_mutex was no longer an appropriate name.=C2=A0 The __must=
_hold()
and lockdep_assert_held() additions document the caller-held mutex after th=
e
lock move; they are not the functional fix.

I do not agree to a Co-developed-by tag for my patch, and please do not add
Co-developed-by for me without my agreement and Signed-off-by.

I do not want to keep tracking or arguing about this issue.=C2=A0 My only g=
oal is
to see this regression fixed upstream.

Thanks,
Wang
