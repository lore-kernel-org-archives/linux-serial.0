Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565015;
	b=WGYetNrAjEu5qnAxU1Kb6uPPlBQDaK/EUiBRNN9r80xDMzEbI5UeaLXU9di/juU0g/vC
	 Cpsr6fkNVwrx2TtYKf4gDmpfK2uaC693H2m6JRLbaKegxNP1HnhHdbfKDHhfVQwHkf5R7
	 yazL+8Ltf1G6Cnbefvix9Nl0sBJGucHt70omc6RZhgJCTtzhUdsImFr+esXtqjjPiNDhz
	 7g6TRiIcXtgo8XWvCMbown1m67+r6GTkk4LhgBkXlwITjFwM8BLnfxam1Xv7smqU6Np31
	 pw5JAZBtLGSJojCF9Q7FyruxPGLNFD3+/ORzvw6QxdSE+tgEqxw1Pl+gGz41r+YLYOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565015;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=hOcd/ybW41WQRIw4yk0tTChVIHQbGli2LRqLVjxW4rI=;
	b=CFXeBGR61TH8ToFYMU33dKlcVqkdxKFuGzDrQzVqpNlaCug8mB4PtHGJi/Pf9NFdMYHw
	 iLJMSu+af3CyfYOYufakmR8Wfike6fmHuT1wJ/jsUKGHBY7Y3qv2tz3yBcxPG2CxmM3gX
	 FyXxy4HPxzutnWUuua/iOgk+r98b6myc6BfWemdirXWQILt4GpegO4VMl6R+JBXxj81HQ
	 SDCeh5md3RSe6QGZIriQD9JNCrAa6e+zghjoRKg2Qe+YFKEbv3pWP22kW7b4aXntwNlYW
	 IoXDh189UkHXabF6mhjbfKYJaIbK+bXs8fWLYFCk37X2VBdquxQQ3lW0dg8USa0+xSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HtxnNQJt;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEEA606A324;
	Wed, 21 Oct 2026 06:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BEEA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HtxnNQJt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792565010; x=1824101010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t7QuSbFm/OZPuXTWlsUtCNI9PFTEGuzt+w+5HV1IiWc=;
  b=HtxnNQJtyasmV60Fjt8jrYqeED/BIH46PTy42inlfU9JsZWYrnlGWb5+
   Fhdc6MyMjZ73aIym8FOFiF9oI0El9VbnPMNzgEVi9rrBU55cGqE6KUPNi
   26MPVxL2gctVm5rjYWTBZIcae62O1ELquCh5KSa6DTGfpwz+RMFmov8sm
   rcfs/xrkaSM0dbWLxPzrAHyRB5xKmGyX7rE4PUhUD3sfSPsdSB/jrj+s8
   3XAfhu0nnCdeDQOgEWDJaghxB8WzgjO28C/fzV+PrTa/0F8f/xZ8R91Pa
   iWpz6gEQTxlypUFK0WKyNZbj0iyD4H7XmgQGc0fjqu06M0GomPvtDHI3v
   Q==;
X-CSE-ConnectionGUID: EEBlMLjtQCaqjfBEHXSJ6g==
X-CSE-MsgGUID: QlvvidoESr+xGzv35bM5jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1262071"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1262071"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:43:29 -0700
X-CSE-ConnectionGUID: EUWzumZPRr2YHD64Lu80qw==
X-CSE-MsgGUID: 1d1oD7PaRWOdxkHTs7rzWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4810152"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:43:26 -0700
Date: Wed, 21 Oct 2026 09:43:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-sunxi@lists.linux.dev,
	andre.przywara@arm.com, wens@kernel.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, enzo.adriano.code@gmail.com
Subject: Re: [PATCH v2 2/4] serial: 8250_dw: Only accept a contiguous DLF
 readback
Message-ID: <athfC3qGJuQGbITy@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <d992e18d-31ab-4937-8780-9c9dc423082a@kernel.org>
 <atcm2zqDs1P_EDr0@ashevche-desk.local>
 <09812a6a-dd0d-9c47-e1ad-5220f1954648@linux.intel.com>
 <20261020122746.41699-1-vinicius.eduardo.pedrosa@gmail.com>
 <6c4a5613-7e10-64dc-a670-6407a4f1f6ed@linux.intel.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c4a5613-7e10-64dc-a670-6407a4f1f6ed@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 04:02:29PM +0300, Ilpo Järvinen wrote:
> On Tue, 20 Oct 2026, Vinicius Pedrosa wrote:
> > On Tue, 20 Oct 2026, Ilpo Järvinen wrote:
> > 
> > > For is_power_of_2(), 0 is not a power of two. And it also wouldn't make
> > > sense to have zero bits in the bit field as it's same as no bit field so
> > > using just is_power_of_2() should be enough.
> > 
> > I think the reg != 0 check still needs to stay here, since the test is
> > is_power_of_2(reg + 1), rather than is_power_of_2(reg).
> > 
> > For reg == 0, reg + 1 is 1, and is_power_of_2(1) is true. So without
> > the explicit reg check, a zero readback, meaning no DLF, would be
> > accepted as a valid DLF.
> > 
> > I'll keep it as:
> > 
> >     reg && is_power_of_2(reg + 1)
> > 
> > in v3.
> 
> Ah, you're right.

Sorry for being unclear, yes, that's what I meant, reg != 0 should stay.

-- 
With Best Regards,
Andy Shevchenko


