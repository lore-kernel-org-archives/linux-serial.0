Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43650199381
	for <linux-serial@vger.kernel.org>; Mon, 26 Aug 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705704; cv=none; b=RE9MRmb+3d75ufm1Qw3MmiOIbDAjRLQI15mflo2EJPBI/JqHArjVJ8h6tSfrh95dE7++rgR1JeQ7l9pctpAfkiSRg/J2AGNpExZOhTIRSJZ4xUbdNFlqfbk2AeOIpTs6soRibyLM4Dc/yKeab/kkBuN4O7RNq5CH72FiDqlTRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705704; c=relaxed/simple;
	bh=7NXtnwmvCIhyA32Y9cVSO9Z9Tqjqcf1blkjdopyxGR8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzHUOovumkBUnBheKnN4I6nPlS8rqo+Lflfh6p6Y0BVgRwmh9NMy47gsRYjjZ2qPJmeMPsu5GRxK7HW4cH6lLxhhHVnaIlP/xG771M4gkefQlijIxMO+Eilsglr3aXvESPmNMvaKWCxKYEHnZMnLhgYtJ5YXoMB7UkwAEGP0+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 75ac7369-63ed-11ef-8ec2-005056bdf889;
	Mon, 26 Aug 2024 23:55:00 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Aug 2024 23:55:00 +0300
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 0/3] OF support for Surface System Aggregator Module
Message-ID: <ZszrpJrltlUsdPv7@surfacebook.localdomain>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>

Wed, Aug 14, 2024 at 12:27:24PM +0200, Konrad Dybcio kirjoitti:
> Wire up OF support for SSAM drivers, to use with Surface Laptop 7 and
> other Qualcomm-based devices.
> 
> Patch 3 references compatible strings introduced in [1]
> 
> [1] https://lore.kernel.org/linux-arm-msm/20240809-topic-sl7-v1-1-2090433d8dfc@quicinc.com/T/#u

Please, Cc to me the v4.

-- 
With Best Regards,
Andy Shevchenko


