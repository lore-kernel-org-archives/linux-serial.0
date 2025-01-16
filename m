Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A51E86E;
	Thu, 16 Jan 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028924; cv=none; b=krXptUCPdcizy1d62TfOyj2jKLd1Hc+edKXcpfI0rVd4PmCtHz0fiOdEXgHcHYdzkg5vcq52DNlHKgrgU2ItgHHPwU2kN0SFlFisNYwTvJ98llBsMilKDSJlqUEXnKNATgV+zJ3XWMDt/WlyBuDaj/xSuVmHQdCqObrfZGQunqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028924; c=relaxed/simple;
	bh=tsg0IKuMb8zz0xiJdU3NcduFif97BuFbErgR5qyq3BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt1xo/kQPCvl2V4yo6opxeXbWGoUJe/xf9QYVaB5mQKCzh6S1TFl+Zs1yXkb1lNGNohxLJikLN4qoR1YbwqsNg5YjFaRcdn/g67OyYsa+rx0BaSr123SbeU9YUkeDpQcmpqcXWZJ8J0Yc/KtpaHVf8p2G6jxqiJxVyeFklovVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Tv0Y9UoKTLeacItKrXD0AQ==
X-CSE-MsgGUID: Z86abuIxTJipIyAFMpkGKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="47900943"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="47900943"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:02:03 -0800
X-CSE-ConnectionGUID: EoccqJorStyim46Q5TgEMA==
X-CSE-MsgGUID: cOgFKDAJQH2Xcx0CNeDMmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110449732"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:02:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tYOZS-00000001eop-0UuR;
	Thu, 16 Jan 2025 14:01:58 +0200
Date: Thu, 16 Jan 2025 14:01:57 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	gregkh@linuxfoundation.org, hvilleneuve@dimonoff.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com
Subject: Re: [PATCH v1] serial: sc16is7xx: Extend IRQ check for negative valus
Message-ID: <Z4j1NdXs-ng6VBNZ@smile.fi.intel.com>
References: <Z4jLU75SU53VGsRU@smile.fi.intel.com>
 <20250116093203.460215-1-andre.werner@systec-electronic.com>
 <be1bc254-da95-47c2-b81c-e630c0f924b2@kernel.org>
 <Z4jW_TUQ8RNr1FWX@smile.fi.intel.com>
 <834d7b6e-27a4-41e9-b36b-2bcbd0504bd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <834d7b6e-27a4-41e9-b36b-2bcbd0504bd5@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 11:02:23AM +0100, Jiri Slaby wrote:
> On 16. 01. 25, 10:53, Andy Shevchenko wrote:
> > On Thu, Jan 16, 2025 at 10:42:14AM +0100, Jiri Slaby wrote:
> > > This is threaded weirdly.
> > 
> > Yeah, new patch (version) — new email thread.
> > 
> > > On 16. 01. 25, 10:32, Andre Werner wrote:
> > > > Fix the IRQ check to treat the negative values as No IRQ.
> > > 
> > > Care to describe on what HW that can happen?
> > 
> > But how does this relevant? The whole idea is that neither I²C nor SPI
> > frameworks do not guarantee the IRQ field never be negative. This is
> > the fix to the previously submitted patch.
> 
> They do AFAICS.

They don't AFAICT.

> Could you be more specific?

The documentation of the fields and their types suggests my way of perception.

-- 
With Best Regards,
Andy Shevchenko


