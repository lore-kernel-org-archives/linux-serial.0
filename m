Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1B1E519;
	Mon, 26 Aug 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677457; cv=none; b=YscEtUpfwYG9ekf4rSRfv3avkfgAAVqjdORlcklkPZoyZtcTyXOFC7Rx6YHYYuABf4slueD2aWtk0OMh2gaMvHg3eapwtdwWdpfRNI1AheiAUf4LA46HPSHNEWg1GfFZIP1dHXg3p6jXA+fXYKHX4a8gn38KLja9y3m9HcjaRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677457; c=relaxed/simple;
	bh=gj4Tzqn1OcjqzZlEGWvDUsJAJQPhP/T8FGUFq6YceBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMbiDq2Qz9rrElbK0rfcVoKlz0fPSrE+jstRGNUO9AZPMmmH3EBMdlP28S2lg2uIJLbFhIPXMg/xc6Ewod78a+2KmC685mtx5BdAfXPnxOhS1deVVttA3U6zAKqvijWzOj2z0gPIrptG1pkXdgW1SLJB2ajd5b8wlTDAP8CVk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: hUZfdjo7Spa1gionn4S1eQ==
X-CSE-MsgGUID: Y40tbUgJRBqesioVmuM7Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23253083"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23253083"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:04:16 -0700
X-CSE-ConnectionGUID: 6ETm3d4uQKGkdJFPsjxMDA==
X-CSE-MsgGUID: Jt00UD+yQSiXqCiLCaQ6sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="63219181"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:04:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1siZOE-00000001w2F-3zxC;
	Mon, 26 Aug 2024 16:04:10 +0300
Date: Mon, 26 Aug 2024 16:04:10 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: linux-serial@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Krzysztof =?utf-8?Q?Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
	=?utf-8?B?UGF3ZcWC?= Lenkow <pawel.lenkow@camlingroup.com>,
	Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: Re: [PATCH v3 3/3] serial: sc16is7xx: convert bitmask definitions to
 use BIT() macro
Message-ID: <Zsx9SqoWIkAyo7cD@smile.fi.intel.com>
References: <7deb753f-bf86-47ce-89bf-8277aca4293e@camlingroup.com>
 <fbd8debf-46ab-407a-beda-43e083bffee7@camlingroup.com>
 <CAHp75VeqOV7GEqMs6fMi2Fax-97zt+ykEXaptng=pi_BDKU5Bg@mail.gmail.com>
 <5d1f5d01-c7ab-49f9-b754-1c32043668c5@camlingroup.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d1f5d01-c7ab-49f9-b754-1c32043668c5@camlingroup.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 02:35:37PM +0200, Lech Perczak wrote:
> W dniu 23.08.2024 o 19:58, Andy Shevchenko pisze:
> > On Fri, Aug 23, 2024 at 7:55 PM Lech Perczak
> > <lech.perczak@camlingroup.com> wrote:

...

> >>  /* IIR register bits */
> >> -#define SC16IS7XX_IIR_NO_INT_BIT       (1 << 0) /* No interrupts pending */
> >> -#define SC16IS7XX_IIR_ID_MASK          0x3e     /* Mask for the interrupt ID */
> >> -#define SC16IS7XX_IIR_THRI_SRC         0x02     /* TX holding register empty */
> >> -#define SC16IS7XX_IIR_RDI_SRC          0x04     /* RX data interrupt */
> >> -#define SC16IS7XX_IIR_RLSE_SRC         0x06     /* RX line status error */
> >> -#define SC16IS7XX_IIR_RTOI_SRC         0x0c     /* RX time-out interrupt */
> >> -#define SC16IS7XX_IIR_MSI_SRC          0x00     /* Modem status interrupt
> >> -                                                 * - only on 75x/76x
> >> -                                                 */
> >> -#define SC16IS7XX_IIR_INPIN_SRC                0x30     /* Input pin change of state
> >> -                                                 * - only on 75x/76x
> >> -                                                 */
> >> -#define SC16IS7XX_IIR_XOFFI_SRC                0x10     /* Received Xoff */
> >> -#define SC16IS7XX_IIR_CTSRTS_SRC       0x20     /* nCTS,nRTS change of state
> >> -                                                 * from active (LOW)
> >> -                                                 * to inactive (HIGH)
> >> -                                                 */
> >> +#define SC16IS7XX_IIR_NO_INT_BIT       BIT(0)          /* No interrupts pending */

> >> +#define SC16IS7XX_IIR_ID_MASK          GENMASK(5,1)    /* Mask for the interrupt ID */

This is the only change (one definition / line) makes sense in this block.

> > This is okay, but the rest of the bit combinations are better to have
> > to be plain numbers as usually they are listed in this way in the
> > datasheets. Note as well that 0x00 is a valid value which you can't
> > express using BIT() or GENMASK() (and this is usually the main point
> > to *not* convert them to these macros).
> > 
> >> +#define SC16IS7XX_IIR_THRI_SRC         BIT(1)          /* TX holding register empty */
> >> +#define SC16IS7XX_IIR_RDI_SRC          BIT(2)          /* RX data interrupt */
> >> +#define SC16IS7XX_IIR_RLSE_SRC         GENMASK(2,1)    /* RX line status error */
> >> +#define SC16IS7XX_IIR_RTOI_SRC         GENMASK(3,2)    /* RX time-out interrupt */
> >> +#define SC16IS7XX_IIR_MSI_SRC          0x00            /* Modem status interrupt
> >> +                                                        * - only on 75x/76x
> >> +                                                        */
> >> +#define SC16IS7XX_IIR_INPIN_SRC                GENMASK(5,4)    /* Input pin change of state
> >> +                                                        * - only on 75x/76x
> >> +                                                        */
> >> +#define SC16IS7XX_IIR_XOFFI_SRC                BIT(4)          /* Received Xoff */
> >> +#define SC16IS7XX_IIR_CTSRTS_SRC       BIT(5)          /* nCTS,nRTS change of state
> >> +                                                        * from active (LOW)
> >> +                                                        * to inactive (HIGH)
> >> +                                                        */
> >
> Before I send out v4, do I get it right, that I should convert back SC16IS7XX_*_SRC
> (i.e. interrupt source constants), and leave the rest as in v3?

See above. I.o.w. change only _MASK and leave the rest as is.

-- 
With Best Regards,
Andy Shevchenko


