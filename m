Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9971021CA0D;
	Sat, 18 Oct 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760813781; cv=none; b=Y94ajsriheoz8GLa+VbtNQhEMH+vWZAMM9XrDDZWEuPJbzO5DKjVqfZ09kKuV3srzkO2NS9YuKtCnOvxyJ5edX63ZScvir/aV47SMQ5zMchkIG+Op64yNNV32WR1uIMuIDmcvx74Fz3bsIR/tdUCHIMEX9QMuc4TxglRlSUhGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760813781; c=relaxed/simple;
	bh=jAFFX9re57CbcGmY/anw6g9Xgwh+ZfQ2CdQT+K3Wmq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0eK8xtg3iJ0nJOLSXoyzUSpj34FzjsStFST1U2R6SvYa2ONiR7sK9pvLzleDQhGxk73w82W+0GqDy6Io4lLs37Q24Kf9Ef1e0Vv7ldiPtJ35RKtCq4qQTaCX3xfVW/WrQGM1q4IkzurXyltAtuDCsCee63V99XD2gSN6gbF83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZb1EmDJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZb1EmDJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760813778; x=1792349778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jAFFX9re57CbcGmY/anw6g9Xgwh+ZfQ2CdQT+K3Wmq8=;
  b=LZb1EmDJEhMXmP2cmVI8hhZTIp6McTRu1DmPNhRrfYzOIwWfUVowQSzv
   bEZz4q7eVtkSMoqjFfCvrykvdV4Wzf8TO/l/RuhAk28ktN/OZpcVa3dzt
   nHHg9ymGy5iiJ+eJzm8DIYXl9TEJdDFF4OcYop3GkvSy4jmmkI+bua23g
   73pooFFpWQs81NRQxDalcuZzJN2DCOoevTlg7TH0wdIxCqShS33O7SxGG
   QaScGyF+mDpFcss2S2/gdFl783SOOd+nxWXnI313NJXdfJMhXVWWYZyFa
   44G/QDFOgjkqqJRkzSuKwGLZryXyj9O54p7Z9sVIb0Gz5+FRFHr2x8WAG
   Q==;
X-CSE-ConnectionGUID: QlWqOqmLSZ6OfN6wWiQ3UA==
X-CSE-MsgGUID: 3uWGVFuRQV+9ke+iUmMTvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73279642"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="73279642"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 11:56:18 -0700
X-CSE-ConnectionGUID: mQQxhz5RSsePe5MgmLpYUQ==
X-CSE-MsgGUID: r/bTuVqmRUulbMLDhAalqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="213966635"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 11:56:15 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAC69-00000000x6Y-0o2t;
	Sat, 18 Oct 2025 21:56:13 +0300
Date: Sat, 18 Oct 2025 21:56:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	songmuchun@bytedance.com,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	buytenh@arista.com
Subject: Re: [PATCH] serial: 8250: always disable IRQ during THRE test
Message-ID: <aPPizEp9w3gcwa0H@ashevche-desk.local>
References: <20251014114727.1186-1-zhangpeng.00@bytedance.com>
 <94d19d6d-5bb5-4156-8499-0be3d227f478@bytedance.com>
 <0eb4c357-aafd-42bd-a4fd-687a91831bf4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eb4c357-aafd-42bd-a4fd-687a91831bf4@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 15, 2025 at 05:49:34PM +0200, Jiri Slaby wrote:
> On 14. 10. 25, 14:19, Peng Zhang wrote:
> > 在 2025/10/14 19:47, Peng Zhang 写道:
> > > commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
> > > has been set up") moved IRQ setup before the THRE test, so the interrupt
> > > handler can run during the test and race with its IIR reads. This can
> > > produce wrong THRE test results and cause spurious registration of the
> > > serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
> > > short duration of the test and re-enable it afterwards to avoid the race.

...

> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct
> > > uart_port *port)
> > >       if (up->port.flags & UPF_NO_THRE_TEST)
> > >           return;
> > > -    if (port->irqflags & IRQF_SHARED)
> > > -        disable_irq_nosync(port->irq);
> > > +    disable_irq_nosync(port->irq);
> > disable_irq_nosync() may need to be changed to disable_irq() to prevent
> > interrupts that are currently being handled.
> 
> Make sense to me. Care to Cc the people from 039d4926379b next time, so that
> they can comment?

Thanks for sharing, Jiri!

The above commit message is unclear about the scope (HW wise) of the problem.
Is this only appears on a certain platform or on a wide range of
8250-compatible devices?

If this is only about a single platform, perhaps it needs a simple
UPF_NO_THRE_TEST flag to be set?

Otherwise, I think the above mentioned commit missed to explain the case of
the delayed THRE test. Brief look at the code doesn't reveal a problem to me:
the THRE test and timer backup is for Tx, and if we got already an interrupt
before THRE test it either Rx, so no timer is involved, or Tx on the platforms
that do _not_ need this backup solution. Ilpo, am I right?

-- 
With Best Regards,
Andy Shevchenko


