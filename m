Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A61EEA4B;
	Thu, 30 Jan 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254704; cv=none; b=W7hiPIaMrEp3yZiTmPE1F84hT88ZuoR4NV4W6getiU69CaFfFX5V6biIfOY0yoaE7Bh7fPtGbaolLtgRvAQnoKxIQWLWLGsD5SsneBRLYUHpxVmHm2gY60pM2pQziUua7C4QFtFgnb4DX032aj7+OvUNxonOzdR1buC/oVeTeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254704; c=relaxed/simple;
	bh=33qiW3dWmI8bHxHCG3SW5kkf5Qn+guEvPG4As5/sGno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTosDhM6ptwLMMnSEDakAAzVRf0Ls35TipuDQ6u3vRAsUKCF9gQfGgOS+x++Ufb2jiPmso83Ae+YrtjeMU4Nb3qiofURvprGN/X978Ezs2eGldrYppPjdyfEPxWc7DxG7wtiKmgNnc1RAjSC1+gvbsfm9vW3tmws+SM2taWiHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2sQi5qV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2sQi5qV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738254703; x=1769790703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=33qiW3dWmI8bHxHCG3SW5kkf5Qn+guEvPG4As5/sGno=;
  b=c2sQi5qVQ88r5+dgy7cQG9G4oQdgdg8mdQMB6m4KGX6IymhCj38OlUY/
   eJNZbDu3Z7aH0xC47JAoCaCu6eEbATQ8lRejTKl1XdR+pNvAqTWnWjoUT
   muR6xZ3i6YwYUDP3u8P10cOuiF0rNRXqvZ3TUUMZoxOSfEU57xCOldxKR
   b01zRGQL3l2PaYNXYIMuAkmnh5TlruTNGP7Z9JQZsWoTinUC6eNBzksk9
   sbLhc2VO8P8f1nv/0N5xArYFp1kf/w36co0no4a0L8E/MOtYcIqOds5FQ
   uf5F1x4q5Nc/w7KV6Y8vzh0ND2Rwlt8lC4/2Dy8+BPXZQ3Ewt9b6HZjnt
   Q==;
X-CSE-ConnectionGUID: T3TV64EETxC5NPr8hGap0Q==
X-CSE-MsgGUID: 3ZbUukYERwaEMKv6xMuT/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38514479"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="38514479"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 08:31:42 -0800
X-CSE-ConnectionGUID: Aq4BY09mR/+UcK4yGKgjJg==
X-CSE-MsgGUID: qSUJ8LpvTMCHNOdKh5Y06w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="109944324"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 08:31:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tdXS3-00000006ixE-0s7S;
	Thu, 30 Jan 2025 18:31:35 +0200
Date: Thu, 30 Jan 2025 18:31:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	"Dr . David Alan Gilbert" <linux@treblig.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>, linux-serial@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "tty/serial: Add kgdb_nmi driver"
Message-ID: <Z5upZhPz_LIbwrzx@smile.fi.intel.com>
References: <20250129162700.848018-1-dianders@chromium.org>
 <20250129082535.1.Ia095eac1ae357f87d23e7af2206741f5d40788f1@changeid>
 <Z5s38S7sJ2mka3-1@smile.fi.intel.com>
 <Z5s5IThpnMNdY62v@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5s5IThpnMNdY62v@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 30, 2025 at 10:32:33AM +0200, Andy Shevchenko wrote:
> On Thu, Jan 30, 2025 at 10:27:29AM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 29, 2025 at 08:25:50AM -0800, Douglas Anderson wrote:

...

> > > [1] https://lore.kernel.org/lkml/1348522080-32629-9-git-send-email-anton.vorontsov@linaro.org/
> > 
> > It might be possible to use Link tag here in a form
> > 
> > Link: URL [1]
> 
> Hmm... I'm not sure what this Link is supposed to mean. You might be forgotten
> to update an URL to point out to the cover letter? (This is the link to patch 9
> in the series and looks a bit unrelated).

I reread and I think now understand what you meant. The are several patches
starting from this one that are not landed in the upstream.

-- 
With Best Regards,
Andy Shevchenko


