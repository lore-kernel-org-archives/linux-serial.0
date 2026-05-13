Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46B3EE1C1;
	Wed, 13 May 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674902; cv=none; b=fVel6i87v9T9zb/PTIg/7xAU/OhUraO/HpB8jgja4LBgE0tQqpmS9peY7CxtPdACYalWD4l7Ofk9K8tXszoqc7nM2indgQxMMOOr+pDMyJfRH/Cvgz+wEP3vNEeYxsu5eHSvqI3DYr7WSNndvCX2zmA5HGrke3Aq2bKm4G6/6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674902; c=relaxed/simple;
	bh=nPm/wSE0+OEeAtE7bVcSR+O7c7s18K8e/rVXiNhQrfk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hcTqSC+r7sMxD3JbWWkz/6Caq537I7wjKyYKBwur1SzlypBvU507HcizyvsyPhfX7eQ0QjAwvTkvJ8jIhM1OPAnbZ+NTJr+ELIYg4HoKs8mn5lpjhYfJeT5MqItGgpBKzAVbid1w0YMi8ocL1TS/t9j4/s/uFQ/tbKgOBK8GpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRQIDOrd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRQIDOrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778674901; x=1810210901;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nPm/wSE0+OEeAtE7bVcSR+O7c7s18K8e/rVXiNhQrfk=;
  b=NRQIDOrdt7itftEAx+404/lK4LA3oJpy4hgGgY60PpZfPYhafbqe//Mk
   cOoBuQpX+3hW+S6ee0pRl0KmhK/LLVNDCEca6F+B+N//KFp1Q89HUTXtp
   riaWKXhPjEvQSMjXZh27uKw6g8J02neQMa0JmPz9B9GiH8TGS6qHEtxXI
   q7n68CLBh2RDmPzlW5UmVo4aMl9zJ0p3mrjKiePb9gNQiLeo08gNCNRME
   t9yeo+HHv17DMtTqQA0QgcQQk8U1DlJMC12bYj3O/2c34FU089C3kzlBY
   jrA/ypJzGTYvmKobGNWtkn/90yBu1UXurcQPrLWSVeQKdEkAn3ZkN57Tj
   Q==;
X-CSE-ConnectionGUID: mK1H9+h2RiqDLC4HipALAw==
X-CSE-MsgGUID: SlRLNnHYQKuSPRq+Y6i1zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90701304"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="90701304"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 05:21:40 -0700
X-CSE-ConnectionGUID: pek5dWe5TKW7gbqEemXsgA==
X-CSE-MsgGUID: TOByA4PKSVygE9Wb0zs8aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233801208"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 05:21:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 May 2026 15:21:35 +0300 (EEST)
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] serial: core: introduce
 guard(uart_port_lock_sysrq_irqsave)
In-Reply-To: <20260513121205.45921-1-jnilo@free.fr>
Message-ID: <f3d9c75f-48a5-684d-4f03-879ffa8118b6@linux.intel.com>
References: <b65b5237542c1c1c694a20e9d8fd0e18434a82b9.1778592805.git.jnilo@free.fr> <3439217b-90b5-5d21-e777-d238b3ffc1a0@linux.intel.com> <20260513121205.45921-1-jnilo@free.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1942567383-1778674895=:12534"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1942567383-1778674895=:12534
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 May 2026, Jacques Nilo wrote:

> On Wed, 13 May 2026, Ilpo J=C3=A4rvinen wrote:
>=20
> > > +DEFINE_LOCK_GUARD_1(uart_port_lock_sysrq_irqsave, struct uart_port,
> >
> > I suppose the "check" in the name is kind of important detail so maybe
> > it shouldn't be dropped from the guard name.
>=20
> Quick clarification before I respin: do you want this renamed in v2?
>=20
> I dropped the "check_" segment because the existing
> guard(uart_port_lock_irqsave) doesn't mirror its destructor's name
> either (it expands to uart_port_unlock_irqrestore, not
> uart_port_lock_irqsave_and_unlock_irqrestore), and the longer
> uart_port_lock_check_sysrq_irqsave starts to feel verbose. But I see
> the symmetry argument with uart_unlock_and_check_sysrq_irqrestore() and
> I have no strong attachment to the shorter name.

I meant guard(uart_port_lock_check_sysrq_irqsave)

The point is it does "check" sysrq. Though I admit I'm starting to see now=
=20
why you had irqsave earlier placed before sysrq.

It still fits to the expected indentation levels pretty well.

> If you'd like the rename, I'll do it for v2. If you're fine either
> way, I'll keep the current name -- patches 2/3 and 3/3 already have
> your Reviewed-by trailers on the call sites and I'd rather not
> invalidate those over a naming choice.
>=20
> The other points (commit-message reflow, Cc: stable on 1/3,
> single-line destructor formatting) are unambiguous and will land in
> v2 regardless.
>=20
> Thanks for the review.
>=20
> --
> Jacques
>=20

--=20
 i.

--8323328-1942567383-1778674895=:12534--
