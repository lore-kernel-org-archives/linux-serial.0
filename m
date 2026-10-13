Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05D395AE4;
	Tue, 13 Oct 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882572; cv=none; b=ubGue2RrpHng5NlaGyGFKmG6z1x7znFNClKy4xVvcoKx5tMW76sqctPc0YZuE/S2oObGN4imE83LaJwzYl5kAWjnxZ2hh8jMNaP7r6ONhgGMAg/lE6+Cqzy09PWEiBOXvgEx0+L6CgyQjq4afRCo/8LPAxJwp+qGxojTAO8LyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882572; c=relaxed/simple;
	bh=IQ/UNuFHURdJ5ziTLh4qZrD8MOsGX3B11CY5vdjd4ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU1G4ecdDUbUi/WDiLX1eZMGnCLIREscso5TsSBEUPMpKHlgS6SEqZNz1lY5kFsk3Fk+q6A4KSTM/YtxyHFUmvQRwA+/fPcLXlhTqZBQaK0S8Q9pu72LB+5jskUPhHfXcSA8i5RH3hCpXISk8vsEIizUrcTvwlhEJhYDiTMJ8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwG7vtZ6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwG7vtZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791882571; x=1823418571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IQ/UNuFHURdJ5ziTLh4qZrD8MOsGX3B11CY5vdjd4ZM=;
  b=hwG7vtZ6YBR7AfXPt3DffO1F6MMLYFDQchc4k9T2NfR2dDokx/8E9Mej
   ZHpA6HCI6U+FsX+rNWpqN8HVMBYL1IJJqtIqtKP9RWXrWgzp8N/CNJ7E9
   OFgovNi5Z3U6KINz9JdhtblHU8BlUk3mfkw4VloBFmDxf359h+iSaYlCS
   ORL36WNZT0nN37qSpJxxP8O+L8qk79jC5wCopYVdKxnVhxhlKMxL+pnCa
   IN77ybNQBHPPrveoNRrnyfbd4IroAJaDMTg2Jlt55g2RTvuioon8OHA4A
   2EkAqVjd4dYmS3RjmGnYuFlFZ//dcUZYt5BXm6wq7pW8gcYXw3E1LDRJe
   w==;
X-CSE-ConnectionGUID: fPqzkKJTSviPLrXKqzkBKg==
X-CSE-MsgGUID: AaWK8NZNSZy+UpjoFEwQnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="595188"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="595188"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:09:30 -0700
X-CSE-ConnectionGUID: BgXYAbCpQMSPY4ai3EmgtQ==
X-CSE-MsgGUID: Z+SacHifQmOu6wFBhA0rHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1196513"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:09:20 -0700
Date: Tue, 13 Oct 2026 12:09:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as31PsESOgLUhMB6@ashevche-desk.local>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
 <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 09:53:26AM +0200, Jiri Slaby wrote:
> On 13. 10. 26, 9:33, Andy Shevchenko wrote:
> > On Tue, Oct 13, 2026 at 08:48:51AM +0200, Jiri Slaby (SUSE) wrote:

...

> > > -	rc = serial8250_register_8250_port(&port);
> > > -	if (rc < 0)
> > > +	struct uart_8250_port *uport = serial8250_register_8250_port(&port);
> > > +	if (IS_ERR(uport)) {
> > > +		rc = PTR_ERR(uport);
> > >   		goto err_sysfs_remove;
> > > +	}
> 
> > Also do not define
> > variables in the middle of the code (it's only allowed for auto cleanup
> > variables and for-loop iterators).
> 
> Why, actually?

Because it's the style. Linus also told it many times (I am tired to repeat
this, I leave it to you to find his words on lore.kernel.org).

> First, it is used in the kernel quite a few times already
> [1]. Second, while it is sort of c++ism (and I like to use modern c++), it
> makes the life of the variable a lot more obvious.
> 
> [1] eg. see output of: rg -U -C 5 '}\n+\s+struct .*\*.*=' drivers/

(you made me to install something I haven't heard about, it's better to use
 `git grep` though)

Note excluded __free() if I get regexp correctly

$ rg -U -l '}\n+\s+struct .*\*[^)]*=' drivers/ | less
drivers/ufs/host/ufs-qcom.c
drivers/dma/xilinx/xilinx_dma.c
drivers/dma/idxd/init.c
drivers/media/platform/raspberrypi/rp1-cfe/csi2.c
drivers/gpib/agilent_82357a/agilent_82357a.c
drivers/gpib/ni_usb/ni_usb_gpib.c
drivers/tty/serial/samsung_tty.c
drivers/s390/scsi/zfcp_scsi.c
drivers/gpio/gpiolib-shared.c
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
drivers/gpu/drm/msm/msm_gem_vma.c
drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

So, less than dozen of drivers doing wrong is not an argument, try something
better. But thanks, I will check and address this in some of the above.

-- 
With Best Regards,
Andy Shevchenko


