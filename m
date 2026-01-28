Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CF350D65;
	Wed, 28 Jan 2026 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606775; cv=none; b=bbgIubx1t7iFN5xjSyyjVOotg3Jam0YLiSy3Uf6JRxlVxxY/Qqv1bysJsjpYTewmbgoDk1MEoIG939oZhrcMRTzQ3tU/QWEKKa4aSieuoLn1BK7CIyJ3puvBNJ7eM9ik2mEbgBRdcx9/OBGrJD2PSZDC0m4IyCi+ziwgxO4N/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606775; c=relaxed/simple;
	bh=BQZ5+Q5fN4Bx0/ezssZNqz3qw9WsryoVOA3B1SgGO3k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AsP4ZyKNxfR64rkfJNBq9sBJ1itM6Ka5hqPREzDx8YkXq5F9liWjElH3/ZvWt/KPSjp9YrXfR6AYfOWzTOJrK7n16UCIz7JolPqVB6s4SX3RnIqTZAy1j5D9inziOgRNTwWfv5J7+vZ4256IAkiUuv541Xpng5Hedtd8iH2hJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7FM06rv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7FM06rv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769606774; x=1801142774;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BQZ5+Q5fN4Bx0/ezssZNqz3qw9WsryoVOA3B1SgGO3k=;
  b=e7FM06rvVzYqxrwy5hOD/Gu+3eaOAEnG0HrOkf6gXQvnZHeiyzcpRXiK
   bZPuDVHP6huijoMTFimNIVkhXKykI6VNNRrkG1zozVYiAR4UpRCN/ztBo
   +fXwyG+d8erE8eBWHQ91BZR4EKT5cd4z5uzaLYiWcPMHX1UKsg0EY0qnR
   1zT9beiivgqOFfPgaGLAyE/XdmogxJZRqZKXvroPjldPZ/EEcijBCquf+
   xGi5i90an4vR/yfELbPbpgRkeTaIxvAG85uHyO3MbI0ktavhuFmAnE3vg
   RV4EMavh1t/A5yyotZmuSj7HFasCdzPlFHlp6OyHc/yorDy+MHfsy7Qkv
   w==;
X-CSE-ConnectionGUID: oUgk51iASDem5MRrH4sivQ==
X-CSE-MsgGUID: K0CKrGkESaW6YgHmL3swvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82245675"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="82245675"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:26:14 -0800
X-CSE-ConnectionGUID: V4j53NsiRUyxfulmDvY2JQ==
X-CSE-MsgGUID: 51MvsZ3eStGvnJlCKAeIdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208640444"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:26:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Jan 2026 15:26:07 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae <adriana@arista.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Bandal, Shankar" <shankar.bandal@intel.com>, 
    "Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/7] serial: 8250: Add
 serial8250_handle_irq_locked()
In-Reply-To: <aXoNB7pnQMpPd8xY@smile.fi.intel.com>
Message-ID: <1181064f-5e2a-9538-bec3-b05026ac9a5c@linux.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com> <20260128105301.1869-4-ilpo.jarvinen@linux.intel.com> <aXoNB7pnQMpPd8xY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1483632068-1769606767=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1483632068-1769606767=:1017
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Jan 2026, Andy Shevchenko wrote:

> On Wed, Jan 28, 2026 at 12:52:57PM +0200, Ilpo J=E4rvinen wrote:
> > 8250_port exports serial8250_handle_irq() to HW specific 8250 drivers.
> > It takes port's lock within but a HW specific 8250 driver may want to
> > take port's lock itself, do something, and then call the generic
> > handler in 8250_port but to do that, the caller has to release port's
> > lock for no good reason.
> >=20
> > Introduce serial8250_handle_irq_locked() which a HW specific driver can
> > call while already holding port's lock.
> >=20
> > As this is new export, put it straight into a namespace (where all 8250
> > exports should eventually be moved).
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> ...
>=20
> > +void serial8250_handle_irq_locked(struct uart_port *port, unsigned int=
 iir);
> >  int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
>=20
> Looking at these I think at some point we can move to 'u32 iir'.

Yes (though for common 8250 code even u8 would probably suffice).

--=20
 i.

--8323328-1483632068-1769606767=:1017--
