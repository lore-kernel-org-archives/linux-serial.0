Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A783546F7;
	Fri, 14 Aug 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709900; cv=none; b=Hb2xAjHomxJbrMHWwsU+DQm/DxOoCLb9kHu0IEkmTmqpzo6sSfNv2qm0P+oLzybdY4fg0qu0bUkBJCvyq1eu7D8/vUe+0HIOKXtlTSCCEcLozaq6OuHiJiHuvmCq7skDpCmzJRLEGDVtKMsv+Aq9EagqOf2O+qRFOFisGzRCvFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709900; c=relaxed/simple;
	bh=eMS5yx7DHQR/4xo7wpBwlrJFEC77o7e+FVVMyIgEMUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/OXN/vRK7XB77VQO6Lzcsy7ZZbEvWYmeMprDMW2cpLwqW/5ffCeM2+KHJ2XRaQwTSaLTRGCEEaTHspnBqyN7mUNEzizQn9c2PTGvsOClQ8zLxrtd6uSwwc5KtPtPKFIYiUNrLEuBHxbugvp4TkjfLaSq9SHiNBY3sQmwY052pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r9RfqAHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r9RfqAHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D029B1F000E9;
	Fri, 14 Aug 2026 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786709899;
	bh=u15YfQFLWx8a1a1z3IX1HlF2oAxtiOpA4xaWgNKcumk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=r9RfqAHLN1Y6AO/oOKwK0RgZGt54sDUBX8e2eVQka+Aqr48fU6vo0Y0SaN6gbSegF
	 IFYr1TZVam5X3KqlpgzjkIjVwROMFLltdKIJZebTUk1+Rv1NLchs+BQrAWq0R/o8AS
	 gR/v0FdT1U+XK/JbnED527cSJEmxiuIU3+Vlb2BU=
Date: Fri, 14 Aug 2026 21:16:45 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75
 quirks
Message-ID: <2026081437-splendid-smog-ee5a@gregkh>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
 <an7YKyVbe1YDtyL_@ashevche-desk.local>
 <DS0PR19MB7925F03452B896607C0B8F43DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
 <an8BisPHjhqn4g4d@ashevche-desk.local>
 <DS0PR19MB79251D4A473960EE4BFDC642DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB79251D4A473960EE4BFDC642DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>

On Fri, Aug 14, 2026 at 12:10:34PM +0000, Long Zhao wrote:
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.
> 

Now deleted.
