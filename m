Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370341C7F;
	Wed, 19 Jun 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781477; cv=none; b=ihksMgGkvZfM5G/2zqTZLb39bPE2NGPVyizXJgsfB9xX9BhOha1u4Y4JCxQDMJtVWtOf54nxYWX3X+zAIHq+P05iJOOxZq5vGL7i8Ph05HMfHny/gtXyrN97rktjTLGMWqQbkAwFB2WW57KpiL1wuxbcsBmtnL7upIUwF67gmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781477; c=relaxed/simple;
	bh=RFKfX4QMJoxOLdHQIwV7xomt+DU8o44LRv+PC1+j5wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHbIJU4JFneagVGpxYaAqqihTBe4Cf/e9JloxpWhavrWm+fHxS534pOrDNlEjG7Zy5aYjMZkFTWtp2wFEZdSlchHvMyC1blwfauhu2g/frLfHFSzlr5Ktz6WJVs1ram3NlhpPrgqgjfV9zt+cRpNm8o+r1foisFylZeSZuKM+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMCaz48G; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMCaz48G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718781475; x=1750317475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RFKfX4QMJoxOLdHQIwV7xomt+DU8o44LRv+PC1+j5wg=;
  b=WMCaz48Ga01vf9qHoP3Rd50SjDwOrMMK515hhCxirNiBeH3BnknQAYRB
   T6MHA5sW5CTSf6u/Qwd7PdujISOJrik2FJtyH9JgaW6sxHUR2jF/5vVfi
   jI1YVJyQ0dMfLbBne8qiyK9joyZuJfoL5Eelp9VfUMiXetZjh/9+QOfH6
   CyWIAlQ+9qBoN1kQvLmgWVhlFobIimBe5z8AWPA4GsztZATcOXOf3OWxL
   MAdSsMKsosXG3MwyX1cXsrQdA7u5tYdqsK8mBe/9NzFGpipwnUTPHalov
   i4VemfwZZ+sega2UpQxCcKDJKglR93hvbnQYzad+5Go8i8IutP63jaVWD
   A==;
X-CSE-ConnectionGUID: MRRMwKkTTzS1iS2VVzMAGw==
X-CSE-MsgGUID: SHrMX8z5RmCSwIETx+4D8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15934872"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15934872"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:17:54 -0700
X-CSE-ConnectionGUID: YbzCoJzxRlWg5kZSP3dKWg==
X-CSE-MsgGUID: TxlOFb/vRTKpX4a2w81e8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="41778957"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.247.16])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:17:50 -0700
Date: Wed, 19 Jun 2024 10:17:46 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Rename preferred console handling
 for match and update
Message-ID: <ZnKGGoboxRMwkeWm@tlindgre-MOBL1>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-4-tony.lindgren@linux.intel.com>
 <ZnGQ8JAu2OQf0GX8@pathway.suse.cz>
 <ZnJg6KQeIs95UFAB@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnJg6KQeIs95UFAB@tlindgre-MOBL1>

On Wed, Jun 19, 2024 at 07:39:04AM +0300, Tony Lindgren wrote:
> On Tue, Jun 18, 2024 at 03:51:44PM +0200, Petr Mladek wrote:
> > It seems to try whether c->devname matches a number "X", or "ttySX".
> > It even tries the sparc-specific transformations in
> > serial_base_add_sparc_console()
> > 
> > But this is the original format which does _not_ include ":".
> > It never will be stored in c->devname and will never match.
> 
> Good catch, this won't do anything now with console_setup()
> checking for ":" for deferred consoles. So we should revert commit
> a0f32e2dd998 ("serial: core: Handle serial console options").

Heh actually we can revert a lot more, basically leaving only
the renamed serial_base_match_and_update_preferred_console().

Regards,

Tony
