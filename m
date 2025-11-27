Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0772405E1
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276983; cv=none; b=uyRESBhVXchLBY3MZDz4DF40DEcAEtPPWg19QYDOvOpnpzlz+pC/AFSjf0dLg+tn6bXwGQ2KDEuOHw0LTTsJMyJzgs6FO/rGUTqQY92HsVuHLnHCuSgWc9+o9FRXqPLy/IJhw2mCtPvFmgYJMUS1yePSrh0jt4+eAi55VmS0oCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276983; c=relaxed/simple;
	bh=OZ2EEZny/FjxprF8WEN/iWSO/Bo/UfKxlA7JUeP6tks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8LHqvgY0ghZ7fVA5a0fFduyFF4F2yRRsvyPgeXuMSOvHZSC6r6/WYuJ+FOsPOiOUAKRCiHqIYWqIGrvC2CGQKLbiIYYD/Y6KaslvDwJEIpz8nT2mPURzUsF0RGvWGfapPOaiCZnE0B7ea4/4A3Nx9u5KAOU9tue7NtFnXx76FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xrvrd9cU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xrvrd9cU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764276982; x=1795812982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OZ2EEZny/FjxprF8WEN/iWSO/Bo/UfKxlA7JUeP6tks=;
  b=Xrvrd9cUmVIuYmqONK0nt+omEd9P7Pir4uNKthFefT+2FRLOMxkpxz0q
   6VhDrmBh8gvyZP5btwQUUHx7P7Y6VMhTtaQy909Pmw6e3U+y9jo7SLPYD
   HpK/xJ/2HG3yIzXHwEDXmpOk/uvCKB/b8NrJXMlmJ8FgF48urIlom8YM4
   alMp9k8y5u3pBXzbv5uA3cclAwXjSvrqMH1Z+mgRiuHHhWyyiQli/NouG
   ucwr3emuzu/7zJQE67X7RuLR8ofuFnRK66JLG7H+cVa6XyOW5yJI42JlM
   MOvgRg8Kj5Eavun2Ifgkz5AYVGdICtNSDYgpOJlTbmJIgJj6Aw8f4juWk
   g==;
X-CSE-ConnectionGUID: pihHyk7TR1K/5b/QXqwTVA==
X-CSE-MsgGUID: hLBtPff8ThurwXGrmR5lSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="76952715"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="76952715"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 12:56:20 -0800
X-CSE-ConnectionGUID: rr5e9hmbQL27A5Evba7Xsw==
X-CSE-MsgGUID: QvwMRt/zTYaklSlKnU0k/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="197480622"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 12:56:06 -0800
Date: Thu, 27 Nov 2025 22:56:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Subject: Re: [PATCH v2 0/2] serial: add KEBA UART driver
Message-ID: <aSi641ahFZ2WvZAg@smile.fi.intel.com>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <aSh21GDLStR3uhnX@black.igk.intel.com>
 <d7f1fbbb-0ec0-47b7-beee-8e9487098c99@engleder-embedded.com>
 <aSis8tuBCfHqJvGY@smile.fi.intel.com>
 <0269cc4a-9631-4129-b52c-59ee396f71c9@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0269cc4a-9631-4129-b52c-59ee396f71c9@engleder-embedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 09:07:10PM +0100, Gerhard Engleder wrote:
> On 27.11.25 20:56, Andy Shevchenko wrote:
> > On Thu, Nov 27, 2025 at 08:26:13PM +0100, Gerhard Engleder wrote:
> > > On 27.11.25 17:05, Andy Shevchenko wrote:
> > > > On Fri, Oct 17, 2025 at 04:42:07PM +0200, Gerhard Engleder wrote:

...

> > > > Third, the expect approach is to see DT overlay provided along with the FPGA
> > > > configuration. So, basically your cp500.c should not have been existed to begin
> > > > with.
> > > 
> > > Like first, it is just a PCIe target and this PCIe target is divided
> > > into auxiliary devices, which was suggested by gregkh. Initially I
> > > divided it into platform devices, but the suggestion of gregkh is a
> > > better fit. It is a single PCIe target, which consists of multiple
> > > logical devices with its own registers and interrupts. This logical
> > > devices are then separated by auxiliary devices.
> > 
> > This is implementation detail in Linux, but in HW why are those not a proper
> > PCI endpoints / functions? With that done, the drivers can be just normal
> > PCI device drivers.
> 
> Yes, PCI subfunctions would have been much nicer, with direct drivers
> and no auxiliary/platform stuff in between. But these were not
> supported by the FPGA vendor.

Unfortunately...

> > > 3 years ago Intel was not able to deliver enough FPGAs. With just being
> > > a PCIe target, it was possible to switch the FPGA vendor without
> > > touching the software in the field. With Linux re-configuring the FPGA
> > > that would not have been possible. So re-configuring FPGAs during
> > > runtime is something that should be only used if needed.
> > > 
> > > > Can you elaborate on these considerations?
> > > 
> > > I hope you get a better impression what this is about. For the drivers
> > > it is not relevant that the device is FPGA based.
> > 
> > Yes, so it's rather something with a custom FW that is not supposed to be
> > changed (at least from the device hierarchy / functionality perspective),
> > or very little from version to version. Is this a correct summary?
> 
> Yes, the only changes are bugfixes. The register interface must be kept
> compatible. Like a microcontroller with a firmware which implements an
> USB device.

Got it, thanks for the elaboration on this.

-- 
With Best Regards,
Andy Shevchenko


