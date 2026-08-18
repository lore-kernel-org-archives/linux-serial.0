Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979B2749DA;
	Tue, 18 Aug 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062653; cv=none; b=LZCxZZgnvH7drYwIWvS//Fk/rmiqaHHVYP7L2Pe1NFQaSjyj/h2s/yMGF/+pfymfpRHZ7PrjLFzu4M6GOxpaYx5VaoVBjwzbSv24Mv8iIFiIDQrNDBwpaavDLatdLokmkhKLTsew2zVkorUv43+1U4lA3LRM4vHO9v/AJR+68g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062653; c=relaxed/simple;
	bh=lL6H9haiC5nl4nTwOlYGfW3J0UtwnXNdwbQDacHIkxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3519LnsmrWvKUDhyCF3jv4pqr4fQH9vudDIHiwoG3zhq1vWmDGwYGjoyeZSeIrGnHQ8gUsWVF8UDxwB4VDzJS4Xnij4LoLBJQ3TvBnfulgskYMKb29pYRF7GomXpdnqWub65PbiLiFmukqIj6jG/4VkxOuF1h03gSb7q7oXGAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=latn6tzY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="latn6tzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787062652; x=1818598652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lL6H9haiC5nl4nTwOlYGfW3J0UtwnXNdwbQDacHIkxQ=;
  b=latn6tzY4YGdjKn9PSWR2ZhsdNd55WRitY8QMlYd1qHC73CMjfeRoqgm
   YTu+6ZARQiBni62lVQfluZ8HRYeQQxyEcJCRRuCfKdVm+JjrKIKsjnLrs
   /mc11QuLhq706NoPSplwM0qu67Yi3AwhsdEj+3J5H6rVtzdTJrl14VnJC
   nJvmfEOwrrFSqVDL8HnTgY2w0VAvxv99mhD0PxZ+bw/VQTTBryB7v1YSO
   JTAPoEehkR+RI/nXA4rTYVVnjp6hOvpIoeNNWQNjhK24ELp8ARFztBsc/
   ZDvlbDrD/nRKC5oppc26YzA7YWbLCBvI/jU7goCQXStXDzyCvRiWyH/rx
   Q==;
X-CSE-ConnectionGUID: CBUH52VLRqe42hjBjIVz1Q==
X-CSE-MsgGUID: mA9+p5nVQ76aI1P1RBP0iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="75085553"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="75085553"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:17:31 -0700
X-CSE-ConnectionGUID: Np9P21ywT6uabLZe7WThEw==
X-CSE-MsgGUID: eW7Qnan3TPiDX4vnKvFvUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="290039624"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:17:26 -0700
Date: Tue, 18 Aug 2026 17:17:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>, Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev, Long Zhao <zl020895@163.com>
Subject: Re: [PATCH v5 10/12] serial: 8250: add Ambarella UART driver
Message-ID: <aoRpc2RK2_X3CdAi@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-10-7bbb12f0360f@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-cv75-v5-v5-10-7bbb12f0360f@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 06:31:24PM +0800, Long Zhao via B4 Relay wrote:

> Add an 8250 platform driver for Ambarella CV75 instead of claiming
> snps,dw-apb-uart compatibility.

This is a record from a changelog. There is nothing in the commit message.
...

The code seems like an almost blind copy of 8250_dw.c.

> +#define AMBARELLA_UART_USR		0x1f
> +#define AMBARELLA_UART_USR_BUSY		BIT(0)

So, is it Synopsys IP-based design? How this gets into this platform? This
whole story completely made me lost.

> +#define AMBARELLA_UART_IIR_IID		GENMASK(3, 0)
> +#define AMBARELLA_UART_IIR_STATUS	GENMASK(5, 0)


...

> +	of_property_read_u32(dev->of_node, "reg-shift", &reg_shift);
> +	of_property_read_u32(dev->of_node, "reg-io-width", &reg_io_width);
> +	uart.port.regshift = reg_shift;

> +	switch (reg_io_width) {
> +	case 4:
> +		uart.port.iotype = UPIO_MEM32;
> +		uart.port.serial_in = ambarella_serial_in;
> +		uart.port.serial_out = ambarella_serial_out;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL,
> +				     "unsupported reg-io-width %u\n",
> +				     reg_io_width);
> +	}

This is handled by uart_read_port_properties().

-- 
With Best Regards,
Andy Shevchenko


