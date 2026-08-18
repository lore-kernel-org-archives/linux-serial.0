Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B5347BD7;
	Tue, 18 Aug 2026 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033698; cv=none; b=fwAtoRU37wYGXz3kvd7iNkFMGtD7TPG5DJTrltZaRCD85F1IZTBKZGMGKhI9QA3lGHODRHv/b5O01C2RFAbzMEXrJFaYEhrd0048Bku0Xl/A+ia47Y/AnTT+GdkneUnEec2aetpQEz5Cwyb4Ql2LGrf1wmdnuSBN0I29qqrr6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033698; c=relaxed/simple;
	bh=qmM93o9jv0NTkaOlDD7aB7TzWSk+F2gZPiTnShlYhI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmIobewR56rKmyTUkPMTXjLOZGAcSGcb6cZGMFC6Sdnniyaqv2dp0ElUtV2KU4aRt7/8Att5yuJ5jKiDmz/zBrlX7u+zQJ3sqrLkU1A1gqa+EG7/xGztNw7gT7K4InOEtWwuEJ6AXYdhiqRzW6proC9tjvwwjMFI1247NNsApT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9HIKrPy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9HIKrPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787033697; x=1818569697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qmM93o9jv0NTkaOlDD7aB7TzWSk+F2gZPiTnShlYhI8=;
  b=b9HIKrPyXA7TgZ3Q1DpbLGjPGwXpGmiy6mspsKlv2Zudv2rcNp27KDcw
   /yt0SZkmuyu1zYOy03r2HLZmENjAF2cJGh7AeAIfLmjjeLhJnv5UeZWbx
   VxJoJLPetj6ozoZbLkB+5vdx3+KWrLZEasu2GHkEo5+r+0KOyTdsZfO0l
   IeyEPG8K0XEdQZ4ZEJaHFwbRAu0mgMwRsQyC9q28XcCOd+ypmyat1xVNA
   AaprAjcw/ZIRoq8UtzS94OiwA6Yn3PBUXKEvdkv2MeLwmKS9pyJclLgg2
   KuSfvCcKe373G5LtU1K0lhDgPXQT+u0a67pRBRBcYfKZlvdGG2cIMbxy0
   A==;
X-CSE-ConnectionGUID: Id1Xq7AMQDCKhMFWSpzXGA==
X-CSE-MsgGUID: Ruse1gmlT6mWYJ29sngNew==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87430104"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87430104"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:14:57 -0700
X-CSE-ConnectionGUID: EtJUJCZRQO+QPOocJrxmnw==
X-CSE-MsgGUID: clqqQzv4RCOrbqD+WkD+xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="265742698"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:14:54 -0700
Date: Tue, 18 Aug 2026 09:14:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v9 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <aoP4Wzji7w1XTTpI@ashevche-desk.local>
References: <20260724103654.133654-1-john.ogness@linutronix.de>
 <20260724103654.133654-2-john.ogness@linutronix.de>
 <3023d7d7-c8ab-48e7-a0e4-e18cc4ea0b9a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3023d7d7-c8ab-48e7-a0e4-e18cc4ea0b9a@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 06:32:12AM +0100, Jon Hunter wrote:
> On 24/07/2026 11:36, John Ogness wrote:
> > Implement the necessary callbacks to switch the 8250 console driver
> > to perform as an nbcon console.
> > 
> > Add implementations for the nbcon console callbacks:
> > 
> >    ->write_atomic()
> >    ->write_thread()
> >    ->device_lock()
> >    ->device_unlock()
> > 
> > and add CON_NBCON to the initial @flags.
> > 
> > All hardware access in the callbacks is within unsafe sections.
> > The ->write_atomic() and ->write_thread() callbacks allow safe
> > handover/takeover per byte and add a preceding newline if they
> > take over from another context mid-line.
> > 
> > For the ->write_atomic() callback, a new irq_work is used to defer
> > modem control since it may be called from a context that does not
> > allow waking up tasks. During suspend/resume the irq_work is not
> > used as this has been shown to cause suspend problems for some
> > hardware. Upon resume, any pending modem control is performed.
> > 
> > Note: A new __serial8250_clear_IER() is introduced for direct
> > clearing of UART_IER during console writing (which will not be
> > holding the port lock for atomic printing or KDB/KGDB). This
> > allows restoring a lockdep check to serial8250_clear_IER() in
> > a follow-up commit.
> 
> This change is causing a boot regression for our Tegra20 and Tegra30
> platforms. Reverting this on top of -next fixes the issue. Previously with
> V5 I did not see a boot issue only an issue in suspend.

Wasn't v11 applied and not v9?

> So far the only
> interesting thing I have observed is that if I add 'keep_bootcon' to the
> command line the board does boot.

keep_bootcon defers driver taking over, that's why it works, it uses just
simple primitives instead of full-featured driver.

-- 
With Best Regards,
Andy Shevchenko


